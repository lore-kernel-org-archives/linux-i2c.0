From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Fallback to of_node of parent
Date: Sat, 16 Nov 2013 17:06:02 +0100
Message-ID: <20131116160601.GA8723@katana>
References: <528791EF.9060505@koalo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <528791EF.9060505-oZ8rN/sblLk@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	if (!dev->of_node && dev->parent)
> +		dev->of_node = dev->parent->of_node;
> +

That is not enough. Current drivers could then have the assignment
removed and even more important, this behaviour should be documented.

Regards,

   Wolfram


--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSh5fpAAoJEBQN5MwUoCm25B4P/RSu2lUvlTiCC0juQ14xPItg
9W+MTd/1HD6uCKly7aO8Gsk5JZHhm2sUCCACtrJ94pDgm/FTwUc6dVdsvF38Vgxd
fTcaRYdOtqwMBWW3Pa4+PJuMFnIuWwkeIrF8+XweqFQMcnfPhDgsabKxQue/1EMk
Kn8zGdlhmeixISQ7zVtnIxQjO4zDQkCd18j8btaw2xuvmzZHOzkWTitvKXP6DjMk
nPVP/M+3J9217XBd3t9cGY+lZ8R0ZlcSVP+TonUOGa93kjjQr3I2xixlqseu1xOD
fFTlXaTYgY+Wa2xGP/QZtx5ttYLQzqSfcNs98XpgAXJ/DUCfACHf1kOJLhvNtoPd
f2r5wckNoQNF9x6/Hgxh2LaleRQtovX4rO+g03Mr2/uPxrixrUhuDbycWKGwlh+7
15/RGJ4RQY/sxdwi0+DjNGy76UfFokUhW4nxxL+14hIJoevRV3SlGUfZbl3S2o6+
PmnGt15vQmoPmbysZy6sqDVEBwwfks9R4KW3l7V3NfV6JTVlEGuf5qN+HK3D4vfj
vMPoN54xddpXMT5F5Xnni3wKNzZdrEHAQcYa1hOYAdFcDFIAiEPE53yZvrqst7js
al0+nBVG8UPdGWQWRTKWaMk9dGp+TTWyglobS27mTdJpkKeZMf6XUH1myhf7l6ti
hNnTZOZbJoimWgda6lwX
=MHLQ
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
