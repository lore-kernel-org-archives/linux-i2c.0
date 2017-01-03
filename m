From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/5] mfd: axp20x: Drop wrong AXP288_PMIC_ADC_EN define
Date: Tue, 3 Jan 2017 17:54:35 +0000
Message-ID: <20170103175435.GJ27589@dell>
References: <20161214135209.16369-1-hdegoede@redhat.com>
 <20161214135209.16369-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38727 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965064AbdACRuy (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 3 Jan 2017 12:50:54 -0500
Received: by mail-wm0-f50.google.com with SMTP id k184so240369237wme.1
        for <linux-i2c@vger.kernel.org>; Tue, 03 Jan 2017 09:50:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161214135209.16369-4-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

On Wed, 14 Dec 2016, Hans de Goede wrote:

> The adc-enable register for the axp288 is 0x82, not 0x84.
> 0x82 is already defined as AXP20X_ADC_EN1 and that is what the
> axp288_adc driver is actually using, so simply drop the wrong
> AXP288_PMIC_ADC_EN define.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  include/linux/mfd/axp20x.h | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index 199cce3..fe93e00 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -232,7 +232,6 @@ enum {
>  #define AXP288_PMIC_ADC_H               0x56
>  #define AXP288_PMIC_ADC_L               0x57
>  #define AXP288_ADC_TS_PIN_CTRL          0x84
> -#define AXP288_PMIC_ADC_EN              0x84
>  
>  /* Fuel Gauge */
>  #define AXP288_FG_RDC1_REG          0xba

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
