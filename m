From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2 V2] MXS: Set I2C timing registers for mxs-i2c
Date: Sat, 9 Jun 2012 09:45:57 +0530
Message-ID: <CAM=Q2cuv0NQTYJH=+d6Na+JK5rGYsLiSmuX7g8T-_Ry7bs3fRQ@mail.gmail.com>
References: <1339181689-22573-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1339181689-22573-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Jun 9, 2012 at 12:24 AM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
> This patch configures the I2C bus timing registers according
> to information passed via DT. Currently, 100kHz and 400kHz
> modes are supported.
>
> Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> Cc: Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>
> CC: Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> CC: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> CC: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> CC: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
> CC: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
> Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
> =A0Documentation/devicetree/bindings/i2c/i2c-mxs.txt | =A0 =A01 +
> =A0arch/arm/boot/dts/imx28.dtsi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A02 +
> =A0drivers/i2c/busses/i2c-mxs.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 54 +++++++++++++++++++++
> =A03 files changed, 57 insertions(+)
>
> V2: Use clock-frequency instead
>
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt b/Docu=
mentation/devicetree/bindings/i2c/i2c-mxs.txt
> index 1bfc02d..d2bf750 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> @@ -4,6 +4,7 @@ Required properties:
> =A0- compatible: Should be "fsl,<chip>-i2c"
> =A0- reg: Should contain registers location and length
> =A0- interrupts: Should contain ERROR and DMA interrupts
> +- clock-frequency: desired I2C bus clock frequency in Hz.
>
> =A0Examples:
>
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.d=
tsi
> index a89da5a..714e63c 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -398,6 +398,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compat=
ible =3D "fsl,imx28-i2c";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D=
 <0x80058000 2000>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interr=
upts =3D <111 68>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-f=
requency =3D <400000>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status=
 =3D "disabled";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> @@ -407,6 +408,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compat=
ible =3D "fsl,imx28-i2c";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D=
 <0x8005a000 2000>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interr=
upts =3D <110 69>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-f=
requency =3D <400000>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status=
 =3D "disabled";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mx=
s.c
> index 04eb441..b4d083f 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -46,6 +46,10 @@
> =A0#define MXS_I2C_CTRL0_DIRECTION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A00x00010000
> =A0#define MXS_I2C_CTRL0_XFER_COUNT(v) =A0 =A0 =A0 =A0 =A0 =A0((v) & =
0x0000FFFF)
>
> +#define MXS_I2C_TIMING0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x10)
> +#define MXS_I2C_TIMING1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x20)
> +#define MXS_I2C_TIMING2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x30)
> +
> =A0#define MXS_I2C_CTRL1 =A0 =A0 =A0 =A0 =A0(0x40)
> =A0#define MXS_I2C_CTRL1_SET =A0 =A0 =A0(0x44)
> =A0#define MXS_I2C_CTRL1_CLR =A0 =A0 =A0(0x48)
> @@ -97,6 +101,24 @@
> =A0#define MXS_CMD_I2C_READ =A0 =A0 =A0 (MXS_I2C_CTRL0_SEND_NAK_ON_LA=
ST | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MXS_I=
2C_CTRL0_MASTER_MODE)
>
> +struct mxs_i2c_speed_config {
> + =A0 =A0 =A0 uint32_t =A0 =A0 =A0 =A0timing0;
> + =A0 =A0 =A0 uint32_t =A0 =A0 =A0 =A0timing1;
> + =A0 =A0 =A0 uint32_t =A0 =A0 =A0 =A0timing2;
> +};
> +
> +const struct mxs_i2c_speed_config mxs_i2c_95kHz_config =3D {
You are using 95k?
Didnt understand this.


> + =A0 =A0 =A0 .timing0 =A0 =A0 =A0 =A0=3D 0x00780030,
> + =A0 =A0 =A0 .timing1 =A0 =A0 =A0 =A0=3D 0x00800030,
> + =A0 =A0 =A0 .timing2 =A0 =A0 =A0 =A0=3D 0x0015000d,
> +};
> +
> +const struct mxs_i2c_speed_config mxs_i2c_400kHz_config =3D {
> + =A0 =A0 =A0 .timing0 =A0 =A0 =A0 =A0=3D 0x000f0007,
> + =A0 =A0 =A0 .timing1 =A0 =A0 =A0 =A0=3D 0x001f000f,
> + =A0 =A0 =A0 .timing2 =A0 =A0 =A0 =A0=3D 0x0015000d,
> +};
> +

How are these values calculated?
