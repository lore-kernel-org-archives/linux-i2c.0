From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: fix broken timing calculation
Date: Mon, 15 Jul 2013 14:24:32 +0200
Message-ID: <201307151424.32248.marex@denx.de>
References: <1373041680-26939-1-git-send-email-LW@KARO-electronics.de> <201307051937.10975.marex@denx.de> <20963.52588.898163.953695@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20963.52588.898163.953695-VjFSrY7JcPWvSplVBqRQBQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lothar =?iso-8859-1?q?Wa=DFmann?= <LW-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Lothar,

> Hi Mark,
>=20
> Marek Vasut writes:
> > Dear Lothar Wa=DFmann,
> >=20
> > > Hi,
> > >=20
> > > Marek Vasut writes:
> > > > Hi Lothar,
> > > >=20
> > > > > The timing calculation is rather bogus and gives extremely wr=
ong
> > > > > results for higher frequencies (on an i.MX28). E.g. instead o=
f 400
> > > > > kHz I measured 770 kHz.
> > > > >=20
> > > > > Implement a calculation that adheres to the I2C spec and give=
s
> > > > > exact results for I2C frequencies from 12.56 kHz to 960 kHz.
> > > > >=20
> > > > > Also the bus_free and leadin parameters are programmed accord=
ing to
> > > > > the I2C spec for standard and fast mode.
> > > >=20
> > > > I suspect the resulting speed is heavily dependent on hardware
> > > > properties of the bus. Did you have a chance to check it with a
> > > > scope? I will try to recheck on other boards next week.
> > >=20
> > > Of course I did! I found the DS1339 RTC not working on our hardwa=
re
> > > with the I2C clock frequency set to 400kHz and then checked the b=
us
> > > timing. I found the SCL frequency to be 770kHz instead of 400kHz =
and
> > > 113kHz instead of 100kHz.
> > > On what hardware did you do your measurements?
> >=20
> > MX28EVK and M28EVK.
> >=20
> > > The fancy constants -2 and -7 in the calculation were derived fro=
m
> > > measuring the clock low and high time with low_count and high_cou=
nt
> > > set to 1 and measuring the actual timing of the signal.
> > > The clock frequeny in this setup is 2.18 MHz corresponding to 11 =
clock
> > > cycles of the 24MHz clock. The LOW time was about 140ns and the H=
IGH
> > > time 318ns corresponding to 3 and 8 (instead of 1) clock cycles.
> > >=20
> > > These constants could be different for different SoCs (i.MX23).
> > > But I don't have any hardware to verify that.
> >=20
> > I can check it for you on MX23 next week, I have two boards with th=
at
> > chip with well accessible I2C. I am not in the office now, so this =
will
> > have to wait until next week.
>=20
> Did you have time to look into this? And also recheck the timing on
> the i.MX28? Because there obviously is a fundamental discrepancy
> between your and my measurements.

I did not, sorry. I am catching a train to Prague only today, my vacati=
on took a=20
tag longer.

> > btw offtopic, I will at least try to fix the PIO in the meantime.
>=20
> Did you succeed at this? Because this is the real problem for the
> DS1339 failing on our board. With DMA only transfers it works, but
> other chips (TSC2007, PCA9554, SGTL5000) fail.

Is that correct to assume that even DMA fails? So far I got to a patch =
[1],=20
which is almost an RFC, but please give it a go. I suspect I didn't CC =
you, I=20
will CC you on V2.

> I also tried to get the PIO transfers working but didn't have any
> success. Interestingly all the chips mentioned above worked flawlessl=
y
> with the 3.3 kernel. That should exclude any HW deficiencies of our
> modules or the I2C interface of the i.MX28 in general.

At that time, the i2c used the PIOQUEUE mode, but that is not compatibl=
e with=20
MX23. Think of it like this:

        PIO    PIOQUEUE  DMA
MX23  broken      N/A    OK
MX28    OK        OK     OK

So MX23 is really a poor device :(

> What disturbs me most is the sequence of accessing the I2C DATA
> register and clearing the DMAREQ bit. Normally you should clear the
> DMAREQ _before_ accessing the DATA reg, because the access will
> trigger a new assertion of DMAREQ.

=46ully agreed. I spent _days_ on the patch [1] to fully understand the=
 hardware=20
and fix all the fine details of this operation. I also tried to documen=
t it in=20
the code for future adventurers who dare to enter this insanity. The DM=
AREQ bit=20
is nonsense it seems.

> Thus clearing that bit _after_
> the access (like suggested in the i.MX28 Ref Manual and currently
> implemented in the driver) is racy and potentially leads to
> inadvertently clearing a fresh DMAREQ condition.

Yes, indeed.

> But handling it 'the right way' in the driver doesn't improve
> anything.
>=20
>=20
> Lothar Wa=DFmann

[1] http://permalink.gmane.org/gmane.linux.drivers.i2c/15787

Best regards,
Marek Vasut
