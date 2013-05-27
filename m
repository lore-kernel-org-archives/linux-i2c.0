From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] i2c: sirf: move driver init from module_init to
 subsys_initcall
Date: Mon, 27 May 2013 08:16:58 -0400
Message-ID: <20130527121658.GA3660@sirena.org.uk>
References: <1368672607-5536-1-git-send-email-Baohua.Song@csr.com>
 <20130516093846.GA2927@katana>
 <CAGsJ_4zVOF8-g=emEGgP3atxkWdxMaQQiVZrZkht_WueTriSnw@mail.gmail.com>
 <20130525201032.GD32043@sirena.org.uk>
 <CAGsJ_4y6SY6nNkbW+Yh8jx0WB4Pi9MO1W3xVZcrQcedGeD5ogQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGsJ_4y6SY6nNkbW+Yh8jx0WB4Pi9MO1W3xVZcrQcedGeD5ogQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, workgroup.linux-kQvG35nSl+M@public.gmane.org, Xiaomeng Hou <Xiaomeng.Hou-kQvG35nSl+M@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 27, 2013 at 09:54:56AM +0800, Barry Song wrote:

> Mark, the case is not that deferred probing is slow or not. deferred
> probing is pretty good.
> the case is that we want to i2c and media connected with i2c probed
> earlier than other devices.
> in auto infotainment devices, we actually do some hacking in kernel
> that makes rear view work earlier than other device driver
> initialization with a kernel thread which take care of backing-car
> policy not only mechanism. that means, we make camera work to see
> backview image even earlier than other drivers' initialization.
> we don't want media deferred to wait for i2c. we want make some early
> jobs ready earlier.

So this change makes no practical difference in mainline and exists to
support out of tree hacks for performance?  It doesn't seem like that
big a patch to carry along with the out of tree stuff...

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRo063AAoJELSic+t+oim9S3sP/j3A2fecoTYaq3LwNHVkyv8K
fy6PTmbfSEkvWR5pkYw2b567ODLtNW3Ld7h7OsY0R0am/jgjoknKNtMkBSoiWJV3
Zw1N7xygfbvQDk4IgQhpSIJmb5P/woiwoBBSgdlJeZ95dBVzxaRe8wndGqQayOIY
DvJjxHf0uPH0yEWtYohUsTG/PQe3AvaXsr4XlTXgbQpwqsJzww2vzSTq2BCy4zn5
jXWxEMv9vWGTuqWAVmf1uGUH8sjUnS/CDTl+BW7O/K8oNNj6m5MMRSmFo2TF8EyY
PTKYE7UH1NPa7PnfAyauqMGzMuukK6+y3KI4G7AwYkB8nYYeOPlGjfINxkHYf+sz
uwvlWi78q1U05/KFRISgpXyFEbPWGoDpLbgLxizOGUod3Mm8gRqG7sAaE92ZVM/E
EFFcAeKZqzOWh5MEwTy9pd5DKm0jn4QhNuENbU5XhjV0Vqhrwmz7B2lazWTaIPTQ
2BgQRvb1aXhpPxXR/sH5b0r+t264APO/WJMKvVMYyg1Uq6Z9kFiPwUXlO+2IVBO7
njGm2TxSRanVhXFgMOPtbrE1CdAMbh5rLKeky6WJhLl9UyEvFIQubjxWl+TenQ0e
AtJgtZNZ62mn9vceelxop/rpr2Q0AungU5tAGb6MR1TaoHR7kvFxdB0bURGUmm3f
oH4PA1FsCs23rSFye/lb
=sEpd
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
