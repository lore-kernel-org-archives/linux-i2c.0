From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: i801: Fix I2C Block Read on 8-Series/C220 and
 later
Date: Wed, 26 Oct 2016 14:51:12 +0200
Message-ID: <20161026125112.GA1438@katana>
References: <20161011131327.0eabd227@endymion>
 <20161025100241.GH1597@katana>
 <20161026141532.5bd82382@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55363 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S942107AbcJZMvV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 26 Oct 2016 08:51:21 -0400
Content-Disposition: inline
In-Reply-To: <20161026141532.5bd82382@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Your changes are obviously correct, but you'll have to solve the merge
> conflict again when applying Benjamin's patch, sorry.

I know and I am OK. Still, I wanted your patch to be in v4.9 while
Benjamin's patches look like v4.10 material to me.


--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYEKbAAAoJEBQN5MwUoCm2QV0P/2wQCcyb6xGjenMNCRuv5yIy
2XWw+5xI4lpcBfvJbtsVZ8k4wuvSgu0J8+DgCowAY6OMzYdHUhSWszgkVYpobTGb
1qpm33ncmyN94ZmPPbnwyaUb9o5ZpBuOebm+K3nojigK4WVBQYc53oU2ZPePM9xh
3abCSt6SaX68p9BkY3feE1yiShbJPBfwvfm0knZQMscCWEAaqJf3e7RwyY4HiqxW
vSKrTp/6+YE/xEVs0JjIcQqUkogLay37W/Kur31l0QCMcA4Byt+tTtXyAnEq8BZK
6NyzSfjBZ+uyqLkz4xwXJ9TfHcqTFXMOsA84PE+6Hdf/LMmUq6RcHNzgyOy74C0H
hmRVkfh9z6inUkdYYsrsVPhusTcTExNyrIb57BNCBqc7TxbKQoUio8IqvS/lKAzH
kD+kAv4kUPJiXMF22AC1NdWr5ll9wITGXa3EVNBOI3lVF+GEDGgUQu3VhOewSPSi
gyz2TcqWvcskKlfMpVNMWFfI+WsNx/PCyUbdGTtNCtE0jlxvauZ0Xu3Qj4YVrCgO
xJHCqrVzRmvssOiTtefS6k3l4ZlXFGec/sKOtlgw3k/YrKsotIJfKw16G6xhN0pw
t2lFogJJ474wyLpzWPPI8cx9V7hd4dsAH8nHFFpPo52TFRkkL4l5dyEUoUxyti+y
Wo76JOlPHoOj1lhWR/0k
=6uE+
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
