From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: brcmstb: Allow enabling the driver on DSL SoCs
Date: Fri, 5 Oct 2018 14:07:27 +0200
Message-ID: <20181005120727.GE5433@kunai>
References: <20181001174349.26357-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181001174349.26357-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org, kdasu.kdev@gmail.com, geert@linux-m68k.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jean Delvare <jdelvare@suse.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Eddie James <eajames@linux.vnet.ibm.com>, James Hogan <jhogan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 01, 2018 at 10:43:47AM -0700, Florian Fainelli wrote:
> ARCH_BCM_63XX which is used by ARM-based DSL SoCs from Broadcom uses the
> same controller, make it possible to select the STB driver and update
> the Kconfig and help text a bit.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes in v2:
>=20
> - Make COMPILE_TEST last, as per Geert's recommendation
>=20

Applied to for-next, thanks!


--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu3U/8ACgkQFA3kzBSg
KbZ0zQ/+Nmy/sNNBB7LHM+I2AXJm/oTn5aK+VufxVzt9sGI5BRlZItsx3AmKVNeN
xyM5+WypJpBBAob5A354R8Kfy0up4RK4qJMXj6l5cHbNxOG4Ofp5crdsbn08FMkx
ldLrDn3ArzPq57y+OlegOfiue0BNEckSkKlVLV7o5Rn7uvRcEAocOcS0pDahvc+l
PzpufO8OQPGRQbJ2V4jLMj/bS+mxhj5pXVjybJm54LKedsGnZKUEGeHDyxvhOBRo
m8D7BTBgzzcfu3cgZbFfg5nkRjXZ/PaXAll38dkHpJQSN2b1OrBoDvddqI8rqtli
A5XtwzCfNZVN6nGF4XnwndGgGQe7pg1EuCEl3JnE+B/aQPMsqbSNzjZox3moKmw4
oD1PLLpCt+cF9nfZ3ipIwQ3VL8V2u5RQUOpOVhzwVN2qzlgA/WJ6IxurJ9ksVrB6
j55DN2/4KMADCUzK2xnJA1JVUWdhWnyiluScEWEenLrucs0Ychx4WUj/2hz5m+bT
rF04/Xpiqy893XJq7gE/TET3T1xExayKVwCJpHLYKKzTK5lBNa9TjDp9S9ogTnOn
O/Ik/OT8i++K7rEGbf667+p96YAJqv7tzK/QRboTkADmqdSwUF5RzX2ytVf41JuG
6aswlSAYZnwXM1E/KM6Sm4LPrvZWt1MkbBQDbfNzqEg/OySyPgE=
=5a90
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--
