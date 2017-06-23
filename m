From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v11 3/4] i2c: aspeed: added driver for Aspeed I2C
Date: Fri, 23 Jun 2017 20:43:05 +0200
Message-ID: <20170623184305.xqqhjgrbdmgk6lsr@ninjato>
References: <20170620211516.13095-1-brendanhiggins@google.com>
 <20170620211516.13095-4-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cllrszhierrtvfet"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41183 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754327AbdFWSnH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 23 Jun 2017 14:43:07 -0400
Content-Disposition: inline
In-Reply-To: <20170620211516.13095-4-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, gregkh@linuxfoundation.org, davem@davemloft.net, mchehab@kernel.org, joel@jms.id.au, martin.petersen@oracle.com, benh@kernel.crashing.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org


--cllrszhierrtvfet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2017 at 02:15:15PM -0700, Brendan Higgins wrote:
> Added initial master support for Aspeed I2C controller. Supports
> fourteen busses present in AST24XX and AST25XX BMC SoCs by Aspeed.
>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Applied to for-next, thanks for all the hard work!

One question however which can be solved incrementally if needed:

> +	if (command & ASPEED_I2CD_SDA_LINE_STS) {
> +		/* Bus is idle: no recovery needed. */
> +		if (command & ASPEED_I2CD_SCL_LINE_STS)
> +			goto out;
> +		dev_dbg(bus->dev, "SCL hung (state %x), attempting recovery\n",
> +			command);
> +
> +		reinit_completion(&bus->cmd_complete);
> +		writel(ASPEED_I2CD_M_STOP_CMD, bus->base + ASPEED_I2C_CMD_REG);

If SCL is stuck low, how do you want to send a STOP?


--cllrszhierrtvfet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllNYTkACgkQFA3kzBSg
KbZVhw/9Go56ft5oIvkP1bjK2kctgGDt2F5/nDU1eUYYAAv7InrJf5bkeYmOiO/L
jzbuPboz7QiyuBeRB+ojVSiSYG0o3Bq4WBWOT796CU3D7wsoDG+P4kzGtZlzUxeU
7CJtRk1XFzHs87X0NXUxmH2GK+ARD8iDvKtTLicxPYAOC+zAcPnZ+THkYYAJMhte
ubG0x3Zb+KLqf+2YvFkwNDhcfaS04GXLAOnd7YhQt9a4ziggcqpjO1hc7JM8qQWm
zZbI73pnvCOs78gS22AZigAvB2pZN043i0IgJFsFzqicunZo86C+gCJCWVBc4acv
DxIsxiESy0YOe3HFyPnKR3sFX8jWP1OUteV5RUcWdNRikDSSWQjdGdx/mClPym49
ALWoV5/4PGBzsf46d/OVj4gmcDhFUAnwC9pz5SnEGBChyc+2F7SmS+OmV7YgCuL0
xBPEXJdnT5PllHwwFtqsOuyB1DnBVpITW76VSELlhuCbl/rpfTXvh7gtvAzZdx9h
ofnQpM8Dh4wjuwKUp7wVoLAS2jdPQG/BmNgX+gx3+nWe9otG6GupBhKme9szkfua
KIBivSIyfbUmHJwLcEsIiRBW+81ErCpy6uRkxmqFTLO+T1NId3p+Vn5qEkJQH2DK
OebTbw85hbUb5aZKN6PKyc0mj/9HzgC4H12WSU88PLOQf6VdEXQ=
=Qt77
-----END PGP SIGNATURE-----

--cllrszhierrtvfet--
