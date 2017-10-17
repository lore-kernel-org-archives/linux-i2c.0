From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 3/3] i2c: xlp9xx: Handle I2C_M_RECV_LEN in msg->flags
Date: Tue, 17 Oct 2017 23:54:53 +0200
Message-ID: <20171017215453.volrt3ma7vdo5ko2@ninjato>
References: <1507616876-17189-1-git-send-email-kamlakant.patel@cavium.com>
 <1507616876-17189-4-git-send-email-kamlakant.patel@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pji62g7rjmbidu3p"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507616876-17189-4-git-send-email-kamlakant.patel@cavium.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Kamlakant Patel <kamlakant.patel@cavium.com>
Cc: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jayachandran C <jnair@caviumnetworks.com>
List-Id: linux-i2c@vger.kernel.org


--pji62g7rjmbidu3p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2017 at 11:57:56AM +0530, Kamlakant Patel wrote:
> The driver needs to handle the flag I2C_M_RECV_LEN during receive to
> support SMBus emulation.
>=20
> Update receive logic to handle the case where the length is received
> as the first byte of a transaction.
>=20
> Also update the code to handle I2C_CLIENT_PEC, which is set when the
> client sends a packet error checking code byte.
>=20
> Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
> Signed-off-by: Kamlakant Patel <kamlakant.patel@cavium.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to for-next, thanks!


--pji62g7rjmbidu3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnmfCwACgkQFA3kzBSg
KbaxFQ//dEcWBoeHHGmul7d8FMUrGlHDHJgNJ/+7aiFyArNw6s3/bKRWwJdIfkKc
5N8K1/sm7JZhIFRz6YKiF5DrzoECN1nE2JSYJLYD/WbEj2Wb6jjf6I3Bj0YO/wXt
pEDqUYnYANkcvUo1O5O52JyLa0ImXgXhDL8hjjV+a0LaxGmBQLwBoylnmozM2btH
er0+ZH20aITVoZaKu2So5efmjRIcWGK1Apondu7Skr+XxxrmNO6ycgu5DRWyH9hO
ddhfRpDjrflpQXIx4MXI02vPJTK3n6vmZ0GenlcAjcMJp3w1BVPzU3EE/gFU78ES
cgFTzW4O5Bmzkq1FOJwcyqyb1aP9E2XJnmL53QRdzujBf0k904CG9hhOyvDK2fkR
9GuBrnDNTaPwVsZOMMbMkXG586AfX3BdX7j3+noPpcbeZc445sisSOC7RgzQNbWC
HYvDXvutg6Cw8lGolIURHCoPoqDY58Y8Lf4m6U9kPYjcafWSyeqGVm+tOc9R6k5X
hH2pY5E0Dg7qsEUJ1fNRwx5JtrAtNop2k8oKYls1Lbw596nlAA6ISpF6XXL7ERXa
LkK4tBhKB4wOSkeupylFB2R8TTHj9AxgBomYSJADpRenjePeQAVWGm8EQKhz/ZEa
8P7RiUdDXFoX8287nN6c/J0jEU7R4ZZ9of5TmdeHBUmUF1piUh8=
=H/N5
-----END PGP SIGNATURE-----

--pji62g7rjmbidu3p--
