From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 7/9] ASoC: codecs: convert existing I2C client drivers
 to use I2C core runtime PM
Date: Wed, 11 Sep 2013 16:44:33 +0100
Message-ID: <20130911154433.GV29403@sirena.org.uk>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-8-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RdaJseOINYw+elgq"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1378913560-2752-8-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--RdaJseOINYw+elgq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2013 at 06:32:38PM +0300, Mika Westerberg wrote:
> The I2C core now prepares runtime PM on behalf of the I2C client device, =
so
> only thing the driver needs to do is to call pm_runtime_put() at the end =
of
> its ->probe().
>=20
> This patch converts ASoC codec drivers to use this model.

Acked-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

--RdaJseOINYw+elgq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSMI/eAAoJELSic+t+oim9z/0P/A6ZGNTBUHEx8uhzDYehvFEG
LKwfSnTJIOe9460TdRdjMEVDf6cZH49dkt7NiVelLPjcBowzTQTGz87bMcWKsp5J
29dTzMQEAGCRiFMA6jRMOHmXCqoAKcSOuuCDsOaM5kz2uU3PcJzcsr0XQ/1d2MoI
54Qajk4sXf8foANj9xEGj5lwfw4Si6sn2zrLQfF2JL1TF1V5Ds8GqlVCL3gghkrc
svrP+xILdfYwNQr+uoZlrTratsuQ6IRsEFjbxy/xXXbmmJb2OQvhXn87WpoIix8i
fay+ltNl7l5ZiINiRvdR0VmYraVq0vepq17y0SVkDD1I2vCUGy2PiUhTt1DXSIed
rj124eW1YJ63Lj2iT58GNJAnDIjjmNSZnvHINs2ob/hRD/NZIg1SZaty7O1Zkav6
IoaRXgrp9c11E6kCmBoSpkl1ITdRXqMnuEetQxC/SEqXCoRfMTiaAQJWQ7lEdFel
VwLZzNtp52Ljtz6V571+3ivX+8jeixKmFoBkHmMuI3k/7wWsEzcUcEk4DPcdMhwi
wCfmpuJqcvfXxfgE647Gy+WFEztNF4N7WGurE2EpGPkRWG7dhto27CjOlsm6SlLm
wFi7pu94nF+IcJi6rC6uBYrXQr9/ZGs0Ajy/tDvwHb5aW1GSIYtlD6TS9rvMR7z0
knBHPZK6h5fO7T9wXRH6
=FjZF
-----END PGP SIGNATURE-----

--RdaJseOINYw+elgq--
