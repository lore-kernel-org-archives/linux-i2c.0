From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH resend v2] i2c-cht-wc: Add Intel Cherry Trail Whiskey
 Cove SMBUS controller driver
Date: Sat, 12 Aug 2017 14:04:11 +0200
Message-ID: <20170812120410.he2jkil7clhlybd4@ninjato>
References: <20170806105943.31470-1-hdegoede@redhat.com>
 <20170806105943.31470-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="up6yqraskqukepub"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:42927 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752331AbdHLMEM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 12 Aug 2017 08:04:12 -0400
Content-Disposition: inline
In-Reply-To: <20170806105943.31470-2-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org


--up6yqraskqukepub
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License version
> + * 2 as published by the Free Software Foundation.

Here you say V2 only, in MODULE_LICENSE you say V2+.

...

> +static const struct property_entry bq24190_props[] = {
> +	PROPERTY_ENTRY_STRING("extcon-name", "cht_wcove_pwrsrc"),
> +	PROPERTY_ENTRY_BOOL("omit-battery-class"),
> +	PROPERTY_ENTRY_BOOL("disable-reset"),
> +	{ }
> +};
> +
> +static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
> +{
> +	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
> +	struct cht_wc_i2c_adap *adap;
> +	struct i2c_board_info board_info = {
> +		.type = "bq24190",
> +		.addr = 0x6b,
> +		.properties = bq24190_props,
> +	};

I don't know ACPI world much, but it looks to me like the wrong layer to
add this stuff? Shouldn't that be in the same place where the
i2c_adapter is instantiated? Because the place requesting the adapter
should know what is attached to it?


--up6yqraskqukepub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmO7rYACgkQFA3kzBSg
KbZ+2w//ZJDUcmJrU3oihBJL/C0IDMlwDbud/LyV+2ZXHCbfqnUFZQrrV9JlaJtF
6hql76RVoYrHGZSgtVwZEIReK552dlE6k9B50TCLMINlye44le0R9DJQ9HF2IDxe
Gw0cne1GOKiOYlU7ySdhR7bPdiKJNrhvfBTsq5518jKYtZGBZ4OgkIDUyZzdJ5su
T1MEhN3FKpPSHRjTlxSrosy+MOpuUkpBTC+168+BLofwn9KNA/Ew2BReKrUw45LS
e0hefBcUbKbbB7ugwVh9yg8Cm/Q/3hvbGl9+0egd3L7oDfeevK51SZVshUh439js
/KxFs0Ea0dllbY83ikeoq/J8E3ROEc/JFZXEWVPMCyDGmQ01Drz3LeZ7uUZzF6dj
kgVlPCSLawKVStGliF7WQP3DSR2FshlQm3R5Z+we1RpQbdAycQVER+H3IgO4SrMY
vqDTYMHRMEEFuHTi7aTNieVhBdg94HyMmolQQIIYgbue9xPy+eHuGsLAj3Hmf/ks
AIiRH13ZHrERPoS3Z6szj7W6cZQXtGftyt3RglQZNTsh8Nmuf7Ra2MT86ycE9Zb0
voM2w3K3S3/JSXVuibIx5zWVa8911pldlqOHxR1/SBAT5d6JNVxgNb1icxsBNQuv
wLhhIq0j3EjXiUPd9serVDCzR7Ni4z6M2SErPTHW7mf2JRX9fqI=
=ao8+
-----END PGP SIGNATURE-----

--up6yqraskqukepub--
