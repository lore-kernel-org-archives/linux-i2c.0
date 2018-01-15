From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 0/6] i2c: send STOP after recovery; use it for i2c-rcar
Date: Tue, 16 Jan 2018 00:08:25 +0100
Message-ID: <20180115230825.wlfisucepjilqifw@ninjato>
References: <20180109135859.20771-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6ikwx66mlux3s2a3"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:42283 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750776AbeAOXI1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 15 Jan 2018 18:08:27 -0500
Content-Disposition: inline
In-Reply-To: <20180109135859.20771-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Phil Reid <preid@electromag.com.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>


--6ikwx66mlux3s2a3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2018 at 02:58:53PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> When implementing bus recovery for the i2c-rcar driver, two problems were
> encountered: 1) When reading the SDA bit, not the SDA status was returned=
 but
> the internal state of the "bus_is_busy" logic. 2) This logic needs a STOP=
 to
> consider the bus free again. SCL/SDA high is not enough, and there is no =
other
> way known to reset the internal logic otherwise.
>=20
> The obvious solution to just send STOP after recovery makes sense for the
> generic case, too, IMO. If we made a device release SDA again, and are ab=
out
> start a new transfer using START, then we should terminate the previous s=
tate
> properly with STOP. This may help with some devices and shouldn't create =
any
> drawback AFAICS.
>=20
> For this, we need to introduce a 'set_sda' callback to the recovery
> infrastructure. The first five patches may be interesting for anyone, so =
input
> is greatly appreciated. Also, testing the new features with GPIO based re=
covery
> would be awesome to have. Thanks to Phil for testing already!
>=20
> This was tested on a Renesas Lager board (r8a7790/R-Car H2). My test proc=
edure
> is documented here:
>=20
> https://elinux.org/Tests:I2C-bus-recovery
>=20
> A branch is available here:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/topic=
/rcar-i2c-recovery
>=20
> Please let me know what you think.
>=20
> Changes since V1:
>=20
> * add more identifiers in patch 2
> * don't use GPIOF_* flags but hardocded '0'
> * added Phil's Tested-by
>=20
>=20
>=20
> Wolfram Sang (6):
>   i2c: make kerneldoc about bus recovery more precise
>   i2c: add identifier in declarations for i2c_bus_recovery
>   i2c: add 'set_sda' to bus_recovery_info
>   i2c: ensure SDA is released in recovery if SDA is controllable
>   i2c: send STOP after successful bus recovery
>   i2c: rcar: implement bus recovery
>=20
>  drivers/i2c/busses/i2c-rcar.c | 54 +++++++++++++++++++++++++++++++++++++=
++++--
>  drivers/i2c/i2c-core-base.c   | 25 +++++++++++++++++++-
>  include/linux/i2c.h           | 26 ++++++++++++---------
>  3 files changed, 91 insertions(+), 14 deletions(-)

Applied to for-next, thanks!


--6ikwx66mlux3s2a3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpdNGkACgkQFA3kzBSg
KbZ5whAAkFA6eyFi1gc1hafSb3n9MWn40i7NdhGa/4vj2JTmUz8eFTdyYn+H6UJz
b+tg5OGoMVAhImy2PEtv1M03bj/3ZPzGoHB9a1i4tWgLNj026r5snmKQWsOcovjE
1xql5cDc1w8dXDF1KBV718pJ0vkVFJaT5V4Rm27u01pOBkTRiDdosxpz4B12vwoV
ov5pdfZEZkwDiHWn/Jf73rQ4LsQ2Bnx7mdzNZAfZTNEkq21ltNOKKjlg3hGh010H
iZnL0aAAvERE7XFoNuZn2MWOoP8G7Wnhr0NT2PKt/S5cU9dyuFVU4d36lBliXUYy
pRuDoD6lbtT//4JP/Lt3SH94uEiVukFzIl/psBJP7dr12rI2mLRtNd/GRo0yA5bu
g3E1k5w1RKDqtN6uAxIgKK8wlnCeuQM+1sUGbLdXSBxS4DPfv2QLY9FlmFfruYuz
L5n0XtlTdoYZazCNzlESeQQmo3TCEmbAm0ueV1PzdcfDKFk7nQoIC2TbejQsxt++
poGHGcaFK92V147IK142S/iqgO+LmwwxvqD/5q1PDSgrnsYLtX3lWk6/1EHy3RZn
u8Z/wqdjz7E4jMcgZfRpTcuxPsYGekjfxsqCTrhcdZ69IwuJGx4+1kfiqJLdsec/
oAq0yXAT/t6CtNuaRJ5Plz0Go87GgNfdZRoKsCXWm7Xsgd2gNz4=
=H46L
-----END PGP SIGNATURE-----

--6ikwx66mlux3s2a3--
