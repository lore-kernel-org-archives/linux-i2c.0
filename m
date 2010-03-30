From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 02/24] power/ds2782: really clear i2c_clientdata on exit
Date: Tue, 30 Mar 2010 14:28:34 +0200
Message-ID: <20100330122834.GD29472@pengutronix.de>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de> <1269094385-16114-3-git-send-email-w.sang@pengutronix.de> <20100322170810.GA30325@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100322170810.GA30325-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ryan Mallon <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>, Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Why is this needed? I'd vote for just removing set_clientdata in
> fail/remove paths.

Yes, it will be done this way. I will prepare the necessary cleanups for
2.6.35. Please drop this patch.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkux7nIACgkQD27XaX1/VRtwVgCgktG65wiSfWynE/Ysg29wExEe
ZZMAnj2B3w9xn+Cg5pSet6T/UIEYRWr9
=t4mc
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--
