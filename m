From: fetzerch <fetzer.ch@gmail.com>
Subject: Re: [PATCH v5 0/3] Support multiplexed main SMBus interface on SB800
Date: Sat, 23 Jan 2016 14:47:27 +0100
Message-ID: <56A3846F.9000908@googlemail.com>
References: <1447960429-19256-1-git-send-email-fetzer.ch@gmail.com>
 <20160122135040.6db7b66b@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35388 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbcAWNrb (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sat, 23 Jan 2016 08:47:31 -0500
Received: by mail-wm0-f68.google.com with SMTP id 123so2894656wmz.2
        for <linux-i2c@vger.kernel.org>; Sat, 23 Jan 2016 05:47:30 -0800 (PST)
In-Reply-To: <20160122135040.6db7b66b@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Christian Fetzer <fetzer.ch@gmail.com>
Cc: linux-i2c@vger.kernel.org, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, galandilias@gmail.com

Hi Jean,

On 22.01.2016 13:50, Jean Delvare wrote:
> Hi Christian,
>=20
> On Thu, 19 Nov 2015 20:13:46 +0100, Christian Fetzer wrote:
>> This is an attempt to upstream the patches created by Thomas Brandon=
 and
>> Eddi De Pieri to support the multiplexed main SMBus interface on the=
 SB800
>> chipset. (https://www.mail-archive.com/linux-i2c@vger.kernel.org/msg=
06757.html)
>>
>> I have mainly rebased the latest patch version and tested the driver=
 on a
>> HP ProLiant MicroServer G7 N54L (where this patch allows to access s=
ensor data
>> from a w83795adg).
>>
>> The patched driver is running stable on the machine, given that ic2_=
piix4 is
>> loaded before jc42 and w83795. If jc42 is loaded before i2c_piix4 ca=
lling
>> sensors triggers some errors:
>>     ERROR: Can't get value of subfeature temp1_min_alarm: Can't read
>>
>> While the kernel log shows:
>>     i2c i2c-1: Transaction (pre): CNT=3D0c, CMD=3D05, ADD=3D31, DAT0=
=3D03, DAT1=3Dc0
>>     i2c i2c-1: Error: no response!
>>     i2c i2c-1: Transaction (post): CNT=3D0c, CMD=3D05, ADD=3D31, DAT=
0=3Dff, DAT1=3Dff
>> Unfortunately I don't know how to tackle this specific issue.
>=20
> I think I can explain it. In piix4_setup_sb800() you touch the
> SB800_PIIX4_SMB_IDX port without first taking the mutex that protects
> it. You only take the mutex on transactions (in piix4_access_sb800) n=
ot
> during initialization. If self-probing I2C device drivers such as jc4=
2
> are already loaded before you load i2c-piix4, then as soon as the fir=
st
> SMBus port is registered, i2c-core will try to attach I2C devices to
> it, while at the same time i2c-piix4 is registering the second SMBus
> port. So SB800_PIIX4_SMB_IDX is changed while piix4_access_sb800
> accesses it and chaos happens.
>=20
> I think if we had proper locking in piix4_setup_sb800() then you shou=
ld
> be able to load jc42 first and then i2c-piix4 and it should work fine=
=2E
>=20

Since the problem remains even after your patch, I'll try to provide
more information about the issue.

If i2c_piix4 is loaded before jc42 and w83795 things work as they shoul=
d
and sensors prints values from all modules.

If w83795 is loaded before i2c_piix4, the w83795adg is not detected. I'=
m
not sure though if this is because of i2c_piix4 or just a shortcoming i=
n
the w83795 module.

If jc42 is loaded before i2c_piix4 then the problem described above
occurs. It seems that jc42 tries to read from all multiplexed ports.
This is the full sensors output:

jc42-i2c-0-18
Adapter: SMBus PIIX4 adapter SDA0 at 0b00
RAM1 Temp:    +26.8=B0C  (low  =3D  +0.0=B0C)
                       (high =3D +60.0=B0C, hyst =3D +54.0=B0C)
                       (crit =3D +70.0=B0C, hyst =3D +64.0=B0C)

jc42-i2c-0-19
Adapter: SMBus PIIX4 adapter SDA0 at 0b00
RAM2 Temp:    +26.5=B0C  (low  =3D  +0.0=B0C)
                       (high =3D +60.0=B0C, hyst =3D +54.0=B0C)
                       (crit =3D +70.0=B0C, hyst =3D +64.0=B0C)

k10temp-pci-00c3
Adapter: PCI adapter
CPU Temp:     +30.6=B0C  (high =3D +70.0=B0C)
                       (crit =3D +100.0=B0C, hyst =3D +95.0=B0C)

jc42-i2c-1-18
Adapter: SMBus PIIX4 adapter SDA2 at 0b00
ERROR: Can't get value of subfeature temp1_min_alarm: Can't read
ERROR: Can't get value of subfeature temp1_max_alarm: Can't read
ERROR: Can't get value of subfeature temp1_crit_alarm: Can't read
ERROR: Can't get value of subfeature temp1_min: Can't read
ERROR: Can't get value of subfeature temp1_max: Can't read
ERROR: Can't get value of subfeature temp1_max_hyst: Can't read
ERROR: Can't get value of subfeature temp1_crit: Can't read
ERROR: Can't get value of subfeature temp1_crit_hyst: Can't read
temp1:            N/A  (low  =3D  +0.0=B0C)
                       (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)
                       (crit =3D  +0.0=B0C, hyst =3D  +0.0=B0C)

jc42-i2c-1-19
Adapter: SMBus PIIX4 adapter SDA2 at 0b00
ERROR: Can't get value of subfeature temp1_min_alarm: Can't read
ERROR: Can't get value of subfeature temp1_max_alarm: Can't read
ERROR: Can't get value of subfeature temp1_crit_alarm: Can't read
ERROR: Can't get value of subfeature temp1_min: Can't read
ERROR: Can't get value of subfeature temp1_max: Can't read
ERROR: Can't get value of subfeature temp1_max_hyst: Can't read
ERROR: Can't get value of subfeature temp1_crit: Can't read
ERROR: Can't get value of subfeature temp1_crit_hyst: Can't read
temp1:            N/A  (low  =3D  +0.0=B0C)
                       (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)
                       (crit =3D  +0.0=B0C, hyst =3D  +0.0=B0C)

jc42-i2c-2-18
Adapter: SMBus PIIX4 adapter SDA3 at 0b00
ERROR: Can't get value of subfeature temp1_min_alarm: Can't read
ERROR: Can't get value of subfeature temp1_max_alarm: Can't read
ERROR: Can't get value of subfeature temp1_crit_alarm: Can't read
ERROR: Can't get value of subfeature temp1_min: Can't read
ERROR: Can't get value of subfeature temp1_max: Can't read
ERROR: Can't get value of subfeature temp1_max_hyst: Can't read
ERROR: Can't get value of subfeature temp1_crit: Can't read
ERROR: Can't get value of subfeature temp1_crit_hyst: Can't read
temp1:            N/A  (low  =3D  +0.0=B0C)
                       (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)
                       (crit =3D  +0.0=B0C, hyst =3D  +0.0=B0C)

jc42-i2c-2-19
Adapter: SMBus PIIX4 adapter SDA3 at 0b00
ERROR: Can't get value of subfeature temp1_min_alarm: Can't read
ERROR: Can't get value of subfeature temp1_max_alarm: Can't read
ERROR: Can't get value of subfeature temp1_crit_alarm: Can't read
ERROR: Can't get value of subfeature temp1_min: Can't read
ERROR: Can't get value of subfeature temp1_max: Can't read
ERROR: Can't get value of subfeature temp1_max_hyst: Can't read
ERROR: Can't get value of subfeature temp1_crit: Can't read
ERROR: Can't get value of subfeature temp1_crit_hyst: Can't read
temp1:            N/A  (low  =3D  +0.0=B0C)
                       (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)
                       (crit =3D  +0.0=B0C, hyst =3D  +0.0=B0C)

jc42-i2c-3-18
Adapter: SMBus PIIX4 adapter SDA4 at 0b00
ERROR: Can't get value of subfeature temp1_min_alarm: Can't read
ERROR: Can't get value of subfeature temp1_max_alarm: Can't read
ERROR: Can't get value of subfeature temp1_crit_alarm: Can't read
ERROR: Can't get value of subfeature temp1_min: Can't read
ERROR: Can't get value of subfeature temp1_max: Can't read
ERROR: Can't get value of subfeature temp1_max_hyst: Can't read
ERROR: Can't get value of subfeature temp1_crit: Can't read
ERROR: Can't get value of subfeature temp1_crit_hyst: Can't read
temp1:            N/A  (low  =3D  +0.0=B0C)
                       (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)
                       (crit =3D  +0.0=B0C, hyst =3D  +0.0=B0C)

jc42-i2c-3-19
Adapter: SMBus PIIX4 adapter SDA4 at 0b00
ERROR: Can't get value of subfeature temp1_min_alarm: Can't read
ERROR: Can't get value of subfeature temp1_max_alarm: Can't read
ERROR: Can't get value of subfeature temp1_crit_alarm: Can't read
ERROR: Can't get value of subfeature temp1_min: Can't read
ERROR: Can't get value of subfeature temp1_max: Can't read
ERROR: Can't get value of subfeature temp1_max_hyst: Can't read
ERROR: Can't get value of subfeature temp1_crit: Can't read
ERROR: Can't get value of subfeature temp1_crit_hyst: Can't read
temp1:            N/A  (low  =3D  +0.0=B0C)
                       (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)
                       (crit =3D  +0.0=B0C, hyst =3D  +0.0=B0C)
