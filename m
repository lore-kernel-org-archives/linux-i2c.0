From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] drivers/i2c/busses/i2c-imx.c:remove duplicate print
 after platform_get_irq()
Date: Wed, 18 Mar 2020 11:18:44 +0100
Message-ID: <20200318101844.55c273zh242ymxcf@pengutronix.de>
References: <20200318100748.17540-1-tangbin@cmss.chinamobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47071 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRKSx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 18 Mar 2020 06:18:53 -0400
Content-Disposition: inline
In-Reply-To: <20200318100748.17540-1-tangbin@cmss.chinamobile.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Tang Bin <tangbin@cmss.chinamobile.com>
Cc: linux@rempel-privat.de, s.hauer@pengutronix.de, shawnguo@kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 06:07:48PM +0800, Tang Bin wrote:
> We don't need dev_err() message because when something goes wrong,
> platform_get_irq() has print an error message itself, so we should
> remove duplicate dev_err().
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index a3b61336f..01fd46682 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1066,10 +1066,8 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  	dev_dbg(&pdev->dev, "<%s>\n", __func__);
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(&pdev->dev, "can't get irq number\n");
> +	if (irq < 0)
>  		return irq;
> -	}

Maybe add a comment for the next person who wonders about an error path
without error message? Something like:

	irq = platform_get_irq(pdev, 0);
	if (irq < 0)
		/*
		 * platform_get_irq() already issued an error message, so
		 * fail silently here.
		 */
		 return irq;

And to get some extra kudos mention the commit that modified
platform_get_irq() to emit a message in the commit log.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
