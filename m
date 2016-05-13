From: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH] i2c: at91: change log when dma configuration fails
Date: Fri, 13 May 2016 11:53:09 +0200
Message-ID: <5735A405.3080008@free.fr>
References: <1463131331-6136-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:54647 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576AbcEMJxX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 13 May 2016 05:53:23 -0400
In-Reply-To: <1463131331-6136-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, nicolas.ferre@atmel.com

On 13/05/2016 11:22, Ludovic Desroches wrote:

> When the DMA configuration fails, there is a log reporting that we can't
> use DMA and indicating the error number. When booting the kernel, it is
> annoying to see this error number. Moreover, people can think something
> is going wrong. It is not the case, it means that DMA can't be used but
> it doesn't prevent to use i2c.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  drivers/i2c/busses/i2c-at91.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 921d32b..f2a7457 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -1013,7 +1013,9 @@ static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
>  
>  error:
>  	if (ret != -EPROBE_DEFER)
> -		dev_info(dev->dev, "can't use DMA, error %d\n", ret);
> +		dev_info(dev->dev,
> +			 "can't request DMA channels, continue without DMA support\n",
> +			 ret);

Did you forget to remove 'ret' after removing the %d format spec?

Regards.
