From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: fix broken timing calculation
Date: Fri, 5 Jul 2013 19:37:10 +0200
Message-ID: <201307051937.10975.marex@denx.de>
References: <1373041680-26939-1-git-send-email-LW@KARO-electronics.de> <201307051853.45786.marex@denx.de> <20951.550.818976.677404@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20951.550.818976.677404-VjFSrY7JcPWvSplVBqRQBQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lothar =?iso-8859-1?q?Wa=DFmann?= <LW-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dear Lothar Wa=DFmann,

> Hi,
>=20
> Marek Vasut writes:
> > Hi Lothar,
> >=20
> > > The timing calculation is rather bogus and gives extremely wrong
> > > results for higher frequencies (on an i.MX28). E.g. instead of 40=
0 kHz
> > > I measured 770 kHz.
> > >=20
> > > Implement a calculation that adheres to the I2C spec and gives ex=
act
> > > results for I2C frequencies from 12.56 kHz to 960 kHz.
> > >=20
> > > Also the bus_free and leadin parameters are programmed according =
to
> > > the I2C spec for standard and fast mode.
> >=20
> > I suspect the resulting speed is heavily dependent on hardware prop=
erties
> > of the bus. Did you have a chance to check it with a scope? I will =
try
> > to recheck on other boards next week.
>=20
> Of course I did! I found the DS1339 RTC not working on our hardware
> with the I2C clock frequency set to 400kHz and then checked the bus
> timing. I found the SCL frequency to be 770kHz instead of 400kHz and
> 113kHz instead of 100kHz.
> On what hardware did you do your measurements?

MX28EVK and M28EVK.

> The fancy constants -2 and -7 in the calculation were derived from
> measuring the clock low and high time with low_count and high_count
> set to 1 and measuring the actual timing of the signal.
> The clock frequeny in this setup is 2.18 MHz corresponding to 11 cloc=
k
> cycles of the 24MHz clock. The LOW time was about 140ns and the HIGH
> time 318ns corresponding to 3 and 8 (instead of 1) clock cycles.
>=20
> These constants could be different for different SoCs (i.MX23).
> But I don't have any hardware to verify that.

I can check it for you on MX23 next week, I have two boards with that c=
hip with=20
well accessible I2C. I am not in the office now, so this will have to w=
ait until=20
next week.

btw offtopic, I will at least try to fix the PIO in the meantime.

> Maybe some guru from Freescale can comment on this and perhaps
> document the relationship between the register contents and the actua=
l
> timing.

Ok, you're taking a third stab at getting FSL to explain how to configu=
re=20
arbitrary clock speeds on the MXS I2C. Good luck ;-D

Best regards,
Marek Vasut
