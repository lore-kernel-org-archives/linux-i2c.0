From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: fix broken timing calculation
Date: Thu, 15 Aug 2013 12:12:52 +0200
Message-ID: <20130815101252.GF2987@katana>
References: <1373041680-26939-1-git-send-email-LW@KARO-electronics.de>
 <201307151424.32248.marex@denx.de>
 <20965.3.293494.346855@ipc1.ka-ro>
 <201307171954.59556.marex@denx.de>
 <20967.53016.902909.282346@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="udcq9yAoWb9A4FsZ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20967.53016.902909.282346-VjFSrY7JcPWvSplVBqRQBQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lothar =?iso-8859-15?Q?Wa=DFmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--udcq9yAoWb9A4FsZ
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2013 at 01:18:48PM +0200, Lothar Wa=DFmann wrote:
> Hi,
>=20
> > > Marek Vasut writes:
> > > > > > btw offtopic, I will at least try to fix the PIO in the meantim=
e.
> > > > >=20
> > > > > Did you succeed at this? Because this is the real problem for the
> > > > > DS1339 failing on our board. With DMA only transfers it works, but
> > > > > other chips (TSC2007, PCA9554, SGTL5000) fail.
> > > >=20
> > > > Is that correct to assume that even DMA fails? So far I got to a pa=
tch
> > > > [1], which is almost an RFC, but please give it a go. I suspect I d=
idn't
> > > > CC you, I will CC you on V2.
> > >=20
> > > I applied that patch and all the above mentioned devices seem to work
> > > with it.
> > > And with my patch the timing is also correct.
> >=20
> > First, please accept my appology for the delay. I finally measured the =
bus.=20
> > Without this patch, I see 107khz at 100kHz setting and 410kHz at 400kHz=
 setting.=20
> > With this patch I see 93kHz and 307kHz respectively.
> >=20
> > I suspect the result really is board-dependent. Can you measure MX28EVK=
 so we=20
> > know what the result is there please? I don't have one here.=20
> >=20
> No, I don't have an EVK. Obviously the base clock from which the I2C
> clock is derived must be different from 24MHz on your board.
>=20
> Can you measure the high and low width of the SCL signal when setting
> the HIGH_COUNT and LOW_COUNT to 1 and 10 (0x0a) successively?
>=20
> I'm getting a LOW pulse with of:
> 130ns, 520ns
> and a HIGH pulse width of:
> 330ns, 730ns
>=20
> Thus the granularity of the timing setting is about 40ns which is
> close the period of the 24MHz clock of 41.666ns that the SCL timing
> generation is based on.

Ping, waiting for updates. Marek, any time for this?

Haven't checked in detail if it is a similar issue, yet the designware
people had some in-depth discussions about I2C timings and PCB
influences...


--udcq9yAoWb9A4FsZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSDKmkAAoJEBQN5MwUoCm2fXQP/iVZ5lJrDIsVitRPuFIn0LK3
NEgK4wUBdw9foid6yRUz0gORXD7nijHsF0Du6im231iwcJfm3qZ9tXHWihjhRm4G
06fRKl0L+dm2jjzr2qQ7sdMApaFkQ9ozTPXZsNiP+7nC7QDog8WaHYbEacYumLYk
+ryxl5g5YLJ16G49Sci1tU7Rl+yLdSNjAmyfoIGP5VlGghS9FFyT74AoMDsSX9Tk
ug9CDfCcOOXRNg1nYEfPbe1S9GXuGfjMs41P2Jjebvdg/hN+qmqc/4bkiWIZLOWd
IdBf/kcz0ORDTxZbmb0egfhI6J4nGGwRcTV5qC5ltYkbm6fTOJx7F8UvRYjsGvwN
5A7kVZhvBZ/+L0zQssmM05RK+xa2DCv9MGextzxk9xPtp1CQy2NkRj2pVGw0ps2V
2lUPPSf26Q3vkJUDwUkClpiz2znM1n+8+J2PSN3LIXyHW93OMKoUAgxIfKWaxeO1
JvMr/T9+vjDfdSQ7pUgNOQoUTeYbpQeaJ2ldBBNmzLDBHCzExyi0AwKPZ6kkuHKP
7tXoE8C/DcfkU29hugl3l04UkqyLNyXccchnph/xw9L+IqdxDav9IPgeIYYsPbs0
UL0H2AoXEYwQP8tXdKBdhz3Fn8tdV80JXeVHT9ZttXN8jAKdFuyXm+09K1V1203n
M1f8BRMpexGpYNiPeQub
=w9+P
-----END PGP SIGNATURE-----

--udcq9yAoWb9A4FsZ--
