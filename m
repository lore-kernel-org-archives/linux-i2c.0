From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND, 2/4] i2c: mpc: unify obtaining the MPC8533/44 I2C clock
 prescaler w/ MPC8xxx
Date: Sat, 30 Dec 2017 19:19:20 +0100
Message-ID: <20171230181920.4fmxcrvvcdf72u3q@ninjato>
References: <20171207102003.23496-3-asolokha@kb.kras.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="td4tbvkqzm275edf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171207102003.23496-3-asolokha@kb.kras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Arseny Solokha <asolokha@kb.kras.ru>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Valentin Longchamp <valentin.longchamp@keymile.com>
List-Id: linux-i2c@vger.kernel.org


--td4tbvkqzm275edf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2017 at 05:20:01PM +0700, Arseny Solokha wrote:
> Commit 8ce795cb0c6b ("i2c: mpc: assign the correct prescaler from SVR")
> introduced the common helper function for obtaining the actual clock
> prescaler value for MPC85xx. However, getting the prescaler for MPC8544
> which depends on the SEC frequency ratio on this platform, has been always
> performed separately based on the corresponding Device Tree configuration.
>=20
> Move special handling of MPC8544 into that common helper. Make it depende=
nt
> on the SoC version and not on Device Tree compatible node, as is the case
> with all other SoCs. Handle MPC8533 the same way which is similar
> to MPC8544 in this regard, according to AN2919 "Determining the I2C
> Frequency Divider Ratio for SCL".
>=20
> Signed-off-by: Arseny Solokha <asolokha@kb.kras.ru>

Looks good to me, but I have comments to patches 3+4.


--td4tbvkqzm275edf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpH2KgACgkQFA3kzBSg
KbY5pg/+IFeetPFqQ9pQr7KLHAuEjvfNlYWgkhbv9c20xw687lamOkYmsadWqQie
piR2rzkQsTJ5N4Ut+w5+PJ6QJhzKL+yHwCyVgLXIhGlzg6FfqNuhP7bRCtoI+w91
DUHJM+TtAl1VlFvBecih/Be/4HpME3RckkTatJMk3Lvku+OOIHxvXZPurwtgeX+/
O7aBwHHHCRoY7J/Qk9xnANCVY2aY+pSBFTvDvq2eEwaH2vg6EhpY3+/SOaY/lC85
9JTXunLeI+2OVjus4ozwmJQzA8IQcbAWHmfDHuzKbPLw51aYQ4w5fiHOlJdHQgBV
nRzTEYZAu/s8Ld7I/kvyy465AMIp8wfR7uYVQ76iC1gKyepQcwk+y1MSVqIr6WjZ
YBcOKn8oNtzEUsDkcK+tK2BKWT0ZOmu3twsN1uaLT+/ay7tvMQ2tJ+ildAOvihSF
z26mRH5gbM5z4huTBGxHYEhHO2nGXNEUrEurhFouKyKkw4hJIaN6rMke0lJPZomh
q28GU/CPYHe0VMYASDJb5ZDwRSDMrSOuolp9odOxQ/UZH6DQQOGkMrm+vEZOYmry
EHtcTGOk6e3GOQjmscorTzfXPvn/WC9WCwRctBsTK5JI9WDdiZlBbRZbeRSCytSI
EpfLPhWxQJLH4A2Gq3ULeLMWS9FzrwF5edJMUrFscH4AZ86Nlks=
=n1h2
-----END PGP SIGNATURE-----

--td4tbvkqzm275edf--
