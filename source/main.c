#include "common.h"
#include "pad_hook.h"

#define ENABLE_USB_GCN_TIMER 30

#ifdef RMCP

#define RUN_1FR_HOOK 0x8016eb68

#endif

#ifdef RMCE

#define RUN_1FR_HOOK 0x8016eac8

#endif

#ifdef RMCJ

#define RUN_1FR_HOOK 0x8016eA88

#endif

void ICInvalidateRangeAsm(void*, unsigned int);
int getSceneID(void);

void *get_run_1fr_asm(void);
void *get_run_1fr_asm_end(void);
void lecodeEntry(void);

void u32ToBytes(unsigned char *mem, unsigned int val){
    *mem = (val >> 24);
    *(mem + 1) = ((val >> 16) & 0xFF);
    *(mem + 2) = ((val >> 8) & 0xFF);
    *(mem + 3) = (val & 0xFF);
}

unsigned int bytesToU32(unsigned char *mem){
    return (*mem << 24) | (*(mem + 1) << 16) | (*(mem + 2) << 8) | *(mem + 3);
}

void ICInvalidateRange(void *_start, unsigned int length){
    //CPUのキャッシュメモリを更新し、過去にキャッシュされたコードの実行を防ぐ？
    //_start とlengthを0x20でアラインメント alignment for 0x20
    unsigned int start = (unsigned int)_start;
    unsigned int end = start + length;
    if(end & 0x1F){
        end = ((end >> 5) + 1) << 5;
    }
    if(start & 0x1F){
        start = (start >> 5) << 5;
    }
    ICInvalidateRangeAsm((void*)start, end - start);
}

unsigned int makeBranchInstructionByAddrDelta(int addrDelta){//アドレス差分からbranch命令作成
    unsigned int instruction = 0;
    if(addrDelta < 0){
        instruction = addrDelta + 0x4000000;
    }else{
        instruction = addrDelta;
    }
    instruction |= 0x48000000;
    return instruction;
}

void injectBranch(void *target, void *src){
    //srcからtargetへジャンプ
    //branch to src from target
    unsigned int instruction = makeBranchInstructionByAddrDelta((int)target - (int)src);
    u32ToBytes((void*)src, instruction);
    ICInvalidateRange((void*)src, 4);
}

void injectC2Patch(void *targetAddr, void *codeStart, void *codeEnd){
    //inject code like C2 code type
    u32ToBytes((unsigned char*)codeEnd - 8, makeBranchInstructionByAddrDelta((unsigned int)targetAddr + 4 - ((unsigned int)codeEnd - 8)));
    u32ToBytes(targetAddr, makeBranchInstructionByAddrDelta(codeStart - targetAddr));
    ICInvalidateRange((void*)((unsigned int)codeEnd - 8), 4);
    ICInvalidateRange(targetAddr, 4);
}

unsigned char isInTitleScreen(void){
    int sceneID = getSceneID();
    //https://wiki.tockdom.com/wiki/List_of_Identifiers
    if(sceneID < 0x3F)return 0;
    if(sceneID > 0x43)return 0;
    return 1;
}

int padHookInstallTimer;
unsigned char alreadyInstalledPadHook;

void __main(void){
    padHookInstallTimer = -1;
    alreadyInstalledPadHook = 0;
    injectC2Patch((void*)RUN_1FR_HOOK, get_run_1fr_asm(), get_run_1fr_asm_end());
    lecodeEntry();//LE-CODE本来のエントリポイント
}

void run_1fr(void){
    //画面焼き付き防止機能を無効化
    VIResetDimmingCount();
    //タイトル画面になってから30フレーム後にUSB GCNを有効化する
    //Enable USB GCN 30 frames after entering the title scene.
    if(padHookInstallTimer < ENABLE_USB_GCN_TIMER && padHookInstallTimer > -1)padHookInstallTimer++;
    if(padHookInstallTimer == ENABLE_USB_GCN_TIMER && (!alreadyInstalledPadHook)){
        alreadyInstalledPadHook = 1;
        installPadHook();
    }
    if(padHookInstallTimer < 0 && isInTitleScreen())padHookInstallTimer = 0;
    return;
}