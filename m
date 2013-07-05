From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: fix broken timing calculation
Date: Fri, 5 Jul 2013 19:28:06 +0200
Message-ID: <20951.550.818976.677404@ipc1.ka-ro>
References: <1373041680-26939-1-git-send-email-LW@KARO-electronics.de>
	<201307051853.45786.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201307051853.45786.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

Marek Vasut writes:
> Hi Lothar,
>=20
> > The timing calculation is rather bogus and gives extremely wrong
> > results for higher frequencies (on an i.MX28). E.g. instead of 400 =
kHz
> > I measured 770 kHz.
> >=20
> > Implement a calculation that adheres to the I2C spec and gives exac=
t
> > results for I2C frequencies from 12.56 kHz to 960 kHz.
> >=20
> > Also the bus_free and leadin parameters are programmed according to
> > the I2C spec for standard and fast mode.
>=20
> I suspect the resulting speed is heavily dependent on hardware proper=
ties of the=20
> bus. Did you have a chance to check it with a scope? I will try to re=
check on=20
> other boards next week.
>=20
Of course I did! I found the DS1339 RTC not working on our hardware
with the I2C clock frequency set to 400kHz and then checked the bus
timing. I found the SCL frequency to be 770kHz instead of 400kHz and
113kHz instead of 100kHz.
On what hardware did you do your measurements?

The fancy constants -2 and -7 in the calculation were derived from
measuring the clock low and high time with low_count and high_count
set to 1 and measuring the actual timing of the signal.
The clock frequeny in this setup is 2.18 MHz corresponding to 11 clock
cycles of the 24MHz clock. The LOW time was about 140ns and the HIGH
time 318ns corresponding to 3 and 8 (instead of 1) clock cycles.

These constants could be different for different SoCs (i.MX23).
But I don't have any hardware to verify that.

Maybe some guru from Freescale can comment on this and perhaps
document the relationship between the register contents and the actual
timing.



Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org
___________________________________________________________
