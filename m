From: Christophe Ricard <christophe.ricard@gmail.com>
Subject: Re: [MinnowBoard] Linux x86 I2C device probing with ACPI
Date: Sun, 1 Nov 2015 22:37:48 +0100
Message-ID: <5636862C.40000@gmail.com>
References: <1445455164-5566-1-git-send-email-christophe-h.ricard@st.com>
 <20151022081806.GJ1526@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33723 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbbKAVhw (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 1 Nov 2015 16:37:52 -0500
Received: by wijp11 with SMTP id p11so40389201wij.0
        for <linux-i2c@vger.kernel.org>; Sun, 01 Nov 2015 13:37:51 -0800 (PST)
In-Reply-To: <20151022081806.GJ1526@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: andriy.shevchenko@linux.intel.com, jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org

Hi Mika,

Sorry for the delay.
After forcing _STA method to return 0xF and moving NFC1 node into 
Scope(I2C7) node the probing went through.

Thanks !
Christophe

On 22/10/2015 10:18, Mika Westerberg wrote:
> On Wed, Oct 21, 2015 at 09:19:24PM +0200, Christophe Ricard wrote:
>> From: Christophe Ricard <christophe.ricard@gmail.com>
>>
>> Hi,
>>
>> I am trying to probe slave i2c devices with ACPI running Ubuntu 15.04 and kernel 4.3
>> without success so far.
>>
>> I've followed guidance here:
>> http://elinux.org/Minnowboard:MinnowMaxLinuxKernel <http://elinux.org/Minnowboard:MinnowMaxLinuxKernel>
>>
>> but i found no i2c device are probed at boot.
> By probed do you mean that they are not listed under
> /sys/bus/i2c/devices/ or that a driver is not probed against an existing
> device?
>
>> For example, one default device available in the acpi table is never detected: RTEK node (with ID 10EC5640).
> If the device _STA() method returns 0 then we do not enumerate it. You
> can check this by looking for the corresponding ACPI device node. For
> example I have here I2C connected touch screen:
>
> # cat /sys/bus/acpi/devices/NTRG0001\:00/status
> 15
>
> 15 means that it is there (among other things). Also the device is then
> available as I2C device here:
>
> # ls -1 /sys/bus/i2c/devices/
> i2c-0
> i2c-1
> i2c-2
> i2c-NTRG0001:00
>
>> When adding my own device to I2C7, my device is never detected as well .
>>
>> For example the complete modified I2C7 is at the end of the message.
>>
>> I am compiling the kernel with options:
>> CONFIG_ACPI_CUSTOM_DSDT_FILE="dsdt.hex"
>> CONFIG_ACPI_CUSTOM_DSDT=y
>> CONFIG_ACPI_INITRD_TABLE_OVERRIDE=y
> You don't need the last one.
>
>> I am running on Minnowboard firmware 0.83 with default options.
>>
>> Best Regards
>> Christophe
>>
>>          Device (I2C7)
>>          {
>>              Name (_ADR, Zero)  // _ADR: Address
>>              Name (_HID, "80860F41" /* Intel Baytrail I2C Host Controller */)  // _HID: Hardware ID
>>              Name (_CID, "80860F41" /* Intel Baytrail I2C Host Controller */)  // _CID: Compatible ID
>>              Name (_DDN, "Intel(R) I2C Controller #7 - 80860F47") // _DDN: DOS Device Name
>>              Name (_UID, 0x07)  // _UID: Unique ID
>>              Name (_DEP, Package (One)  // _DEP: Dependencies
>>              {
>>                  PEPD
>>              })
>>              Name (RBUF, ResourceTemplate ()
>>              {
>>                  Memory32Fixed (ReadWrite,
>>                      0x00000000,         // Address Base
>>                      0x00001000,         // Address Length
>>                      _Y1F)
>>                  Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, )
>>                  {
>>                      0x00000026,
>>                  }
>>                  FixedDMA (0x001C, 0x0004, Width32bit, )
>>                  FixedDMA (0x001D, 0x0005, Width32bit, )
>>              })
>>              Method (SSCN, 0, NotSerialized)
>>              {
>>                  Name (PKG, Package (0x03)
>>                  {
>>                      0x0200,
>>                      0x0200,
>>                      0x06
>>                  })
>>                  Return (PKG) /* \_SB_.I2C7.SSCN.PKG_ */
>>              }
>>
>>              Method (FMCN, 0, NotSerialized)
>>              {
>>                  Name (PKG, Package (0x03)
>>                  {
>>                      0x55,
>>                      0x99,
>>                      0x06
>>                  })
>>                  Return (PKG) /* \_SB_.I2C7.FMCN.PKG_ */
>>              }
>>
>>              Method (FPCN, 0, NotSerialized)
>>              {
>>                  Name (PKG, Package (0x03)
>>                  {
>>                      0x1B,
>>                      0x3A,
>>                      0x06
>>                  })
>>                  Return (PKG) /* \_SB_.I2C7.FPCN.PKG_ */
>>              }
>>
>>              Method (_HRV, 0, NotSerialized)  // _HRV: Hardware Revision
>>              {
>>                  Return (SOCS) /* \SOCS */
>>              }
>>
>>              Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>>              {
>>                  CreateDWordField (RBUF, \_SB.I2C7._Y1F._BAS, B0BA)  // _BAS: Base Address
>>                  CreateDWordField (RBUF, \_SB.I2C7._Y1F._LEN, B0LN)  // _LEN: Length
>>                  B0BA = I70A /* \I70A */
>>                  B0LN = I70L /* \I70L */
>>                  Return (RBUF) /* \_SB_.I2C7.RBUF */
>>              }
>>
>>              Method (_STA, 0, NotSerialized)  // _STA: Status
>>              {
>>                  If ((PCIM == One))
>>                  {
>>                      Return (Zero)
>>                  }
>>
>>                  If (((I70A == Zero) || (L27D == One)))
>>                  {
>>                      Return (Zero)
>>                  }
>>
>>                  Return (0x0F)
>>              }
>>
>>              Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
>>              {
>>                  PSAT |= 0x03
>>                  PSAT |= Zero
>>              }
>>
>>              Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
>>              {
>>                  PSAT &= 0xFFFFFFFC
>>                  PSAT |= Zero
>>              }
>>
>>              OperationRegion (KEYS, SystemMemory, I71A, 0x0100)
>>              Field (KEYS, DWordAcc, NoLock, WriteAsZeros)
>>              {
>>                  Offset (0x84),
>>                  PSAT,   32
>>              }
>>
>>              Device (NFC1)
>>              {
>>                  Name (_ADR, Zero)  // _ADR: Address
>>                  Name (_HID, "NXP5441")  // _HID: Hardware ID
>>                  Name (_CID, "NXP5441")  // _CID: Compatible ID
>>                  Name (_DDN, "NXP NFC")  // _DDN: DOS Device Name
>>                  Name (_UID, One)  // _UID: Unique ID
>>                  Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>>                  {
>>                      Name (SBUF, ResourceTemplate ()
>>                      {
>>                          I2cSerialBus (0x0028, ControllerInitiated, 0x00061A80,
>>                              AddressingMode7Bit, "\\_SB.I2C7",
>>                              0x00, ResourceConsumer, ,
>>                              )
>>                          Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, )
>>                          {
>>                              0x00000047,
>>                          }
>>                          GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
>>                              "\\_SB.GPO2", 0x00, ResourceConsumer, ,
>>                              )
>>                              {   // Pin list
>> 				0x0009
>>                              }
>>                          GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
>>                              "\\_SB.GPO2", 0x00, ResourceConsumer, ,
>>                              )
>>                              {   // Pin list
>> 				0x0008
>>                              }
>>                      })
>>                      Return (SBUF) /* \_SB_.I2C7.NFC1._CRS.SBUF */
>>                  }
>>
>>                  Method (_STA, 0, NotSerialized)  // _STA: Status
>>                  {
>>                      If ((NFCS == One))
>>                      {
>>                          Return (0x0F)
>>                      }
>>
>>                      Return (Zero)
> Can you check what following returns?
>
> # cat /sys/bus/acpi/devices/NXP5441:00/status
>
>
>>                  }
>>              }
>>          }
>>
>>          Scope (I2C7)
>>          {
>>          }
>>      }
>>
>>
>>
>> -- 
>> 2.1.4
