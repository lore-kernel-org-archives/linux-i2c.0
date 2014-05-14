From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c/nuc900: fix ancient build error
Date: Wed, 14 May 2014 21:17:49 +0200
Message-ID: <20140514191749.GA25709@katana>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-11-git-send-email-arnd@arndb.de>
 <20140514162725.GG12911@katana>
 <4944869.eRrWyMmW4d@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4944869.eRrWyMmW4d@wuerfel>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Wan ZongShun <mcuos.com-wSZih8+RwX/YtjvyW6yDsg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> For the moment, I'd leave this up to Wan ZongShun. He has in the past
> at least replied to emails about the platform, even though there hasn't
> been any new development.

Agreed. Let's wait for his response. If there is none, I'll think about
removing the driver.


--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTc8FdAAoJEBQN5MwUoCm2E9QP/jxPLp8arOPDrRmvM3afFc5j
tioCbPk11VsNTwWN/eQF+ww4FHk4HXZIhXf1VUShBaVBAox3nSlowvYRjZrvam7E
Lo/z6bYsw4Zef2I94PgTxVKyvUvHX/csyhdKqaBPJ6AkAhBICDLUr2LSsmJCSZ2C
KqPdHeX63mdVXx/x8r4xQ9/mEnpDkCkn1fPmBHLcXr4INpp8O5S4SFZEy54rDLFh
03NR5cPGXRrilJ2D6sk+GLnpheNY8fj/QX/xatI2R4/jwIG3gTsmTwltCd9XUwYG
L1b2dpGlOwLW90OdCIrqT3PhasSlHyviojAuvaEA0gxiGJSKQuWGTbd3vVH9m/ql
qxC8s56C51WSl8ZAKwa5XOnIHlJ2NGy/4Rt+wzAj5c7/vAb6jQsS+H3L7NmrvJF7
L3J8f1STrAJYkCQHt71dq//RBnEoa7o7BPxR04SJWsxqW5ptsHHBaCLSdbfFE6VT
g4KwGYDoif3YdmxbQgyK7RUZY67j3mbFWLBFFFlnrEc+YUpNlYZxSsehwpmdTvJe
x2X+ZLVlUTxWt76DGQfra8E0yB9oNzI/UvzNpb4+oAqwVut51kKd3jdYKfRYaQRb
5ueKuFKqX6V5LL3Df9ZHSXVvJzBoylk/QNqeXolia7zrGGsSuQnqmR1hcxihrXZ9
RF2qx5fLOe2ONiE+KbR3
=fvlQ
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
