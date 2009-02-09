From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: add missing KERN_* constants to printks
Date: Mon, 9 Feb 2009 09:35:37 +0100
Message-ID: <20090209083537.GA3438@pengutronix.de>
References: <498C3EEA.5060508@suse.de> <20090208000553.059a0732@hyperion.delvare> <498EDA18.1090300@f-seidel.de> <20090208144751.46184041@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090208144751.46184041-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Frank Seidel <frank-aMRDT+nbkrEb1SvskN2V4Q@public.gmane.org>, Frank Seidel <fseidel-l3A5Bk7waGM@public.gmane.org>, linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, ukleinek-jNDFPZUTrfROceuj71AUlABBhMqQ4zRThC4ANOJQIlc@public.gmane.org, Frans Pop <elendil-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>, Geert Uytterhoeven <Geert.Uytterhoeven-osDt5Q4Chk1BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> I mean the (first) printk in the loop, not the last printk in this
> function. So what I am suggesting is:
>=20
> +	printk(KERN_DEBUG);
> 	for (i =3D 0; i < i2c->irqlogidx; i++)
> 		printk("[%08x:%08x] ", i2c->isrlog[i], i2c->icrlog[i]);
> 	printk("\n");

Hmm, I was told (by Jean ;)) that every printk should end with newline,
otherwise it might get interrupted with other output -> mess.

Bye,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmP6tkACgkQD27XaX1/VRvAFACghhFugQU2E+yF8jSMZ2W3tU0n
m9AAoIzP6diwB1m0Nou2CUegk+SHBSKF
=pkji
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
