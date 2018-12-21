From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 1/1] i2c: imx: refactor error handling on
 i2c_imx_dma_request()
Date: Fri, 21 Dec 2018 16:24:41 +0100
Message-ID: <20181221152441.2nq5hjpoujioyf7n@pengutronix.de>
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
Cc: Wolfram Sang <wsa@the-dreams.de>, Sascha Hauer <s.hauer@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Fri, Nov 30, 2018 at 10:44:18AM +0100, Oleksij Rempel wrote:
> @@ -1159,11 +1163,13 @@ static int i2c_imx_probe(struct platform_device *=
pdev)
>  	dev_dbg(&i2c_imx->adapter.dev, "device resources: %pR\n", res);
>  	dev_dbg(&i2c_imx->adapter.dev, "adapter name: \"%s\"\n",
>  		i2c_imx->adapter.name);
> -	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
>  =

>  	/* Init DMA config if supported */
> -	i2c_imx_dma_request(i2c_imx, phy_addr);
> +	ret =3D i2c_imx_dma_request(i2c_imx, phy_addr);
> +	if (ret < 0)
> +		goto clk_notifier_unregister;

Just found another problem while going over my mails:

goto clk_notifier_unregister is wrong here as you have to undo
i2c_add_numbered_adapter(). Probably it also makes sense to move
initialisation of DMA before i2c_add_numbered_adapter() because
otherwise the first transfer request might come in while
i2c_imx_dma_request is in the middle of initializing the dma channels.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
