DefinitionBlock("", "SSDT", 2, "hack", "batt", 0)
{
    External(_SB.PCI0, DeviceObj)
    External(_SB.PCI0.BAT0, DeviceObj)
    External(_SB.PCI0.BAT0._BIF, MethodObj)
    External(_SB.PCI0.BAT0.BIXT, PkgObj)
    External(_SB.PCI0.BAT0.LFCC, IntObj)
    External(_SB.PCI0.BAT0.NBIX, PkgObj)
    External(_SB.PCI0.BAT0.PBIF, PkgObj)
    External(_SB.PCI0.BAT0.PBST, PkgObj)
    External(_SB.PCI0.BAT0.PUNT, IntObj)    

    External(_SB.PCI0.LPCB.EC0, DeviceObj)   
    External(_SB.PCI0.LPCB.EC0.ACAP, MethodObj)
    External(_SB.PCI0.LPCB.EC0.ADDR, FieldUnitObj)
    
    External(_SB.PCI0.LPCB.EC0.BATP, MethodObj)
    
    External(_SB.PCI0.LPCB.EC0.BCNT, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.BCN2, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.BLLO, IntObj)
    External(_SB.PCI0.LPCB.EC0.BRAH, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.BSLF, IntObj)
    External(_SB.PCI0.LPCB.EC0.CMDB, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.DAT0, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.DAT1, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.EB0S, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.ECAV, MethodObj)
    External(_SB.PCI0.LPCB.EC0.GBTT, MethodObj)
    External(_SB.PCI0.LPCB.EC0.MUEC, MutexObj)
    External(_SB.PCI0.LPCB.EC0.PRTC, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.RCBT, IntObj)
    External(_SB.PCI0.LPCB.EC0.RDBL, IntObj)
    External(_SB.PCI0.LPCB.EC0.RDBT, IntObj)
    External(_SB.PCI0.LPCB.EC0.RDQK, IntObj)
    External(_SB.PCI0.LPCB.EC0.RDWD, IntObj)
    External(_SB.PCI0.LPCB.EC0.SBBY, IntObj)
    External(_SB.PCI0.LPCB.EC0.SDBT, IntObj)
    External(_SB.PCI0.LPCB.EC0.SWTC, MethodObj)
    External(_SB.PCI0.LPCB.EC0.WRBL, IntObj)
    External(_SB.PCI0.LPCB.EC0.WRBT, IntObj)
    External(_SB.PCI0.LPCB.EC0.WRQK, IntObj)
    External(_SB.PCI0.LPCB.EC0.WRWD, IntObj)
    External(_SB.PCI0.LPCB.EC0.PRT2, FieldUnitObj)

    External(_SB.PCI0.LPCB.EC0.ADD2, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.CMD2, FieldUnitObj)

    External(_SB.PCI0.LPCB.EC0.DA20, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.DA21, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.SSTS, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.SST2, FieldUnitObj)
    
    External(CHGS, MethodObj)
    External(BLLO, IntObj)
    External(MBLF, IntObj)
    External(BSLF, IntObj)

    External(BRAI, MethodObj)
    External(BRAD, MethodObj)
    
    Method (B1B2, 2, NotSerialized)
    { 
        Return(Or(Arg0, ShiftLeft(Arg1, 8)))
    }
    
    Scope (_SB.PCI0.LPCB.EC0)
    {
        External(ECOR, OpRegionObj)
        Field(ECOR, ByteAcc, Lock, Preserve)
        {
            Offset (0x93), 
            AH00,8,AH01,8, 
            AH10,8,AH11,8,
            Offset (0xB0), 
            B0P0,8,B0P1,8, 
            Offset (0xBE), 
            B0T0,8,B0T1,8, 
            B010,8,B011,8, 
            B020,8,B021,8, 
            B030,8,B031,8, 
            B040,8,B041,8, 
            Offset (0xD0), 
            B1P0,8,B1P1,8, 
            Offset (0xDE), 
            B1T0,8,B1T1,8, 
            B110,8,B111,8, 
            B120,8,B121,8, 
            B130,8,B131,8, 
            B140,8,B141,8, 
            Offset (0xF4), 
            B0N0,8,B0N1,8, 
            Offset (0xFC), 
            B1N0,8,B1N1,8
        }
        
        OperationRegion (RMB1, EmbeddedControl, 0x18, 0x28)
        Field (RMB1, ByteAcc, NoLock, Preserve)
        {
            Offset(4),
            BDAX,    256
        }
        
        OperationRegion (RMB2, EmbeddedControl, 0x40, 0x28)
        Field (RMB2, ByteAcc, NoLock, Preserve)
        {
            Offset(4),
            BDAY,    256
        }
        
        Field (RMB1, ByteAcc, NoLock, Preserve)
        {
            Offset (0x04), 
            T2B0,8,T2B1,8
        }
        
    }
    
    Scope (_SB.PCI0)
    {
        Scope (BAT0) {
            
                    Method (_BIX, 0, NotSerialized)  // _BIX: Battery Information Extended
        {
            If (LNot (^^LPCB.EC0.BATP (Zero))) {
                Return (NBIX) /* \_SB_.PCI0.BAT0.NBIX */
            }
            If (LEqual (^^LPCB.EC0.GBTT (Zero), 0xFF)) {
                Return (NBIX) /* \_SB_.PCI0.BAT0.NBIX */
            }
            _BIF ()
            Store (DerefOf (Index (PBIF, Zero)), Index (BIXT, One))
            Store (DerefOf (Index (PBIF, One)), Index (BIXT, 0x02))
            Store (DerefOf (Index (PBIF, 0x02)), Index (BIXT, 0x03))
            Store (DerefOf (Index (PBIF, 0x03)), Index (BIXT, 0x04))
            Store (DerefOf (Index (PBIF, 0x04)), Index (BIXT, 0x05))
            Store (DerefOf (Index (PBIF, 0x05)), Index (BIXT, 0x06))
            Store (DerefOf (Index (PBIF, 0x06)), Index (BIXT, 0x07))
            Store (DerefOf (Index (PBIF, 0x07)), Index (BIXT, 0x0E))
            Store (DerefOf (Index (PBIF, 0x08)), Index (BIXT, 0x0F))
            Store (DerefOf (Index (PBIF, 0x09)), Index (BIXT, 0x10))
            Store (DerefOf (Index (PBIF, 0x0A)), Index (BIXT, 0x11))
            Store (DerefOf (Index (PBIF, 0x0B)), Index (BIXT, 0x12))
            Store (DerefOf (Index (PBIF, 0x0C)), Index (BIXT, 0x13))
            If (LEqual (DerefOf (Index (BIXT, One)), One)) { Store (Zero, Index (BIXT, One))
                Store (DerefOf (Index (BIXT, 0x05)), Local0)
                Multiply (DerefOf (Index (BIXT, 0x02)), Local0, Index (BIXT, 0x02))
                Multiply (DerefOf (Index (BIXT, 0x03)), Local0, Index (BIXT, 0x03))
                Multiply (DerefOf (Index (BIXT, 0x06)), Local0, Index (BIXT, 0x06))
                Multiply (DerefOf (Index (BIXT, 0x07)), Local0, Index (BIXT, 0x07))
                Multiply (DerefOf (Index (BIXT, 0x0E)), Local0, Index (BIXT, 0x0E))
                Multiply (DerefOf (Index (BIXT, 0x0F)), Local0, Index (BIXT, 0x0F))
                Divide (DerefOf (Index (BIXT, 0x02)), 0x03E8, Local0, Index (BIXT, 0x02))
                Divide (DerefOf (Index (BIXT, 0x03)), 0x03E8, Local0, Index (BIXT, 0x03))
                Divide (DerefOf (Index (BIXT, 0x06)), 0x03E8, Local0, Index (BIXT, 0x06))
                Divide (DerefOf (Index (BIXT, 0x07)), 0x03E8, Local0, Index (BIXT, 0x07))
                Divide (DerefOf (Index (BIXT, 0x0E)), 0x03E8, Local0, Index (BIXT, 0x0E))
                Divide (DerefOf (Index (BIXT, 0x0F)), 0x03E8, Local0, Index (BIXT, 0x0F))  }
            Store (B1B2(^^LPCB.EC0.B030,^^LPCB.EC0.B031), Index (BIXT, 0x08))
            Store (0x0001869F, Index (BIXT, 0x09))
            Return (BIXT) /* \_SB_.PCI0.BAT0.BIXT */
        }
            
        Method (FBST, 4, NotSerialized)
        {
            And (Arg1, 0xFFFF, Local1)
            Store (Zero, Local0)
            If (^^LPCB.EC0.ACAP ()) { 
                Store (One, Local0)
            }
            
            If (Local0) {
                If (CHGS (Zero)) {
                    Store (0x02, Local0)
                } Else {
                    Store (Zero, Local0)
                }  
            } Else { 
                Store (One, Local0)  
            }
            If (BLLO) {
                ShiftLeft (One, 0x02, Local2)
                Or (Local0, Local2, Local0)  
            }
            If (And (^^LPCB.EC0.EB0S, 0x08)) {
                ShiftLeft (One, 0x02, Local2)
                Or (Local0, Local2, Local0)  
            }
            If (LGreaterEqual (Local1, 0x8000)) { Subtract (0xFFFF, Local1, Local1) }
            Store (Arg2, Local2)
            If (LEqual (PUNT, Zero)) {
                Multiply (Local1, B1B2(^^LPCB.EC0.B0D2,^^LPCB.EC0.B0D3), Local1)
                Multiply (Local2, 0x0A, Local2)  
            }
            And (Local0, 0x02, Local3)
            If (LNot (Local3)) {
                Subtract (LFCC, Local2, Local3)
                Divide (LFCC, 0xC8, Local4, Local5)
                If (LLess (Local3, Local5)) { Store (LFCC, Local2) }  
            } Else {
                Divide (LFCC, 0xC8, Local4, Local5)
                Subtract (LFCC, Local5, Local4)
                If (LGreater (Local2, Local4)) { Store (Local4, Local2) }  
            }
            If (LNot (^^LPCB.EC0.ACAP ())) {
                Divide (Local2, MBLF, Local3, Local4)
                If (LLess (Local1, Local4)) { Store (Local4, Local1) }  
            }
            Store (Local0, Index (PBST, Zero))
            Store (Local1, Index (PBST, One))
            Store (Local2, Index (PBST, 0x02))
            Store (Arg3, Index (PBST, 0x03))
        }
        
        Method (CBST, 0, NotSerialized)
        {
            If (PUNT) { Store (B1B2(^^LPCB.EC0.B0D2,^^LPCB.EC0.B0D3), Index (PBST, 0x03))
                Store (DerefOf (Index (PBST, 0x03)), Local0)
                Multiply (DerefOf (Index (PBST, One)), Local0, Index (PBST, One))
                Divide (DerefOf (Index (PBST, One)), 0x03E8, Local1, Index (PBST, One))
                Multiply (DerefOf (Index (PBST, 0x02)), Local0, Index (PBST, 0x02))
                Divide (DerefOf (Index (PBST, 0x02)), 0x03E8, Local1, Index (PBST, 0x02))
            }
        }
        

        
        
        
        }




    }
    
    Scope (_SB.PCI0.LPCB.EC0)
    {

    }
    Scope (_SB.PCI0.LPCB.EC0)
    {
        Method (RE1B, 1, NotSerialized)
        {
            OperationRegion(ERAM, EmbeddedControl, Arg0, 1)
            Field(ERAM, ByteAcc, NoLock, Preserve) { BYTE, 8 }
            Return(BYTE)
        }
        Method (RECB, 2, Serialized)
        {
            ShiftRight(Arg1, 3, Arg1)
            Name(TEMP, Buffer(Arg1) { })
            Add(Arg0, Arg1, Arg1)
            Store(0, Local0)
            While (LLess(Arg0, Arg1))
            {
                Store(RE1B(Arg0), Index(TEMP, Local0))
                Increment(Arg0)
                Increment(Local0)
            }
            Return(TEMP)
        }
        
        Method (WE1B, 2, NotSerialized)
        {
            OperationRegion(ERAM, EmbeddedControl, Arg0, 1)
            Field(ERAM, ByteAcc, NoLock, Preserve) { BYTE, 8 }
            Store(Arg1, BYTE)
        }
        
        Method (WECB, 3, Serialized)
        {
            ShiftRight(Arg1, 3, Arg1)
            Name(TEMP, Buffer(Arg1) { })
            Store(Arg2, TEMP)
            Add(Arg0, Arg1, Arg1)
            Store(0, Local0)
            While (LLess(Arg0, Arg1)) {
                WE1B(Arg0, DerefOf(Index(TEMP, Local0)))
                Increment(Arg0)
                Increment(Local0)  
            }
        }
        
        Method (BIF0, 0, NotSerialized)
        {
            If (ECAV ()) {
                If (BSLF) {
                    Store (B1B2(B1M0,B1M1), Local0)
                } Else {
                    Store (B1B2(B0M0,B0M1), Local0)
                }
                If (LNotEqual (Local0, 0xFFFF)) {
                    ShiftRight (Local0, 0x0F, Local1)
                    And (Local1, One, Local1)
                    XOr (Local1, One, Local0)
                }  
            } Else { Store (Ones, Local0)  }
            Return (Local0)
        }

        Method (BIF1, 0, NotSerialized)
        {
            If (ECAV ()) {
                If (BSLF) {
                    Store (B1B2(B1D0,B1D1), Local0)
                } Else {
                    Store (B1B2(B0D0,B0D1), Local0)
                }
                And (Local0, 0xFFFF, Local0)  } Else { Store (Ones, Local0)  }
            Return (Local0)
        }

        Method (BIF2, 0, NotSerialized)
        {
            If (ECAV ()) {
                If (BSLF) {
                    Store (B1B2(B1F0,B1F1), Local0)
                } Else {
                    Store (B1B2(B0F0,B0F1), Local0)
                }
                And (Local0, 0xFFFF, Local0)  
            } Else { Store (Ones, Local0)  }
            Return (Local0)
        }

        Method (BIF3, 0, NotSerialized)
        {
            If (ECAV ()) {
                If (BSLF) {
                    Store (B1B2(B1M0,B1M1), Local0)
                } Else {
                    Store (B1B2(B0M0,B0M1), Local0)
                }
                If (LNotEqual (Local0, 0xFFFF)) {
                    ShiftRight (Local0, 0x09, Local0)
                    And (Local0, One, Local0)
                    XOr (Local0, One, Local0)
                }  
            } Else { Store (Ones, Local0)  }
            Return (Local0)
        }

        Method (BIF4, 0, NotSerialized)
        {
            If (ECAV ()) {
                If (BSLF) {
                    Store (B1B2(B1D2,B1D3), Local0)
                } Else {
                    Store (B1B2(B0D2,B0D3), Local0)
                }  
            } Else { Store (Ones, Local0)  }
            Return (Local0)
        }

        Method (BIFA, 0, NotSerialized)
        {
            If (ECAV ()) {
                If (BSLF) {
                    Store (B1B2(B1N0,B1N1), Local0)
                } Else {
                    Store (B1B2(B0N0,B0N1), Local0)
                }  
            } Else { Store (Ones, Local0)  }
            Return (Local0)
        }

        Method (BSTS, 0, NotSerialized)
        {
            If (BSLF) { Store (B1B2(B1S0,B1S1), Local0)  
            } Else { Store (B1B2(B0S0,B0S1), Local0)  }
            Return (Local0)
        }

        Method (BCRT, 0, NotSerialized)
        {
            If (BSLF) { 
                Store (B1B2(B1C0,B1C1), Local0)  
            } Else { 
                Store (B1B2(B0C0,B0C1), Local0)  
            }
            Return (Local0)
        }

        Method (BRCP, 0, NotSerialized)
        {
            If (BSLF) { 
                Store (B1B2(B1R0,B1R1), Local0)  
            } Else { 
                Store (B1B2(B0R0,B0R1), Local0)  
            }
            If (LEqual (Local0, 0xFFFF)) { Store (Ones, Local0)  }
            Return (Local0)
        }

        Method (BVOT, 0, NotSerialized)
        {
            If (BSLF) { 
                Store (B1B2(B1V0,B1V1), Local0)  
            } Else { 
                Store (B1B2(B0V0,B0V1), Local0)
            }
            Return (Local0)
        }

        Method (SMBR, 3, Serialized)
        {
            Store (Package (0x03) { 0x07, Zero, Zero }, Local0)
            If (LNot (ECAV ())) { Return (Local0) }
            If (LNotEqual (Arg0, RDBL)) {
                If (LNotEqual (Arg0, RDWD)) {
                    If (LNotEqual (Arg0, RDBT)) {
                        If (LNotEqual (Arg0, RCBT)) {
                            If (LNotEqual (Arg0, RDQK)) { Return (Local0) }
                        }
                    }
                }  
            }
            Acquire (MUEC, 0xFFFF)
            Store (PRTC, Local1)
            Store (Zero, Local2)
            While (LNotEqual (Local1, Zero)) {
                Stall (0x0A)
                Increment (Local2)
                If (LGreater (Local2, 0x03E8)) {
                    Store (SBBY, Index (Local0, Zero))
                    Store (Zero, Local1)
                } Else {
                    Store (PRTC, Local1)
                }  
            }
            If (LLessEqual (Local2, 0x03E8)) {
                ShiftLeft (Arg1, One, Local3)
                Or (Local3, One, Local3)
                Store (Local3, ADDR) /* \_SB_.PCI0.LPCB.EC0_.ADDR */
                If (LNotEqual (Arg0, RDQK)) {
                    If (LNotEqual (Arg0, RCBT)) {
                        Store (Arg2, CMDB) /* \_SB_.PCI0.LPCB.EC0_.CMDB */
                    }
                }
                WECB(0x1c,256,Zero) /* \_SB_.PCI0.LPCB.EC0_.BDAT */
                Store (Arg0, PRTC) /* \_SB_.PCI0.LPCB.EC0_.PRTC */
                Store (SWTC (Arg0), Index (Local0, Zero))
                If (LEqual (DerefOf (Index (Local0, Zero)), Zero)) {
                    If (LEqual (Arg0, RDBL)) {
                        Store (BCNT, Index (Local0, One))
                        Store (RECB(0x1c,256), Index (Local0, 0x02))
                    }
                    If (LEqual (Arg0, RDWD)) {
                        Store (0x02, Index (Local0, One))
                        Store (B1B2(T2B0,T2B1), Index (Local0, 0x02))
                    }
                    If (LEqual (Arg0, RDBT)) {
                        Store (One, Index (Local0, One))
                        Store (DAT0, Index (Local0, 0x02))
                    }
                    If (LEqual (Arg0, RCBT)) {
                        Store (One, Index (Local0, One))
                        Store (DAT0, Index (Local0, 0x02))
                    }
                }  
            }
            Release (MUEC)
            Return (Local0)
        }
        
        Method (SMBW, 5, Serialized)
        {
            Store (Package (0x01) { 0x07 }, Local0)
            If (LNot (ECAV ())) { Return (Local0) }
            If (LNotEqual (Arg0, WRBL)) {
                If (LNotEqual (Arg0, WRWD)) {
                    If (LNotEqual (Arg0, WRBT)) {
                        If (LNotEqual (Arg0, SDBT)) {
                            If (LNotEqual (Arg0, WRQK)) { Return (Local0) }
                        }
                    }
                }  
            }
            Acquire (MUEC, 0xFFFF)
            Store (PRTC, Local1)
            Store (Zero, Local2)
            While (LNotEqual (Local1, Zero)) {
                Stall (0x0A)
                Increment (Local2)
                If (LGreater (Local2, 0x03E8)) {
                    Store (SBBY, Index (Local0, Zero))
                    Store (Zero, Local1)
                } Else { Store (PRTC, Local1) }  
            }
            If (LLessEqual (Local2, 0x03E8)) {
                WECB(0x1c,256,Zero) /* \_SB_.PCI0.LPCB.EC0_.BDAT */
                ShiftLeft (Arg1, One, Local3)
                Store (Local3, ADDR) /* \_SB_.PCI0.LPCB.EC0_.ADDR */
                If (LNotEqual (Arg0, WRQK)) {
                    If (LNotEqual (Arg0, SDBT))
                    {
                        Store (Arg2, CMDB) /* \_SB_.PCI0.LPCB.EC0_.CMDB */
                    }
                }
                If (LEqual (Arg0, WRBL)) {
                    Store (Arg3, BCNT) /* \_SB_.PCI0.LPCB.EC0_.BCNT */
                    WECB(0x1c,256,Arg4) /* \_SB_.PCI0.LPCB.EC0_.BDAT */
                }
                If (LEqual (Arg0, WRWD)) {
                    Store(Arg4, T2B0) Store(ShiftRight(Arg4,8), T2B1) /* \_SB_.PCI0.LPCB.EC0_.DT2B */
                }
                If (LEqual (Arg0, WRBT)) {
                    Store (Arg4, DAT0) /* \_SB_.PCI0.LPCB.EC0_.DAT0 */
                }
                If (LEqual (Arg0, SDBT)) {
                    Store (Arg4, DAT0) /* \_SB_.PCI0.LPCB.EC0_.DAT0 */
                }
                Store (Arg0, PRTC) /* \_SB_.PCI0.LPCB.EC0_.PRTC */
                Store (SWTC (Arg0), Index (Local0, Zero))
            }
            Release (MUEC)
            Return (Local0)
        }
        
        Method (ECSB, 7, NotSerialized)
        {
            Store (Package (0x05) {
                    0x11, 
                    Zero, 
                    Zero, 
                    Zero, 
                    Buffer (0x20){}
                }, Local1)
            If (LGreater (Arg0, One)) {
                Return (Local1)  
            }
            If (ECAV ()) {
                Acquire (MUEC, 0xFFFF)
                If (LEqual (Arg0, Zero)) {
                    Store (PRTC, Local0)
                } Else {
                    Store (PRT2, Local0)
                }
                Store (Zero, Local2)
                While (LNotEqual (Local0, Zero)) {
                    Stall (0x0A)
                    Increment (Local2)
                    If (LGreater (Local2, 0x03E8)) {
                        Store (SBBY, Index (Local1, Zero))
                        Store (Zero, Local0)
                    } ElseIf (LEqual (Arg0, Zero)) {
                        Store (PRTC, Local0)
                    } Else {
                        Store (PRT2, Local0)
                    }
                }
                If (LLessEqual (Local2, 0x03E8)) {
                    If (LEqual (Arg0, Zero)) {
                        Store (Arg2, ADDR) /* \_SB_.PCI0.LPCB.EC0_.ADDR */
                        Store (Arg3, CMDB) /* \_SB_.PCI0.LPCB.EC0_.CMDB */
                        If (LOr (LEqual (Arg1, 0x0A), LEqual (Arg1, 0x0B))) {
                            Store (DerefOf (Index (Arg6, Zero)), BCNT) /* \_SB_.PCI0.LPCB.EC0_.BCNT */
                            WECB(0x1c,256,DerefOf (Index (Arg6, One))) /* \_SB_.PCI0.LPCB.EC0_.BDAT */
                        } Else {
                            Store (Arg4, DAT0) /* \_SB_.PCI0.LPCB.EC0_.DAT0 */
                            Store (Arg5, DAT1) /* \_SB_.PCI0.LPCB.EC0_.DAT1 */
                        }
                        Store (Arg1, PRTC) /* \_SB_.PCI0.LPCB.EC0_.PRTC */
                    } Else {
                        Store (Arg2, ADD2) /* \_SB_.PCI0.LPCB.EC0_.ADD2 */
                        Store (Arg3, CMD2) /* \_SB_.PCI0.LPCB.EC0_.CMD2 */
                        If (LOr (LEqual (Arg1, 0x0A), LEqual (Arg1, 0x0B))) {
                            Store (DerefOf (Index (Arg6, Zero)), BCN2) /* \_SB_.PCI0.LPCB.EC0_.BCN2 */
                            WECB(0x44,256,DerefOf (Index (Arg6, One))) /* \_SB_.PCI0.LPCB.EC0_.BDA2 */
                        } Else {
                            Store (Arg4, DA20) /* \_SB_.PCI0.LPCB.EC0_.DA20 */
                            Store (Arg5, DA21) /* \_SB_.PCI0.LPCB.EC0_.DA21 */
                        }
                        Store (Arg1, PRT2) /* \_SB_.PCI0.LPCB.EC0_.PRT2 */
                    }
                    Store (0x7F, Local0)
                    If (LEqual (Arg0, Zero)) {
                        While (PRTC) {
                            Sleep (One)
                            Decrement (Local0)
                        }
                    } Else {
                        While (PRT2) {
                            Sleep (One)
                            Decrement (Local0)
                        }
                    }
                    If (Local0) {
                        If (LEqual (Arg0, Zero)) {
                            Store (SSTS, Local0)
                            Store (DAT0, Index (Local1, One))
                            Store (DAT1, Index (Local1, 0x02))
                            Store (BCNT, Index (Local1, 0x03))
                            Store (RECB(0x1c,256), Index (Local1, 0x04))
                        } Else {
                            Store (SST2, Local0)
                            Store (DA20, Index (Local1, One))
                            Store (DA21, Index (Local1, 0x02))
                            Store (BCN2, Index (Local1, 0x03))
                            Store (RECB(0x44,256), Index (Local1, 0x04))
                        }
                        And (Local0, 0x1F, Local0)
                        If (Local0) { Add (Local0, 0x10, Local0) }
                        Store (Local0, Index (Local1, Zero))
                    } Else { Store (0x10, Index (Local1, Zero)) }
                }
                Release (MUEC)  
            }
            Return (Local1)
        }

    }
    

}