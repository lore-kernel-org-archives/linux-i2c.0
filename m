From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/6] regulator: add bcm59056 pmu DT binding
Date: Tue, 4 Feb 2014 17:23:09 +0000
Message-ID: <20140204172309.GG22609@sirena.org.uk>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
 <1391516352-32359-3-git-send-email-mporter@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PfY+OYVI0N/4DRLF"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391516352-32359-3-git-send-email-mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--PfY+OYVI0N/4DRLF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2014 at 07:19:08AM -0500, Matt Porter wrote:
> Add a DT binding for the BCM59056 PMU. The binding inherits from
> the generic regulator bindings.

Is this really only a regulator - does the chip have no other functions?

> +- regulators: This is the list of child nodes that specify the regulator
> +  initialization data for defined regulators.  Generic regulator bindings
> +  are described in regulator/regulator.txt.

The regulators property should always be optional, the driver should be
able to start up and read back the hardware state without any further
configuration.

--PfY+OYVI0N/4DRLF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8SH6AAoJELSic+t+oim9rsYP/1L1zj3GN9KmZgnHe+QCaAtu
6WqNIr5o73Yird56+njBW2CXcIWh4eK1MzAiX7ahmqeBebQY5M08Zqff0kOklZZg
JIua3A4HWFjFw9yPwc5AI/5tCwAedRVIkj/+FoMJRDuWiUb4PdzzjB9LL+U3+A14
tIWGNDN09pp1iZQpAVUipYaI6yY2Yk4d8MkTEqBAn+wH/gxmoYzLz0CCb4oFQ++W
MWAy+EwT/uIL3Yn9f0rGZ9PjTGhP7ZWKgMg+Ol+V7KXbLm8FnW+8DRX9kV6N1QTp
hFqRdBUWQf8kD2hVsPAW0FrpvlSJRBoRDpGVkHq4AzO4HpLavncr0tehxfON2Uth
OSpSr8NoaCo+hh+CfXTLB3dMJFk3zcWjdMisE4IWDBMAh8LIox8IGwPyTAMzvhSr
scBy/oAZP9QEuxj2JG/HHS/w77cb+WkpeL2+WOmb8nFJyCisNowiXqstGv/sRecT
Md/2DjumZSGquXl6gvtTKobdsohr938KFowsqlxvoIdBkZbqESv+61Tq8OuBYH28
qF2ohti6LAORm4cz+CBZ2vrPxLVOOZdEJtg6TEbTaP3263iQvXWf+bUDvph02CC3
sP/nM+dwnCTOMuPnjhARwnNklM8+4u4lQOYwFqcbW5sMCX1MMHEQZnK9GGb1cQVb
aD3UAjGRs9AAfG5VnPoa
=IlGD
-----END PGP SIGNATURE-----

--PfY+OYVI0N/4DRLF--
