ENTRY(__main)
SECTIONS
{
        .text 0x808E9AF0 : {
                *(.text.__main);
                *(.text*);
        }
        myGlobalVarPtr = 0x80000CC0;
        OSReport = 0x801A24F0;
        strcmp =  0x800131C0;
        Egg__Heap__Alloc = 0x80229734;
        DVDConvertPathToEntryNum = 0x8015DE6C;
        DvdArchive__ripFile = 0x80518a70;
        DVDFastOpen = 0x8015E174;
        DVDReadPrio = 0x8015E754;
        DVDClose = 0x8015E488;
        memcpy = 0x80005F34;
        memcmp = 0x8000F238;
        strncpy = 0x80013104;
        sprintf = 0x80011950;
        strcmp = 0x800131c0;
        NETCalcCRC32 = 0x801d1bc0;
        strlen = 0x80021178;
        ControlLoader__Load = 0x805c25e0;
        ISFS_Open = 0x8016ad7c;
        ISFS_Close = 0x8016b2a4;
        OSLaunchTitle = 0x801AD920;
        bmg_func = 0x805F85CC;
        IOS_Open = 0x80193818;
        IOS_Close = 0x801939f8;
        MultiDvdArchive__clear = 0x8052a5c0;
        IOS_IoctlAsync = 0x80194078;
        IOS_IoctlvAsync = 0x8019441c;
        IOS_OpenAsync =  0x80193700;
        IOS_CloseAsync = 0x80193938;
        DCFlushRange = 0x801a154c;
        VIResetDimmingCount = 0x801bafcc;
        Egg__ExpHeap__create = 0x802269e8;
        sSystem__Q23EGG10BaseSystem = 0x803868e0;
        nw4r__ut__List_GetNext = 0x800af0a0;
        RACEDATA = 0x809BC788;
        SubtractTimers = 0x807EDECC;
        trackMusicSpeedUpPatch4PlusCLwzAddr = 0x809C18B0;
        Egg__Heap__Free = 0x80229aa4;
        ISFS_Read = 0x8016b11c;
        menu_pointer = 0x809C0E98;
        lecodeEntry = 0x808dd6b0;
}