From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] i2c: i2c-core: do not use bus internal data
Date: Mon, 14 Mar 2016 10:18:19 +0100
Message-ID: <20160314091819.GA27975@ulmo>
References: <1457351357-13457-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36074 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932438AbcCNJSX (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 14 Mar 2016 05:18:23 -0400
Content-Disposition: inline
In-Reply-To: <1457351357-13457-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, gregkh@linuxfoundation.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2016 at 05:19:17PM +0530, Sudip Mukherjee wrote:
> The variable p is a data structure which is used by the driver core
> internally and it is not expected that busses will be directly accessing
> these driver core internal only data.
>=20
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
>=20
> Reference of Greg's comment about it at:
> https://lkml.org/lkml/2016/3/5/171
>=20
>  drivers/i2c/i2c-core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 2949ab3..2f31fb5 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -73,6 +73,7 @@ static struct device_type i2c_client_type;
>  static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *dr=
iver);
> =20
>  static struct static_key i2c_trace_msg =3D STATIC_KEY_INIT_FALSE;
> +static bool is_registered;
> =20
>  void i2c_transfer_trace_reg(void)
>  {
> @@ -1529,7 +1530,7 @@ static int i2c_register_adapter(struct i2c_adapter =
*adap)
>  	int res =3D 0;
> =20
>  	/* Can't register until after driver model init */
> -	if (unlikely(WARN_ON(!i2c_bus_type.p))) {
> +	if (unlikely(WARN_ON(!is_registered))) {
>  		res =3D -EAGAIN;
>  		goto out_list;
>  	}
> @@ -1926,7 +1927,7 @@ int i2c_register_driver(struct module *owner, struc=
t i2c_driver *driver)
>  	int res;
> =20
>  	/* Can't register until after driver model init */
> -	if (unlikely(WARN_ON(!i2c_bus_type.p)))
> +	if (unlikely(WARN_ON(!is_registered)))
>  		return -EAGAIN;
> =20
>  	/* add the driver to the list of i2c drivers in the driver core */
> @@ -2118,6 +2119,7 @@ static int __init i2c_init(void)
>  	if (IS_ENABLED(CONFIG_OF_DYNAMIC))
>  		WARN_ON(of_reconfig_notifier_register(&i2c_of_notifier));
> =20
> +	is_registered =3D true;
>  	return 0;
> =20
>  class_err:

This doesn't work. I see a number of these WARN_ON()s trigger and I
think the reason is that i2c_init() always fails now. The cause seems to
be that i2c_init() calls i2c_add_driver(&dummy_driver), which will now
always fail, because is_register is set to true *after* that call. There
is no way I see I2C working at all after this patch.

Thierry

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW5oHXAAoJEN0jrNd/PrOhz+EP/i0MmjqzAwYApIdyAwhABkUj
jETLGqUHEZdbGlKcwtfb52TUqtwFvAmYw1Qz7hyqO4LPBZ2NNBBXhGlHWN8BVkZa
JwOjopH4IosGlc3q0ck5pGKdQFB+dKbmlHR+r84doKe4utc558t89CYkE6ytsFrZ
WcG89ngba4OxpQ41XTZW1o0cVXsUaNopqSnSB4OvPJVB3Z19EawkTeCC6u7ZBu0l
n9efRJ8hRfWypZB0SdPLTiGm/JLQLovZTGNrJ50QG7Wn/6mlhl2l8X/fhD9p7tz0
FyvccRU05AgE07L4zA0w9/izGV19SpxsdYBsVPfyMVwuR81aR8yZRKR64hZFiWZp
UOblqLNgkohtLOXjYBY0O1UtQlXSBd3GURM/AhtwM/g06AlHb9sGGQm6mv2bRzia
0AQNScgbUzwwOhVSyF4g0vg5oIS4TJPtIH3J5S23AqI8AUH8vAjbuuQT3+yZpboJ
7TwuEmE5F+K7zccVg/8wotU/4VY7AibHBiaWthp7g64PmV7Aj716K6kOcNWUeMLe
Q2FqbSbOr6ZmWUPbqRO/XAxckztKlDBBAy++qkdaO2vcI+QV09jLNeo/fJr1/n8/
20i9BmE+DyWlFT+ythpmJgCdWf9VvwRvBcLfXMv0eQYnMU3ELjsqzV5mwzNRhWou
KTOKy6UJ8TqLiu5DjFcb
=xiUR
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
