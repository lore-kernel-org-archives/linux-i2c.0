From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [v5+1,repost] i2c: mux: mellanox: add driver
Date: Thu, 17 Nov 2016 23:20:35 +0100
Message-ID: <20161117222035.GA13783@katana>
References: <1478813183-134553-1-git-send-email-vadimp@mellanox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:47840 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752017AbcKQWUi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 17 Nov 2016 17:20:38 -0500
Content-Disposition: inline
In-Reply-To: <1478813183-134553-1-git-send-email-vadimp@mellanox.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: vadimp@mellanox.com
Cc: wsa@the-dreams.de, peda@axentia.se, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@resnulli.us, Michael Shych <michaelsh@mellanox.com>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 10, 2016 at 09:26:23PM +0000, vadimp@mellanox.com wrote:
> From: Vadim Pasternak <vadimp@mellanox.com>
>=20
> This driver allows I2C routing controlled through CPLD select registers on
> a wide range of Mellanox systems (CPLD Lattice device).
> MUX selection is provided by digital and analog HW. Analog part is not
> under SW control.
> Digital part is under CPLD control (channel selection/de-selection).
>=20
> Connectivity schema.
> .---.             .-------------.
> | l |             |             |-- i2cx1 -- i2cx8
> | i |-- i2cn --+--| mlxcpld mux |
> | n |          |  |             |-- i2cy1 -- i2cy8
> | u |          |  '-------------'
> | x |          |         |
> '---'          '---------'
>=20
> i2c-mux-mlxpcld does not necessarily require i2c-mlxcpld. It can be used
> along with another bus driver, and still control i2c routing through CPLD
> mux selection, in case the system is equipped with CPLD capable of mux
> selection control.
>=20
> The Kconfig currently controlling compilation of this code is:
> drivers/i2c/muxes/Kconfig:config I2C_MUX_MLXCPLD
>=20
> Signed-off-by: Michael Shych <michaelsh@mellanox.com>
> Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> Reviewed-by: Jiri Pirko <jiri@mellanox.com>
> Acked-by: Peter Rosin <peda@axentia.se>

Applied to for-next, thanks!


--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYLi0zAAoJEBQN5MwUoCm2Op0QAITDwfbAr7QL3ElIKIdSaO8g
958qmWnRSPZF4oOTv+FeT/DVsu5zCxfm07ZJn3LiG9YvhuwrHdeOTHsrUVYy+YdP
wbY+5eXUQYQa6jnZk4YFAcEhr6zC+bHus7PO3J3FoIdOvp4xe5494dxqM+OVOcDa
wtMEzDp7cMARjDYIbWESzwZMsziheructMUHLVFAfL+tD3wydHmoIQutIn8dpReF
CBpy+bMsrQidieJiFpeb8ZS7erNizMBifW9QcFXityZkOYubRTbYJEjkDz/Xh+vd
JF5PJtS6E3CMFTicUXM8CLTczPRsbYKeS41pT7oScdcfIUJUDNb0h2styPXZZvDg
Ivmsvi3OsHE0g+QntZScRREWbPJIKCgi+Oq0y3Um4Ej+xL+a1lidE+sc/RdivxLE
mTdlYfU7My4OR4P4MmUL151esQNTMY3aH1NmNCLmH6PyBbSJSYXcoTfm3/j/wgx/
BCBCXP92NJAC42t7rTbapc3Foau+1leFzTJPSSsWzsHEYlOzUCgTfCKU3MzoSxGG
ebDN+G+ddPTR4FhHqwxIVLiHJW/4F/vX0pnnfi5f0GGnJ6avR/fznYFkWvnOmOFA
AiZA5+CwNk9a0gUeBa03vkWX8DZ9cLvpKEyxpydWNkS0vWWvwY4bCLIJkjluxiw7
AZIKx3ET4ZDGa2z63lrz
=38oD
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
