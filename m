From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: attach/detach SPI device to the ACPI power
 domain
Date: Wed, 9 Oct 2013 18:55:28 +0100
Message-ID: <20131009175528.GV21581@sirena.org.uk>
References: <1381327461-10562-1-git-send-email-mika.westerberg@linux.intel.com>
 <1381327461-10562-4-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OxWh+UR3R7TveXYN"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1381327461-10562-4-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--OxWh+UR3R7TveXYN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 09, 2013 at 05:04:21PM +0300, Mika Westerberg wrote:
> If the SPI device is enumerated from ACPI namespace (it has an ACPI handle)
> it might have ACPI methods that needs to be called in order to transition
> the device to different power states (such as _PSx).

Acked-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> +	if (ACPI_HANDLE(&spi->dev))
> +		acpi_dev_pm_attach(&spi->dev, true);

Though I do wonder if it wouldn't be sensible to push the if () here
inside acpi_dev_pm_attach() and similarly for _detach().  Terribly
trivial either way.

--OxWh+UR3R7TveXYN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSVZiNAAoJELSic+t+oim9YlYP/0gXTLvice4UKl4gaWNo7EQX
OrQHKw5iUy0ZEOymDlYdZ+f2rtJcUTmp/tW5SEYX7Fc93wQZGbcc9qdhKbECTPt8
y+lYBS64fEp9kQf2sZ5GZ6psODV5w/8Z1lmTaPG9w95w1K/SVwty1KdXYBdxOlyR
fXk0rZgGchKCQlqjxJi6N0tqpZWIHT/y1fjidgjSL4+3s6ctwYSJQlhsMa0rrMe8
QdYUFmG7QZo5y6LQrj/M41naN4oXtuF6GGqRkSya5hD1wY8HgMhpKPxkmS+DBXoA
I4u11dtwB7a3VcOy8a0yzMzGKWshGIPrOu5k7YbrZU3wlz1ejpL9Bg4XBHyfeFK0
87xANoSG6Ob9B9gYOJRF3bK/eFtuq9bY811f8/x+zbMcTEI3B3NspDQpKkFWJHmG
N5Kfp7quQJb44ldR0iChEu+6hxzH+ASDYpfSR1lxZY/EkbY911Q6GgDtCo3c0hAi
aQVm6nV22csj70rFsfrrZMRr+UMEsgM6I1iiSf6zOVhu7xaERWZ/xljqT/fJul/8
5rjVbrfsLEEkJh3EskWzbMNyHDt7o5a3MJ6/tCeF+ONpCMSYVnMjwFu2wGaQWPTJ
Eliz8gINjcuyAE57rqh+XNWwSu/dHvD66UDP9QtmXzRemR9QxMDrW6LZGw4RZP9q
dEayJ46LEmrlEYUS00Rw
=rrml
-----END PGP SIGNATURE-----

--OxWh+UR3R7TveXYN--
