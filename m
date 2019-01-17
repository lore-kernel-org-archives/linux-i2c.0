From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH -next] i2c: imx: Fix inconsistent IS_ERR and PTR_ERR in
 i2c_imx_dma_request()
Date: Thu, 17 Jan 2019 06:21:42 +0100
Message-ID: <48d711a6-f9ea-8f32-7c52-e46e4df92bd8@pengutronix.de>
References: <1547694894-69589-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1547694894-69589-1-git-send-email-yuehaibing@huawei.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: YueHaibing <yuehaibing@huawei.com>, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com, peda@axentia.se, wsa+renesas@sang-engineering.com, u.kleine-koenig@pengutronix.de, l.stach@pengutronix.de, eha@deif.com, linux@rempel-privat.de
Cc: kernel-janitors@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi,

thank you.

On 17.01.19 04:14, YueHaibing wrote:
> Change the call to PTR_ERR to access the value just tested by IS_ERR.
> 
> Fixes: 5b3a23a3cc94 ("i2c: imx: notify about real errors on dma i2c_imx_dma_request")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

> ---
>   drivers/i2c/busses/i2c-imx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 09b1245..42fed40 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -287,7 +287,7 @@ static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
>   
>   	dma->chan_tx = dma_request_chan(dev, "tx");
>   	if (IS_ERR(dma->chan_tx)) {
> -		ret = PTR_ERR(dma->chan_rx);
> +		ret = PTR_ERR(dma->chan_tx);
>   		if (ret != -ENODEV && ret != -EPROBE_DEFER)
>   			dev_err(dev, "can't request DMA tx channel (%d)\n", ret);
>   		goto fail_al;
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
