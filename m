From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v6 1/2] i2c: imx: add DMA support for freescale i2c driver
Date: Wed, 6 Aug 2014 09:20:17 +0200
Message-ID: <20140806072017.GA2730@katana>
References: <1407232563-10856-1-git-send-email-yao.yuan@freescale.com>
 <1407232563-10856-2-git-send-email-yao.yuan@freescale.com>
 <53E0C498.6070608@gmail.com>
 <30487e0abf4b4564af296d17f5cebf49@BL2PR03MB338.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <30487e0abf4b4564af296d17f5cebf49-AZ66ij2kwaZYLYlmg7qx2OO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "marex-ynQEQJNshbs@public.gmane.org" <marex-ynQEQJNshbs@public.gmane.org>, "LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org" <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
> > 			     struct i2c_msg *msgs)
> >=20
> > run checkpatch.pl on this patch...
>=20
> Sorry for my code style. I will match open parenthesis in this case.

FYI, I am not strict on the open parenthesis thingie.


--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT4dcxAAoJEBQN5MwUoCm28f8P/1BS5rATojDksbpfftlxquQP
tU8kND+nhWI5OIamiGfP5+kuTq9wFydRgvm1MM4NVeJ8Er/xwEBKfiOVgcftL+JX
19kPUo0jBVxtu6zyW9NgTD7YZUzOPXpINHJEGQtwrcsJVXr7Z3ACfuQ4Ys8fbl6F
ivDSke+6gt7pc6U99t4C67twBNF/uESRjxY3Td+JubXsSbE48Ban4aY6khRt11Jf
XdbGL0PJO9kHo0RUCrbH9wAoh2m7ZdTPdgCkZgEco9ppZQ/mO39rf1sWKwOKP7TU
M7qA6xO5sK/t2Zv9mobtK/n9Di4CZxZsV7AyibYTNwjlMo4AYkgiJfHS5OcUMDHI
K1E4PscAta4Hgg4D33hiDsvfnAM677u1fG3J9B1H0Tc0d5HMrwLR+/Yb4EzvLbUL
GDfO3dOetosQuLW+1JXyRSBskfuwT5D9bE9rbnWEyY/wlkY+JbnDjkUhftzyhbwM
GOM16tO8H1T9go0/Dh7D5tQb4c4B7VJB2aexqzNPeYtEzcmVUHL/JsT+yDwlz7sE
/fi/7kBWDTEaikh7+XwmAix7Cn/cZcsuvIxz/Y7wcn5y64cx5jVPUB8twp/u/WFT
t2HLZVdjb54X4BFda/PQUjLDY5vbpuKnU+CWNZB9iITt6lFS29MZe3UtA/aumyDk
9OvkCNzpIHF23ATczoXY
=mxTY
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
