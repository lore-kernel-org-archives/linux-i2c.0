From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: dts: cfa10049: Add the i2c muxer buses to the
 CFA-10049
Date: Fri, 16 Nov 2012 09:32:18 +0100
Message-ID: <20121116083218.GE8464@pengutronix.de>
References: <1351182234-22971-1-git-send-email-maxime.ripard@free-electrons.com>
 <1351182234-22971-3-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1351182234-22971-3-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, brian-ZKiFAVwZFM2FeswfMrDH8w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 25, 2012 at 06:23:54PM +0200, Maxime Ripard wrote:
> This will allow to add the 3 Nuvoton NAU7802 ADCs and the NXP PCA9555
> GPIO expander eventually.
>=20
> Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Shawn, I pushed the needed code to my for-next now. So you could apply
this patch for 3.8 or give an ack in case you want me to pick it via
i2c.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCl+hIACgkQD27XaX1/VRv2yACfer5SM0MdcuDMj28T7nLbzJqX
35AAoKnuDCwz9kA9WoTRsJOWpaYe7Y9O
=UB8s
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--
