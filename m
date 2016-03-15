From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: I2c client driver + ACPI on Baytrail & kernel 4.4.2 = ?
Date: Tue, 15 Mar 2016 23:02:09 +0000
Message-ID: <CA+V1Lzr2pHqwWfdDRinouDJ3CBOMckT9Y-xUsvRi9qZQp1st8A@mail.gmail.com>
References: <CA+V1LzrWqmx2GH6cs65mS=YHkvx+6wnnq7RpeYChH886pn5fog@mail.gmail.com>
	<56E6ACBC.6010508@linux.intel.com>
	<CA+V1LzqgXpm1nERbXD2MPHFFvsv8skm=-BKLdwYU-uU=RQUaYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:32809 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbcCOXCL (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 15 Mar 2016 19:02:11 -0400
Received: by mail-qk0-f182.google.com with SMTP id s5so13984925qkd.0
        for <linux-i2c@vger.kernel.org>; Tue, 15 Mar 2016 16:02:10 -0700 (PDT)
In-Reply-To: <CA+V1LzqgXpm1nERbXD2MPHFFvsv8skm=-BKLdwYU-uU=RQUaYg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org

In addition here is   ACPI DSDT for touch:

          Device (TCS5)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "CHPN0001")  // _HID: Hardware ID
                Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus)
*/)  // _CID: Compatible ID
                Name (_S0W, Zero)  // _S0W: S0 Device Wake State
                Name (_DEP, Package (0x02)  // _DEP: Dependencies
                {
                    GPO1,
                    I2C5
                })
                Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                {
                }

                Method (_PS0, 0, Serialized)  // _PS0: Power State 0
                {
                    If ((^^^GPO1.AVBL == One))
                    {
                        ^^^GPO1.TCD3 = Zero
                    }

                    Sleep (0x05)
                    If ((^^^I2C5.PMI1.AVBG == One))
                    {
                        ^^^I2C5.PMI1.TCON = One
                    }

                    Sleep (0x1E)
                    If ((^^^GPO1.AVBL == One))
                    {
                        ^^^GPO1.TCD3 = One
                    }

                    Sleep (0x78)
                }

                Method (_CRS, 0, NotSerialized)  // _CRS: Current
Resource Settings
                {
                    Name (RBUF, ResourceTemplate ()
                    {
                        I2cSerialBus (0x0030, ControllerInitiated, 0x00061A80,
                            AddressingMode7Bit, "\\_SB.I2C4",
                            0x00, ResourceConsumer, ,
                            )
                        Interrupt (ResourceConsumer, Level,
ActiveHigh, Exclusive, ,, )
                        {
                            0x00000044,
                        }
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.GPO1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x001A
                            }
                    })
                    Return (RBUF) /* \_SB_.I2C4.TCS5._CRS.RBUF */
                }

                Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
                {
                    Name (_T_1, Zero)  // _T_x: Emitted by ASL Compiler
                    Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
                    Debug = "Method _DSM begin"
                    If ((Arg0 == ToUUID
("3cdff6f7-4267-4555-ad05-b30a3d8938de") /* HID I2C Device */))
                    {
                        While (One)
                        {
                            _T_0 = ToInteger (Arg2)
                            If ((_T_0 == Zero))
                            {
                                While (One)
                                {
                                    _T_1 = ToInteger (Arg1)
                                    If ((_T_1 == One))
                                    {
                                        Debug = "Method _DSM Function Query"
                                        Return (Buffer (One)
                                        {
                                             0x03
                       /* . */
                                        })
                                    }
                                    Else
                                    {
                                        Return (Buffer (One)
                                        {
                                             0x00
                       /* . */
                                        })
                                    }

                                    Break
                                }
                            }
                            Else
                            {
                                If ((_T_0 == One))
                                {
                                    Debug = "Method _DSM Function HID"
                                    Return (Zero)
                                }
                                Else
                                {
                                    Return (Zero)
                                }
                            }

                            Break
                        }
                    }
                    Else
                    {
                        Return (Buffer (One)
                        {
                             0x00
       /* . */
                        })
                    }
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((OSSL & 0x80))
                    {
                        Return (Zero)
                    }

                    If ((OSYS == 0x07DD))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (0x0F)
                    }
                }
            }
        }

        Device (I2C5)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Name (_HID, "80860F41" /* Intel Baytrail I2C Host
Controller */)  // _HID: Hardware ID
            Name (_CID, "80860F41" /* Intel Baytrail I2C Host
Controller */)  // _CID: Compatible ID
            Name (_DDN, "Intel(R) I2C Controller #5 - 80860F45")  //
