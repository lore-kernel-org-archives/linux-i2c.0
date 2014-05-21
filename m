From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: cadence: fix Kconfig dependency
Date: Wed, 21 May 2014 10:29:17 +0200
Message-ID: <20140521082917.GG2708@katana>
References: <1396811227-8851-1-git-send-email-wsa@the-dreams.de>
 <1396852656.682914397@f273.i.mail.ru>
 <20140407065657.GO29751@pengutronix.de>
 <1396854155.872298456@f287.i.mail.ru>
 <4c4d2ba5-f5f6-4589-8a48-6a88d1c16098@VA3EHSMHS046.ehs.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iAL9S67WQOXgEPD9"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4c4d2ba5-f5f6-4589-8a48-6a88d1c16098-+Ck8Kgl/v09cIS6rUbAYerjjLBE8jN/0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--iAL9S67WQOXgEPD9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> I'd propose the below fix. The relaxed IO helpers are currently
> available on ARM only and the clock notifier used, depends on
> COMMON_CLK. I2C-related dependencies should be okay due to the location in
> Kconfig of this option.

If somebody thinks an update is still needed, please resend against
latest i2c-next. Thanks.


--iAL9S67WQOXgEPD9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIbBAEBAgAGBQJTfGPdAAoJEBQN5MwUoCm2840P+ISJT7ez6BzEnJaOp+b/67TY
ji2i5O7CAvnQ/nAIfxVGZMkqBNj4wue8ZYLnUa1ixxfsIeNHE3CWcLZyP2PjIZQu
3JYFPcXE6y9f7gkb++3vJNblU9nk2MfwXy9aZKLZ09/ADdhbbJ7jBYIZrv8cubAs
kzekuiz22Rq/s/pbbGWrEQYKncnyElCf/9BII3+8+p3UNdVdwPzfQqmibRhA1H0E
XTpEHFd8ux0bLk5ddXUrhm5QADIsSsu6O//AEv6dh6GM31vsCvCV/H0CHO7csTGL
05Us5hY6u4elCKmZd+LlCSnZwjSledlIU/Wd6UbEAMvYz0VVyOlX5JiXB0sJM44F
Mhyk3NClDIURRQInBABBsCuWEUSts9hNdV+ClcgZoas6EiQhdGzX/F492VABmpkN
+OPwkAjxPT5t7DoCE4AbmJTYyC0pTpp3HNTGsXNuZCih/FgFcfWLYQycrHqmyuvs
Ow1D8koJutcztMMg2397VBbwA7YibjaUIUwPSkNkbGWqPmgeP0iavz1WSeqyjji2
u7/qIpWriKMvQ+bDYwNUbF0fXYH4UbwGOYv5xAt8GP6MN5ciUJ/FYj+zctbTv22L
443zE+tuT6PA0s/PPE88D7HhU7M0st/MixDGbNkbH1CZ0xuOBMUM2+odtrtKxe3T
3N7wBPAp7VTB4Bvyhkg=
=utAo
-----END PGP SIGNATURE-----

--iAL9S67WQOXgEPD9--
