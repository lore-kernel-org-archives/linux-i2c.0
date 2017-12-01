From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: BUG: support for at24 multi-slave-address eeproms is broken.
Date: Fri, 1 Dec 2017 11:04:29 +0100
Message-ID: <CAMRc=MexK_HNGgzNmavoXp4X_8LP3zn22gc3+RwVLVXn4PF5cw@mail.gmail.com>
References: <1512068603-12378-1-git-send-email-svendev@arcx.com> <20171130223458.g2gvv3ura2aygzeq@kekkonen.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f182.google.com ([74.125.82.182]:46912 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbdLAKEa (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 1 Dec 2017 05:04:30 -0500
Received: by mail-ot0-f182.google.com with SMTP id j2so8583064ota.13
        for <linux-i2c@vger.kernel.org>; Fri, 01 Dec 2017 02:04:30 -0800 (PST)
In-Reply-To: <20171130223458.g2gvv3ura2aygzeq@kekkonen.localdomain>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Sven Van Asbroeck <svendev@arcx.com>, linux-kernel@vger.kernel.org, linux-i2c <linux-i2c@vger.kernel.org>, divagar.mohandass@intel.com

2017-11-30 23:34 GMT+01:00 Sakari Ailus <sakari.ailus@linux.intel.com>:
> Hi Sven,
>
> On Thu, Nov 30, 2017 at 02:03:23PM -0500, Sven Van Asbroeck wrote:
>> Summary
>> -------
>> Some at24 eeproms have multiple i2c slave addresses. A patch introduced
>> between 4.14-rc5 and 4.14-rc6 breaks support for these eeproms:
>> reads/writes which start outside the first slave no longer work.
>>
>> 98e8201039afad5d2af87df9ac682f62f69c0c2f
>> (eeprom: at24: enable runtime pm support)
>>
>> How to reproduce
>> ----------------
>> - I'm using the latest mainline at24 driver (4.15-rc1)
>> - I have a 24AA16/24LC16B on board, which is a 2048-byte eeprom,
>>       made up of 8x 256-byte internal eeproms, all with their own i2c sl=
ave
>>       address. Base i2c address is 0x50, so this results in the followin=
g
>>       slave addresses: 0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57 of
>>       256 bytes each.
>
> Thank you for reporting this.
>
>>
>> $ ls -l /sys/bus/i2c/devices/1-0050/eeprom
>> -rw-------    1 root     root          2048 Nov 30 13:16 /sys/bus/i2c/de=
vices/1-0050/eeprom
>>
>> Reading from the beginning to the end in one go works just fine:
>> $ hexdump -C /sys/bus/i2c/devices/1-0050/eeprom
>> 00000000  f8 6e cf 01 ff 01 00 00  03 00 58 41 18 00 00 00  |.n........X=
A....|
>> 00000010  53 61 74 20 4d 61 72 20  31 32 20 31 32 3a 35 35  |Sat Mar 12 =
12:55|
>> 00000020  3a 31 32 20 32 30 31 36  01 00 58 41 0f 00 00 00  |:12 2016..X=
A....|
>> 00000030  41 58 4d 2d 55 50 33 32  39 32 2d 30 38 32 34 00  |AXM-UP3292-=
0824.|
>> 00000040  02 00 58 41 0d 00 00 00  41 58 53 2d 55 50 33 4b  |..XA....AXS=
-UP3K|
>> 00000050  2d 30 32 30 34 00 00 00  04 00 58 41 09 00 00 00  |-0204.....X=
A....|
>> 00000060  55 4e 54 31 34 30 30 42  34 00 00 00 0a 00 58 41  |UNT1400B4..=
...XA|
>> 00000070  01 00 00 00 32 00 00 00  09 00 58 41 01 00 00 00  |....2.....X=
A....|
>> 00000080  31 00 00 00 01 00 00 00  32 00 00 00 01 00 00 00  |1.......2..=
.....|
>> 00000090  32 00 00 00 ff ff ff ff  ff ff ff ff ff ff ff ff  |2..........=
.....|
>> 000000a0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |...........=
.....|
>> *
>> 00000800
>>
>> Reading from somewhere in the middle (outside of first slave) gives
>> EACCESS:
>> $ dd if=3D/sys/bus/i2c/devices/1-0050/eeprom bs=3D1 skip=3D520 count=3D2=
0
>> dd: /sys/bus/i2c/devices/1-0050/eeprom: Permission denied
>>
>> Reading from somewhere in the middle (INSIDE of first slave) still works=
:
>> $ dd if=3D/sys/bus/i2c/devices/1-0050/eeprom bs=3D1 skip=3D20 count=3D20=
 | hexdump -C
>> 00000000  4d 61 72 20 31 32 20 31  32 3a 35 35 3a 31 32 20  |Mar 12 12:5=
5:12 |
>> 00000010  32 30 31 36                                       |2016|
>> 00000014
>>
>> Additional questions for the patch authors
>> ------------------------------------------
>> 1. why is there a need to add pm_runtime support to a series of chips
>> (at24) which do not have any power management registers, hardware or
>> support ?
>
> Power management is not a property of the chip itself, it's external to i=
t.
>
> The motivation for the patch was that the chip is powered together with
> other chips in a camera module. If it is not powered off, all other devic=
es
> in the module will remain powered. This is undesirable.
>
>>
>> 2. why is the at24's pm_runtime support operating on its parent i2c bus?
>> Why can't the parent i2c bus driver be in charge of its own runtime pm?
>
> This is device specific, the I=C2=B2C bus driver doesn't know about it.
>
> I have a patch that should address the problem, let me know if it works f=
or
> you.
>
> --
> Kind regards,
>
> Sakari Ailus
> sakari.ailus@linux.intel.com

Thanks for taking care of it!

@Sven: it would be great if you could test it and add your Tested-by
to the patch. I'll then queue it for 4.15.

Thanks,
Bartosz
