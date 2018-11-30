From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 1/1] i2c: imx: refactor error handling on
 i2c_imx_dma_request()
Date: Fri, 30 Nov 2018 10:52:38 +0100
Message-ID: <20181130095238.z736hvdeibouqu2b@pengutronix.de>
References: <20181130094418.17700-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181130094418.17700-1-o.rempel@pengutronix.de>
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
Cc: Wolfram Sang <wsa@the-dreams.de>, Sascha Hauer <s.hauer@pengutronix.de>, linux-i2c@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org, NXP Linux Team <linux-imx@nxp.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, Nov 30, 2018 at 10:44:18AM +0100, Oleksij Rempel wrote:
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> =

> Current implementation will print error if system is not configured
> with DMA for I2C core. At least on i.MX5x variants is DMA event for I2C
> muxed with SDHC. So it is project specific configuration and not an error.
> =

> This patch will also affect probe, since it will forward all error except
> of missing DMA.
> =

> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> [ore: make it actually compile, fix a corner case]
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes:
> 20181130 v3:
>  - reword commit message =

> 20181112 v2:
>  - drop "[PATCH v1 2/3] i2c: imx: probe dma only only on i.MX50 and
>    later" and rebase without this patch.
>  - Set proper initial author
> =

>  drivers/i2c/busses/i2c-imx.c | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> =

> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index c406700789e1..3c12b174bbb1 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -273,7 +273,7 @@ static inline unsigned char imx_i2c_read_reg(struct i=
mx_i2c_struct *i2c_imx,
>  }
>  =

>  /* Functions for DMA support */
> -static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
> +static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
>  						dma_addr_t phy_addr)

If you touch the line above, maybe also realign the followup line to
start at the opening parenthesis.

>  {
>  	struct imx_i2c_dma *dma;
> @@ -283,11 +283,13 @@ static void i2c_imx_dma_request(struct imx_i2c_stru=
ct *i2c_imx,
>  =

>  	dma =3D devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
>  	if (!dma)
> -		return;
> +		return -ENOMEM;
>  =

> -	dma->chan_tx =3D dma_request_slave_channel(dev, "tx");
> +	dma->chan_tx =3D dma_request_chan(dev, "tx");

Maybe this is worth a separate change?

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
