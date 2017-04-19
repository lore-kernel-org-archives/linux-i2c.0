From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: PMBus and SMBUS_BLOCK with "extended" lenght
Date: Wed, 19 Apr 2017 08:54:36 +0200
Message-ID: <20170419065436.GA1432@katana>
References: <1490948247.3177.233.camel@kernel.crashing.org>
 <20170331163336.4sy4br3i2o5etcoe@ninjato>
 <1492580427.25766.131.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:59524 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933226AbdDSGyk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 19 Apr 2017 02:54:40 -0400
Content-Disposition: inline
In-Reply-To: <1492580427.25766.131.camel@kernel.crashing.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-i2c <linux-i2c@vger.kernel.org>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Not a huge deal, all this is just a thought, I don't think I have a
> device to deal with today that will return more on any of my systems (I
> can double check later). I just noticed that while reading the PMbus
> spec.

I once stumbled over a TPM device which had a flag to send either 32 or
255 byte. Can't recall which exactly, though.


--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY9wmsAAoJEBQN5MwUoCm29dAP/3WJKQQzBJssI0S75KVsXS9+
NyHCtn497Iv1hwVCJYaUVAgu5LwF6fTX440syCzuykh23Z5Yb7pkaIbHFXGWFtBN
Hq5OhNviWIjHviR8mBg0ruSBjeulGRuVnqYiQyq4T8XBtaRaXfhbkbAu/kthTiae
xdnFB4T7fhOIGgbvAQDNmmJG4EbV0J/ZG1lovVIYzRwvL1ZayfLDPsAMZEL3B2zO
zXg7VKVrR9uLAHo0VUVSZRrvZk3RUIyUwa7juJ2tvblDC/ypq89oe4VT8vTwRUuO
Z1BQeQlrwXjCOCkNvyc1zoJRTQFhXBf01ogvBrSgQz5dshs/f65q3qbKqFP26zG8
PpI3zzGVj8JlTxL8dskMyJDs57rrkTE/gmCCnp6vdWbfYJIdYIYbjDdwKhl5+Hht
pGzfqw99mdykUsbnHqlyo5eLnaLKbkSr3nSMkCDggc+953s0kFacxDVPB8Wsamhf
mY4cdNyC/tIs9GwIQhlUasB9cch/Hu1LugACWvURYrGdIGDC+87b8TU10FKPnsQ+
45qYOL40APZMK82R8a1T3tEbzRYPb2v3f32VUHW8YbEpHAekppX+1CSTAUjl15cb
8QmT0646ej1MzDnOQoUW1NXzKRsE7HdjNUOBHL1cCacnwGFdVO5Ijhuavl6yudF8
e+qTECT8azfM7UPyyBOb
=Myga
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
