From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] of_i2c: Honour "status=disabled" property of device
Date: Wed, 28 Nov 2012 18:10:57 +0100
Message-ID: <20121128171057.GD4659@pengutronix.de>
References: <50B61DDA.5090109@sysgo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50B61DDA.5090109-uSbOeAmDUekAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <asv-uSbOeAmDUekAvxtiuMwx3w@public.gmane.org>
Cc: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, alexander sverdlin <alexander.sverdlin.ext-OYasijW0DpE@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2012 at 03:21:14PM +0100, Alexander Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin-uSbOeAmDUekAvxtiuMwx3w@public.gmane.org>
>=20
> of_i2c: Honour "status=3Ddisabled" property of device
>=20
> Currently of_i2c_register_devices() function registers all i2c devices,
> independently from their status property in device tree. According to
> "ePAPR 1.1" spec, device should only be registered if there is no
> "status" property, or it has "ok" (or "okay") value (see
> of_device_is_available()). In case of "platform devices",
> of_platform_device_create_pdata() checks for "status" and ensures
> that disabled devices are not populated. But such check for i2c buses
> was missing until now. Fix it.
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin-uSbOeAmDUekAvxtiuMwx3w@public.gmane.org>

Seems like Rob wants to pick it, so:

Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlC2RaEACgkQD27XaX1/VRtErgCfavDZJx+ljGwduWdf/SO9FBXj
1pUAn1WJVOvBAFX57ek5/NWfmRL0JkL9
=rI2Q
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--
