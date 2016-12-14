From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 5/5] mfd: axp20x: Fix axp288 volatile ranges
Date: Wed, 14 Dec 2016 22:41:28 +0800
Message-ID: <CAGb2v66Wd06foGn3dxaVrTYZrfhwox0Mc1YB=jM5+Z87UWXMrg@mail.gmail.com>
References: <20161214135209.16369-1-hdegoede@redhat.com> <20161214135209.16369-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:47826 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754899AbcLNOl6 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 14 Dec 2016 09:41:58 -0500
Received: from mail-it0-f47.google.com (mail-it0-f47.google.com [209.85.214.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: b93043)
        by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 9B47C262B7
        for <linux-i2c@vger.kernel.org>; Wed, 14 Dec 2016 22:41:50 +0800 (CST)
Received: by mail-it0-f47.google.com with SMTP id c20so1328139itb.0
        for <linux-i2c@vger.kernel.org>; Wed, 14 Dec 2016 06:41:50 -0800 (PST)
In-Reply-To: <20161214135209.16369-5-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lee Jones <lee.jones@linaro.org>, Chen-Yu Tsai <wens@csie.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

On Wed, Dec 14, 2016 at 9:52 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> The axp288 pmic has a lot more volatile registers then we were
> listing in axp288_volatile_ranges, fix this.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/axp20x.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index a294121..b9c1adf 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -117,7 +117,10 @@ static const struct regmap_range axp288_writeable_ranges[] = {
>  };
>
>  static const struct regmap_range axp288_volatile_ranges[] = {
> +       regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_PWR_OP_MODE),

Actually register 0x02 is volatile as well. Various fields say "write
1 to clear".
You might need a new define for it though, as the usage is different.

>         regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IPSOUT_V_HIGH_L),
> +       regmap_reg_range(AXP22X_GPIO_STATE, AXP22X_GPIO_STATE),
> +       regmap_reg_range(AXP20X_FG_RES, AXP288_FG_CC_CAP_REG),

Could you also add AXP20X_TIMER_CTRL and 0xa0 ~ 0xa1 (real time
battery voltage),
if you're adding defines?

Thanks
ChenYu

>  };
>
>  static const struct regmap_access_table axp288_writeable_table = {
> --
> 2.9.3
>
