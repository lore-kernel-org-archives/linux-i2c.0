From: "Matthias Zacharias" <Matthias.Zacharias-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org>
Subject: Antw: Re: Need help to fix some issues with the linux driver
	 "i2c-gpio"
Date: Thu, 16 Dec 2010 11:32:07 +0100
Message-ID: <4D09F8B7020000AA00008369@center.bmk-electronics.de>
References: <4CF4DF5E020000AA0000808F@center.bmk-electronics.de>
 <20101130182150.3bbc8f01@endymion.delvare>
 <4CF62AFD020000AA000080E3@center.bmk-electronics.de>
 <20101202172322.43ea4698@endymion.delvare>
 <4CFCB095020000AA00008187@center.bmk-electronics.de>
 <20101206112557.3dc8ffe3@endymion.delvare>
 <4D025397020000AA00008248@center.bmk-electronics.de>
 <20101211172336.35c434ef@endymion.delvare>
 <4D0789C5020000AA00008346@center.bmk-electronics.de>
 <20101214175828.0a62ce3f@endymion.delvare>
 <4D08C6B2020000AA0000835E@center.bmk-electronics.de>
 <20101215154255.20d471a4@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101215154255.20d471a4-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Jean,

With the new patch the driver is working fine, also with i2c_debug =3D
3.

See the screenshot in my dropbox
(http://www.dropbox.com/gallery/16457261/1/I2C_2_MLX90614?h=3D8e2a46)

>>> Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> schrieb am Mittwoch, 15. Dezember
2010 um
15:42 in Nachricht <20101215154255.20d471a4-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>:
> Hallo Matthias,
>=20
> On Wed, 15 Dec 2010 13:46:26 +0100, Matthias Zacharias wrote:
>> Thank you for the new patch.
>> I tried it and it works fine for our system with i2c_debug < 2.
>=20
> Great, thanks for the feedback.
>=20
>> For i2c_debug >=3D2 the debug outputs leads to timeout condition whe=
n
>> address should be acknowledged.
>=20
> Hmm, calling printk() with the spinlock held wasn't the smartest
thing
> to do, I guess. Updated patch attached, I've made sure to always
> release the spinlock before calling bit_dbg(), hopefully it should
fix
> your last issue.
>=20
>> I'll try to publish the "mlx90614" driver after doing some
>> optimizations. Are you interested to review this driver before,
because
>> it is the first driver we try to publish?
>=20
> Just publish it as is, and I'll review it publicly. It will
certainly
> take a number of round trips to get it right, if this is your first
> contribution, but that's OK.
>

This MLX90614 driver has a reduced functionality. It was tailored for
our application which use only the temperature read function.
Also the SMBus address is fix defined in the source code, and no
checkes if the factory preprogramming is correct are done.
The option to manage the configuration of the MLX90614 as described in
the datasheets is not yet implemented, because we don't need it.
=20
> FYI, I have asked Melexis for an MLX90614 evaluation board, they
have
> sent something to me, so as soon as I receive it I should be able to
> test your driver.
>=20

The evalutionboard (EVB) shiped by Melexis uses his own microcontroller
on that board and communicate to the PC via USB. In our system the
MLX90614 sensor is connected directly to the port pins of the
microcontroller.

>> Do plan to include your patch on the "i2c-algo-bit" into the
lastest
>> kernel?
>=20
> Yes. Please test the new version of the patch, and if it works OK
for
> you, I'll schedule it for merge in kernel 2.6.38. For 2.6.37 it's
too
> late, the patch is quite intrusive and i2c-algo-bit is used by many
> many drivers including very popular ones, so I can't merge it that
late
> in the release cycle.
>=20
>> I had applied the patch and done my tests on the 2.6.25.4 kernel,
with
>> a bunch of other patches needed for my system.=20
>>=20
>> Thanks a lot for your fast and good support for fixing this issue
we
>> had.
>=20
> You're welcome.

Best regards
Matthias Zacharias
matthias.zacharias-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org

--------------------
BMK electronic solutions GmbH
Werner-von-Siemens-Str. 6, Eingang 18 f
D-86159 Augsburg
Tel. +49 (0) 821 / 207 88 - 700
=46ax +49 (0) 821 / 207 88 - 721
info-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org
Gesch=C3=A4ftsf=C3=BChrer: Dipl.-oec. Alois Kn=C3=B6ferle
Sitz: Augsburg
HR-Nr.: B21197
---------------------

Diese E-mail kann vertrauliche Informationen enthalten. Falls Sie diese
E-Mail irrt=C3=BCmlich erhalten haben, informieren Sie bitte unverz=C3=BC=
glich den
Absender und l=C3=B6schen Sie diese E-Mail von jedem Rechner, auch von =
den
Mailservern. Jede Verbreitung des Inhalts, auch die teilweise
Verbreitung, ist in diesem Fall untersagt. Au=C3=9Fer bei Vorsatz oder =
grober
=46ahrl=C3=A4ssigkeit schliessen wir jegliche Haftung f=C3=BCr Verluste=
 oder Sch=C3=A4den
aus, die durch Viren befallene Software oder E-Mails verursacht werden.

This e-mail may contain confidential information. If you received this
e-mail in error, please contact the sender and delete this e-mail from
your computer, including your mailservers. Any dissemination, even
partly, is prohibited. Except in case of gross negligence or wilful
misconduct we accept no liability for any loss or damage caused by
software or e-mail viruses.
