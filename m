From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: algo-bit: add support for I2C_M_STOP
Date: Thu, 22 Jun 2017 12:15:20 +0200
Message-ID: <20170622101520.hwbzunqg5xxehttp@ninjato>
References: <20170617171238.19638-1-wsa+renesas@sang-engineering.com>
 <20170619103002.5d502c92@endymion>
 <20170620172810.h2anac45n5u3oova@ninjato>
 <20170621091843.657de813@endymion>
 <20170621143018.GA1571@katana>
 <20170622110606.6ae3aabc@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b7fm5gn6xkytka4r"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170622110606.6ae3aabc@endymion>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--b7fm5gn6xkytka4r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I remember wishing I could drop support, asking around, and a few
> people replying to me that 10-bit slaves actually exist. But of course
> I can't find the discussion thread again.

Dropping 10-bit support would be super nice from a maintenance point of
view, but I didn't have hopes for that to happen ;) This is why I wanted
to buy a device to be able to test.

> However it seems that in many cases I2C_M_TEN is used directly (instead
> of the more correct I2C_CLIENT_TEN.) See for example

Yeah, good idea to scan for I2C_CLIENT_TEN directly. From a glimpse, I
didn't see a device which I could easily buy, connect, and sniff the
wires. But it is not urgent anyhow.

> I see also commits explicitly adding or fixing 10-bit address support
> in various I2C bus drivers, I don't think developers would be doing
> that if they didn't need it.

Agreed. It will stay, I had no intention of removing it.

Thanks for the help!


--b7fm5gn6xkytka4r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllLmLgACgkQFA3kzBSg
KbZO3w//e5SQXFo4NC1KUGs/F8TSbhtwAMbsJOi9zP3NPEpNO4NXXCCv72/Ersoe
hAzIx+pVLu5y4r1evqa6D4sbXE0eqwbsFJziJx+ZoZ4470lMzfi4is6HSGvgkhzL
GAlNJn3A8mkZ3T1FWxVUGtUcupE587uytsSdWfXQFP22G2ECzLKdKPx4d8DmZRtr
cbP1raKgF2LKy4BLJ97L708yI27F910fNyhYEL9ttS9UpVhjz8jPA4hMe34S/sS+
1OQU8fC+Kmm2JCI6RAYL37am+Ee0DImvu43RurFnOXmJnkGxcKBKo9ZccZm+7xrq
ecylNWuhJPs7bwBRejSPdaXbCUzhZSEr1tn17Bq4dsJn2X2IawU5DjBJwoNoU9Pd
nOh1C3pH4sEEEbFpAed1KJfHTp9S/2a7KDEJ02tosC/SjFDEeZWv586gBa24ebiq
iinBEPcES/B4V1wajYSVs2ebH8zyHLOSUyD7Cff4l1M2sM7rXfBI9E7VnaCs/u41
B1L97wPYmOrD0QOoZ6QGmw1ptEbXefuCUWWTufH9MjT5GMBDWUXOHVvxPqE3hLqO
AAeeLoQOMHuF9/D37MhSzVvR+yhU/qxiQyCXmHkZXFr0jhM0ld3WqRngmBVAykAJ
5Irgen01DmBztpJX0U1JEvajlYT2A+F6qB+711vcIJiz55BjiNU=
=pE38
-----END PGP SIGNATURE-----

--b7fm5gn6xkytka4r--
