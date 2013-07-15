From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: fix broken timing calculation
Date: Mon, 15 Jul 2013 12:22:36 +0200
Message-ID: <20963.52588.898163.953695@ipc1.ka-ro>
References: <1373041680-26939-1-git-send-email-LW@KARO-electronics.de>
	<201307051853.45786.marex@denx.de>
	<20951.550.818976.677404@ipc1.ka-ro>
	<201307051937.10975.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201307051937.10975.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Mark,

Marek Vasut writes:
> Dear Lothar Wa=C3=9Fmann,
>=20
> > Hi,
> >=20
> > Marek Vasut writes:
> > > Hi Lothar,
> > >=20
> > > > The timing calculation is rather bogus and gives extremely wron=
g
> > > > results for higher frequencies (on an i.MX28). E.g. instead of =
400 kHz
> > > > I measured 770 kHz.
> > > >=20
> > > > Implement a calculation that adheres to the I2C spec and gives =
exact
> > > > results for I2C frequencies from 12.56 kHz to 960 kHz.
> > > >=20
> > > > Also the bus_free and leadin parameters are programmed accordin=
g to
> > > > the I2C spec for standard and fast mode.
> > >=20
> > > I suspect the resulting speed is heavily dependent on hardware pr=
operties
> > > of the bus. Did you have a chance to check it with a scope? I wil=
l try
> > > to recheck on other boards next week.
> >=20
> > Of course I did! I found the DS1339 RTC not working on our hardware
> > with the I2C clock frequency set to 400kHz and then checked the bus
> > timing. I found the SCL frequency to be 770kHz instead of 400kHz an=
d
> > 113kHz instead of 100kHz.
> > On what hardware did you do your measurements?
>=20
> MX28EVK and M28EVK.
>=20
> > The fancy constants -2 and -7 in the calculation were derived from
> > measuring the clock low and high time with low_count and high_count
> > set to 1 and measuring the actual timing of the signal.
> > The clock frequeny in this setup is 2.18 MHz corresponding to 11 cl=
ock
> > cycles of the 24MHz clock. The LOW time was about 140ns and the HIG=
H
> > time 318ns corresponding to 3 and 8 (instead of 1) clock cycles.
> >=20
> > These constants could be different for different SoCs (i.MX23).
> > But I don't have any hardware to verify that.
>=20
> I can check it for you on MX23 next week, I have two boards with that=
 chip with=20
> well accessible I2C. I am not in the office now, so this will have to=
 wait until=20
> next week.
>=20
Did you have time to look into this? And also recheck the timing on
the i.MX28? Because there obviously is a fundamental discrepancy
between your and my measurements.

> btw offtopic, I will at least try to fix the PIO in the meantime.
>=20
Did you succeed at this? Because this is the real problem for the
DS1339 failing on our board. With DMA only transfers it works, but
other chips (TSC2007, PCA9554, SGTL5000) fail.

I also tried to get the PIO transfers working but didn't have any
success. Interestingly all the chips mentioned above worked flawlessly
with the 3.3 kernel. That should exclude any HW deficiencies of our
modules or the I2C interface of the i.MX28 in general.

What disturbs me most is the sequence of accessing the I2C DATA
register and clearing the DMAREQ bit. Normally you should clear the
DMAREQ _before_ accessing the DATA reg, because the access will
trigger a new assertion of DMAREQ. Thus clearing that bit _after_
the access (like suggested in the i.MX28 Ref Manual and currently
implemented in the driver) is racy and potentially leads to
inadvertently clearing a fresh DMAREQ condition.

But handling it 'the right way' in the driver doesn't improve
anything.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org
___________________________________________________________
