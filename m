From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 2/4] i2c: add support for Socionext SynQuacer I2C
 controller
Date: Wed, 4 Apr 2018 20:35:58 +0200
Message-ID: <20180404183558.2arfnwbocsigkwii@ninjato>
References: <20180403191151.14924-1-ard.biesheuvel@linaro.org>
 <20180403191151.14924-3-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5665654586069609421=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180403191151.14924-3-ard.biesheuvel@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: andy.shevchenko@gmail.com, jassisinghbrar@gmail.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============5665654586069609421==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qpwhkrle6q6f7czj"
Content-Disposition: inline


--qpwhkrle6q6f7czj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 09:11:49PM +0200, Ard Biesheuvel wrote:
> This is a cleaned up version of the I2C controller driver for
> the Fujitsu F_I2C IP, which was never supported upstream, and
> has now been incorporated into the Socionext SynQuacer SoC.
>=20
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Removed two empty lines found by 'checkpatch --strict' and applied to
for-next, thanks!


--qpwhkrle6q6f7czj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrFGw0ACgkQFA3kzBSg
Kba5lxAAhlce4zQ9teA+4t1jYqlOqKAkvrnRZcmdZC8zC+3ZSwIVMWwU3c7yQgQ2
5LBr1psLni0Yh9nLlcmw4E9U9E1GfytjT3YToESXPfOcyp3Zyi1UCSCiGCjx4cS9
lbdr/aKlMMqJV2i34wJjxwc6H9LfRhacnlxW/KWzzXFnPLlN6cb6/2CXwsA0nCK4
uVAbei5ad++YmVBGLlBioGPCYSX3IzTa36THYaUeXRidbFF+e+e3M1LU3qPFRRlz
9HgkrkvGLofkpFMztC9RPv0F1H1J+2zw8yu5ThGB5xvC4iEmrbZU06q3BSlPoGTW
mQTySWkyOrkSQ0ohG5KB9XknFHhMiKde+5pmtA9Dd6SPGAPVtdv4Iix0zSDfldwI
9387eWUvB1IX2QlVxj5Q2Hrzf75zVjJIFk1wIKzxqr6wRPrG2Jkut2UpSv1Yzc9k
LDloO0p/JKGoK6KQ4qVbn8ck6qXtlWhvE1MQMmH4EWcssyqxolyNMmA1uExDTWU/
ouwvAgcTs3T3TTG0JXfv5eAjA8tLJ9FkTgU9czG7ijdF3+zCixNj5WBAVDmmUvsD
lBvyNAX4XmU3yC5R5AaMpKv4OshK/oQ2U6P3Gzhh5L6URqdyuWd/vgW1TnUjPqaq
RJAc7WmzMzN3eC+EwveYj2sULA/HpMGzCx4ocd3BXIJMzf6Dn+o=
=x3pU
-----END PGP SIGNATURE-----

--qpwhkrle6q6f7czj--


--===============5665654586069609421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5665654586069609421==--
