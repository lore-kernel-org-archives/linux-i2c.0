From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: fix broken timing calculation
Date: Thu, 18 Jul 2013 13:18:48 +0200
Message-ID: <20967.53016.902909.282346@ipc1.ka-ro>
References: <1373041680-26939-1-git-send-email-LW@KARO-electronics.de>
	<201307151424.32248.marex@denx.de>
	<20965.3.293494.346855@ipc1.ka-ro>
	<201307171954.59556.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201307171954.59556.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

> > Marek Vasut writes:
> > > > > btw offtopic, I will at least try to fix the PIO in the meant=
ime.
> > > >=20
> > > > Did you succeed at this? Because this is the real problem for t=
he
> > > > DS1339 failing on our board. With DMA only transfers it works, =
but
> > > > other chips (TSC2007, PCA9554, SGTL5000) fail.
> > >=20
> > > Is that correct to assume that even DMA fails? So far I got to a =
patch
> > > [1], which is almost an RFC, but please give it a go. I suspect I=
 didn't
> > > CC you, I will CC you on V2.
> >=20
> > I applied that patch and all the above mentioned devices seem to wo=
rk
> > with it.
> > And with my patch the timing is also correct.
>=20
> First, please accept my appology for the delay. I finally measured th=
e bus.=20
> Without this patch, I see 107khz at 100kHz setting and 410kHz at 400k=
Hz setting.=20
> With this patch I see 93kHz and 307kHz respectively.
>=20
> I suspect the result really is board-dependent. Can you measure MX28E=
VK so we=20
> know what the result is there please? I don't have one here.=20
>=20
No, I don't have an EVK. Obviously the base clock from which the I2C
clock is derived must be different from 24MHz on your board.

Can you measure the high and low width of the SCL signal when setting
the HIGH_COUNT and LOW_COUNT to 1 and 10 (0x0a) successively?

I'm getting a LOW pulse with of:
130ns, 520ns
and a HIGH pulse width of:
330ns, 730ns

Thus the granularity of the timing setting is about 40ns which is
close the period of the 24MHz clock of 41.666ns that the SCL timing
generation is based on.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org
___________________________________________________________
