From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 3/5] mfd: axp20x: Fix axp288 PEK_DBR and PEK_DBF irqs
 being swapped
Date: Wed, 14 Dec 2016 22:28:36 +0800
Message-ID: <CAGb2v64FyNrxwEe2myuu9nNBb3k_jxi4S-AceMmYZxytD1WXLA@mail.gmail.com>
References: <20161214135209.16369-1-hdegoede@redhat.com> <20161214135209.16369-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:47512 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753305AbcLNO3b (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 14 Dec 2016 09:29:31 -0500
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com [209.85.223.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: b93043)
        by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 9ED13262A4
        for <linux-i2c@vger.kernel.org>; Wed, 14 Dec 2016 22:28:58 +0800 (CST)
Received: by mail-io0-f174.google.com with SMTP id p42so41553277ioo.1
        for <linux-i2c@vger.kernel.org>; Wed, 14 Dec 2016 06:28:58 -0800 (PST)
In-Reply-To: <20161214135209.16369-3-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lee Jones <lee.jones@linaro.org>, Chen-Yu Tsai <wens@csie.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

On Wed, Dec 14, 2016 at 9:52 PM, Hans de Goede <hdegoede@redhat.com> wrote:
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

Acked-by: Chen-Yu Tsai <wens@csie.org>
