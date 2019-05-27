From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: Allow selecting BCM2835 I2C controllers on
 ARCH_BRCMSTB
Date: Mon, 27 May 2019 21:21:56 +0200
Message-ID: <20190527192156.GF8808@kunai>
References: <20190509210438.28223-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dWYAkE0V1FpFQHQ3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190509210438.28223-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Kamal Dasu <kdasu.kdev@gmail.com>, Jean Delvare <jdelvare@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Eddie James <eajames@linux.vnet.ibm.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Ajay Gupta <ajayg@nvidia.com>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Juergen Fitschen <jfi@ssv-embedded.de>, Elie Morisse <syniurge@gmail.com>, "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--dWYAkE0V1FpFQHQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2019 at 02:04:36PM -0700, Florian Fainelli wrote:
> From: Kamal Dasu <kdasu.kdev@gmail.com>
>=20
> ARCH_BRCMSTB platforms have the BCM2835 I2C controllers, allow
> selecting the i2c-bcm2835 driver on such platforms.
>=20
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to for-next, thanks!


--dWYAkE0V1FpFQHQ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlzsONQACgkQFA3kzBSg
KbYiRQ//Rt13LD4OiH6Oi2ARvnFvTNUEFodH7gJfdfIQqEGg6uTRfRJMdh9pPFgN
SbhXmxB0Jy9J65kG06L1OZoPmsykZOvlxdcdXU8/OOUALe7Uz/P9UW4stPAb+PE6
Qpa7i50R/Sl8xaDxNFXw2pjHdOU/dO4zFkw+pGaGXB8YxxtiVp2ZBebBD3dtsgGv
PEDxTmcFwC2xv7eLBVXE+rEbpAu8QB5EwijobxMUdGjl7x0z3T0Adb2HRY0FviQH
TxX06BfENtqiZAiLKSLsGj4jxdb1YrrCVeleBZMu0nFpgrZmemVMrysfSPbm9EAB
GHcAG6QYx82EDuosRui3BcJ7ZKu5tDp9nlv04p8MCikem5PG0oNQYHSrt46ghvVb
ahSaT3qMC7VuzkRrJapraLKtjVaMfM4b8B/zyLOV1B9ZTMhO82o9R+XEUWRO0rXl
TpTF/Lk0hwj0ZtgQMB+uL2SqdwaxjRm/ZBbRyEalURESBJ28DjuBBd70S7Na5107
pDqZvCyC0dv3y8g/t1QL5Z5BAh+GvqtbXBLJJsSWftJl3/MscpeZiRk8xEENjPX5
rzeDtYUHab+XxCwG/rEiJXQNt3B7S5lAzQPASpzhootAjFxKy+qlroORnZ1tmy1S
fnzI/jTN4KIGJSWSV4RjW2dFeo+L4q2g5bglwqDJ6e+fI6DHils=
=wyGP
-----END PGP SIGNATURE-----

--dWYAkE0V1FpFQHQ3--
