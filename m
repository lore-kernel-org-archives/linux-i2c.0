From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-pnx: fix error return code in i2c_pnx_probe()
Date: Fri, 23 Aug 2013 11:02:42 +0200
Message-ID: <20130823090242.GD3035@katana>
References: <CAPgLHd9W5GtFtt6yCHRJ2mmuy2ha2u_utF9jR3yLY5O_oYpLWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd9W5GtFtt6yCHRJ2mmuy2ha2u_utF9jR3yLY5O_oYpLWg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2013 at 10:55:51AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> Fix to return a negative error code in the irq get error handling
> case instead of 0, as done elsewhere in this function.
>=20
> Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>

Applied to for-current, thanks!


--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSFyUxAAoJEBQN5MwUoCm2VUkP/Ap9ztEqqwsI/fDBznabGQQe
RNUG0ikCgKIsxlPpCvmUApPM0oYk6oMvnXRsXdnm01JS3ytzVtONnzF7faEoyV8h
RsKWtX/Ose3HsXrbBWog/cdmZISwpFzDbHUYOoXsBlLQN0/aAuHGiOpahu6ChlK0
QoaseG+AO70ijUKvRLfLMDDMVCv10n6xkDQyf0ostwc+yyjo88LMOrTNeGimtriH
XU0hOvAU0bnMqrD/uyYgjOHFQiI0oUgm4s8va2YsZJFYIWEmDjZdGs7FqZ/STFEL
sJ4Ggdsp1GZEFuW+LNWjteGQ/1j8hK2CcD0jx+3cZTzsCQt4PWDdN4AB1FN5wntQ
mbrSf3GdNthbaI9GyYAIBtAP0iO7CR7T0SXsGJvvY0OuzZGIzMEE3e/ZRbFfp5WN
NnVKo0WHaSynuWqze70nRmvoNmJlFwnCcQmo7Km1QVunY4trvM/QuKTkralhQH+7
v86IfW/zCuxXq875ql8UnKCDjph48+jmA6EbSSfwkAmZAbsfPMTV2NrY/driXtuv
EALPvX+3Jm4CGVzHFvVvvqglFsLvr5Hc+8cKU/bmApcLCuhuAn0t6d4Q1pJgWIg9
8e15TYcfBtI4tbeDlLH2knHD/Wyw4kpUP5CeUBHQMi0UYF0PSlgnMh/45NvYdw+M
8ed5EDfk047xbgK5tLdz
=SiPh
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
