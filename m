From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [Patch V7] i2c: imx: implement bus recovery
Date: Fri, 16 Oct 2015 09:14:54 +0200
Message-ID: <20151016071454.GZ7858@pengutronix.de>
References: <1444809643-25329-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57008 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbbJPHO5 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 16 Oct 2015 03:14:57 -0400
Content-Disposition: inline
In-Reply-To: <1444809643-25329-1-git-send-email-b54642@freescale.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <b54642@freescale.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, B20596@freescale.com, b38611@freescale.com, u.kleine-koenig@pengutronix.de, kernel@pengutronix.de, hkallweit1@gmail.com

On Wed, Oct 14, 2015 at 04:00:43PM +0800, Gao Pan wrote:
> Implement bus recovery methods for i2c-imx so we can recover from
> situations where SCL/SDA are stuck low.
>=20
> Once i2c bus SCL/SDA are stuck low during transfer, config the i2c
> pinctrl to gpio mode by calling pinctrl sleep set function, and then
> use GPIO to emulate the i2c protocol to send nine dummy clock to reco=
ver
> i2c device. After recovery, set i2c pinctrl to default group setting.
>=20
> Signed-off-by: Fugang Duan <B38611@freescale.com>
> Signed-off-by: Gao Pan <b54642@freescale.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> V2:
> As Uwe Kleine-K=F6nig's suggestion, the version do below changes:
>  -replace of_get_named_gpio() with devm_gpiod_get_optional()
>  -move gpio_direction_input() and gpio_direction_output() call to the
>   prepare callback
>  -use 0 and 1 as return value for the get_scl and get_sda callbacks
>=20
> V3:
>  -replace "...-gpio" with "...-gpios" in i2c binding doc
>  -document the requirement of using sleep state to configure
>   the pins as gpio in i2c binding doc
>  -remove i2c_recover_bus() in i2c_imx_trx_complete()
>  -use GPIOD_OUT_HIGH as the parameter of devm_gpiod_get_optional to
>   config the gpios as output high
>  -add error disposal as devm_gpiod_get_optional meets error
>=20
> V4:
>  -remove include <linux/of_gpio.h>
>  -call i2c_recover_bus under the condition of the existing of
>   both sda and scl. Drop the sda and scl check in i2c_imx_get_scl,
>   i2c_imx_get_sda, i2c_imx_set_scl, i2c_imx_prepare_recovery and
>   i2c_imx_prepare_recovery
>  -use GPIOD_OUT_IN as the parameter of devm_gpiod_get_optional
>  -remove documenting the requirement of using sleep state to configur=
e
>   the pins as gpio in i2c binding doc
>=20
> V5:
>  -introduce a dedicated gpio state for bus recovery.
>  -assign adapter.bus_recovery_info after the two gpios were aquired s=
uccessfully
>=20
> V6:
>  -assign adapter.bus_recovery_info under the condition that gpios are=
 acquired successfully
>  -not try the recovery when pinctrl_lookup_state returns an error
>=20
> V7:
>  -execute the bus recovery once in a transfer, when the controller fa=
ils to start
>  -use i2c_generic_gpio_recovery() to handle the bus recovery with gpi=
os
>=20
>  Documentation/devicetree/bindings/i2c/i2c-imx.txt |  9 +++
>  drivers/i2c/busses/i2c-imx.c                      | 84 +++++++++++++=
++++++++--
>  2 files changed, 87 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx.txt b/Docu=
mentation/devicetree/bindings/i2c/i2c-imx.txt
> index ce4311d..eab5836 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> @@ -14,6 +14,10 @@ Optional properties:
>    The absence of the propoerty indicates the default frequency 100 k=
Hz.
>  - dmas: A list of two dma specifiers, one for each entry in dma-name=
s.
>  - dma-names: should contain "tx" and "rx".
> +- scl-gpios: specify the gpio related to SCL pin
> +- sda-gpios: specify the gpio related to SDA pin
> +- pinctrl: add extra pinctrl to configure i2c pins to gpio function =
for i2c
> +  bus recovery, call it "gpio" state
> =20
>  Examples:
> =20
> @@ -37,4 +41,9 @@ i2c0: i2c@40066000 { /* i2c0 on vf610 */
>  	dmas =3D <&edma0 0 50>,
>  		<&edma0 0 51>;
>  	dma-names =3D "rx","tx";
> +	pinctrl-names =3D "default", "gpio";
> +	pinctrl-0 =3D <&pinctrl_i2c1>;
> +	pinctrl-1 =3D <&pinctrl_i2c1_gpio>;
> +	scl-gpios =3D <&gpio5 26 GPIO_ACTIVE_HIGH>;
> +	sda-gpios =3D <&gpio5 27 GPIO_ACTIVE_HIGH>;
>  };
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-im=
x.c
> index 91bdf28..c3a0d43 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -49,6 +49,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/of_dma.h>
> +#include <linux/of_gpio.h>
>  #include <linux/platform_data/i2c-imx.h>
>  #include <linux/platform_device.h>
>  #include <linux/sched.h>
> @@ -64,6 +65,8 @@
>  /* Default value */
>  #define IMX_I2C_BIT_RATE	100000	/* 100kHz */
> =20
> +#define I2C_PINCTRL_STATE_GPIO	"gpio"

This is unused, please remove.

>  static u32 i2c_imx_func(struct i2c_adapter *adapter)
>  {
>  	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
> @@ -1011,12 +1075,12 @@ static int i2c_imx_probe(struct platform_devi=
ce *pdev)
> =20
>  	/* Setup i2c_imx driver structure */
>  	strlcpy(i2c_imx->adapter.name, pdev->name, sizeof(i2c_imx->adapter.=
name));
> -	i2c_imx->adapter.owner		=3D THIS_MODULE;
> -	i2c_imx->adapter.algo		=3D &i2c_imx_algo;
> -	i2c_imx->adapter.dev.parent	=3D &pdev->dev;
> -	i2c_imx->adapter.nr		=3D pdev->id;
> -	i2c_imx->adapter.dev.of_node	=3D pdev->dev.of_node;
> -	i2c_imx->base			=3D base;
> +	i2c_imx->adapter.owner =3D THIS_MODULE;
> +	i2c_imx->adapter.algo =3D &i2c_imx_algo;
> +	i2c_imx->adapter.dev.parent =3D &pdev->dev;
> +	i2c_imx->adapter.nr =3D pdev->id;
> +	i2c_imx->adapter.dev.of_node =3D pdev->dev.of_node;
> +	i2c_imx->base =3D base;

unrelated whitespace changes. Please drop this.

Sascha

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
