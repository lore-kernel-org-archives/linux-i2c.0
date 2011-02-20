From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: Minor fixes to upgrading-clients document
Date: Sun, 20 Feb 2011 15:08:38 +0100
Message-ID: <20110220140837.GA14786@pengutronix.de>
References: <20110220150408.03e9a674@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110220150408.03e9a674-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 20, 2011 at 03:04:08PM +0100, Jean Delvare wrote:

> * Typical legacy drivers implemented method .detach_client, not
>   .detach_adapter.
> * Drop all references to __devexit, as i2c drivers shouldn't use it.

Even not in remove()? 40 out of 84 drivers are doing so.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk1hIGUACgkQD27XaX1/VRvi+wCeJbZ179DGti0cZQVXa4EZ9QGs
yxgAoLnLKsAKa2aM2182hKOXf3rzzOV5
=q6sM
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
