From: Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH] i2c: imx: don't leak the i2c adapter on error
Date: Fri, 29 Mar 2019 19:03:55 +0530
Message-ID: <2c5f68e0-5377-cfd3-f527-e235c0e19bef@codeaurora.org>
References: <20190329124817.6717-1-laurentiu.tudor@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329124817.6717-1-laurentiu.tudor@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: laurentiu.tudor@nxp.com, linux-i2c@vger.kernel.org, wsa+renesas@sang-engineering.com
Cc: linux-kernel@vger.kernel.org, leoyang.li@nxp.com, linux-imx@nxp.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


On 3/29/2019 6:18 PM, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> Make sure to free the i2c adapter on the error exit path.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/i2c/busses/i2c-imx.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 42fed40198a0..2dfd33f48cd8 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1169,11 +1169,13 @@ static int i2c_imx_probe(struct platform_device *pdev)
>   	/* Init DMA config if supported */
>   	ret = i2c_imx_dma_request(i2c_imx, phy_addr);
>   	if (ret < 0)
> -		goto clk_notifier_unregister;
> +		goto del_adapter;
>   
>   	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
>   	return 0;   /* Return OK */
>   
> +del_adapter:
> +	 i2c_del_adapter(&i2c_imx->adapter);
>   clk_notifier_unregister:
>   	clk_notifier_unregister(i2c_imx->clk, &i2c_imx->clk_change_nb);
>   rpm_disable:
