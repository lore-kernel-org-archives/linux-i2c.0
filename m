From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: imx: add slave support. v2
Date: Thu, 3 Mar 2016 22:35:10 +0100
Message-ID: <20160303213509.GF1501@katana>
References: <1453824880-4844-1-git-send-email-dbaranov@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iBwuxWUsK/REspAd"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46101 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754573AbcCCVfO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 3 Mar 2016 16:35:14 -0500
Content-Disposition: inline
In-Reply-To: <1453824880-4844-1-git-send-email-dbaranov@dev.rtsoft.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Dmitriy Baranov <dbaranov@dev.rtsoft.ru>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Maxim Syrchin <syrchin@dev.rtsoft.ru>


--iBwuxWUsK/REspAd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 26, 2016 at 07:14:40PM +0300, Dmitriy Baranov wrote:
> Add I2C slave provider using the generic slave interface.
> It also supports master transactions when the slave in the idle mode.
>=20
> Issues:
> Changes work only in PIO mode (when driver doesn`t use DMA)

This is fine with me. We don't support block transfers currently in the
slave core anyhow.

> There are might be race conditions.

Can you name them

> +enum imx_i2c_slave_state {
> +	I2C_IMX_SLAVE_IDLE,
> +	I2C_IMX_SLAVE_IRQ,
> +	I2C_IMX_SLAVE_POLLING

Highlevel question first: Why do you have polling? Why would anyone not
want to use interrupts here?

--iBwuxWUsK/REspAd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW2K4NAAoJEBQN5MwUoCm25RgQAJ+Cm/jssZg7bHOXzlx37Fo4
MFWNxH3PboBkvzWxlebuqrS0vckSYGO/uvBXuF3w3hd39txodgeEBqcfucOMT3Ge
DxRCAvtLWXm/5EgUYn+3Z1xMs9JdhBZ69zV34nklTZAdwHKPe58goM9zJCRFhSFg
FE4MS917zr9VEX8xJEx6XMf2KhddHTeiwxeZLM+0yXOu7GUao0tBIZLtn+fKA+0J
SOSAbPKQG60cIgNvaLlsFNweGz/84X6PL7SnqNVPIEn5Pqi7MyT39JB6hgYIYeLP
HDidajpx+tzObDX1CJA49Q97OomaEhiJGACX+q4YI3OOyr+0bIfKQn7xXlMXhCYu
Oktf9AQhljBVos5LhbBpU0OpbuPejurT8kVOJovcPanflw4TF7Gr0SDl5FEoBuhG
1aTWBqhRxZxmcMv/H7KQ/WHc5nz/tgMfkGmX6pDBCk/dar7fhsaclA5YCQAKiWrl
Fl/zSXtg0Fobc5lrx3votcQeTlo1ZyOo6sss32OoHCqOE8+XQY6bnD0pzz1ZUrYJ
Z8yw3ZmDWMqLPEhewEaIJ01O/g7LIChosQogX32J3PGXFuOa+4pvwclDx1RElES4
cukMBQdX2S65hg+OV5zseFSMy8IwH5z+253ERIy/+uTV9WNW/3YpIn8wFnnjP7Q2
DJjWOaIM8mHaPSBpTmss
=G14s
-----END PGP SIGNATURE-----

--iBwuxWUsK/REspAd--
