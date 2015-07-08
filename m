From: Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH 01/10] i2c: add and export of_get_i2c_adapter_by_node()
 interface
Date: Wed, 8 Jul 2015 15:11:42 +0200
Message-ID: <20150708131140.GA12791@ulmo.nvidia.com>
References: <1436360095-9065-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1436360352-9181-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0976470360=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1436360352-9181-1-git-send-email-vladimir_zapolskiy@mentor.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-i2c@vger.kernel.org, Andy Yan <andy.yan@rock-chips.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

--===============0976470360==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2015 at 03:59:12PM +0300, Vladimir Zapolskiy wrote:
> of_find_i2c_adapter_by_node() call requires quite often missing
> put_device(), and i2c_put_adapter() releases a device locked by
> i2c_get_adapter() only. In general module_put(adapter->owner) and
> put_device(dev) are not interchangeable.
>=20
> This is a common error reproduction scenario as a result of the
> misusage described above (for clearness this is run on iMX6 platform
> with HDMI and I2C bus drivers compiled as kernel modules):
>=20
>     root@mx6q:~# lsmod | grep i2c
>     i2c_imx                10213  0
>     root@mx6q:~# lsmod | grep dw_hdmi_imx
>     dw_hdmi_imx             3631  0
>     dw_hdmi                11846  1 dw_hdmi_imx
>     imxdrm                  8674  3 dw_hdmi_imx,imx_ipuv3_crtc,imx_ldb
>     drm_kms_helper        113765  5 dw_hdmi,imxdrm,imx_ipuv3_crtc,imx_ldb
>     root@mx6q:~# rmmod dw_hdmi_imx
>     root@mx6q:~# lsmod | grep i2c
>     i2c_imx                10213  -1
>=20
>                                  ^^^^^
>=20
>     root@mx6q:~# rmmod i2c_imx
>     rmmod: ERROR: Module i2c_imx is in use
>=20
> To fix existing users of these interfaces and to avoid any further
> confusion and misusage in future, add one more interface
> of_get_i2c_adapter_by_node(), it is similar to i2c_get_adapter() in
> sense that an I2C bus device driver found and locked by user can be
> correctly unlocked by i2c_put_adapter().
>=20
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---
> The change is based on RFC http://www.spinics.net/lists/linux-i2c/msg2025=
7.html
>=20
> * added new exported function declaration in include/linux/i2c.h
> * added put_device(dev) call right inside of_get_i2c_adapter_by_node()
> * corrected authorship of the change
>=20
>  drivers/i2c/i2c-core.c | 20 ++++++++++++++++++++
>  include/linux/i2c.h    |  6 ++++++
>  2 files changed, 26 insertions(+)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 069a41f..0d902ab 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1356,6 +1356,26 @@ struct i2c_adapter *of_find_i2c_adapter_by_node(st=
ruct device_node *node)
>  	return i2c_verify_adapter(dev);
>  }
>  EXPORT_SYMBOL(of_find_i2c_adapter_by_node);
> +
> +struct i2c_adapter *of_get_i2c_adapter_by_node(struct device_node *node)
> +{
> +	struct device *dev;
> +	struct i2c_adapter *adapter;
> +
> +	dev =3D bus_find_device(&i2c_bus_type, NULL, node,
> +			      of_dev_node_match);
> +	if (!dev)
> +		return NULL;
> +
> +	adapter =3D i2c_verify_adapter(dev);
> +	if (adapter && !try_module_get(adapter->owner))
> +		adapter =3D NULL;
> +
> +	put_device(dev);

I don't think this is correct. Users still need to keep a reference to
the device, otherwise it can simply disappear even if the module stays
around (think sysfs bind/unbind attributes).

Looking at i2c_put_adapter() it seems like it would need to do more than
just drop the module reference. Then again, that probably means that we
need to add a get_device() somewhere in i2c_get_adapter() to balance the
put_device() in i2c_put_adapter().

Thierry

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVnSGJAAoJEN0jrNd/PrOhxHYQAJF0oJt7bFrfAOXqZcwxM3PZ
GnMJXPKowJys/a8Qlx+MBXDhmlqXrv94e/UesTQxzNEqmgv1EhYEtScvmVOhvPcO
GpC/rETJzGegzCt8TXnfD38+Xl88NGaefHkhy00Fdyi2I7GJqQVjJN/SDMR6TGm+
8WsgSpicKKMrJH49L7gs757CMhnAYk5hUg5wFLc49gCXqPNT5GZ4+W3z4IrN8Fs5
SUukHIuXSDzkrzOE2KuEGDWe8EkPNKSeBnOTOWCxZixLsxILAnbP+FpbtpYA1t9H
//DIbEEpIVHErU2ak33txTlS8UxjsuHyguHrKyqy9koMuJdtfU48UnKoQl4ajE87
OJsUNZNgk/kghNAyU2ip4ddIVb0eM5kX8e5zadmmSQ4Y4gKzYLb7g3PjzC3qj4jC
Sg/xqkpCFLk7+qKHxT0i2JM5DU6xiYMuXwfmkebJNte8sUotZ07nbXwqk/3ic40p
zcOPi4iD0+5k8rktnPI7SlvoRzi46O4KU2lMIGzgGvCSKXlzdEg4u3Jw/5p7tSS2
FmPJPAgdFBYPn8PPcXev1ObW5yoIoqgQwhN6b6EkgiTqIwI0v3/Y1pJVuS2Gw5N1
CACyCDsFCbJJnv40wQ9IurxfW7Z+r5jLfm9d+Ouk6JDMWp8VwNAga/IDkvg90XMC
NoT8ReZOP9Oj9UR+6AQr
=R9B/
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--

--===============0976470360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============0976470360==--
