ENTRY(__main)
SECTIONS
{
        .text 0x808E9AF0 : {
                *(.text.__main);
                *(.text*);
        }
        myGlobalVarPtr = 0x80000CC0;
        OSReport = 0x801a2530;
        strcmp =  0x8001273c;
        Egg__Heap__Alloc = 0x80229490;
        DVDConvertPathToEntryNum = 0x8015deac;
        DvdArchive__ripFile = 0x80514c7c;
        DVDFastOpen = 0x8015e1b4;
        DVDReadPrio = 0x8015e794;
        DVDClose = 0x8015e4c8;
        memcpy = 0x80005f34;
        memcmp = 0x8000e7b4;
        strncpy = 0x80012680;
        sprintf = 0x80010ecc;
        NETCalcCRC32 = 0x801d1c00;
        strlen = 0x800206f4;
        ControlLoader__Load = 0x805ba2cc;
        ISFS_Open = 0x8016adbc;
        ISFS_Close = 0x8016b2e4;
        OSLaunchTitle = 0x801ad960;
        bmg_func = 0x805d840c;
        IOS_Open = 0x80193858;
        IOS_Close = 0x80193a38;
        MultiDvdArchive__clear = 0x805267cc;
        IOS_IoctlAsync = 0x801940b8;
        IOS_IoctlvAsync = 0x8019445c;
        IOS_OpenAsync =  0x80193740;
        IOS_CloseAsync = 0x80193978;
        DCFlushRange = 0x801a158c;
        VIResetDimmingCount = 0x801bb00c;
        Egg__ExpHeap__create = 0x80226744;
        sSystem__Q23EGG10BaseSystem = 0x80382bd8;
        nw4r__ut__List_GetNext = 0x800af0e0;
        RACEDATA = 0x809B8F68;
        SubtractTimers = 0x808423FC;
        trackMusicSpeedUpPatch4PlusCLwzAddr = 0x809BDC10;
        Egg__Heap__Free = 0x80229800;
        ISFS_Read = 0x8016b15c;
        menu_pointer = 0x809bd508;
        lecodeEntry = 0x808dd6b0;
}