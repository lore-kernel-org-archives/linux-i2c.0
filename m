From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-mpc: do not allow interruptions when waiting for
	I2C to complete
Date: Tue, 10 Feb 2009 16:11:56 +0100
Message-ID: <20090210151156.GA15678@pengutronix.de>
References: <1233928837-3401-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1233928837-3401-1-git-send-email-timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, mditto-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 06, 2009 at 08:00:37AM -0600, Timur Tabi wrote:
> The i2c_wait() function is using wait_event_interruptible_timeout() to wa=
it for
> the I2C controller to signal that it has completed an I2C bus operation. =
 If
> the process that causes the I2C operation terminated abruptly, the wait w=
ill
> be interrupted, returning an error.  It is better to let the I2C operation
> finished before the process exits.
>=20
> It is safe to use wait_event_timeout() instead, because the timeout will =
allow
> the process to exit if the I2C bus hangs.  It's also better to allow the
> I2C operation to finish, because unacknowledged I2C operations can cause =
the
> I2C bus to hang.
>=20
> Signed-off-by: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmRmTwACgkQD27XaX1/VRvD6gCghacTrahXacggGU1+ZWtk9yeJ
+BwAn0IpNXSVXfUM2XAVzdnomK4yOowT
=vZgE
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
