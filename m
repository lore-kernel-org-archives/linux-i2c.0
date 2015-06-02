From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: scx200_acb: avoid I2C bus overclocking.
Date: Wed, 3 Jun 2015 03:21:35 +0900
Message-ID: <20150602182134.GG1494@katana>
References: <553955C6.3030000@secomea.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yQbNiKLmgenwUfTN"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <553955C6.3030000-sijd2F9aCfdBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Svenning =?utf-8?B?U8O4cmVuc2Vu?= <sss-sijd2F9aCfdBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--yQbNiKLmgenwUfTN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2015 at 10:27:50PM +0200, Svenning S=C3=B8rensen wrote:
> According to I2C spec, max SCL rate is 100 kHz, but SCx200/CS5536
> controller is currently driving it at 214 kHz according to my math.
>=20
> SCL is derived from an input clock of 48 MHz, which must be divided
> by 480 (240 cycles for each SCL high/low state) to be within spec.
>=20
> Signed-off-by: Svenning Soerensen <sss-sijd2F9aCfdBDgjK7y7TUQ@public.gmane.org>

Thanks for mentioning that it fixed a problem for you. I needed this
info.

> +#define ACBCLK		240	/* 48 MHz / 100 kHz / 2 */

Can you add a comment where you found the info about 48MHz? Since I
don't know the hardware at all: Can you imagine that there is even older
hardware with a clock where 0x70 was suitable?

> -	outb(inb(ACBCTL2) | ACBCTL2_ENABLE, ACBCTL2);
> +	outb(ACBCLK | ACBCTL2_ENABLE, ACBCTL2);
=2E..
> -	outb(inb(ACBCTL2) | ACBCTL2_ENABLE, ACBCTL2);
> +	outb(ACBCLK | ACBCTL2_ENABLE, ACBCTL2);

For consistency reasons and to be less intrusive, I'd rather keep the
original chunks.


--yQbNiKLmgenwUfTN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbfQuAAoJEBQN5MwUoCm2uOkQAJhR9zcQgDqhdqkjK8gzWlYC
jMPDhblJhRHe3F8fDJ3FMsLgMfO63TtdJmsTviqJR6ItBwf6dq8oLBbIIsj9MxSc
DjzEVPC7+X5qvZKARYrLh7biaS+3lk437d2nw7ufqpIHy1YFJhpkZOO1Zjeugzhz
9A0t/v8cg97Yh6Gnd0tEVpPDoJvWscnjbexXbYfNOfts+19rCWVwBsHV3z+nzEW8
OfEuV1yQe4l4o5r0hPLSWmo/VRNBcFZCcWrbSfuLb+EW32398a70R1ZTI4uFpCIB
Lje/S5IDZf9cgc/x1ltUcUpdJWUgN5ETvb+1eIacK0hVx3WfeFQwlwiekNVjHbIc
vzSI8W+YdRUaieW9kNHBVk3U1yHo0aqO80uZ8E/x6CCaZfsRoZ2dca6nV+Ocpa2Q
vVuNnx9cNYNbXCtYZstu8TslfEOOkfV3ZRT8et0FXqH05YPLtO0t4MVMVPTM39yM
iqWnMCIakVooRRo/OjfA8U4jbaRyU1P0zPNJJWpmZWvNUt4RGrnkSSeH/cIvc+VV
V6+aOrVJ9ZQFEmyM/DnG82IuwPLHCNSmKASPiH7D+HG8EK7p4lQjlGBJCKZ9wcgb
PoMnLs6e8Nipf5jTMnc8rw8WcB/rnZysjY2Fd3r8aS1WkeR0Xq/Mg5Tpfps7uQGN
H/DZnxr9MUQet4gLU1KO
=CI3M
-----END PGP SIGNATURE-----

--yQbNiKLmgenwUfTN--
