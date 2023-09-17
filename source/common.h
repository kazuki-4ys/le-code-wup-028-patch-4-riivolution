#ifndef _COMMON_H_
#define _COMMON_H_

#define NULL 0

#define COURSE_SLOT_MAX 42
#define COURSE_PATH_MAX 0x40

//https://github.com/riidefi/mkw/blob/454ba2d115b02af4462dd34b854573909b454722/source/game/system/MultiDvdArchive.hpp
typedef struct{
    void *vtable;
    void* archives;
    unsigned short archiveCount;
    unsigned char pad0[2];
    unsigned int *fileSizes;
    char **suffixes;
    void** fileStarts;
    unsigned int *kinds;
}MultiDvdArchive_Struct;

//https://github.com/riidefi/mkw/blob/47013193474cc88ef07696cb1037eb5227561a50/source/egg/core/eggDisposer.hpp#L28
typedef struct{
    unsigned char unk0[0x10];
}EGG__Disposer_Struct;//size = 0x10;

//https://github.com/riidefi/mkw/blob/47013193474cc88ef07696cb1037eb5227561a50/source/game/system/ResourceManager.hpp#L204
typedef struct{
    EGG__Disposer_Struct s;
    void* mpBuffer;
    void* mpHeap;
    unsigned int mCourseId;
    unsigned int mState;
    MultiDvdArchive_Struct* mpArchive;
}System__CourseCache_Struct;

typedef struct{
    int slotID;
    int determinedTextureHackIndex;
    void *saveUILayoutControlForSom;
    unsigned char somDigit;
    unsigned char useTrackMusicSpeedUpOnFinalLap;
    unsigned char skipSpeedUp;

    //これより上のメンバは弄らないこと(アセンブラソースによりハードコーディングされているため)
    //クソコードでごめんね

    unsigned char useCtgpReplicaSom;
    unsigned char useRandomTexture;
    unsigned char changeRegionColor;
    int textureHackCount[COURSE_SLOT_MAX];
    unsigned int randomNumber;//add 1 pre 1 frame to get random texture hack
    unsigned char regionColor;
    unsigned char disableOriginalTracks;
    unsigned char wiimmfiPatcher;
    unsigned char unlockEverything;
    unsigned char changeMatchMakeRegion;
    unsigned short matchMakeRegion;
    int riivolutionLaunchTimer;
    unsigned char couresCacheloadCountOnline;
    unsigned char disableCacheLoad;
    unsigned int lastSceneID;
    System__CourseCache_Struct *courseCache;
    void *mem2Heap;
}myGlobalVarStruct;

typedef struct{
    void* unk;
    void* mMEM1ArenaLo;
    void* mMEM1ArenaHi;
    void* mMEM2ArenaLo;
    void* mMEM2ArenaHi;
    unsigned int mMemorySize;
    void* mRootHeapMem1;
    void* mRootHeapMem2; 
}BaseSystem;

typedef struct{
    void* head;
    void* tail;
    unsigned short count;
    unsigned short intrusion_offset;
}nw4r__ut__List;

//https://github.com/riidefi/mkw/blob/7f11b3ce7baf41e54aba301617a99a301feda118/source/egg/core/eggHeap.hpp
typedef struct{
    unsigned char unk[0x28];
    nw4r__ut__List mChildren;
    const char* mName;
}Egg__Heap_Struct;

extern myGlobalVarStruct *myGlobalVarPtr;
extern const char** COURSE_NAMES;
extern unsigned char canUseDevUsbVen;
extern unsigned char usbGcnDisconnectReq;

void memcpy(void*, void*, unsigned int);
void *my_malloc(unsigned int length);
void *my_malloc_mem2(unsigned int length);
void injectC2Patch(void *targetAddr, void *codeStart, void *codeEnd);
void u32ToBytes(unsigned char *mem, unsigned int val);
unsigned int bytesToU32(unsigned char *mem);
void ICInvalidateRange(void *_start, unsigned int length);
void OSReport(const char*, ...);
void memcpy(void*, void*, unsigned int);
int ISFS_Open(const char* path, int flag);
void ISFS_Close(int fd);
void OSLaunchTitle(unsigned long long titleID);
int IOS_Open(const char *path, int flags);
void IOS_Close(int fd);
void MultiDvdArchive__clear(MultiDvdArchive_Struct *self);
void *Egg__ExpHeap__create(unsigned int, void*, unsigned int);
void *nw4r__ut__List_GetNext(const nw4r__ut__List*, const void*);
void checkUseTrackMusicSpeedUpOnFinalLap(void);
int ISFS_Read(int fd, void *buffer, int length);
void VIResetDimmingCount(void);

#endif//_COMMON_H_