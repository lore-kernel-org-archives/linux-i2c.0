From: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c, i2c_imc: Add DIMM bus code
Date: Sun, 8 Mar 2015 07:09:08 -0700
Message-ID: <CALCETrV2YeBi2+kZqdihLRPt=JLNr0A+LYxdv=-++YJ29OtOaw@mail.gmail.com>
References: <cover.1425695891.git.luto@amacapital.net> <4ec9e7471354b350936ffa75e94125b169d14690.1425695891.git.luto@amacapital.net>
 <54FB2154.7000701@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54FB2154.7000701-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rui Wang <ruiv.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Alun Evans <alun-eX+YDEU5biwsV2N9l4h3zg@public.gmane.org>, Robert Elliott <Elliott-VXdhtT5mjnY@public.gmane.org>, Boaz Harrosh <boaz-/8YdC2HfS5554TAoqtyWWQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Mar 7, 2015 at 8:03 AM, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
> On 03/06/2015 06:50 PM, Andy Lutomirski wrote:
>>
>> Add i2c_scan_dimm_bus to declare that a particular i2c_adapter
>> contains DIMMs.  This will probe (and autoload modules!) for useful
>> SMBUS devices that live on DIMMs.  i2c_imc calls it.
>>
>> As more SMBUS-addressable DIMM components become supported, this
>> code can be extended to probe for them.
>>
>> Signed-off-by: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
>
>
> Similar to the other patch, I would suggest to run it through checkpatch.
>

Done for both patches.

