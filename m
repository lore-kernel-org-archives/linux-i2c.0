From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 21/66] rtl2830: implement own I2C locking
Date: Mon, 2 Feb 2015 21:33:24 +0100
Message-ID: <20150202203324.GA11486@katana>
References: <1419367799-14263-1-git-send-email-crope@iki.fi>
 <1419367799-14263-21-git-send-email-crope@iki.fi>
 <20150202180726.454dc878@recife.lan>
 <54CFDCCC.3030006@iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54CFDCCC.3030006-X3B1VOXEql0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>
Cc: Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >Ok, this may eventually work ok for now, but a further change at the I2C
> >core could easily break it. So, we need to double check about such
> >patch with the I2C maintainer.
> >
> >Jean,
> >
> >Are you ok with such patch? If so, please ack.

Jean handed over I2C to me in late 2012 :)

> Basic problem here is that I2C-mux itself is controlled by same I2C device
> which implements I2C adapter for tuner.
>=20
> Here is what connections looks like:
>  ___________         ____________         ____________
> |  USB IF   |       |   demod    |       |    tuner   |
> |-----------|       |------------|       |------------|
> |           |--I2C--|-----/ -----|--I2C--|            |
> |I2C master |       |  I2C mux   |       | I2C slave  |
> |___________|       |____________|       |____________|
>=20
>=20
> So when tuner is called via I2C, it needs recursively call same I2C adapt=
er
> which is already locked. More elegant solution would be indeed nice.

So, AFAIU this is the same problem that I2C based mux devices have (like
drivers/i2c/muxes/i2c-mux-pca954x.c)? They also use the unlocked
transfers...


--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUz98UAAoJEBQN5MwUoCm2BccP/RV44szd9ocf8LtYppv7c4do
Gvg9shTDCBVSJVTs6iBhgFjU3MCzvmqcP9ZTSpAmH6xHdD5bPq+O8TztjSlhHjeR
dOHaC/bWhtlBVYSiUnR26jc1EDtVhVeNmeiiRMRRASnb8lqwEXUiUNkT6LOiygfC
rNmaqfAb8B+boX3yODbx29SjMpjtAOcbOXSU+ABNU2Bc+3SzItwtXCilCL4/s3Ob
ow8Ngyo2Wri6dWryo4Q71+bOlYbZVNUwa9iJpxKURnZ6PHWfGQhTM95j+thP5M75
TWBrnwaGg22vjH5xK/7rBmGFMqLHeya2kTuvgFnjELIBP9trUaiLYgAi9A5rq7Vx
Urf9SUxJM0McaksjB7o0ecw+YDELbm/y9v4OoNQzqaErnO1X0BfXHXYb0jB77qQf
cin/7q4ApXlplGf+CF/SkERKMqfA/TxFe6m0Lvnh/2jh1NCQUfRbGCOeyDqFvQyM
QJiHV4SHVTgCFq7aCdoaLeGSPprm64rxrTb1Tf/hR5r5cmCTSMQu+j9pMSQTtNxT
zFasSviPp95ztSUFmC9rLMGe06sjDM57+OvtN/ejoWNrA0X8H+sAnKauzbOBlxei
ZMyWMWbFCbSFBP1yb08DL7+w8AnSAJEPjWulk+VYmw7Rxlf8tktwMkvcsLpGR7w+
2RJPHeX7v+pUNgCeqChT
=dDU1
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
