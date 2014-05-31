From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Make I2C ID tables non-mandatory for DT'ed and/or
 ACPI'ed devices
Date: Sat, 31 May 2014 15:48:06 +0200
Message-ID: <20140531134805.GA3287@katana>
References: <1401452797-29521-1-git-send-email-lee.jones@linaro.org>
 <1401452797-29521-2-git-send-email-lee.jones@linaro.org>
 <20140530123656.GC2742@katana>
 <20140530133405.GB29731@lee--X1>
 <20140530174800.GA4917@katana>
 <20140530192516.GA4319@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140530192516.GA4319@lee--X1>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Right, I read the function which provides the functionality, but my
> point is; I don't think my patch changes the semantics in a way which
> would adversely affect this option.  If you think that it does, can you
> specify how please?

Currently, if a driver would be DT only and does not provide a seperate
i2c_device_id table, then the driver is unusable with method 4. I don't
like to have some drivers being capable of it and some not.

> Does the sysfs method create a i2c_device_id table?  If not, how does
> it probe successfully pre-patch?

The sysfs method creates a device. Its name is matched against
i2c_device_ids only since it does not have a node pointer for DT to be
matched against.


--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTid2VAAoJEBQN5MwUoCm2hMYP/jKCgTIbnDG18sgyWdYlHw+I
CLQA0Q4xnfTxoKF5CvWUbGt93a356LIqzGIZF9J6dm9U7FCZ/GB8lEZnu98APIFD
P0bAw5OmSIg7cNNrwgeg4rNZ7AB3Hf75jVWww70BGp/p//EKMGt5IA77YRYf68DV
TKJUY4Mxl3Q2RDtSNKwFu5uEqF1bxAsFldlTn4HJgeYDsFlQ86UC+xhvApzTolBH
saf25xiDqb+o1AVYpWRfkORl+stK4SnDekDfxRbmo1Mczuwg1jgED1os9ARVtTJY
SiA9aQvVrwFPKaHWkjAqoMTr2gNmqmgwUEwA0r+j/aupWQBrJ2Wu/gxM5dLLtzdc
e2QEuQSQj+xQ4meEjETMZ/OQLE0XywYJjfYr0syFQbDBmMWH4XDqccy05rzXOWw9
WtiuXEqP/nzE0UgbnQJztv1ldtnqoV8jWI/G6JHoYY7lq586jB/XEa73a60WCJYE
r8ClFhbg1CPvozXgXXtyAf2MxABP9r4o5swwMW4tJxPLDNYDo36rPin3yKPHUoos
7QcSVN60yd4tzg3WaHrg7+5o31QYuwPCKHLl21WJxKoe/Sl86DzRKtw729sjXaNB
+I4b8A46FIYU3V+8p3bzFYUL9buHOZrsHqxDBNRxdD1EmKyiesNbNXye7AEpQ66/
6Nt6LpR/P80S0/0lJSpJ
=DimM
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
