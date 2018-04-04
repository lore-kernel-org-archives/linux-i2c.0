From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 2/3] i2c: add support for Socionext SynQuacer I2C
 controller
Date: Wed, 4 Apr 2018 20:35:01 +0200
Message-ID: <20180404183501.objbi4egz4qdu6hs@ninjato>
References: <20180325110747.8852-1-ard.biesheuvel@linaro.org>
 <20180325110747.8852-3-ard.biesheuvel@linaro.org>
 <20180404183411.rrukznuwmtbwwyjd@ninjato>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7140379720709646456=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180404183411.rrukznuwmtbwwyjd@ninjato>
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


--===============7140379720709646456==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="buiogc4zymqs2qf7"
Content-Disposition: inline


--buiogc4zymqs2qf7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 04, 2018 at 08:34:11PM +0200, Wolfram Sang wrote:
> On Sun, Mar 25, 2018 at 12:07:46PM +0100, Ard Biesheuvel wrote:
> > This is a cleaned up version of the I2C controller driver for
> > the Fujitsu F_I2C IP, which was never supported upstream, and
> > has now been incorporated into the Socionext SynQuacer SoC.
> >=20
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>=20
> Removed two empty lines found by 'checkpatch --strict' and applied to
> for-next, thanks!

Again, this applies to v7 of this patchset...


--buiogc4zymqs2qf7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrFGtUACgkQFA3kzBSg
KbZk2Q//Q2AQJpSxcCOSJ9lVCst+xC8XMkUBE3RyD8eNZyC+8p5pOiclwMkYXoCL
c+4n4WtrtIQVm2AWmfNfP+TInvJBnuL5prFbXu6GfFjKODwfIpHBStT9DHW2zjvF
CokGOQxIi12Cfs4VxFqHurLRvMHmcN+5NZgzqSGkOkqOFBmgkBULUrRxNrU16Sdd
jGQoLGzHWAnNexC17TqwkFTpD2/7I8TGggeduwKL7uoYapxnAtczzJUW+KgJSWWl
343hOFKNkjv9T8ZsusR4uaGS2b8PVe8XNhe44xXAr7OcoGEI0V8XviCV4ToxxOL6
A5bixhP4ZA3kcYOu/ZaTmxKyzsYgcoSrhnhoVhhpYXEoaSIZ3YNLSr3UKC2PstGj
Ysvf+1i6oDJs3cZTdqBIOZo0RE3n3d2qAGJC56TCUudm7IHFhrg5r0su2/WwJBIz
UeiN6gKV7bRd2VdyJWhUtC+EZtpBtulJ/Q27uuiOxx1rrXyyPrrPL39cpDB1pbM7
vXyaXt0CBY6FiGZRns1wQcb6EQzQrOFkWGFCnJtwrby5yKV1xjCoBtImE6Kc6cMY
CxPduJkAeI/1MMepKbbuW/lNPjNewUdLvPNAajdSXQIzY+qd+Ste6oensFGuIth3
4xdMQIsq7GXCxdlE7HjY5jW5nwKaXFJTcdiyG3um/G0yBs2WdUU=
=x2vf
-----END PGP SIGNATURE-----

--buiogc4zymqs2qf7--


--===============7140379720709646456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7140379720709646456==--
