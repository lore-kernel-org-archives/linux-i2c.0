From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] MIPS: Octeon: Register EEPROM device on the I2C bus
Date: Fri, 5 Mar 2010 08:11:30 +0100
Message-ID: <20100305071130.GB21925@pengutronix.de>
References: <1267772895-25409-1-git-send-email-yang.shi@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1267772895-25409-1-git-send-email-yang.shi-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yang Shi <yang.shi-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Cc: ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> +	{
> +		I2C_BOARD_INFO("eeprom", 0x50),
> +	},

Is the use of 'eeprom' instead of 'at24' intentional?

Regards

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuQrqIACgkQD27XaX1/VRvOxACbB3tjlz8LFvaToAhx4vOJp0La
+PYAoMMcDlXWyahLNZ7BEnriAIdm5MrH
=vrmz
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
