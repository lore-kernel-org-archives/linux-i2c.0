From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v5] i2c: rk3x: fix bug that cause measured high_ns
 doesn't meet I2C specification
Date: Tue, 13 Jan 2015 12:42:37 +0100
Message-ID: <20150113114237.GC7660@katana>
References: <1418277650-25215-1-git-send-email-addy.ke@rock-chips.com>
 <1418295760-19639-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1418295760-19639-1-git-send-email-addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2014 at 07:02:40PM +0800, Addy Ke wrote:
> The number of clock cycles to be written into the CLKDIV register
> that determines the I2C clk high phase includes the rise time.
> So to meet the timing requirements defined in the I2C specification
> which defines the minimal time SCL has to be high, the rise time
> has to taken into account. The same applies to the low phase with
> falling time.
>=20
> In my test on RK3288-Pink2 board, which is not an upstream board yet,
> if external pull-up resistor is 4.7K, rise_ns is about 700ns.
> So the measured high_ns is about 3900ns, which is less than 4000ns
> (the minimum high_ns in I2C specification for Standard-mode).
>=20
> To fix this bug min_low_ns should include fall time and min_high_ns
> should include rise time.
>=20
> This patch merged the patch from chromium project which can get the
> rise and fall times for signals from the device tree. This allows us
> to more accurately calculate timings. see:
> https://chromium-review.googlesource.com/#/c/232774/
>=20
> Signed-off-by: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

Applied to for-next, thanks!

I fixed the typo Doug mentioned.

Please send new patches as seperate threads, not as a reply to the old
patch.


--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtQStAAoJEBQN5MwUoCm27d0QAJ0C0cXADG+xa8Ne8Bm5HLpn
tLSC1zy2GCk9ykPqU3o0KMmjibA7XbfCx9wEYVTHgBG0KAO2K4oWPnlCxfNknoDt
U5pRpIG4/TJhcV0bOXw7c6zKfX7tHUukynNMbpo1C5/w8UvzPGlZoFqkOSEO1UGh
3BYpNk6+6AbiX2myndAbfKheb2zqV7dghdvS8WUYnn8o59VYluJT2FvLKCDdMPF/
ohIFcEwmTxW7AqpjalgBwg3tE1MIlqwCr5BeIV+7iR9hHzpJ5zQ5bLXOYw8V2iQW
iQHeNAL/ApVERfQxOTPwm2dBvt2WjvJ5r19BnpwmRtjU2wNfzEkFE89Pei6XeBjN
2WqJ8w6dMSkacjRNyDVgMTtlQi+kKCvGPfaI1pdAN/W27Y3Cm2wtn9tDF4URY2YI
8DT20EBjt9U7ve05sbR+HIiyHc2dldRh4p+7bTKt+oL/VftYp+fI6dWuNs3tTu8K
ZPnBUvkbK+ta5XeCTDD+bTVh2as+fTJU2cH1aiQRJo6vy2Qui7mdJ3N0RTdMsgQ/
vp7ijglIDmA8Bz9AKbPbjcZEOPx8GEVus3rIcCL+2T9fxmgoqoufUQ7WRVM+LlRk
QYeFBwi8ew3Y5xFTNU/ESvC8fn6PI0hqBXvQTdD/ZbG87L3qT+ve15iBT7ytzUmu
ghV4ncW3ytJ6LRQ0CboB
=K/FS
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
