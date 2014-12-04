From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 1/3] i2c: cadence: Handle > 252 byte transfers
Date: Thu, 4 Dec 2014 19:32:43 +0100
Message-ID: <20141204183242.GJ7944@katana>
References: <1417610126-7957-1-git-send-email-harinik@xilinx.com>
 <1417610126-7957-2-git-send-email-harinik@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ou9v+QBCNysIXaH"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417610126-7957-2-git-send-email-harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vishnum-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--1ou9v+QBCNysIXaH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +		/*
> +		 * If the device is sending data If there is further
> +		 * data to be sent. Calculate the available space
> +		 * in FIFO and fill the FIFO with that many bytes.
> +		 */

This comment looks broken. In general, I think there should be more
comments explaining why things have to be done this way.


--1ou9v+QBCNysIXaH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgKjKAAoJEBQN5MwUoCm2QNYQALFSMcFaSdbuQdzFfDGCUSNQ
QCBKi1yuVOAArsXzWiPqedR62xNJ2r4AfUhNxAQF+wu6ZZtztOTT1XMFtkNvuGhM
1VYOqRuq84LjduhW19OFCdO0Vli2Zgr9qLKNMLoJxnLviwHx2HPsYyOjG6mM6IdZ
hCLGe1y/he6IhImAyTheqF4VMawyQQ8mzWGGIvuyp/ry5amnUMHVYfWk0FSAm+iV
+fTxLC/9AHmUIUPPu1b5NPHfkaY3R/blgZVkWxSe+sK62+TV+gNJhOh1260NQkq/
9qfQdVm8kYSxfCv0BRWmS2tOCtO/A42zFnkdNbN74OzEZPsxWWMeWb7sb5bMdr3P
i3da2tyQaurODcY6rZah0lfpl7bct3mUhZjWrLyL/yTbe59Kmo9pEFwC4l21uKFo
szK5Rn9vf2MRWJfEQ6C3eOs+LRxJ4wgdDAR4pEJuqO/7aKQoaRF0jchxGNWJhu0G
BJjtY+GLb/OrE9Qu1U6kFrvSCoYX1jHit3d2l1rZNQHLTLnLQFKD0gq2mAvD5AQ3
0SNfFV2HifTy+2jvAfTbQpCxIDp83c+7aT+nasFTPJWj2P50qzMs6+kARX/ujRIR
aBxOgQhBQvgwzyMAI7IQhJhdMRJiFX+POF3hE6qyLK22juapEvdB5x796PhdyGFr
7OwvbsXXapolMMpTh8UX
=4GSX
-----END PGP SIGNATURE-----

--1ou9v+QBCNysIXaH--
