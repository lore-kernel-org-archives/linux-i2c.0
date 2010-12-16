From: "Matthias Zacharias" <Matthias.Zacharias-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org>
Subject: Antw: Re: Need help to fix some issues with the linux driver  
	 "i2c-gpio"
Date: Thu, 16 Dec 2010 14:27:13 +0100
Message-ID: <4D0A21C1020000AA00008375@center.bmk-electronics.de>
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
 <4D09F8B7020000AA00008369@center.bmk-electronics.de>
 <20101216135202.38ce671a@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101216135202.38ce671a-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Jean,

>>> Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> schrieb am Donnerstag, 16.
Dezember 2010 um
13:52 in Nachricht <20101216135202.38ce671a-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>:
> On Thu, 16 Dec 2010 11:32:07 +0100, Matthias Zacharias wrote:
>> With the new patch the driver is working fine, also with i2c_debug
=3D
>> 3.
>>=20
>> See the screenshot in my dropbox
>> (http://www.dropbox.com/gallery/16457261/1/I2C_2_MLX90614?h=3D8e2a46=
)
>=20
> Looks good, great. I'll send the patch for review and comments to
both
> the linux-i2c list and LKML later today.
>=20
> Do you want me to list you as a tester in the patch header? If I do
> that, I'll have to include your name and e-mail address, so I need
to
> know if this is OK with you.
>=20

Yes it's OK, you can include me as tester, my name and e-mail address
also.

>> > (...)
>> > Just publish it as is, and I'll review it publicly. It will
>> > certainly take a number of round trips to get it right, if this
is
>> > your first contribution, but that's OK.
>> >
>>=20
>> This MLX90614 driver has a reduced functionality. It was tailored
for
>> our application which use only the temperature read function.
>> Also the SMBus address is fix defined in the source code, and no
>> checkes if the factory preprogramming is correct are done.
>> The option to manage the configuration of the MLX90614 as described
in
>> the datasheets is not yet implemented, because we don't need it.
>=20
> This is totally OK. Others can add functionalities to the driver
later
> if needed.
>=20
>> > (...)
>> > FYI, I have asked Melexis for an MLX90614 evaluation board, they
>> > have sent something to me, so as soon as I receive it I should be
>> > able to test your driver.
>>=20
>> The evalutionboard (EVB) shiped by Melexis uses his own
microcontroller
>> on that board and communicate to the PC via USB. In our system the
>> MLX90614 sensor is connected directly to the port pins of the
>> microcontroller.
>=20
> I know that. I don't plan to actually use the micro-controller on
the
> evaluation board. There are I2C pins on the board, and I'll connect
an
> external I2C master [1] to them.
>=20
> [1] http://www.harbaum.org/till/i2c_tiny_usb/index.shtml=20

This seems to be an interesting board. I'm impressed that it works also
with a smartphone as frontend.

Best regards
Matthias Zacharias

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