_DDN: DOS Device Name
            Name (_UID, 0x05)  // _UID: Unique ID
            Method (_SEM, 0, NotSerialized)
            {
                If ((((PMID == 0x04) || (PMID == 0x05)) || (PMID == 0x06)))
                {
                    ADBG ("$COVE")
                    Return (One)
                }
                Else
                {
                    ADBG ("CCOVE")
                    Return (Zero)
                }
            }

            Name (_DEP, Package (0x01)  // _DEP: Dependencies
            {
                PEPD
            })
            Name (RBUF, ResourceTemplate ()
            {
                Memory32Fixed (ReadWrite,
                    0x00000000,         // Address Base
                    0x00001000,         // Address Length
                    _Y1C)
                Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, )
                {
                    0x00000024,
                }
                FixedDMA (0x0018, 0x0000, Width32bit, )
                FixedDMA (0x0019, 0x0001, Width32bit, )
            })
            Method (_HRV, 0, NotSerialized)  // _HRV: Hardware Revision
            {
                Return (SOCS) /* \SOCS */
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateDWordField (RBUF, \_SB.I2C5._Y1C._BAS, B0BA)  //
_BAS: Base Address
                CreateDWordField (RBUF, \_SB.I2C5._Y1C._LEN, B0LN)  //
_LEN: Length
                B0BA = I50A /* \I50A */
                B0LN = I50L /* \I50L */
                Return (RBUF) /* \_SB_.I2C5.RBUF */
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (((I50A == Zero) || (L25D == One)))
                {
                    Return (Zero)
                }

                Return (0x0F)
            }

            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
            {
                If ((((PMID == 0x04) || (PMID == 0x05)) || (PMID == 0x06)))
                {
                    Return (Zero)
                }

                PSAT |= 0x03
                Local0 = PSAT /* \_SB_.I2C5.PSAT */
            }

            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
            {
                PSAT &= 0xFFFFFFFC
                Local0 = PSAT /* \_SB_.I2C5.PSAT */
            }

            OperationRegion (KEYS, SystemMemory, I51A, 0x0100)
            Field (KEYS, DWordAcc, NoLock, WriteAsZeros)
            {
                Offset (0x84),
                PSAT,   32
            }

            Name (XPMC, ResourceTemplate ()
            {
                I2cSerialBus (0x0034, ControllerInitiated, 0x00061A80,
                    AddressingMode7Bit, "\\_SB.I2C5",
                    0x00, ResourceConsumer, ,
                    )
            })
            OperationRegion (XSCG, GenericSerialBus, Zero, 0x0100)
            Field (XSCG, BufferAcc, NoLock, Preserve)
            {
                Connection (XPMC),
                AccessAs (BufferAcc, AttribByte),
                XP00,   8,
                XP01,   8
            }

            Field (XSCG, BufferAcc, NoLock, Preserve)
            {
                Connection (XPMC),
                Offset (0xB9),
                AccessAs (BufferAcc, AttribByte),
                XPB9,   8
            }

            Field (XSCG, BufferAcc, NoLock, Preserve)
            {
                Connection (XPMC),
                Offset (0x2C),
                AccessAs (BufferAcc, AttribByte),
                XP2C,   8,
                XP2D,   8,
                XP2E,   8,
                XP2F,   8,
                XP30,   8,
                XP31,   8,
                XP32,   8,
                XP33,   8
            }

            Field (XSCG, BufferAcc, NoLock, Preserve)
            {
                Connection (XPMC),
                Offset (0x2C),
                AccessAs (BufferAcc, AttribBytes (0x0A)),
                XPCG,   8
            }
        }

        Scope (I2C5)
        {
            Name (AVBL, Zero)
            Method (_REG, 2, NotSerialized)  // _REG: Region Availability
            {
                If ((Arg0 == 0x09))
                {
                    AVBL = Arg1
                }
            }

            Device (PMI1)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "INT33F4" /* XPOWER PMIC Controller */)
// _HID: Hardware ID
                Name (_CID, "INT33F4" /* XPOWER PMIC Controller */)
// _CID: Compatible ID
                Name (_DDN, "XPOWER PMIC Controller")  // _DDN: DOS Device Name
                Name (_HRV, 0x02)  // _HRV: Hardware Revision
                Name (_UID, One)  // _UID: Unique ID
                Name (_DEP, Package (0x01)  // _DEP: Dependencies
                {
                    I2C5
                })
                Method (_CRS, 0, NotSerialized)  // _CRS: Current
