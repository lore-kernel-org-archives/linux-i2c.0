From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1] MAINTAINERS: i2c-imx: take over maintainership
Date: Mon, 12 Aug 2019 08:48:11 +0200
Message-ID: <20190812064811.427cy7ahim54odkk@pengutronix.de>
References: <20190812050817.23279-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190812050817.23279-1-o.rempel@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Wolfram Sang <wsa@the-dreams.de>, Andrey Smirnov <andrew.smirnov@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, linux-i2c@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Chris Healy <cphealy@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Aug 12, 2019 at 07:08:17AM +0200, Oleksij Rempel wrote:
> I would like to maintain the i2c-imx driver. Since I work with
> different i.MX variants and have access to the hardware, I can spend
> some time on the reviewing of this driver.
> =

> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> =

> diff --git a/MAINTAINERS b/MAINTAINERS
> index e81e60bd7c26..ddc1cf5cb0b9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6441,6 +6441,14 @@ S:	Maintained
>  F:	drivers/perf/fsl_imx8_ddr_perf.c
>  F:	Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
>  =

> +FREESCALE IMX I2C DRIVER
> +M:	Oleksij Rempel <o.rempel@pengutronix.de>
> +R:	Pengutronix Kernel Team <kernel@pengutronix.de>
> +L:	linux-i2c@vger.kernel.org
> +S:	Maintained
> +F:	drivers/i2c/busses/i2c-imx.c
> +F:	Documentation/devicetree/bindings/i2c/i2c-imx.txt
> +

Even without this patch the generic "ARM/FREESCALE IMX / MXC ARM
ARCHITECTURE" entry matches the i2c-imx driver. Maybe it is worth to
point that out in the commit log?

Other than that arch/arm/mach-imx/devices/platform-imx-i2c.c might be
related, but not sure this is still used at all.

Great you pick that up.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
