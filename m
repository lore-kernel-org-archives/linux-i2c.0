From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 3/4] V4L/DVB: mfd: use reg_shift instead of regstep
Date: Thu, 12 Jul 2012 15:34:03 +0200
Message-ID: <20120712133403.GJ2194@pengutronix.de>
References: <1341900658-7698-1-git-send-email-jayachandranc@netlogicmicro.com>
 <1341900658-7698-4-git-send-email-jayachandranc@netlogicmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z8yxTSU1mh2gsre7"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1341900658-7698-4-git-send-email-jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Z8yxTSU1mh2gsre7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10, 2012 at 11:40:57AM +0530, Jayachandran C wrote:
> Update for change in i2c-ocores.h which uses reg_shift to
> specify the register offset shifts instead of regstep.
>=20
> Signed-off-by: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>

I'd like to take this via I2C tree since because of dependencies.
So MFD acks are very welcome, but I think not enough lists are on CC.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Z8yxTSU1mh2gsre7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/+0ksACgkQD27XaX1/VRsvxACfWP0kXYpPt1zV01p8XkYknf4B
hz8An3p+Tdnh5Sw1nIP0mtgQzqZH0dgo
=YY/O
-----END PGP SIGNATURE-----

--Z8yxTSU1mh2gsre7--
