From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: nomadik: Don't use IS_ERR for devm_ioremap
Date: Wed, 14 May 2014 17:57:04 +0200
Message-ID: <20140514155703.GC12911@katana>
References: <1397139569-3906-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397139569-3906-1-git-send-email-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2014 at 04:19:29PM +0200, Ulf Hansson wrote:
> devm_ioremap() returns NULL on error, not an error.
>=20
> Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>
> Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied to for-current, thanks!


--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTc5JPAAoJEBQN5MwUoCm2ssIQAIDnumId9QizYd3Q/l7dtpuN
eKuehMhD6xbqzkR/CCGPprCt6d4WJzM5L2FauYmO0z5a1Nr3+TogZJLOb5PTAXFE
BBQ1d+qDNBXkupcuHPK/FnMfks6uhT9CJNXmHl2Ff+8hGA5mQay856ZQRrdmggxz
X+P5MS8W26+1V3XiYq3hVxbq93QDVT2Fp4QQK/eCN4WB035ji+3Ezvrg8sRe65ZV
Y//CZrbOa5XI+wDuMsSZryrobnXu60qbeyYiVqXV2603WOwlGnx4VSPOfG0/yF1p
u4AOkW4l4slMJxq0h03vWXqWxtMH0PU4R67bEQlO9RHxWlNPuhEEgFy9gGSX4gyw
7skBYuUloBgiKZ58oWQidTFjk5ILILwohgnyb20GXiD2v1nK05XyQTZVBs8F4wfc
vor+BypRC3pfby+Do2nLaRZICyeSIBQy0+NAv0vYQPGJKlMbSGJbmXm7ROw+tbte
GcZ0614IF+edseFxgM9SE+dL2hYMZPxNFmovq/mHqOTRXFbFpRM8UzlvIL04L5Nd
Fntc+C20vmhDgcmMJhgF6bBv/5U7V7dY5xM8qewBuGoXbHNmCKqqqPxca3eoyJBg
mJaWGriAtv60aUpubgDsGJFbJ8BumfC9rdiBTHRrE0BOEfjv1XDoujx7MFHFrCcA
yCVxo2NQcZiNrB8xCi86
=qVkq
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--
