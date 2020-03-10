From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] i2c: gpio: suppress error on probe defer
Date: Tue, 10 Mar 2020 09:13:18 +0100
Message-ID: <CACRpkdYwENREw4uCd_tuWWXfv7k+MHOF6Bq=r+JcBHBt8aGuFQ@mail.gmail.com>
References: <20200309211618.25535-1-hamish.martin@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38302 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgCJINd (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 10 Mar 2020 04:13:33 -0400
Received: by mail-lf1-f65.google.com with SMTP id x22so10066802lff.5
        for <linux-i2c@vger.kernel.org>; Tue, 10 Mar 2020 01:13:31 -0700 (PDT)
In-Reply-To: <20200309211618.25535-1-hamish.martin@alliedtelesis.co.nz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c <linux-i2c@vger.kernel.org>

On Mon, Mar 9, 2020 at 10:16 PM Hamish Martin
<hamish.martin@alliedtelesis.co.nz> wrote:

> If a GPIO we are trying to use is not available and we are deferring
> the probe, don't output an error message.
> This seems to have been the intent of commit 05c74778858d
> ("i2c: gpio: Add support for named gpios in DT") but the error was
> still output due to not checking the updated 'retdesc'.
>
> Fixes: 05c74778858d ("i2c: gpio: Add support for named gpios in DT")
> Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Maintainers have varied opinions about this. Some think
it is a stopgap problem until we get probes ordered by other
measures, others think developers should simply learn
the meaning of error -517 and realize it is no error.

But this is fine with me.

Yours,
Linus Walleij
