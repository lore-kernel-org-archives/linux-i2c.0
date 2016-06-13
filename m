From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [TEST PATCH] rtc: convert ds1307 to interim probe_new
Date: Mon, 13 Jun 2016 19:13:24 +0200
Message-ID: <20160613171324.GA2238@katana>
References: <20160610133200.GB1624@katana>
 <1465766027-485-1-git-send-email-kieran@bingham.xyz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465766027-485-1-git-send-email-kieran@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> As we match on only the device, not the manufacturer, I've changed your sketch
> so that the test maxim line is on a compatible with name ds9999 to make it
> unique. Otherwise, we would match to the dallas,ds1307 id type.

OK, so I assumed correctly that userspace instantiation wouldn't have
worked fully.

> If you would prefer that we support separate manufacturers, I can update the
> match function so that it attempts a full match first, followed by a stripped
> manufacturer match. I'm not certain if we have a need for that at the moment
> though, as the current drivers simply match on the device name:

I think we *need* that. We can't instantiate my previous example via
userspace otherwise. Also, stripping vendor names is what we want to get
rid of with this series, no?

> This patch also demonstrates a method to obtain the device ID from the new
> match system for drivers which would normally have expected this information to
> be passed in.

Thanks for the testing!

   Wolfram


--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXXum0AAoJEBQN5MwUoCm2NfMP/0UZW/nei65lOyelDC4FJ8/e
J+WIESQCf3uA863vwAKc1uku/XN6ngu8QstfU8V1pCkgHybQ6G84n4JApEDWY1nX
bw3kFORM6O9Qffz3gbn4vI+P9ttIAl2ycPKYGL0LJ3u/2YSrXuXswzTUupCHF7tg
mCoY2CdXAg1ww7gfG2K1TAlvBWiknbk60TgIeQZf1uYcEssRV6T3Q/U3SuMg5nx5
NFmEaj48zf+6yhL+6OF0ksKviFdbqNfhWeNWMkpC/ajwetgseuFGmmOzyLdTRPy+
592w3yuZPDEYC1yBrveEeYTsxedispNLYH571gAQm7PMVNKuy/0KcbkX+9G/3edD
sDfb5JpINpqwsnm+4jIfdDRsxdNoLO055WUeW7F7HRjQHJs+ZlKbQc/u+ILTL77L
XggzZGbuXOYawjHBaxN0szlffYhgwl1Oz3ZD1KrpMKUi20b2DRtag7QVrCMMGNIL
SaIYAylvkcUetzQqv9d5kXN3tDEZ9y/KZDR/+QwJYod/nPXjk943/zxeQN/06y6Y
jCOaIo/gwZI5dUuv0WP7d0/gZLUkVpDnr+m1QP/h1BkeYWotIaMsfdY8dShgMylR
8cnavx98Na/u0lkbCMCy4Zl0w6zUQZ4e0BszMED8Uhk2XbaD3N/12nDjpCEcBA4j
i9Ovvwcg4Yd6WwKut2mI
=UZlv
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
