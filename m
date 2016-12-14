From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 2/5] mfd: axp20x: Add missing axp288 irqs
Date: Wed, 14 Dec 2016 22:21:11 +0800
Message-ID: <CAGb2v64uaK6B7eaqdKArA7o=YPTj7cC6swrN=ireTGgGMOuHnw@mail.gmail.com>
References: <20161214135209.16369-1-hdegoede@redhat.com> <20161214135209.16369-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:47238 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753305AbcLNOWH (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 14 Dec 2016 09:22:07 -0500
Received: from mail-it0-f49.google.com (mail-it0-f49.google.com [209.85.214.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: b93043)
        by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 6BB0A26284
        for <linux-i2c@vger.kernel.org>; Wed, 14 Dec 2016 22:21:33 +0800 (CST)
Received: by mail-it0-f49.google.com with SMTP id y23so977365itc.0
        for <linux-i2c@vger.kernel.org>; Wed, 14 Dec 2016 06:21:33 -0800 (PST)
In-Reply-To: <20161214135209.16369-2-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lee Jones <lee.jones@linaro.org>, Chen-Yu Tsai <wens@csie.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

On Wed, Dec 14, 2016 at 9:52 PM, Hans de Goede <hdegoede@redhat.com> wrote:
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

Acked-by: Chen-Yu Tsai <wens@csie.org>
