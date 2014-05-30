From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Make I2C ID tables non-mandatory for DT'ed and/or
 ACPI'ed devices
Date: Fri, 30 May 2014 19:48:00 +0200
Message-ID: <20140530174800.GA4917@katana>
References: <1401452797-29521-1-git-send-email-lee.jones@linaro.org>
 <1401452797-29521-2-git-send-email-lee.jones@linaro.org>
 <20140530123656.GC2742@katana>
 <20140530133405.GB29731@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140530133405.GB29731@lee--X1>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Lee,

sorry for the delay.

> Would you mind telling me what I have changed that affects drivers
> registering via Sysfs?

Check Documentation/i2c/instantiating-devices, method 4. If a driver
does not have i2c_device_id, then this method won't work because the
newly created device has no of_node or ACPI_node and nothing will match.
Looking at the bigger picture, I'd really like to keep this feature.
People use it.

Regards,

   Wolfram


--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTiMRQAAoJEBQN5MwUoCm2LocP/A0XFXT2tw/77Isv3MUreh0Q
1lVLFqiVnIAg8Bc8MIsvgCfY2LRpz8xHoAuUYSCPX+8S2Y+6jb/xLfBTM8s5/p5d
rmIYR6P6pyw4kqAcUZrDebUTrU8YJKoH7FHwlMCE8g2opMOROgxlMLMFM7Rm1cve
1X1981IojV6rBtHchKn+X0nZgRgCeFA7bnIoMqvscvojWrZ7oKgBRhR4RUlYfut1
BNqP4fHVS6lKYcCHy15ISgcfwigSJ3H9iq2I+PbdSOGcRkOflEo6bmn6b0X/srf+
wqwsC/E6mhbxVm5DSXNE+8/bmipdp1wrq0eLJdg+p+qTd4FKcdJ3PWHO1njduKsd
DP6lFcQInmqIiXq66YlraNVoy66YyMG6gHWTHbDFufM/rVTe+1xlRo6cNrtdGT29
O6Nk62nwP6DWGWQa66IQmX/zeS6KTzqCy7Lm6ucNEzcdnNrUk1Ne3NpathUKZd2t
ixY8L6+71bxUhWghSiwavw6ZkUtMc1GcgosuQYdeAjwvBCJLmt3/mVkTMGP8NT39
jSg15XtXs5tZToQ5GZRsBZYSiwHPsZLvxGi5Gdf/kOo1TgQUqlFmF8qnXnjjcBL+
281b9rcumw+atpI7+Qg0Sz/K0N1JaYbGO7mKCIhgADQk66df3MynXj+6BTCkOQ4B
HTXKMMvD+jmWYL0jos/G
=E+8a
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
