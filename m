From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-mv64xxxx: allow more than one driver instance
Date: Thu, 12 Jul 2012 15:53:03 +0200
Message-ID: <20120712135303.GL2194@pengutronix.de>
References: <1341762785-6918-1-git-send-email-ffainelli@freebox.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V3eawNQxI9TAjvgi"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1341762785-6918-1-git-send-email-ffainelli-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Fainelli <ffainelli-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Nicolas Schichan <nschichan-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--V3eawNQxI9TAjvgi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 08, 2012 at 05:53:05PM +0200, Florian Fainelli wrote:
> The driver currently checks the platform device id and rejects platform
> device id different from 0. This prevents the registration of a second
> i2c controller on systems where a second one might be available (such as
> Kirkwood 88F6282).
>=20
> CC: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> Signed-off-by: Nicolas Schichan <nschichan-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
> Signed-off-by: Florian Fainelli <ffainelli-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>

Applied to next, thanks.

How are your experiences with the driver? Does it still need
EXPERIMENTAL?

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--V3eawNQxI9TAjvgi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/+1r8ACgkQD27XaX1/VRtKjgCeL3GZZbBmKWSrm2KNwUK3KyS9
ovYAoKkZlgftvgOq7hbFRr9JVUBU2gBA
=/Jhq
-----END PGP SIGNATURE-----

--V3eawNQxI9TAjvgi--
