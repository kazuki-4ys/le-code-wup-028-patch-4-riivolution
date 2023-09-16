ENTRY(__main)
SECTIONS
{
        .text 0x808E9AF0 : {
                *(.text.__main);
                *(.text*);
        }
        myGlobalVarPtr = 0x80000CC0;
        OSReport = 0x801a25d0;
        strcmp =  0x8001329c;
        Egg__Heap__Alloc = 0x80229814;
        DVDConvertPathToEntryNum = 0x8015df4c;
        DvdArchive__ripFile = 0x805190f0;
        DVDFastOpen = 0x8015e254;
        DVDReadPrio = 0x8015e834;
        DVDClose = 0x8015e568;
        memcpy = 0x80005F34;
        memcmp = 0x8000f314;
        strncpy = 0x800131e0;
        sprintf = 0x80011a2c;
        NETCalcCRC32 = 0x801d1ca0;
        strlen = 0x80021254;
        ControlLoader__Load = 0x805c2c60;
        ISFS_Open = 0x8016ae5c;
        ISFS_Close = 0x8016b384;
        OSLaunchTitle = 0x801ada00;
        bmg_func = 0x805f8cf0;
        IOS_Open = 0x801938f8;
        IOS_Close = 0x80193ad8;
        MultiDvdArchive__clear = 0x8052ac40;
        IOS_IoctlAsync = 0x80194158;
        IOS_IoctlvAsync = 0x801944fc;
        IOS_OpenAsync =  0x801937e0;
        IOS_CloseAsync = 0x80193a18;
        DCFlushRange = 0x801a162c;
        VIResetDimmingCount = 0x801bb0ac;
        Egg__ExpHeap__create = 0x80226ac8;
        sSystem__Q23EGG10BaseSystem = 0x80386f60;
        nw4r__ut__List_GetNext = 0x800af180;
        RACEDATA = 0x809bd728;
        SubtractTimers = 0x807ee860;
        trackMusicSpeedUpPatch4PlusCLwzAddr = 0x809C2850;
        Egg__Heap__Free = 0x80229B84;
        ISFS_Read = 0x8016b1fc;
        menu_pointer = 0x809c1e38;
        lecodeEntry = 0x808dd6b0;
}