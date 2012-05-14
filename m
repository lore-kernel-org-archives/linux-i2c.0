From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
Date: Mon, 14 May 2012 18:01:43 +0100
Message-ID: <20120514170143.GF25668@opensource.wolfsonmicro.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-15-git-send-email-lee.jones@linaro.org>
 <20120507170832.GO17002@opensource.wolfsonmicro.com>
 <4FB12981.8050603@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GV0iVqYguTV4Q9ER"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FB12981.8050603-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--GV0iVqYguTV4Q9ER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 14, 2012 at 04:49:21PM +0100, Lee Jones wrote:

> >You should be using of_regulator_match() for this (I think it's supposed
> >to do an equivalent job...) rather than open coding.

> I've ripped this out completely and the code appears to continue be
> fully functional. Happy days! :)

Great!

> The original driver places each of the registers inside a structure
> within the driver itself and recursively registers them from there.
> The constraints are united with the correct element using #defines.

> Can't we just assume that all of the regulators will be put into the
> Device Tree? As this is what I'll be doing.

Part of the idea here is to help with diagnostics, especially during
board bringup, so we really shouldn't be relying on the user to have set
things up reliably.  This is also used to enabled features like powering
off any unused regulators that were left enabled in late init so things
that weren't set up turn out to be moderately important.

--GV0iVqYguTV4Q9ER
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPsTpsAAoJEBus8iNuMP3dgqcP/icgz0RkCu+esPSdn6CqhhfD
xSUqsOnXv/KM4ih6g6iFmfv1CPqjz/5SlsDCpna7WyHe1x9MCRBUTpoFCA/jOxWz
OwFrriEso23QwmbspIS80v50gqhb6C7tbthW4V6vnN1o46rjL/xTYgF6a0Owtdfb
laD7uhcPsOhzdLd9k6MTzD+Wa48HoJ81v8zM/Djyg3tbJKL7iWrRpdRRkbAg+IYa
hiNdNBGB8aZqNmYvChgSZR1FW61GU/RudB5sy6mJ8uf3uqWIul89XfMbA97cIAob
+fGmIR1vqTBmo5G05ObvqZ2DjZOcGWym9jr9NhmsNkNF1KajIIntVcsaCISk6DpI
Cz9nY++P3fmAKdUhmp6G1kQkABSuR6hA+GW/WjW41ER/v1Xa0ZJLmLj+5zQyd84N
ek9HNMF/lf9yx4kPiKXZYDrjQ4mzPrQBWgs1F+zQEz6PLLoWbvrj3UM72EZaoZNp
krgUSSTeXQ/O6Hy2AMmzAjW9zYK0EpufwljNpXb7pBMEwLYb4k810U6sAQ/03lhS
JbmB2Tb30uVGjbnYN+FwlPRWA9PQL0fcz2k4YxqKPCFZedclfmv4Nwjbv3VR2ddQ
1yaKuJGS4PVa86Kk9bxGJq8UbGj7IdcMpr1gQHfa2A/Zr4XraZpijs4RPRXOukT2
kprTfC/hXleMeywA7PQs
=MiIb
-----END PGP SIGNATURE-----

--GV0iVqYguTV4Q9ER--
