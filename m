From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: fix broken timing calculation
Date: Tue, 16 Jul 2013 10:10:43 +0200
Message-ID: <20965.3.293494.346855@ipc1.ka-ro>
References: <1373041680-26939-1-git-send-email-LW@KARO-electronics.de>
	<201307051937.10975.marex@denx.de>
	<20963.52588.898163.953695@ipc1.ka-ro>
	<201307151424.32248.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201307151424.32248.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

Marek Vasut writes:
> > > btw offtopic, I will at least try to fix the PIO in the meantime.
> >=20
> > Did you succeed at this? Because this is the real problem for the
> > DS1339 failing on our board. With DMA only transfers it works, but
> > other chips (TSC2007, PCA9554, SGTL5000) fail.
>=20
> Is that correct to assume that even DMA fails? So far I got to a patc=
h [1],=20
> which is almost an RFC, but please give it a go. I suspect I didn't C=
C you, I=20
> will CC you on V2.
>=20
I applied that patch and all the above mentioned devices seem to work
with it.
And with my patch the timing is also correct.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org
___________________________________________________________
