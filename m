From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/5] mfd: axp20x: Fix axp288 PEK_DBR and PEK_DBF irqs
 being swapped
Date: Tue, 3 Jan 2017 17:54:18 +0000
Message-ID: <20170103175418.GI27589@dell>
References: <20161214135209.16369-1-hdegoede@redhat.com>
 <20161214135209.16369-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wj0-f175.google.com ([209.85.210.175]:33399 "EHLO
        mail-wj0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965064AbdACRuh (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 3 Jan 2017 12:50:37 -0500
Received: by mail-wj0-f175.google.com with SMTP id tq7so213737467wjb.0
        for <linux-i2c@vger.kernel.org>; Tue, 03 Jan 2017 09:50:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161214135209.16369-3-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

On Wed, 14 Dec 2016, Hans de Goede wrote:

> The R in PEK_DBR stands for rising, so it should be mapped to
> AXP288_IRQ_POKP where the last P stands for positive edge.
> 
> Likewise PEK_DBF should be mapped to the falling edge, aka the
> _N_egative edge, so it should be mapped to AXP288_IRQ_POKN.
> 
> This fixes the inverted powerbutton status reporting by the
> axp20x-pek driver.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/axp20x.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 9a81659..a294121 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -205,14 +205,14 @@ static struct resource axp22x_pek_resources[] = {
>  static struct resource axp288_power_button_resources[] = {
>  	{
>  		.name	= "PEK_DBR",
> -		.start	= AXP288_IRQ_POKN,
> -		.end	= AXP288_IRQ_POKN,
> +		.start	= AXP288_IRQ_POKP,
> +		.end	= AXP288_IRQ_POKP,
>  		.flags	= IORESOURCE_IRQ,
>  	},
>  	{
>  		.name	= "PEK_DBF",
> -		.start	= AXP288_IRQ_POKP,
> -		.end	= AXP288_IRQ_POKP,
> +		.start	= AXP288_IRQ_POKN,
> +		.end	= AXP288_IRQ_POKN,
>  		.flags	= IORESOURCE_IRQ,
>  	},
>  };

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
