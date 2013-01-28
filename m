From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c-i801: SMBus patch for Intel Avoton DeviceIDs
Date: Mon, 28 Jan 2013 05:36:42 +0100
Message-ID: <20130128043642.GA30953@pengutronix.de>
References: <1359144661-3528-1-git-send-email-seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1359144661-3528-1-git-send-email-seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> @@ -166,6 +167,7 @@
>  #define PCI_DEVICE_ID_INTEL_5_3400_SERIES_SMBUS	0x3b30
>  #define PCI_DEVICE_ID_INTEL_LYNXPOINT_SMBUS	0x8c22
>  #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_SMBUS	0x9c22
> +#define PCI_DEVICE_ID_INTEL_AVOTON_SMBUS	0x1f3c

This seems to be sorted, please stick to that.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlEGAFoACgkQD27XaX1/VRsYhQCgtOqoxm+RS5rCMegU9ytv7dfE
GfoAoIhnFLkWTVR2B7uqWSE/c3PDGaag
=SEiG
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
