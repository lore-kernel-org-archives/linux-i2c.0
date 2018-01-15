From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH 0/7] i2c: sh_mobile: support per-SoC frequency
 calculation
Date: Mon, 15 Jan 2018 18:02:48 +0100
Message-ID: <20180115170248.lwxc6wy7ktrlc3xf@ninjato>
References: <20171218215802.28591-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qnregg4s6khibxxt"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171218215802.28591-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-i2c@vger.kernel.org


--qnregg4s6khibxxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2017 at 10:57:55PM +0100, Wolfram Sang wrote:
> The current calculation for I2C bus speeds does not match the datasheet a=
nd is,
> in deed, a little too fast for 100kHz settings (~107kHz have been measure=
d).
>=20
> This series implements a second calculation according to the datasheet. In
> order to not cause regressions on the various old SoCs, using this new fo=
rmula
> is opt-in per SoC. Once the new formula has been verified to work, we can
> switch over. By default, the old behaviour is retained.
>=20
> So, the first patches are refactoring the driver to support per-SoC frequ=
ency
> calculations. This is done by making the already existing per-SoC
> setup()-callback mandatory and let the frequency calculation be done in t=
here.
>=20
> This series has been tested on a R-Car H2 Lager board (r8a7790). The comp=
uted
> values match the suggested values in the datasheet. Also, measurements sh=
owed
> that the bus frequency is now 100kHz. For 400 kHz, the overall bus speed =
did
> not change much, but the low-to-high relationship is now matching the
> datasheet, too.
>=20
> This series is RFC because I think we need to discuss when to enable a So=
C to
> the new formula. For Lager, I did some basic checking but did not run a f=
ull
> V4L testsuite or other complex configurations making use of I2C clients. =
Gen3,
> in theory, should be easier to test because only the PMIC and an EEPROM a=
re
> connected to IIC_DVFS. However, there are no testpoints available for mea=
suring
> on Salvator-X(S). And the suggested values in the datasheet do not match =
the
> module clock we have. Do ULCB boards maybe have testpoints for IIC_DVFS? =
For
> Lager, it could be argued that the resulting speed is slower than before =
which
> should not introduce regressions. But I am open to discussion here.
>=20
> A branch can be found here:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/iic-r=
efactor
>=20
> Thanks, and looking forward to comments
>=20
>    Wolfram
>=20
>=20
> Wolfram Sang (7):
>   i2c: sh_mobile: move type detection upwards
>   i2c: sh_mobile: allow setup callback to return errno
>   i2c: sh_mobile: require setup callback
>   i2c: sh_mobile: let RuntimePM do the clock handling
>   i2c: sh_mobile: add helper to check frequency calculations
>   i2c: sh_mobile: add new frequency calculation for later SoC
>   i2c: sh_mobile: let r8a7790 (R-Car H2) use the new formula
>=20

Fixed a spelling mistake in the patch description of patch 5 and applied
to for-next.


--qnregg4s6khibxxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpc3rQACgkQFA3kzBSg
KbaZJQ/+KjxMJYkXM16hqiKWyISDgvh+phRnEdwQ+2rqeFufffz6Fo9bMbUq+dap
WDbwHgolgh2GJ+eoYz4YSxav1Gjw9hYLKRrOrHpXXY/97aHcjoAgzVhejreDR4Qn
kH3r4QPVnLplv1orJ/9UDAhjjErR8P+1pzJFNMXgbl+ZF350K6hJFQQFCJYphQe8
69sL0qfgSp2+DoqiC5roWSPqj8wu/Kc9I2Xea1VZFoC6zTbqul1btf2TzaJHi0aO
WHRNdw/31sUVFtjblTFE8yL5TBK2HQxqJHeQ3fRFiyJa4xOvklpsc3P+ALFwPdaA
OoYWZB1LxGcKVXTgTlLE2qd+mYxDowZZJcY3N2+zpSHDZQgeDCZ20EnmgC+rF7iJ
jgp2Kh9uOf9D1WXgkgJBfNPY24dPD5nobPUp4zhBhC05qDVYoheZfP3sHNaZ+CL5
VNuXXjlY0xx0a4gIchpdO/s2LLsfCsNRatlh1U1n/jpzi/TadR+HSlEpgPsdIS+G
3cADbUS3FbbLO4F/WW+2iEJI68D/Mx8p1aysdSX0OxSsgC2T9naTAJPwdY7gNCAU
ZEoif7z6IVykVOGvl60jqKlRXvE6Nhn/HpNzc5PAHpdznYBLFsKzF+P6wz8c4Q3r
6AtHrUCTmvks8gxl2uQR/nNHXTv/atJXkZFajhV9q/RsvQiLCS4=
=3+n5
-----END PGP SIGNATURE-----

--qnregg4s6khibxxt--
