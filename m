From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC PATCH 9/9] iio: imu: inv_mpu6050: Fix deadlock between i2c
 adapter lock and mpu lock
Date: Wed, 2 Mar 2016 18:06:30 +0100
Message-ID: <20160302170630.GA5439@katana>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
 <1455810794-3188-10-git-send-email-daniel.baluta@intel.com>
 <20160301205052.GD1488@katana>
 <CAEnQRZAF-tAjDwJkUNEVQXYqWDt7RsH2bH81UBAMUhsoWEt73g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAEnQRZAF-tAjDwJkUNEVQXYqWDt7RsH2bH81UBAMUhsoWEt73g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lucas De Marchi <lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Ge Gao <ggao-ktqnL0SqcGIj5TC/SZClsA@public.gmane.org>, Adriana Reus <adi.reus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Crt Mori <cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I looked into the I2C adapter / mux code but I got lost rapidly :). It
> feels like the natural solution would be for the I2C core to not hold
> the adapter lock while doing transactions on the muxed child adapter.

The patch series I mentioned to you does exactly that. It locks only the
mux side of the muxed bus, not the whole parent adapter. It didn't work
for you because the mux driver maybe needed some adaptions as well?

However, I am still undecided if that series should go upstream because
it makes the mux code another magnitude more complex. And while this
seems to be the second issue which could be fixed by that series, both
issues are corner cases, so I am not sure it is worth the complexity.


--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW1x2WAAoJEBQN5MwUoCm2SoYP+wZhCsIYf5HCUxo9YtA4sYB0
41UQd1yVEe16asuC6ChA3UDvjnDGLgy3FcDzwWjPEyJAt7kbP+HhOVjjDpkCe1ux
8C+lr274LITknO2rM+aU9hVFsUnDuMOukvELYxOGZXtQZkTnC/VwuZL4nSrD1CF6
YMCknen+/cluY2Klg+jadpE5uBhKtRdLGU2Nj1YN+o6lhjSsn4GnZSZLGOcjgoup
HGrprCIwU5e4rt+BVrRRCokkptQBJGOjaY6i58NARkJlJlMOXfVbruvNCU4/YLNh
2kMnW3R7aKv54X4KeYl/vaxWg7FBIwWiiVQVj7Sc9H1FE0P1N7S4fZoylmzRvoDe
eH9jH1SESQKqks1kWJ49q5i1e1RoGqwQXIrN49+Bc+BXEyqYOgTYbVpoeXdfhLOI
nCrKkZ4EHxOBO9YT0NPjPdBoyKXQtSpnSl9pAsQQSo2UjC/qxBwWYq49QXs44K15
tll9rrUeES/FUzDjVdacDgavu449MirvUJibKmbgBTib4w/YDeRYb7RPOe9yZ0VH
KOpVR5hqhBPB7tukKq8Mc47CmFdPedbGQnUAkDlP7cxcbOJEPqPJBf1MMa+ozD0y
jeEMGRql+UJsFFL3DiiLBQObAUid0HHjIldWp4jg4xgm7H4xvRTP37Q6uoThC8Lw
tvmxS7J0c2l7iEP3dGL3
=ex7G
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
