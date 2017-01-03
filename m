From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/5] mfd: axp20x: Add missing axp288 irqs
Date: Tue, 3 Jan 2017 17:54:07 +0000
Message-ID: <20170103175407.GH27589@dell>
References: <20161214135209.16369-1-hdegoede@redhat.com>
 <20161214135209.16369-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37011 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965064AbdACRu0 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 3 Jan 2017 12:50:26 -0500
Received: by mail-wm0-f51.google.com with SMTP id t79so435854196wmt.0
        for <linux-i2c@vger.kernel.org>; Tue, 03 Jan 2017 09:50:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161214135209.16369-2-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

On Wed, 14 Dec 2016, Hans de Goede wrote:

> The axp288 has the following irqs 2 times: VBUS_FALL, VBUS_RISE,
> VBUS_OV. On boot / reset the enable flags for both the normal and alt
> version of these irqs is set.
> 
> Since we were only listing the normal version in the axp288 regmap_irq
> struct, we were never disabling the alt versions of these irqs.
> 
> Add the alt versions to the axp288 regmap_irq struct, so that these
> get properly disabled.
> 
> Together with the other axp288 fixes in this series, this fixes the axp288
> irq contineously triggering.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/axp20x.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 3d76941..9a81659 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -405,6 +405,9 @@ static const struct regmap_irq axp288_regmap_irqs[] = {
>  	INIT_REGMAP_IRQ(AXP288, VBUS_FALL,              0, 2),
>  	INIT_REGMAP_IRQ(AXP288, VBUS_RISE,              0, 3),
>  	INIT_REGMAP_IRQ(AXP288, OV,                     0, 4),
> +	INIT_REGMAP_IRQ(AXP288, FALLING_ALT,            0, 5),
> +	INIT_REGMAP_IRQ(AXP288, RISING_ALT,             0, 6),
> +	INIT_REGMAP_IRQ(AXP288, OV_ALT,                 0, 7),
>  
>  	INIT_REGMAP_IRQ(AXP288, DONE,                   1, 2),
>  	INIT_REGMAP_IRQ(AXP288, CHARGING,               1, 3),

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
