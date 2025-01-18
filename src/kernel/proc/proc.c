#include "types.h"
#include "types.h"
#include "defs.h"
#include "mem.h"


#define NPROC 2
enum state{RUNNING, SLEEPING};

// PC, SP and Calle-saved registers
struct context
{
    uint16_t pc;
    uint8_t spl;
    uint8_t sph;

    uint8_t r18;
    uint8_t r19;
    uint8_t r20;
    uint8_t r21;
    uint8_t r22;
    uint8_t r23;
    uint8_t r24;
    uint8_t r25;
    uint8_t r26;
    uint8_t r27;
    uint8_t r30;
    uint8_t r31;
};


struct proc {
    int pid;
    enum state state;
    struct context *context;
};

struct proc proc_list[NPROC];

void proc_init()
{
    struct proc *p;

    for(int i = 0; i < NPROC; i++){
        p = &proc_list[i];
        p->pid = i;
        p->state = SLEEPING;
    }
}

void scheduler()
{
    struct proc *p;

    for(int i = 0; i < NPROC; i++){
        p = &proc_list[i];

        if(p->state == SLEEPING){
            p->state = RUNNING;
            runproc(p);
            p->state = SLEEPING;
        }
    }
}

int runproc(struct proc *p)
{

}
