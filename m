From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 06/15] mfd/ab8500: Remove confusing ab8500-i2c file and
 merge into ab8500-core
Date: Mon, 7 May 2012 17:54:50 +0100
Message-ID: <20120507165450.GM17002@opensource.wolfsonmicro.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-7-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TxukmIqg3MmZ0Kmh"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1336155805-18554-7-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--TxukmIqg3MmZ0Kmh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 04, 2012 at 07:23:16PM +0100, Lee Jones wrote:
> ab8500-i2c is used as core code to register the ab8500 device.
> After allocating ab8500 memory, it immediately calls into
> ab8500-core where the real initialisation takes place. This
> patch moves all core registration and memory allocation into
> the true ab8500-core file and removes ab8500-i2c completely.

This idiom is commonly used as many devices support both I2C and SPI
control interfaces.  Does this apply here, or does the device only
support I2C?

--TxukmIqg3MmZ0Kmh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPp/5TAAoJEBus8iNuMP3dlRMP/A9iofUtbaoDdNgtqO42385s
X9IMqJwQ1X9vvvFie5VoW8LUD7sZwPJNOXRga5BBvQjfWKW4mP4hu7CCxcIlM9ik
DYvRywZBpe2n26f5PivzbpYFJkuQCSo/MWKzaAJZrHn29mLQHQ/qxF/iC8TxluyL
CSlpZ84gVWOzwVNfB+tritP4Uycj9v0VCrydpAbLaPsTjOsXj5i8mPoWpRLGyQLz
Oh8SgCTTData08NkDbCPL6RgAwAodTkYwvYVyUIONtBGGr3NkAmi3qatnGy1vswa
xoynd1AT3erwhdVxK5Je7SEj+HRGtnmyp+4FHWhxL1VE/kdySwnOHRmL44P132ae
sMJEPdhXOZ/4zweTZ5IQPxNLVImThL1LXyJZdTjOJwSkhm3q1IlpnRLMJhtFr1j2
31RNaOoFmTxVarnel6I2dK+Abbxt38WbgZACQ07hqBP0RB2NsFIT7mcGL74LFUew
YVYV1jXlZQaqoDr/7/3ca5eJDCL3uyzZdhiICun1tutb+20E0WxrIAa2GTk89+iN
mEjQ0jKK5kuN48VCo4tlRIalC/BOXdAX8+BF7/SWfiis7m0kVXrzGaOc8N8zxew8
vqZpoj0qMoIRKxAsClU882pTAwouYK7BJv6aNJVNyD5ZZW+B6iouqCkV1iogmEdZ
+tPX9Z7cyjOPc22Vbo01
=mXx+
-----END PGP SIGNATURE-----

--TxukmIqg3MmZ0Kmh--
