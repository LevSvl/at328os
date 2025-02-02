#include <avr/pgmspace.h>

#include "mem.h"
#include "defs.h"

#define NPROC 1

extern char pgm_read_word[];

enum state{RUNNING, SLEEPING, READY};

// PC, SP and calle-saved registers
struct context
{
    uint8_t spl;
    uint8_t sph;
    uint8_t r2;
    uint8_t r3;
    uint8_t r4;
    uint8_t r5;
    uint8_t r6;
    uint8_t r7;
    uint8_t r8;
    uint8_t r9;
    uint8_t r10;
    uint8_t r11;
    uint8_t r12;
    uint8_t r13;
    uint8_t r14;
    uint8_t r15;
    uint8_t r16;
    uint8_t r17;
    uint8_t r28;
    uint8_t r29;
};


struct proc {
    int pid;
    enum state state;
    uint16_t stack;
    struct context context;
};

struct proc proc_list[NPROC];
struct proc sched_proc;

extern void swtch(struct context *old_ctxt, struct context *new_ctxt);

void proc_init()
{
    struct proc *p;

    sched_proc.state = RUNNING;

    for(int i = 0; i < NPROC; i++){     
        printf("proc init %d\n", i);

        p = &proc_list[i];
        p->pid = i;
        p->state = SLEEPING;
        p->stack = USTACK(i);

        p->context.spl = low(p->stack);
        p->context.sph = high(p->stack);
    }
}

void scheduler()
{
    struct proc *up, *sch_p;
    
    sch_p = &sched_proc;

    while(1){
        for(int i = 0; i < NPROC; i++){
            up = &proc_list[i];
            if(up->state == READY){
                sch_p->state = SLEEPING;
                up->state = RUNNING;
                swtch(&sch_p->context, &up->context);
            }
        }
    }
}

int create_task(uint16_t task_addr)
{
    struct proc *up;
    int found = 0;

    for(int i = 0; i < NPROC; i++){
        up = &proc_list[i];
        if(up->state == SLEEPING){
            found = 1;
            break;
        }
    }

    if(!found)
        return -1;

    uint16_t new_stack = up->stack-3;
    up->context.spl = low(new_stack);
    up->context.sph = high(new_stack);
    up->stack = new_stack;

    new_stack += 1;
    *((uint8_t *)(new_stack)) = high(task_addr);
    new_stack += 1;
    *((uint8_t *)(new_stack)) = low(task_addr);
    
    up->state = READY;
    
    return 0;
}