Resource Settings
                {
                    Name (SBUF, ResourceTemplate ()
                    {
                        I2cSerialBus (0x0034, ControllerInitiated, 0x000F4240,
                            AddressingMode7Bit, "\\_SB.I2C5",
                            0x00, ResourceConsumer, ,
                            )
                        Interrupt (ResourceConsumer, Level,
ActiveHigh, Shared, ,, )
                        {
                            0x00000043,
                        }
                        Interrupt (ResourceConsumer, Level,
ActiveHigh, Shared, ,, )
                        {
                            0x00000043,
                        }
                        Interrupt (ResourceConsumer, Level,
ActiveHigh, Shared, ,, )
                        {
                            0x00000043,
                        }
                    })
                    Return (SBUF) /* \_SB_.I2C5.PMI1._CRS.SBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((PMEN == Zero))
                    {
                        Return (Zero)
                    }

                    If ((PMID == 0x05))
                    {
                        ADBG ("XPWR_DCOVE")
                        Return (0x0F)
                    }

                    Return (Zero)
                }

                OperationRegion (PMOP, 0x8D, Zero, 0x0100)
                Field (PMOP, DWordAcc, NoLock, Preserve)
                {
                    ALD1,   32,
                    ALD2,   32,
                    ALD3,   32,
                    DLD1,   32,
                    DLD2,   32,
                    DLD3,   32,
                    DLD4,   32,
                    ELD1,   32,
                    ELD2,   32,
                    ELD3,   32,
                    FLD1,   32,
                    FLD2,   32,
                    FLD3,   32,
                    BUC1,   32,
                    BUC2,   32,
                    BUC3,   32,
                    BUC4,   32,
                    BUC5,   32,
                    BUC6,   32,
                    GPI1,   32
                }

                OperationRegion (DPTF, 0x8C, Zero, 0x0100)
                Field (DPTF, DWordAcc, NoLock, Preserve)
                {
                    TMP0,   32,
                    AX00,   32,
                    AX01,   32,
                    TMP1,   32,
                    AX10,   32,
                    AX11,   32,
                    TMP2,   32,
                    AX20,   32,
                    AX21,   32,
                    TMP3,   32,
                    AX30,   32,
                    AX31,   32,
                    TMP4,   32,
                    AX40,   32,
                    AX41,   32,
                    TMP5,   32,
                    AX50,   32,
                    AX51,   32,
                    PEN0,   32,
                    PEN1,   32,
                    PEN2,   32,
                    PEN3,   32,
                    PEN4,   32,
                    PEN5,   32
                }

                Name (LPAT, Package (0x30)
                {
                    0x0C13,
                    0x01F4,
                    0x0C27,
                    0x01D3,
                    0x0C3B,
                    0x01B3,
                    0x0C4F,
                    0x0196,
                    0x0C63,
                    0x017B,
                    0x0C77,
                    0x0162,
                    0x0C8B,
                    0x014C,
                    0x0C9F,
                    0x0136,
                    0x0CB3,
                    0x0122,
                    0x0CC7,
                    0x0110,
                    0x0CDB,
                    0xFF,
                    0x0CEF,
                    0xEF,
                    0x0D03,
                    0xE1,
                    0x0D17,
                    0xD4,
                    0x0D2B,
                    0xC7,
                    0x0D3F,
                    0xBB,
                    0x0D53,
                    0xB0,
                    0x0D67,
                    0xA6,
                    0x0D7B,
                    0x9D,
                    0x0D8F,
                    0x94,
                    0x0DA3,
                    0x8C,
                    0x0DB7,
                    0x83,
                    0x0DCB,
                    0x7C,
                    0x0DDF,
                    0x76
                })
                OperationRegion (GPOP, GeneralPurposeIo, Zero, 0x0100)
                Field (GPOP, ByteAcc, NoLock, Preserve)
                {
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0020
                            }
                    ),
                    GMP0,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0021
                            }
                    ),
                    GX00,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0022
                            }
                    ),
                    GX01,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0023
                            }
                    ),
                    GMP1,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0024
                            }
                    ),
                    GX10,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0025
                            }
                    ),
                    GX11,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0026
                            }
                    ),
                    GMP2,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0027
                            }
                    ),
                    GX20,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0028
                            }
                    ),
                    GX21,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0029
                            }
                    ),
                    GMP3,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x002A
                            }
                    ),
                    GX30,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x002B
                            }
                    ),
                    GX31,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x002C
                            }
                    ),
                    GMP4,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x002D
                            }
                    ),
                    GX40,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x002E
                            }
                    ),
                    GX41,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x002F
                            }
                    ),
                    GMP5,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0030
                            }
                    ),
                    GX50,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0031
                            }
                    ),
                    GX51,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0032
                            }
                    ),
                    GEN0,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0033
                            }
                    ),
                    GEN1,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0034
                            }
                    ),
                    GEN2,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0035
                            }
                    ),
                    GEN3,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0036
                            }
                    ),
                    GEN4,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0037
                            }
                    ),
                    GEN5,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0040
                            }
                    ),
                    G28X,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0041
                            }
                    ),
                    G3P3,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0045
                            }
                    ),
                    GD3X,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0047
                            }
                    ),
                    G15X,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0048
                            }
                    ),
                    G18X,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0049
                            }
                    ),
                    GE18,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0053
                            }
                    ),
                    GSDX,   1,
                    Connection (
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.I2C5.PMI1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x000B
                            }
                    ),
                    TCON,   1
                }

                Name (AVBL, Zero)
                Name (AVBD, Zero)
                Name (AVBG, Zero)
                Method (_REG, 2, NotSerialized)  // _REG: Region Availability
                {
                    If ((Arg0 == 0x08))
                    {
                        AVBG = Arg1
                    }

                    If ((Arg0 == 0x8D))
                    {
                        AVBL = Arg1
                    }

                    If ((Arg0 == 0x8C))
                    {
                        AVBD = Arg1
                    }
                }
            }


On Tue, Mar 15, 2016 at 10:26 PM, sergk sergk2mail
<sergk.admin@gmail.com> wrote:
> Hi Jarko,
> Exploring sysfs shows:
>
> ls -l /sys/bus/acpi/devices/CHPN0001:00
> lrwxrwxrwx 1 root root 0 Mar 15 22:08
> /sys/bus/acpi/devices/CHPN0001:00 ->
> ../../../devices/LNXSYSTM:00/LNXSYBUS:00/80860F41:03/CHPN0001:00
> root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/status
> 0
>
> status is 0 - what does this mean? It is detected via ACPI but not present?
> What does "LNXSYBUS:00/80860F41:03"  means?  Does it mean i2c-3, 0x41
> ?  80860F41:03 == ?
>
> also inside its subfolders I do not see nothing useful:
>
> cat /sys/bus/acpi/devices/CHPN0001:00/adr
> 0x00000000
> root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/hid
> CHPN0001
> root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/modalias
> acpi:CHPN0001:PNP0C50:
> root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/path
> \_SB_.I2C4.TCS5
> root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/uevent
> MODALIAS=acpi:CHPN0001:PNP0C50:
> root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/power/runtime_usage
> 0
> root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/power/control
> auto
> root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/power/runtime_enabled
> disabled
>
> So the question is the same - how to obtain via acpi in mentioned
> above code i2cbus, bus addr and irq for this touch?
>
> Regards,
>                  Serge Kolotylo.
>
> On Mon, Mar 14, 2016 at 12:21 PM, Jarkko Nikula
> <jarkko.nikula@linux.intel.com> wrote:
>> Hi
>>
>> On 03/13/2016 02:43 PM, sergk sergk2mail wrote:
>>>
>>> Hi All,
>>> Please help to correct create i2c client with ACPI support for device
>>> (touchscreen) on i2c on vanilla 4.4.2 kernel x86_64 Baytrail,
>>> disrtibutive = Arch.
>>> ========================================================
>>> According kernel Documentation I have created such skeleton:
>>>
>>>
>>> #define DEVICE_NAME  "testme"
>>>
>>> static const struct acpi_device_id icn_ts_acpi_match[] = {
>>>      { "CHPN0001", 0 },
>>>      { "PNP05C0", 0 },
>>>      { },
>>> };
>>
>>
>> Touchscreen and PNPxxxx: can it be i2c-hid compatible touchscreen?
>>
>> Those typically have vendor specific ACPI _HID but device is matched using
>> ACPI PNP compatible ID (_CID) "PNP0C50" or "ACPI0C50". See
>> drivers/hid/i2c-hid/i2c-hid.c.
>>
>> Just thinking if you have device with _CID "PNP0C50" and either device is
>> matched before your driver with i2c-hid driver or your driver doesn't probe
>> because "PNP05C0" != "PNP0C50".
>>
>>> MAIN QUESTIONS:
>>>
>>> 1) What is wrong with i2c client driver code? Why it is NOT obtain
>>> info from ACPI DSD table?
>>>
>> Your example looks ok. Another what comes to my mind is the device actually
>> present. Sometimes DSDT tables may specify multiple alternative devices but
>> only one being actually connected. You could check that by reading the
>> device status which reads 15 if the device is present.
>>
>> cat /sys/bus/acpi/devices/ACPI01234/status
>> 15
>>
>>> 2) In which way should be created i2c dev while registering i2c acpi
>>> driver? Who\where\what and how should create this i2c device?
>>>
>> i2c-core registers the i2c devices connected to certain bus when adapter
>> device for that bus is registered in i2c-core.c: i2c_register_adapter().
>>
>> --
>> Jarkko
