From: Christian Fetzer <fetzer.ch@gmail.com>
Subject: Re: [PATCH v5 0/3] Support multiplexed main SMBus interface on SB800
Date: Mon, 25 Jan 2016 22:53:58 +0100
Message-ID: <954A8999-E933-4D1D-BF69-238DAD299F79@gmail.com>
References: <1447960429-19256-1-git-send-email-fetzer.ch@gmail.com> <20160122135040.6db7b66b@endymion.delvare> <56A3846F.9000908@googlemail.com> <20160125121314.73acc965@endymion.delvare>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36713 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932124AbcAYVyC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 25 Jan 2016 16:54:02 -0500
Received: by mail-wm0-f67.google.com with SMTP id l65so13832314wmf.3
        for <linux-i2c@vger.kernel.org>; Mon, 25 Jan 2016 13:54:02 -0800 (PST)
In-Reply-To: <20160125121314.73acc965@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, galandilias@gmail.com

Hi Jean,

> Am 25.01.2016 um 12:13 schrieb Jean Delvare <jdelvare@suse.de>:
>=20
> Hi Christian,
>=20
> On Sat, 23 Jan 2016 14:47:27 +0100, fetzerch wrote:
>> On 22.01.2016 13:50, Jean Delvare wrote:
>>> On Thu, 19 Nov 2015 20:13:46 +0100, Christian Fetzer wrote:
>>>> The patched driver is running stable on the machine, given that ic=
2_piix4 is
>>>> loaded before jc42 and w83795. If jc42 is loaded before i2c_piix4 =
calling
>>>> sensors triggers some errors:
>>>>    ERROR: Can't get value of subfeature temp1_min_alarm: Can't rea=
d
>>>>=20
>>>> While the kernel log shows:
>>>>    i2c i2c-1: Transaction (pre): CNT=3D0c, CMD=3D05, ADD=3D31, DAT=
0=3D03, DAT1=3Dc0
>>>>    i2c i2c-1: Error: no response!
>>>>    i2c i2c-1: Transaction (post): CNT=3D0c, CMD=3D05, ADD=3D31, DA=
T0=3Dff, DAT1=3Dff
>>>> Unfortunately I don't know how to tackle this specific issue.
>>>=20
>>> I think I can explain it. In piix4_setup_sb800() you touch the
>>> SB800_PIIX4_SMB_IDX port without first taking the mutex that protec=
ts
>>> it. You only take the mutex on transactions (in piix4_access_sb800)=
 not
>>> during initialization. If self-probing I2C device drivers such as j=
c42
>>> are already loaded before you load i2c-piix4, then as soon as the f=
irst
>>> SMBus port is registered, i2c-core will try to attach I2C devices t=
o
>>> it, while at the same time i2c-piix4 is registering the second SMBu=
s
>>> port. So SB800_PIIX4_SMB_IDX is changed while piix4_access_sb800
>>> accesses it and chaos happens.
>>>=20
>>> I think if we had proper locking in piix4_setup_sb800() then you sh=
ould
>>> be able to load jc42 first and then i2c-piix4 and it should work fi=
ne.
>>=20
>> Since the problem remains even after your patch, I'll try to provide
>> more information about the issue.
>=20
> OK, I think I see what's going on here.
>=20
> The i2c buses begin to exist for the kernel when i2c_add_adapter()
> is called. This happens in piix4_add_adapter(), which is called from
> two sites: piix4_probe() directly for the legacy devices and for the
> aux SMBus controller, and piix4_add_adapters_sb800() for the muxed ma=
in
> controller of the SB800.
>=20
> Now if you look at piix4_add_adapters_sb800(), you can see that right
> _after_ calling piix4_add_adapter(), the code grabs the
> adapter-specific data (struct i2c_piix4_adapdata *adapdata) and sets
> two fields there: sb800_main and port. While sb800_main isn't needed
> before module removal in piix4_adap_remove(), port is used in
> piix4_access_sb800(), which can be called immediately after
> i2c_add_adapter() returns (possibly even slightly before that.)
>=20
> So we have a small window during which piix4_access_sb800() can be
> called and adapdata->port has not been set yet, so it still has its
> default value of 0 for all ports. Hence the kernel reads from port 0
> for all of SMBus channels 0, 2, 3 and 4. This completely explains the
> symptoms you described.
>=20
> Additionally I see that the algorithm is overwritten also right after
> piix4_add_adapter() is called. So odds are that piix4_access_sb800()
> isn't even called when the already loaded jc42 or w83795 driver probe=
s
> for devices. Instead piix4_access() is called, so no locking and no
> port selection takes place at all.
>=20
> The only right way to handle this is to set all fields of the
> i2c_adapter _and_ its associated struct i2c_piix4_adapdata _before_
> i2c_add_adapter() is called. Anything else is just racy by design.
>=20
> I'll post a patch for you to try shortly.
>=20
> --=20
> Jean Delvare
> SUSE L3 Support

Thanks for the explanation, I=E2=80=99ve successfully tested your chang=
e and can confirm that it fixes the problem.
I=E2=80=99ve loaded i2c_piix4, jc42 and w83795 in all possible permutat=
ions and sensors is now able to correctly access the sensor values inde=
pendently from the module load order.

Cheers,
Christian