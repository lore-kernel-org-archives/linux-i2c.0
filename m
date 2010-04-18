From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c/pnx: Really fix start/stop issue
Date: Sun, 18 Apr 2010 13:40:21 +0200
Message-ID: <20100418114021.GA21364@pengutronix.de>
References: <1271586070-12266-1-git-send-email-w.sang@pengutronix.de> <20100418130457.0341efce@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100418130457.0341efce-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 18, 2010 at 01:04:57PM +0200, Jean Delvare wrote:
> Hi Wolfram,
>=20
> On Sun, 18 Apr 2010 12:21:10 +0200, Wolfram Sang wrote:
> > The issue was truly solved by the second patch in this thread:
> >=20
> > http://thread.gmane.org/gmane.linux.drivers.i2c/5436
> >=20
> > Accidently, the first one was picked up. So, this patch adds the
> > remaining diff (and an additional newline).
> >=20
> > Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Cc: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Cc: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
> > Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> > Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > ---
> >=20
> > Jean, can you pick this up, so it will be correct in 2.6.34?
>=20
> i2c-pnx is for an embedded platform -> this is for Ben.

Would you mind picking it up if he has not done till, let's say, rc6? He did
not comment to my pointers so far. Other stuff is pending, too (though not
urgent). Maybe he is away/busy?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvK76UACgkQD27XaX1/VRtORQCginzeBzUsXgI6A/s309ApY7qA
vYAAmgL4P8OSfRwApar6Gq1N3c/loijo
=p2jY
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
