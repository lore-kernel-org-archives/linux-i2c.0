From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 3/4] i2c: add param sanity check to i2c_transfer()
Date: Wed, 4 Apr 2018 20:38:23 +0200
Message-ID: <20180404183823.ejewg6ran5li2vt5@ninjato>
References: <20180403191151.14924-1-ard.biesheuvel@linaro.org>
 <20180403191151.14924-4-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6411490724304243865=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180403191151.14924-4-ard.biesheuvel@linaro.org>
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


--===============6411490724304243865==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pufwapz7u3rjr266"
Content-Disposition: inline


--pufwapz7u3rjr266
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 09:11:50PM +0200, Ard Biesheuvel wrote:
> The API docs describe i2c_transfer() as taking a pointer to an array
> of i2c_msg containing at least 1 entry, but leaves it to the individual
> drivers to sanity check the msgs and num parameters. Let's do this in
> core code instead.
>=20
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Looks good but I want to test it myself, so I will include it in my
second pull request later.


--pufwapz7u3rjr266
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrFG58ACgkQFA3kzBSg
Kbaf8w//TDMgGV9BsbskxVheLOG/pVkazlsfvKwXJTPzI3Sl32R7oE5VOG00bPWg
SgAFnpC7kfK7aZc5lBG5AELpCcHB+TV5bzE0Ka6KcCxm6pLev2KOZ9OS1a11jv29
LU35pzHs1BqrGdmDfyDhHk2+QtzsZvcxIrWGe8it/c59xyYZfkyeWHN2SUBxwdhF
VyI1CFqxfxIrlR9zh4qf5Zh9SsfXboEp1239nL+Ow1Qd9nrmNeNynByVXupG5YBt
p54R+aP2zJLpITuLpAA3zQi2cyHvlMtwkV8wwr6DhrQDihRgRnyxjs/VWpJhNc0K
srRNzDifthZDEU/pFrfi59smpVqBxfVv5CysYwqZ5IqfyZA1N+NGEKeFxNRiy4ml
VMv8qxyYVnhkaN988HhVbEZ4x/Rf6Hv0/2HdazEXJiNEljd0jUreWtANvFE+LhSr
MwJTSIg+AJGbJiQQy8e6p5ZSCelTJ7UV/8GHgwFN+nnjzghYFbnLjah0CQ17I707
VzUXxv0YtShUCCZ5nIInomeL//L1NuDFTk7sVaQ1a9VIm9U1XjjRaDjPr1dwwRo1
W57PBo974UK0lGhq0pCPPNcPENIACeuMTsT9Ew3wmEK7lKL2iN5Bz1/88IAjGpBV
X4p9JK/IJ1/nnapxWpdiu3PZDztukyhH0D4zkK8lHYlshBQWW5U=
=R/4Y
-----END PGP SIGNATURE-----

--pufwapz7u3rjr266--


--===============6411490724304243865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6411490724304243865==--
