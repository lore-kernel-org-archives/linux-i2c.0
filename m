From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: i2c: slave support framework improvements
Date: Thu, 28 Jul 2016 10:39:14 +0200
Message-ID: <20160728083914.GC2693@katana>
References: <20160725072151.GA1599@katana>
 <354241469432837@web19h.yandex.ru>
 <20160725082813.GA3376@katana>
 <1025301469437877@web19h.yandex.ru>
 <20160725094117.GB3376@katana>
 <1391831469440835@web19h.yandex.ru>
 <499754e2-f60a-5170-21f3-d756f768dd0d@axentia.se>
 <168841469551868@web14h.yandex.ru>
 <20160728074157.GA2693@katana>
 <9bf9e528-de4a-df4d-fed4-ee1afbfb609a@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51277 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251AbcG1IjU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 28 Jul 2016 04:39:20 -0400
Content-Disposition: inline
In-Reply-To: <9bf9e528-de4a-df4d-fed4-ee1afbfb609a@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Kachalov Anton <mouse@mayc.ru>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> In proximity to this, I find it odd that you are allowed to register
> a slave device with the same address as a client device on an adapter
> (one has I2C_CLIENT_FLAG set, which sets I2C_ADDR_OFFSET_SLAVE before
> the address comparisons). Why is that possible? Yes, the two devices
> can probably talk each other, both being aware of who is master at
> the moment, but what about other masters on the bus?

Just a quick answer to this first: The Tegra community wanted to have
loopback support. According to documentation, their hardware can indeed
read from their own slave device. So, we needed this distinction to
instantiate the slave backend driver and the regular driver.

I don't understand the multi-master question: The I2C slave device
should react to any bus master anyhow. And for competing bus masters,
there is the arbitration mechanism.


--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXmcSyAAoJEBQN5MwUoCm2YqEP/3F4lmJQQMPbdO/5GBFpUBxp
oLQEXJJKd4x1rP5nA4aYobe+RIvQO6GyBV/L43deHevW89WNND9ebMlTypqdW3P1
EVKxz3zc2ByH9012RVkOpjTdI2pkohKUzOD//LeCLwMCXHYJZhbcXIVwtrvzFfYI
UNWmigqUyY4Y04d1BJI1nAmJru+g+59E5quwoe8DEPOp9qAFksPfEeFL/aeYiNIy
Npsbjd/bkGBj7TRv0GpBdXUPwUv1wa/cORtnN+NaKgbkUsVGdlT+wU+YufBahabm
UR6K651QRmXvL7Gjwu/H4V/EOW7PScEZQs3c0Gb81yIJjIv3Nqiy+d5MeQtJPvh3
HICjgYT9mzxzK4awTZPDywOcNRgCNoUDg9mRQq1+YwTrFUEZCnYPeewnOl7hvhOc
p2Y6ll0gEC/s1IGMPiXMnwde/D42S78T3Ppa4+Dc5RkZqqLeiZYBbbL0SaigELMc
W4rAOz9tWx+392Ny9bvEyvbap+3mEVklnftdMMDyoWwZn3KJ7/Fosg7B35j0ORnq
VMRDk10p88qR0BmXit8I9jkdXiiXv9LqXJlXj1PVMvc/CA44dddyXbY1JKfHoEve
1gTy1lDFpbqY61hT648ZlTgT/CO8+0LfLPZ5JpT8M2sfb4lvEUwIiGLj41NMtGY/
uDqJ62soqVnjtyvRRKeb
=/zvy
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
