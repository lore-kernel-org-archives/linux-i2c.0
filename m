From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH -next] i2c: remove duplicated include from i2c-digicolor.c
Date: Wed, 22 Apr 2015 10:19:00 +0200
Message-ID: <20150422081900.GI1511@katana>
References: <1429189812-24079-1-git-send-email-weiyj_lk@163.com>
 <20150416132114.GA913@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uJWb33pM2TcUAXIl"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150416132114.GA913@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: weiyj_lk-9Onoh4P/yGk@public.gmane.org
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--uJWb33pM2TcUAXIl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2015 at 03:21:14PM +0200, Wolfram Sang wrote:
> On Thu, Apr 16, 2015 at 09:10:12PM +0800, weiyj_lk-9Onoh4P/yGk@public.gmane.org wrote:
> > From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
> >=20
> > Remove duplicated include.
> >=20
> > Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> Yes, but please sort the includes to prevent this from happening again
> in the future.

Did this now. Thanks for reporting!


--uJWb33pM2TcUAXIl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVN1l0AAoJEBQN5MwUoCm26dgP/AnR2O9SIjdPqjS85KlrT7NC
ff5TtR2p+wYVTU6XavedQnIZouOkOFJwSXHHi8y1P5C+AlOm9a5C0D6Ao95fE8cu
HOonHV1dmegXeVSXAnJE+J3j09G5Bkw/qCqQmBGeOJyNUCTqlyYFEmNxZ+XWXdCB
STylwy1W8sLWm367DbrYucEy7JxyjtaWaSMoBdpiptRHH1Ww/ZdzLmJ1Cm39xHYB
sLtpSiNnj7XMBFndqqZ9+JImh7OzrYVKroDq1eXrzFV84BQjYPogN+VHDal8UII/
58rbPpu8++Jvc9gOwPFcJ7/pbFvTSQ9PyJR3pOjOQ2aDUyAY7J7xGVQpLw+T5MhY
7YaloRKeQ7bHNKKje6uuDO6QY51ObvkIj1UCkWYEWNarbQ3igSH+tet8LpnZLvqP
aXtB22iDVg4AzxCfRbKri50OWRCvK+HAqKT0ZAKrCsWbkiy3COhI9OxxQh4zs2sB
PHIN+ggBIfV+ZsnNU64Wuv4Y2/5NVZsU9ML+BNQ6HFoRmsz/hWRor2A/xFsH1bau
M+XciF3I6B29lJTDphHJzfRTnCF83rCwLOHbm62tpaPaj22BbkhL0kooT5Ky7URk
oY90/4Q4l3RoPqVUTYrKI8Nz/5tb9+mvy1WLUWPeqz5pfcgcNr4J6SSvJoKW8qJE
K50PjF3AfmxYMZ+ZR8TP
=UgmA
-----END PGP SIGNATURE-----

--uJWb33pM2TcUAXIl--