>
>> ---
>>   drivers/i2c/busses/Kconfig    |  4 ++
>>   drivers/i2c/busses/Makefile   |  4 ++
>>   drivers/i2c/busses/dimm-bus.c | 97
>> +++++++++++++++++++++++++++++++++++++++++++
>>   drivers/i2c/busses/i2c-imc.c  |  3 ++
>>   include/linux/i2c/dimm-bus.h  | 24 +++++++++++
>>   5 files changed, 132 insertions(+)
>>   create mode 100644 drivers/i2c/busses/dimm-bus.c
>>   create mode 100644 include/linux/i2c/dimm-bus.h
>>
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index d6b9ce164fbf..2ea6648492eb 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -149,6 +149,10 @@ config I2C_ISMT
>>           This driver can also be built as a module.  If so, the module
>> will be
>>           called i2c-ismt.
>>
>> +config I2C_DIMM_BUS
>> +       tristate
>> +       default n
>> +
>>   config I2C_IMC
>>         tristate "Intel iMC (LGA 2011) SMBus Controller"
>>         depends on PCI && X86
>> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
>> index 4287c891e782..a01bdcc0e239 100644
>> --- a/drivers/i2c/busses/Makefile
>> +++ b/drivers/i2c/busses/Makefile
>> @@ -25,6 +25,10 @@ obj-$(CONFIG_I2C_SIS96X)     += i2c-sis96x.o
>>   obj-$(CONFIG_I2C_VIA)         += i2c-via.o
>>   obj-$(CONFIG_I2C_VIAPRO)      += i2c-viapro.o
>>
>> +# DIMM busses
>> +obj-$(CONFIG_I2C_DIMM_BUS)     += dimm-bus.o
>> +obj-$(CONFIG_I2C_IMC)          += i2c-imc.o
>> +
>>   # Mac SMBus host controller drivers
>>   obj-$(CONFIG_I2C_HYDRA)               += i2c-hydra.o
>>   obj-$(CONFIG_I2C_POWERMAC)    += i2c-powermac.o
>> diff --git a/drivers/i2c/busses/dimm-bus.c b/drivers/i2c/busses/dimm-bus.c
>> new file mode 100644
>> index 000000000000..096842811199
>> --- /dev/null
>> +++ b/drivers/i2c/busses/dimm-bus.c
>> @@ -0,0 +1,97 @@
>> +/*
>> + * Copyright (c) 2013 Andrew Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
>
>
> 2013 ?
>

Fixed.  It's been a long time since I wrote most of this code...

>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2
>> + * as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>> + */
>> +
>> +#include <linux/i2c.h>
>> +#include <linux/bug.h>
>> +#include <linux/module.h>
>> +#include <linux/i2c/dimm-bus.h>
>> +
>> +static bool probe_addr(struct i2c_adapter *adapter, int addr)
>> +{
>> +       /*
>> +        * So far, all known devices that live on DIMMs can be safely
>> +        * and reliably detected by trying to read a byte at address
>> +        * zero.  (The exception is the SPD write protection control,
>> +        * which can't be probed and requires special hardware and/or
>> +        * quick writes to access, and has no driver.)
>> +        */
>
>
> That leads to the question if the controller supports quick commands,
> and if it does, if would make sense to add support for it,
> just for the purpose of reducing risk here.

I don't think it supports them, and even if it did, I don't know how
to test them since I don't have an obvious i2c slave device to poke at
with them.  I have a friend with logic analyzers, though...

>
>
>> +       union i2c_smbus_data dummy;
>> +       return i2c_smbus_xfer(adapter, addr, 0, I2C_SMBUS_READ, 0,
>> +                             I2C_SMBUS_BYTE_DATA, &dummy) >= 0;
>> +}
>> +
>> +/**
>> + * i2c_scan_dimm_bus() - Scans an SMBUS segment known to contain DIMMs
>> + * @adapter: The SMBUS adapter to scan
>> + *
>> + * This function tells the DIMM-bus code that the adapter is known to
>> + * contain DIMMs.  i2c_scan_dimm_bus will probe for devices known to
>> + * live on DIMMs.
>> + *
>> + * Do NOT call this function on general-purpose system SMBUS segments
>> + * unless you know that the only things on the bus are DIMMs.
>> + * Otherwise is it very likely to mis-identify other things on the
>> + * bus.
>> + *
>> + * Callers are advised not to set adapter->class = I2C_CLASS_SPD.
>
>
> Why not ?
>

It could make the legacy eeprom driver try to bind to the bus if it's
loaded.  I improved the comment.

>> + */
>> +void i2c_scan_dimm_bus(struct i2c_adapter *adapter)
>> +{
>> +       struct i2c_board_info info = {};
>> +       int slot;
>> +
>> +       /*
>> +        * We probe with "read byte data".  If any DIMM SMBUS driver can't
>> +        * support that access type, this function should be updated.
>> +        */
>> +       if (WARN_ON(!i2c_check_functionality(adapter,
>> +                                         I2C_FUNC_SMBUS_READ_BYTE_DATA)))
>> +               return;
>> +
>> +       /*
>> +        * Addresses on DIMMs use the three low bits to identify the slot
>> +        * and the four high bits to identify the device type.  Known
>> +        * devices are:
>> +        *
>> +        *  - 0x50 - 0x57: SPD (Serial Presence Detect) EEPROM
>> +        *  - 0x30 - 0x37: SPD WP control -- not worth trying to probe
>
>
> Not worth, or just "not probed" ?

Not obviously safe to probe, and not really useful even if we could do
it.  Comment updated.

>
>> +        *  - 0x18 - 0x1f: TSOD (Temperature Sensor on DIMM)
>> +        *
>> +        * There may be more some day.
>
>
> That is always a possibility. Does that really warrant this comment ?

No.  I removed that.

>
>> +        */
>> +       for (slot = 0; slot < 8; slot++) {
>> +               /* If there's no SPD, then assume there's no DIMM here. */
>> +               if (!probe_addr(adapter, 0x50 | slot))
>> +                       continue;
>> +
>> +               strcpy(info.type, "spd");
>> +               info.addr = 0x50 | slot;
>> +               i2c_new_device(adapter, &info);
>> +
>> +               if (probe_addr(adapter, 0x18 | slot)) {
>> +                       /* This is a temperature sensor. */
>> +                       strcpy(info.type, "jc42");
>> +                       info.addr = 0x18 | slot;
>> +                       i2c_new_device(adapter, &info);
>
>
> How are those devices removed ? Might warrant an explanation.
>

The core handles it.  I added a comment.

--Andy
