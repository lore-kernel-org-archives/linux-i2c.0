From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: imx: defer probing on dma channel request
Date: Tue, 15 Jan 2019 22:55:50 +0100
Message-ID: <20190115215549.sepj7rmpqmtlxwbw@ninjato>
References: <20190115140332.30417-1-laurentiu.tudor@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4k6sn2i42q7o326p"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190115140332.30417-1-laurentiu.tudor@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: linux-i2c@vger.kernel.org, linux-imx@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabio.estevam@nxp.com, leoyang.li@nxp.com
List-Id: linux-i2c@vger.kernel.org


--4k6sn2i42q7o326p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 15, 2019 at 04:03:32PM +0200, Laurentiu Tudor wrote:
> If the dma controller is not yet probed, defer i2c probe.
> The error path in probe was slightly modified (no functional change)
> to avoid triggering this WARN_ON():
> "cg-pll0-div1 already disabled
> WARNING: CPU: 1 PID: 1 at drivers/clk/clk.c:828 clk_core_disable+0xa8/0xb=
0"
>=20
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

I just applied this series to i2c/for-next:

http://patchwork.ozlabs.org/project/linux-i2c/list/?series=3D85099&state=3D*

I haven't checked carefully but maybe it fixes/changes your issue? If
not, your patch most likely will need a rebase on top of the above.

Thanks,

   Wolfram


--4k6sn2i42q7o326p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlw+VuUACgkQFA3kzBSg
KbY/xA//dY9GghhTgU9Ej+l+O1rAOHeUxYTJCWoZ4iUqpPdikDeUeTfMtNAxkpq1
G5XDZqktjN2SuWGbkGZmc2RJ5V5nNq7sMkwr0JxJwF82ViieNiorQB9ZMfor49x2
HZoiCsDVSUU91AbjGdbabffzYgFjylqTS3u1xUPae+MCWfcfOoNLpqfcxNo+qwqg
OQ7SaHwdWSDnkJv+aHXPZzg7O7IdWlDP9+TWRCOVfIWxfv96iZVFXEg7utuztuwj
nSuWRv0lNliAiA8OfcO59791J9aqSrHbD5it15KftdFZBMef/+JD9nLFlTPQnRXo
9KsZ1SNHo2otE6rWwoRID3fmTu7baccvmoCpllR3gn5ARSKeqqp2uf4zdSC5nkwD
d4b3AOppV9ZrPgiG9gzTH/zHFFcKGvkQZuW31Jg24/Dy0gcVyCEEhgR6b4Fc6vYR
qM7Vf+UdewNvdPOyYAAeK0h/xPdzLqyP9TJpQiumypH2eK8JGWmiMwjkfGp3bLUj
7vOfXcvRxLbp4LWXvvcEgwPddBfMTmLeNHGNCmppUUTFH9KsBG6okkskjFGw89kT
1HlwB3XsubRf/onryTWZ0CtZByn7Y+LWje/Pnh4RigSXc4Le/4tW5e/3xHrv3R6C
cHnUg216K+XEtPl9JfCwxjGoPvUPcWox7SJ6NvK4Pb1Nn46CEeU=
=xrXd
-----END PGP SIGNATURE-----

--4k6sn2i42q7o326p--
