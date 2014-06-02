From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V2] i2c: remove unnecessary OOM messages
Date: Mon, 2 Jun 2014 19:27:27 +0200
Message-ID: <20140602172727.GM2654@katana>
References: <000d01cf6e4d$ece8ca50$c6ba5ef0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YS7t75H5cNTCpbja"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <000d01cf6e4d$ece8ca50$c6ba5ef0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Guenter Roeck' <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, 'Jean Delvare' <jdelvare-l3A5Bk7waGM@public.gmane.org>, 'Uwe =?utf-8?Q?Kleine-K=C3=B6nig'?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, 'Felipe Balbi' <balbi-l0cyMroinI0@public.gmane.org>, 'Laurent Pinchart' <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, 'Linus Walleij' <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--YS7t75H5cNTCpbja
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2014 at 10:51:58AM +0900, Jingoo Han wrote:
> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message. For example,
> k.alloc and v.alloc failures use dump_stack().
>=20
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Acked-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> Reviewed-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied to for-next, thanks!


--YS7t75H5cNTCpbja
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTjLP/AAoJEBQN5MwUoCm2WS4P/j4eDqWa4Klx/6lZledSNEGz
JkGJv+UMJmHlDBVFJfTldoJ24RzQeZ6HOkouY2jZgKzdYQnq1scLsoGpb7trKF2h
vx/u8bqy1OywForBxRN6yeRAjKopmkEIEBzN0N+n/wOf5V7BNxq4lzdj/m+1qsFU
z8kIJ69GmMZmzxVSUHCgKiBT326QcHaDTLw9QS4UqOiN6OaR9bVUIiVbQZXAJRf2
Xq93I28ko5eAEVHdbBRFxSd3rn7QYFE91/MrCi8cI580A3lC+I52qftKXffZWom/
yPwFOQQF+FPWBevxzuFJ2e1EtrouE74bSUfI0f/jggzZL95w5s8VYTyLHtTGDgae
juAhopkORCueGBd959iYW4Ye3OTEhHvLUj5cTPuu6IztHLtwh/Sx09KJRJ0S3pnZ
nzbxl6CRRZPvwex5SFgmScEkxYtbjuP259pGBjxDDSHc+ZWfXIA58/u8tLyoAq2x
FRTBvfGHuqQgiXlrJDES4i/BRGdefSVR+bRud0bJdYKQSiTFu+qtf8jHIqeGUttg
4ViPTTG7sxUiu6hZctaf/pp/u6dTky+L4+yxHFZMPzrcu/JCp2j9AjcbCdqngnMW
wekqANc8SDKBduA27ThdIWv1VQ+lQF1MFfxncGB0D4zqZ5f35gJdvT9uCQ4OAdIQ
Lmfqe5f8g4C6HWyWle95
=g6mw
-----END PGP SIGNATURE-----

--YS7t75H5cNTCpbja--
