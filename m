From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 1/6] i2c: i2c-qcom-geni: Provide support for ACPI
Date: Fri, 14 Jun 2019 23:17:14 +0200
Message-ID: <20190614211713.GH17899@ninjato>
References: <20190612142654.9639-1-lee.jones@linaro.org>
 <20190612142654.9639-2-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k+G3HLlWI7eRTl+h"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190612142654.9639-2-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alokc@codeaurora.org, agross@kernel.org, david.brown@linaro.org, wsa+renesas@sang-engineering.com, bjorn.andersson@linaro.org, balbi@kernel.org, gregkh@linuxfoundation.org, ard.biesheuvel@linaro.org, jlhugo@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-usb@vger.kernel.or
List-Id: linux-i2c@vger.kernel.org


--k+G3HLlWI7eRTl+h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2019 at 03:26:49PM +0100, Lee Jones wrote:
> Add a match table to allow automatic probing of ACPI device
> QCOM0220.  Ignore clock attainment errors.  Set default clock
> frequency value.
>=20
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Applied to for-next, thanks!

Alok, are you still there? Your ack is missed here...


--k+G3HLlWI7eRTl+h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0EDtkACgkQFA3kzBSg
KbYERA//fln0PxCO8MCvKtu91PRMaykG6c6IGBWT1XinpcUskkxv2dlJL5qb4I+s
LTRaz0L8MqIxk2vkdTYe0unh38Horq/07c26+SjP/NSqj7PAzSFXLOjtd2f6xRDd
T6cbUsRpQN4+qRWqR3hfKRIGmNwZmbUNLTtAVJ4S+Vx+PGOlvX2RweicbI65gRLJ
+3oZ0iQI+mNA7TGv8Dn32SMkevbGYyXBQW4+ff2hR4lUGYRyG/sGB/izNhmqLyni
Pt5MYDHtZo2JnLfennHKAX5r4nhdDLic+EHjr6sKym1TR+IHwwpApExsRuwsRB2p
Mvp3zi5+3QGqq4LaDdsgtYtE9HaKNSbklaIwolEHNqbk2vECz/Dyrq0gZK2OjSzN
/bCiuUNlbQprEnXJ06Z0/1sS/Rm1hiuYrr9Foqk8q/e7rT5ghbud+IyFf3k0ZKBK
D3y5T+2v/qSU5LOFDXpIG+t+pVL8OActa3Rp5W8mE3t3fJWcjXYVQ06TJv77iSPk
ErpEL3zpZ7CE5VaHOVwKEgULEgDJTEdYBW1OKA2hPmwWpQdEwaTMjDmfSpnwkMQ6
oN+MQRNWaFHKjjLANO9iU00j0KnmX48ZdNifcHXKsDtHQbXmKq/s8P556rV/Pysv
sjLOU5HNDvGLDFt6sMRKKEMFKKZP+jqZqkjQSaoQQ638v1n18ng=
=BNzG
-----END PGP SIGNATURE-----

--k+G3HLlWI7eRTl+h--
