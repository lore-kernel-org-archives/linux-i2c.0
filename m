From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 3/3] i2c: nomadik: Add Device Tree support to the
 Nomadik I2C driver
Date: Fri, 31 Aug 2012 13:22:58 +0200
Message-ID: <20120831112258.GA2624@pengutronix.de>
References: <1345734087-21803-1-git-send-email-lee.jones@linaro.org>
 <1345734087-21803-3-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3453596030035101214=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1345734087-21803-3-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linus.walleij@stericsson.com, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============3453596030035101214==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 23, 2012 at 04:01:27PM +0100, Lee Jones wrote:
> Here we apply the bindings required for successful Device Tree
> probing of the i2c-nomadik driver.
>=20
> Cc: linux-i2c@vger.kernel.org
> Acked-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>

Two acks? I'd think this cannot work for multiple reasons.

BTW, patch 2 and 3 should be merged. It is a lot easier to review the
code with the binding description together.

Is there some dependency other than updating the dts files? If not, I'd
like to pick up the patch via I2C.

> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/i2c/busses/i2c-nomadik.c |   28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-no=
madik.c
> index 61b00ed..8168389 100644
> --- a/drivers/i2c/busses/i2c-nomadik.c
> +++ b/drivers/i2c/busses/i2c-nomadik.c
> @@ -25,6 +25,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/platform_data/i2c-nomadik.h>
> +#include <linux/of.h>
> =20
>  #define DRIVER_NAME "nmk-i2c"
> =20
> @@ -920,15 +921,42 @@ static struct nmk_i2c_controller u8500_i2c =3D {
>  	.sm             =3D I2C_FREQ_MODE_FAST,
>  };
> =20
> +static void nmk_i2c_of_probe(struct device_node *np,
> +			struct nmk_i2c_controller *pdata)
> +{
> +	/* Provide the default configuration as a base. */
> +	pdata =3D &u8500_i2c;

?????? I wonder how that could work... have you tested the patch?

> +
> +	of_property_read_u32(np, "clock-frequency", (u32*)&pdata->clk_freq);

Might be worth changing clk_freq to u32?

> +
> +	/* This driver only supports 'standard' and 'fast' modes of operation. =
*/
> +	if (pdata->clk_freq <=3D 100000)
> +		pdata->sm =3D I2C_FREQ_MODE_STANDARD;

Is standard =3D=3D 100000 Hz?


> +	else
> +		pdata->sm =3D I2C_FREQ_MODE_FAST;

If those two are fixed frequencies, you should omit a warning if the
devicetree has a different frequency set and report which one is going
to be used actually.


> +}
> +
>  static atomic_t adapter_id =3D ATOMIC_INIT(0);
> =20
>  static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id =
*id)
>  {
>  	int ret =3D 0;
>  	struct nmk_i2c_controller *pdata =3D adev->dev.platform_data;
> +	struct device_node *np =3D adev->dev.of_node;
>  	struct nmk_i2c_dev	*dev;
>  	struct i2c_adapter *adap;
> =20
> +	if (np) {
> +		if (!pdata) {
> +			pdata =3D devm_kzalloc(&adev->dev, sizeof(*pdata), GFP_KERNEL);
> +			if (!pdata) {
> +				ret =3D -ENOMEM;
> +				goto err_no_mem;
> +			}
> +		}
> +		nmk_i2c_of_probe(np, pdata);
> +	}
> +
>  	if (!pdata)
>  		/* No i2c configuration found, using the default. */
>  		pdata =3D &u8500_i2c;
> --=20
> 1.7.9.5
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlBAnpIACgkQD27XaX1/VRt03ACgohnOUAd/yK2V/jZKVJeEu3K+
88kAoKYYDgEMyIZ2a+jNa85vStPkEBZz
=SvfE
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--


--===============3453596030035101214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3453596030035101214==--
