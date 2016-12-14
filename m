From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 4/5] mfd: axp20x: Drop wrong AXP288_PMIC_ADC_EN define
Date: Wed, 14 Dec 2016 22:29:18 +0800
Message-ID: <CAGb2v662kMYqh4MNMC3z9+8jgpG4+-i7-OP6CzE8Pi9zEt=JiA@mail.gmail.com>
References: <20161214135209.16369-1-hdegoede@redhat.com> <20161214135209.16369-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:47526 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756136AbcLNO3n (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 14 Dec 2016 09:29:43 -0500
Received: from mail-io0-f180.google.com (mail-io0-f180.google.com [209.85.223.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: b93043)
        by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 232B0262B1
        for <linux-i2c@vger.kernel.org>; Wed, 14 Dec 2016 22:29:40 +0800 (CST)
Received: by mail-io0-f180.google.com with SMTP id p42so41570390ioo.1
        for <linux-i2c@vger.kernel.org>; Wed, 14 Dec 2016 06:29:40 -0800 (PST)
In-Reply-To: <20161214135209.16369-4-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lee Jones <lee.jones@linaro.org>, Chen-Yu Tsai <wens@csie.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

On Wed, Dec 14, 2016 at 9:52 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> The adc-enable register for the axp288 is 0x82, not 0x84.
> 0x82 is already defined as AXP20X_ADC_EN1 and that is what the
> axp288_adc driver is actually using, so simply drop the wrong
> AXP288_PMIC_ADC_EN define.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
