From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused
	by read i2c_msg
Date: Thu, 28 May 2009 19:17:26 +0200
Message-ID: <20090528171726.GE3112@pengutronix.de>
References: <4A124202.4010201@doredevelopment.dk> <d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com> <20090526213351.GG23114@fluff.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="phCU5ROyZO6kBE05"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090526213351.GG23114-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Esben Haabendal <esbenhaabendal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Esben Haabendal <eha-SIcX2qgNSybd/EuGEV170n9LOBIZ5rWg@public.gmane.org>, Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Any blockers to get this accepted?
>=20
> It would be nice to get an ack from someone who can actually test
> the driver before getting this merged.

I wanted to test it, but it does not apply due to line breaks (check
@@-line). Also, I don't really have the time to dig into the topic, so I
would only test it and give a tested-by-tag if it doesn't break anything
here. I think Joakim would be a good candidate for an acked-by .

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--phCU5ROyZO6kBE05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoexyYACgkQD27XaX1/VRu+mACdFGtX1DCt/RqzCoYSloa0zGw3
f0IAoKyRUlePitsTyVsWjV42yZ/Iob4I
=oC0v
-----END PGP SIGNATURE-----

--phCU5ROyZO6kBE05--
