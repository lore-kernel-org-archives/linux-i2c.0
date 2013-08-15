From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: fix broken timing calculation
Date: Thu, 15 Aug 2013 23:30:12 +0200
Message-ID: <201308152330.13123.marex@denx.de>
References: <1373041680-26939-1-git-send-email-LW@KARO-electronics.de> <20967.53016.902909.282346@ipc1.ka-ro> <20130815101252.GF2987@katana>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130815101252.GF2987@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Lothar =?iso-8859-1?q?Wa=DFmann?= <LW-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

> On Thu, Jul 18, 2013 at 01:18:48PM +0200, Lothar Wa=DFmann wrote:
> > Hi,
> >=20
> > > > Marek Vasut writes:
> > > > > > > btw offtopic, I will at least try to fix the PIO in the
> > > > > > > meantime.
> > > > > >=20
> > > > > > Did you succeed at this? Because this is the real problem f=
or the
> > > > > > DS1339 failing on our board. With DMA only transfers it wor=
ks,
> > > > > > but other chips (TSC2007, PCA9554, SGTL5000) fail.
> > > > >=20
> > > > > Is that correct to assume that even DMA fails? So far I got t=
o a
> > > > > patch [1], which is almost an RFC, but please give it a go. I
> > > > > suspect I didn't CC you, I will CC you on V2.
> > > >=20
> > > > I applied that patch and all the above mentioned devices seem t=
o work
> > > > with it.
> > > > And with my patch the timing is also correct.
> > >=20
> > > First, please accept my appology for the delay. I finally measure=
d the
> > > bus. Without this patch, I see 107khz at 100kHz setting and 410kH=
z at
> > > 400kHz setting. With this patch I see 93kHz and 307kHz respective=
ly.
> > >=20
> > > I suspect the result really is board-dependent. Can you measure M=
X28EVK
> > > so we know what the result is there please? I don't have one here=
=2E
> >=20
> > No, I don't have an EVK. Obviously the base clock from which the I2=
C
> > clock is derived must be different from 24MHz on your board.
> >=20
> > Can you measure the high and low width of the SCL signal when setti=
ng
> > the HIGH_COUNT and LOW_COUNT to 1 and 10 (0x0a) successively?
> >=20
> > I'm getting a LOW pulse with of:
> > 130ns, 520ns
> > and a HIGH pulse width of:
> > 330ns, 730ns
> >=20
> > Thus the granularity of the timing setting is about 40ns which is
> > close the period of the 24MHz clock of 41.666ns that the SCL timing
> > generation is based on.
>=20
> Ping, waiting for updates. Marek, any time for this?

I talked to Lothar OTR for a little, since the files with measurements =
were big.=20
I think we can apply these as after this patch, the result on both M28E=
VK and=20
MX23EVK is reasonably good.

Please add my Acked-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> and apply.

> Haven't checked in detail if it is a similar issue, yet the designwar=
e
> people had some in-depth discussions about I2C timings and PCB
> influences...

Yes, that's what I am a little worried as the results of my measurement=
s=20
slightly differ on both boards. Maybe we should mull over this stuff a =
little=20
longer, thanks for bringing this up. On the other hand, the results see=
ms close=20
enough to not cause trouble.

Best regards,
Marek Vasut
