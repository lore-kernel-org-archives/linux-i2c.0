From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: fix broken timing calculation
Date: Thu, 15 Aug 2013 12:13:29 +0200
Message-ID: <20130815101329.GG2987@katana>
References: <1373041680-26939-1-git-send-email-LW@KARO-electronics.de>
 <201307151424.32248.marex@denx.de>
 <20965.3.293494.346855@ipc1.ka-ro>
 <201307171954.59556.marex@denx.de>
 <20967.53016.902909.282346@ipc1.ka-ro>
 <20130815101252.GF2987@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OFj+1YLvsEfSXdCH"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130815101252.GF2987@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lothar =?iso-8859-15?Q?Wa=DFmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--OFj+1YLvsEfSXdCH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Haven't checked in detail if it is a similar issue, yet the designware
> people had some in-depth discussions about I2C timings and PCB
> influences...

the discussion is here:

http://thread.gmane.org/gmane.linux.drivers.i2c/15785


--OFj+1YLvsEfSXdCH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSDKnJAAoJEBQN5MwUoCm20yMP/juxjytmjQPLqvfPmIkGCHIL
F/DU27WEsU8SdyCiPaWnTPUSi2jMZ6qYr1WlrHmsG4LPdJ0l8b/IsiMi2llkcX22
jTWckkApRRl3pxYLNMLsdAprfACvEwyj+X3Tml4ahmixmfWvDjfCrsvxGIc0eu0t
qlgcBXqZXzz6wI78XRVFDwAIJVdGhROh9vnobZ5VFxFSwcT0TmHC7W6SVt0S0NFH
652lagRT7VxPta0j4+g0sfKVc2CTuLstgLBPQ8ZM8uttvjSD3P5gE9pHXiqMXQoQ
HzoFENsXg83GgtH4eH1wwxjvP40/KORqmASq+V3ynQXSu/6S0TllpSU84w4LwF89
O+vMx1/QqMUk81N670XQN9YWZw3rAREm1YELRD4DMwePaWC5aAu01e6NFHGSO/2n
hOHfFVjEV9MbdtcL3JfUsopPS28jkiNLl2UQ/D41BTnQOp4YydzBSXZ1YuoFYs1y
GO80qmJNwKa2tj5+7XZorS1l3XWwFX3jpsLkYd1h4OxJbAqG7yyyajd2wGocOmZk
yjNB0llfH7TrwtwcshLNz9HaTsAJk+SiSyb52A35rPXlOgfBSsz6c4T74VBGZkyU
FRLjKOG25TdhPvCqJhaAwn+ADy9XofP6InwxRPBrlZ7P697EhxW0FZq6OQCIAlo5
C5/6BbQp9ocL44529+Hu
=B+yc
-----END PGP SIGNATURE-----

--OFj+1YLvsEfSXdCH--
