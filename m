From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: Clear client->irq in i2c_device_remove
Date: Wed, 31 Oct 2018 23:35:02 +0000
Message-ID: <20181031233502.GB8321@kunai>
References: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
 <20181019085958.32694-2-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181019085958.32694-2-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 19, 2018 at 09:59:58AM +0100, Charles Keepax wrote:
> The IRQ will be mapped in i2c_device_probe only if client->irq is zero and
> i2c_device_remove does not clear this. When rebinding an I2C device,
> whos IRQ provider has also been rebound this means that an IRQ mapping
> will never be created, causing the I2C device to fail to acquire its
> IRQ. Fix this issue by clearing client->irq in i2c_device_remove,
> forcing i2c_device_probe to lookup the mapping again.
>=20
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Applied to for-current, thanks!


--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvaPCYACgkQFA3kzBSg
KbagKA/9FcmeFpRbTCBZSnQ0ei127fILessOcNaMqJhi386/lKyF87/Wo7MbuYnw
5lbtxe16L40Mt0tvdbT/Q1K5FUJ6OerTGz3NwJeiQJhAkQxCbHdc+w9bByMbwyqi
18f4q/PgBqpiUsIwu5HzXJLfZyVdhX5/m1uvG+Gi+pwIRk7yx5bbuZpx5pIDUtN1
2Bi6+pmQhDMbHIGQTo3fw6MHax/FX0aQ70WJ64o/2g2Apa+IynbksZvjkdq5Cc8W
/GikRRPSN7Ngx0xJUyQ2YP1Ct/LX4de0uLre9eWqnATvZTrRk/puXQWvAm3ywz8X
JVNbwFdYFVxUCk12W4d/5uWw37R6Ah+diav8W7KsPzoNhCvmRFkSq5ROpyVXzlZ4
rhFsa5uoNqN6x5lUMpkfWFeNHaS3NPTWnCcLw8fb7ZBe0vyc5riWGb0Kr9hU86fC
UKHhgh1eEynn/WIOLNKQMADn4qjc9H9wQg2IqhXO8z/CIp8b6c2fT1QE3mnKH7VA
QWcX2jdYzEDIOK67sy4HlSMJ0gm+RXPdq9JLHN0nvrpoLDSbrqx75P0jbptOXUrE
rB6dPJV6/lMCAwCq6ZcHU5wkTQGoPmXrLq8Mu3VDMigac3DyRKNM10/81/QMcRO7
6xdGQX9BKDe7bJFDIgQ5+BPoewa2luHv7qpnlA2WZrk76CFFmwk=
=Aof/
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
