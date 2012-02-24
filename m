From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c-eg20t: Rework pch_i2c_wait_for_bus_idle to
 reduce wait time
Date: Fri, 24 Feb 2012 13:17:53 +0100
Message-ID: <20120224121753.GE2479@pengutronix.de>
References: <1329725656-32715-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uTRFFR9qmiCqR05s"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1329725656-32715-1-git-send-email-alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--uTRFFR9qmiCqR05s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2012 at 09:14:16AM +0100, Alexander Stein wrote:
> If you insert several i2c transfers, the driver might start the next one
> while the STOP bit of the previous transfer is still on the bus, marking
> the bus as busy.
> pch_i2c_wait_for_bus_idle does an msleep(20) delaying the next transfer
> by >=3D20ms. Reduce wait time by actively waiting 5 us once, then using
> usleep_range.
>=20
> Signed-off-by: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>

Tomoya, are you happy with it? (I hope he reads the list, since his
companies mailserver doesn't seem to accept my mails).

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--uTRFFR9qmiCqR05s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk9Hf/EACgkQD27XaX1/VRsJBwCfQcJt+ZL0iuZoBYyAOdvX4CiQ
sO4An3T1JN+rCq+8KmpM22VrMrEWrfc7
=cnOu
-----END PGP SIGNATURE-----

--uTRFFR9qmiCqR05s--
