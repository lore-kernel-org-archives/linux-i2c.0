From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/2] i2c: bcm2835: Ensure clock exists when probing
Date: Wed, 26 Jun 2019 15:16:14 +0200
Message-ID: <20190626131614.GE801@ninjato>
References: <20190621105250.19858-1-nh6z@nh6z.net>
 <20190621105250.19858-3-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6428329988702250439=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190621105250.19858-3-nh6z@nh6z.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Annaliese McDermond <nh6z@nh6z.net>
Cc: f.fainelli@gmail.com, wahrenst@gmx.net, swarren@wwwdotorg.org, team@nwdigitalradio.com, eric@anholt.net, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============6428329988702250439==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u5E4XgoOPWr4PD9E"
Content-Disposition: inline


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2019 at 03:52:50AM -0700, Annaliese McDermond wrote:
> Probe function fails to recognize that upstream clock actually
> doesn't yet exist because clock driver has not been initialized.
> Actually try to go get the clock and test for its existence
> before trying to set up a downstream clock based upon it.
>=20
> This fixes a bug that causes the i2c driver not to work with
> monolithic kernels.
>=20
> Fixes: bebff81fb8b9 ("i2c: bcm2835: Model Divider in CCF")
>=20
> Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>

Applied to for-next, thanks!


--u5E4XgoOPWr4PD9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0TcB4ACgkQFA3kzBSg
Kbawow/+L5IabPpZdV/oJsEGm8QSPCLXmlOdMKHNRBtYDRf4pxOjuje2rxjnrj1U
yXvs48L/D9SgYjG3rBSjtIWe9QqcMF3pucXwos3JaJIG4SV7JPGqi0XH1U580qlM
wN0vbAaYxdAKadYMign2e/MBlcfmdi6qH79a7vez6WkfwhEt58zYc5HbKFWh4ULA
1TrzRlPJvz215mBzmw7fZzOi9wWRSwClt2/F7YUcWEpFvWZ+TZqq5pWRS2MGK8dH
mnpJyWlyR2hfmfxLzswdnaLEEa8H2tbMG+o6YZLhXAxN8jjC5evQi/aCFOyUyE+w
YIXNi00XY3KOJ0+wVCbqdfhYlC2q0lwuXe9lqUjmIDVeqtsahejEFdRtSO8qNTeV
LtQLpCnDBR15Ii/s++E7vSn1ANR20yQYcTjA4jVTUZmgNTsMfM+51+RiYQhqpn6e
9txSMKvhfjGTtzSo4Oqa+wTOaRWjc+5heksEqvtjrqE2VuRG8LOse8AzBER0ZHH4
YeZKR9PsZAdK+fup6m+21z5yNKHAb7PV3uuBz/7NxQocAFH9cHbDpfyM7B7oyIsI
YytbGb6IrJ35qVQahz1DW3EH/QVnWBIoBLSRCFWVJ8uHyzNK+U4zAdZB31fZCdZ+
ODi1HFSV084OxfDdd/T376QuJuvad2PFrf8xw3bHlYmA0JTrL84=
=nE+J
-----END PGP SIGNATURE-----

--u5E4XgoOPWr4PD9E--


--===============6428329988702250439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6428329988702250439==--
