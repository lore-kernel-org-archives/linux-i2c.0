From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: fix broken timing calculation
Date: Wed, 17 Jul 2013 19:54:59 +0200
Message-ID: <201307171954.59556.marex@denx.de>
References: <1373041680-26939-1-git-send-email-LW@KARO-electronics.de> <201307151424.32248.marex@denx.de> <20965.3.293494.346855@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20965.3.293494.346855-VjFSrY7JcPWvSplVBqRQBQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lothar =?iso-8859-1?q?Wa=DFmann?= <LW-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dear Lothar Wa=DFmann,

> Hi,
>=20
> Marek Vasut writes:
> > > > btw offtopic, I will at least try to fix the PIO in the meantim=
e.
> > >=20
> > > Did you succeed at this? Because this is the real problem for the
> > > DS1339 failing on our board. With DMA only transfers it works, bu=
t
> > > other chips (TSC2007, PCA9554, SGTL5000) fail.
> >=20
> > Is that correct to assume that even DMA fails? So far I got to a pa=
tch
> > [1], which is almost an RFC, but please give it a go. I suspect I d=
idn't
> > CC you, I will CC you on V2.
>=20
> I applied that patch and all the above mentioned devices seem to work
> with it.
> And with my patch the timing is also correct.

=46irst, please accept my appology for the delay. I finally measured th=
e bus.=20
Without this patch, I see 107khz at 100kHz setting and 410kHz at 400kHz=
 setting.=20
With this patch I see 93kHz and 307kHz respectively.

I suspect the result really is board-dependent. Can you measure MX28EVK=
 so we=20
know what the result is there please? I don't have one here.=20

Best regards,
Marek Vasut
