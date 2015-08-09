From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 13/22] i2c: core: Probe i2c master devices on demand
Date: Sun, 9 Aug 2015 14:34:30 +0200
Message-ID: <20150809123430.GB1521@katana>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438089593-7696-14-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438089593-7696-14-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2015 at 03:19:44PM +0200, Tomeu Vizoso wrote:
> When looking up an i2c master through its firmware node, probe it if it
> hasn't already.
>=20
> The goal is to reduce deferred probes to a minimum, as it makes it very
> cumbersome to find out why a device failed to probe, and can introduce
> very big delays in when a critical device is probed.
>=20
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

What is the status of this series? The boot time reduction sounds great.

> ---
>=20
> Changes in v2: None
>=20
>  drivers/i2c/i2c-core.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index e6d4935161e4..5520b413e3db 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1353,6 +1353,8 @@ struct i2c_adapter *of_find_i2c_adapter_by_node(str=
uct device_node *node)
>  {
>  	struct device *dev;
> =20
> +	fwnode_ensure_device(&node->fwnode);

TBH, the function name doesn't tell me a lot. It ensures what?

> +
>  	dev =3D bus_find_device(&i2c_bus_type, NULL, node,
>  					 of_dev_node_match);
>  	if (!dev)
> --=20
> 2.4.3
>=20

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVx0jWAAoJEBQN5MwUoCm2dfkP/RwJheGHqSbnXM3/QEfsOCtE
1joUxJcgVOSniFqAcvKMNRuxnWDqOAiuU+ts7Fa1BQ/UGLGM9hYVUUKjBqAZaDRH
Z4gQddCu87WLzHShwbNKCa3p4grVn0XYIeIzE+j0pPSdONcISdb8Mp6fJUA8AvX4
7sl8D5ayZgRezYwpAHpkv6yFxrCfzS8iX91g5JjX0tykIUDLWnhJvcmpLl7i6kaO
xWnruNXGzJMGo/90iLJLFaGHCKmUaNTIxwtELTv8+66wJ5wy0Afq0ycaWXB8lPNp
a9SOZdz/VC2fUj3qOW4IVHflSuhrHyLuJrTjiiFbIgYKj1kNFSZ5NwutMatahAYO
HuC6Z6aIpjAVc2IgsFPZCLB86S9wO2M33xReivljwA80/USlwxjK0QoixXCF+L+n
9wZ7JLEsK3/4caHP9f5drrq+ZUtgNyqDGfbGVP+Dxv0Ck/pp87yqfVRoF2xLpxMA
v9ehTe1nc8KlWeyEHmsNOHtS/gBX5Xyfm0N4TeieDlkxQupg1Ig0C8eVZ5pG24mQ
47YAGUN8DVwtij9SnOldCOtwJzvdde5fQmxmhWK8oROqS4ZmiW6lujerwG74rcFF
92QPSXo/5GYHVSFfWULUL5pD2VJm3XGFBYIUl4URITk5VM1LAAwOOnC7jf/2ayM/
pOJtlvUT5x80dzsfxUed
=OHet
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
