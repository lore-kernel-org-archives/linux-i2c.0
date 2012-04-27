From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: muxes: rename first set of drivers to a standard
 pattern
Date: Fri, 27 Apr 2012 16:05:20 +0200
Message-ID: <20120427140520.GA16504@pengutronix.de>
References: <1335386636-23892-1-git-send-email-w.sang@pengutronix.de>
 <20120427095946.50352d3e@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120427095946.50352d3e-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 27, 2012 at 09:59:46AM +0200, Jean Delvare wrote:
> On Wed, 25 Apr 2012 22:43:56 +0200, Wolfram Sang wrote:
> > Apply a naming pattern like in the rest of the subsystem to a first set
> > of mux drivers. Those drivers are the low-hanging fruit; we want to pick
> > them to motivate upcoming drivers to follow the new pattern. The missing
> > GPIO driver will be converted in a later patch.
>=20
> Good idea.

Thanks.

> Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>=20
> (I can pick this in my tree if you want, just let me know.)

Since I do carry some mux-patches already, might be easier if I keep it.

> Now that you made i2c mux non-experimental, I think it would be great
> to solve the gpio mux case quickly. Renaming drivers, header files and
> public structures is better done early. I'll give it a try.

Cool. I intended to ping Peter after my patch, but forgot :/

Will fix the MAINTAINER issue you just mentioned.

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+ap6AACgkQD27XaX1/VRtYQgCdHvFjA8L1A4YNAGUSoBg/Gz4n
rcMAnROR/XJFvfFp4GWUynDCWth1VX78
=wvHT
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
