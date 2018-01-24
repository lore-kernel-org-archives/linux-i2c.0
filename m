From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [v2,2/5] i2c: meson: add configurable divider factors
Date: Wed, 24 Jan 2018 07:28:30 +0100
Message-ID: <20180124062830.vi52rtlgglryq3xz@ninjato>
References: <20171120145415.6581-3-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7wcuf7vtxhqk5s57"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:53952 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752262AbeAXG2c (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 24 Jan 2018 01:28:32 -0500
Content-Disposition: inline
In-Reply-To: <20171120145415.6581-3-yixun.lan@amlogic.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>, Jian Hu <jian.hu@amlogic.com>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--7wcuf7vtxhqk5s57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2017 at 10:54:12PM +0800, Yixun Lan wrote:
> From: Jian Hu <jian.hu@amlogic.com>
>=20
> This patch try to add support for I2C controller in Meson-AXG SoC,
> Due to the IP changes between I2C controller, we need to introduce
> a compatible data to make the divider factor configurable.
>=20
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Applied to for-next, thanks!

But I got two build warnings, please fix them with an incremental patch:

drivers/i2c/busses/i2c-meson.c:103: warning: No description found for param=
eter 'data'
drivers/i2c/busses/i2c-meson.c:103: warning: Excess struct member 'irq' des=
cription in 'meson_i2c'


--7wcuf7vtxhqk5s57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpoJ44ACgkQFA3kzBSg
KbYFyg//Z3MrMGgZzDZ5BFvOUFiMXZAfrZQTM4+hJlECvMtChjJ1lS+/z52YG9Xr
6LoER7/1zNNDfnsrEe3T3HQrIBvrkXcHlwJ68xG8pX/YwwomLdgXFwSmZ12tChso
pXuYKg3WKlyWoxQx6cYHhyP4M9RfNAqUDQIG8qn0Qhov4M2tU/ESD/oBR8bAZ7N7
qHyC4mKqUX7SKrZ1vlbSV9TWIcmXAA0YFaunMoWFGa52AVnzD2msGebXLqsQ/soM
Nq6Q9XAjrDsHJDJA+2vXibWjUdrzX700kz1wtzEtq9I/NqQTb+o8q758sq2HHCmp
mXOUolEelLSYSEedJ7NOyB9k93GkvR/dIjeH1T0aoTG4jhT1XSWwIIWE/1UvYfAj
C09VwfD1k+obEsqbnMdDt4zWJ3oFViDRbF6GqaohqcbJLcMCEYybb7cYe5/o7shZ
iBqVR9ZhVclYVrlmdYA2HgLq0F6hcCT46E542JsvyUONB09Qwf5ay55rq9xQiu2M
kT2wiPNx3RQIqzWHyGx8PryEvW73lwvhlGJDGEQMTKbcw7Xu7AhcytiXNaSE71B/
DVzCy96OmpCxoex8Oj63TYwB7fWI/fKOxiOUlDkTsu+v6J/Y+r7iZ64f0RgO/ufg
98MrqdhbxDccgHB54Cv8Rtuemmtd0LL4j/hyvC5OdM1f4qcLODI=
=PLdw
-----END PGP SIGNATURE-----

--7wcuf7vtxhqk5s57--
