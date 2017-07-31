From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 2/2] i2c: designware: Some broken DSTDs use 1MiHz
 instead of 1MHz
Date: Mon, 31 Jul 2017 15:57:11 +0200
Message-ID: <20170731135711.c77d2zrgyuzlb2af@ninjato>
References: <20170713134502.10816-1-hdegoede@redhat.com>
 <20170713134502.10816-2-hdegoede@redhat.com>
 <1500213858.29303.20.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dlt2mdaddwryzfmc"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1500213858.29303.20.camel@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--dlt2mdaddwryzfmc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> (on condition Jarkko and Wolfram are okay with this; in the future it
> would be better to have a list of possible speeds and algo that chooses
> one based on FW configuration)

In deed, that sounds feasible if more broken firmware shows up.


--dlt2mdaddwryzfmc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAll/NzcACgkQFA3kzBSg
KbZYfhAAkvTsPhoP7gd3vaDYNSvkg6+MzDCkgfGI6gLNuHFsd/ywM44KahaXlNTP
CawSvjbDS+1CR1j6akyBCY/hZviRhxGdgDWkowQiiiJquq4j2wdrapjAX4vFGzTy
sXDvCyZQ/W1t+KosXbjyDGhVHrcSDPgzxpC+owjygasQwcblv43m7X3vAjVsW4C8
5egRlPJZjO7vJHtMlFQt8v+1DefriPWX3rB5UMxZms4r7s4VhosuoPwakDS+IKVl
yFGxtCRAb+oq/oTofkZGmRw6mbewEIksygGlFWdOY6wQHrhOR+sJU1IpT8Eo+xMv
6Jk2bd3m11ywAGNRi3NEg2GvaNQUCPnXnWzlSa/p/q3hUSAtxtfCidMY/CbUlg5o
BX2Lc5FOyrypcx7wmJ7brbRglsMXNIH1tgISsJR0pQ37cACBhwTNjQCRivdTHKOo
eqRaBWXPwO/rtOfk8UQKakuer5wdLR6dLI2qY7J2bDrIGgcWJsQpKknPxUShEQ5O
1oLdPLpR0bnIHs5sidXg8qqrvHBAyxx9HMM7UZIXJj4CjBdodtfz/nljmvkTKgho
9j8n9bX+ewM2s8jgWDrXBMzAR/OHhAgL91Nj5wQPxvfJqAtI0tnTR1UVftF19EWC
iCb6JwUeDGis8hyjUI5AIUg7VXCUAlPQVmged7m6nyJ3CFdrTKc=
=VAlT
-----END PGP SIGNATURE-----

--dlt2mdaddwryzfmc--
