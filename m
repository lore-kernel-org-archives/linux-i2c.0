From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: Add generic support passing secondary devices
 addresses
Date: Sun, 5 Jun 2016 08:15:03 +0200
Message-ID: <20160605061458.GA2722@katana>
References: <1454254380-9246-1-git-send-email-jean-michel.hautbois@veo-labs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:41357 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750775AbcFEGPb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 5 Jun 2016 02:15:31 -0400
Content-Disposition: inline
In-Reply-To: <1454254380-9246-1-git-send-email-jean-michel.hautbois@veo-labs.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, laurent.pinchart@ideasonboard.com, lars@metafoo.de, Jean-Michel Hautbois <jean-michel.hautbois@veo-labs.com>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 31, 2016 at 04:33:00PM +0100, Jean-Michel Hautbois wrote:
> Some I2C devices have multiple addresses assigned, for example each addre=
ss
> corresponding to a different internal register map page of the device.
> So far drivers which need support for this have handled this with a driver
> specific and non-generic implementation, e.g. passing the additional addr=
ess
> via platform data.
>=20
> This patch provides a new helper function called i2c_new_secondary_device=
()
> which is intended to provide a generic way to get the secondary address
> as well as instantiate a struct i2c_client for the secondary address.
>=20
> The function expects a pointer to the primary i2c_client, a name
> for the secondary address and an optional default address. The name is us=
ed
> as a handle to specify which secondary address to get.
>=20
> The default address is used as a fallback in case no secondary address
> was explicitly specified. In case no secondary address and no default
> address were specified the function returns NULL.
>=20
> For now the function only supports look-up of the secondary address
> from devicetree, but it can be extended in the future
> to for example support board files and/or ACPI.
>=20
> Signed-off-by: Jean-Michel Hautbois <jean-michel.hautbois@veo-labs.com>

Fixed a 'checkpatch --strict' warning and applied to for-next, thanks!


--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXU8NiAAoJEBQN5MwUoCm2x1UP/2iJA6vcisXXipbBaUUCn/be
Dqhwpx8T7E5VSjGtq5zFT2kP/Qbr1+wkFkGyFQKsMd5n7UMgvrG9TuDyTFpAAJVs
Xov0fd8oTtA8SbquP//PipLQmtMuSdCd80tqayqYEgV9yGf9msRIc8RnyXUZ/q8/
RyvLtTIE9nD0ZV88KiuKZAqaOmjjeEf3gW5ouR9VtTiN1LvxEnF0LzezIgFQHVoi
gzqk4V56oulahk/7YtYjAELnNeVgK4uVwoVlthV85QK6YaLPm2yIti+VwVaMNgTV
6p3RCjnRm003CiWIfL0pAXzo0F3RXWUwqXlN8rn8wDkUEXoRQrjZ7U3ZdNrNw3PJ
Z2oDnr1mQxDJcDtnDK3zRyoSszR15CezwbEU6xgtYxgsI1lKKflMcrcIldUB7oEp
zxqvo3mVYBmtg35KNW1XZV4ipyn71U6fKjfI96CPgTYnKYUxbCsRIgamZv4uKZHU
hE4k6V7xm3x9Xb1CC3qkm0185tS2Rh3Q5VbJwDFoExrvrXX9MrxpjvVDiT4ERmOh
XHg8ZVqQqBjuO3xyNcF4OJ9lyrQrSx/GX/hX7fl15flaHpnI6pWZJNU1/ontuqTs
8xJ/h6fvX0qW/ujdodqqyAkawtv70fvRUzNsAHxDA2Dsl/hY1h+0PceUTzoy07Da
ZMB4aB4o1K8LwJJZorjf
=/XYl
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
