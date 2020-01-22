From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] HID: mcp2221: add usb to i2c-smbus host bridge driver
Date: Wed, 22 Jan 2020 14:13:20 +0100
Message-ID: <20200122131320.GA20984@ninjato>
References: <1579581860-29560-1-git-send-email-gupt21@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1579581860-29560-1-git-send-email-gupt21@gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Rishi Gupta <gupt21@gmail.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, wsa+renesas@sang-engineering.com, gregkh@linuxfoundation.org, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2020 at 10:14:20AM +0530, Rishi Gupta wrote:
> MCP2221 is a USB HID to I2C/SMbus host bridge device. This
> commit implements i2c and smbus host adapter support. 7-bit
> address and i2c multi-message transaction is also supported.
>=20
> Signed-off-by: Rishi Gupta <gupt21@gmail.com>

My main concern is there are quite some limitations in mcp_i2c_xfer().
Looking at them, I think we should just drop it. This seems to be an
SMBus controller, not I2C. Or?


--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl4oSmwACgkQFA3kzBSg
KbYUUQ//QRTq13acJjQ3rK7tv03qoLYBTDze3sLkt3dr/yc6ZTQAlXxHGEWdCAzE
zGI4hOu0rpLt+Rm1KQsQo/FDgU7fy4BXSi9oe5zr5TPRctWVAV3MpcqRq0CIRDwP
TcQ7QsXawtCRtwhlOOVzYMqK8DOkeXQncs0qT3ilqpruBA5gbmJanMyVpNU9hQMG
i9fYTdYNBgnydG7TqvCA5Vn2hOQuwIJjt/vNFhDu5dum9koKe+K3P1Ns7TtqeCcA
xB4YL0eQydWNrS0U0nKQoT8L7cwWOwQEa6Nk6zKLIsKRLFbYdQu0KpEBi+KEmzCC
jXHL9B221rG6fvgDp0VaPCRrQzdexgu2tIAH2TQHVReK9+wZOFVIvz135Y3lj3sR
TcORLIPjziA62yQwTWA839liZEYlAAyEcwOUL0U7w7TYMu49SJ0o79nj+Skw3kUt
SwSqq9LLlWO7UJ09omKhikj3zgfBGz7e9V4dCUqZLcSntGEK3yDZBFqXwKGqT3sd
GiAEZu6zocdiZxX5CdUQhJQmUMJHNqD/xYTS6PqKwIu/Kg9jffUgwylV+j4Pmbv5
m/cetIceeRk3DXZ2RUCt0KZBg0UrwueiuBYetiETINRkgDlzNI9FjHYJROFN61ph
ux8Dp4L2SaGrwScrrH+2fiQdpl3RBDNYG7L1ssJCLjXN6pW6jvI=
=hhi+
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
