From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: VAIO EEPROM support in at24
Date: Tue, 17 Mar 2020 16:01:42 +0100
Message-ID: <20200317150142.GA1134@ninjato>
References: <20200317151409.7940926c@endymion>
 <CAMRc=Mdoh5Sk3iS_CO4+++SG2jJOy1qrG4q2zOzbeYYMdJR0VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMRc=Mdoh5Sk3iS_CO4+++SG2jJOy1qrG4q2zOzbeYYMdJR0VA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jean Delvare <jdelvare@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-i2c@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> And we could introduce a new macro called AT24_CHIP_DATA_MASKED that
> would automacially set the AT24_FLAG_MASKED_RANGE flag and take
> another argument that would contain the address and size of the masked
> register range (we'd put it into the "masked" resource)?

I am all for generic solutions. One thing to consider here is that we
need a generic way to detect the various types. I guess it will
always(?) be decided on some memory locations having specific values?


--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5w5lIACgkQFA3kzBSg
KbYekA/+L7CJLLps1WfhgGjOnA/K+jrFcxXmxRwf7JcXxM/1KTNdrmIKPgyGNv0Q
AjgjVmofhpu436E0cnYTJkQLP82tqbDzlIe5JEUtp+YheXfLsOVqZpi603ZDU6Iv
d8dD3JenhnJkS+1NLLY8zH4wJwYfily3GmbnF6Wnf5DczOuJHeLZBPadF/33t2wJ
6HxdcVWA/UDoqTPk0jKJCo7DNWOCh65mRRyX1Czt//r49jOGiHBbSQJrMeCzOHWI
T79PcDm8lh7+gs34Z+O7oS9rDQPwjsyGvxV8Grp2l6cJKzF5L0YW3zTcv151gw/O
PBn9MsPIvQ8XYzZKLKByCd/3rGl4btR16oqVl1vVaIxeDFas5JzuCl+3NzCFTfBY
IkqBM9M1nGXmkW6plaHPHttgQpbc+kmduIV74/FTDi+kAw6g3IH+jfTC1R8k1BPV
DqU8oiPLAMtRXjiDq/jLo0EZquA7Tck3HdgfkjjAEG7KrgZlf6QqaSETCtD/ZzMb
EP+S0FyvTW3/94/vxdCu0Df3pbMFJYPAHGZTA/XZGh5OlytzIqwYuET4VLFxpR5R
Kmaz7nABZObCeoQom2to6r8MRZwXhraP3eGK1yf8DeirIKHiwAxw5oMGxI2mfKMr
xqUEmjwYBpSxiWScFheTEM1W4qjaFcHuqeK1buPOGtnnu7omMhE=
=N89D
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
