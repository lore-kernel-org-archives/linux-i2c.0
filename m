From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] i2c: imx: Include the right GPIO header
Date: Fri, 8 Dec 2017 11:44:54 -0200
Message-ID: <CAOMZO5AyCp-Jud2CTaOTDOtxOpBSyKBqD1rtnYxoLajOfezxCw@mail.gmail.com>
References: <20171208133535.17562-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:39998 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753359AbdLHNoz (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 8 Dec 2017 08:44:55 -0500
Received: by mail-ot0-f193.google.com with SMTP id e74so9194759ote.7
        for <linux-i2c@vger.kernel.org>; Fri, 08 Dec 2017 05:44:55 -0800 (PST)
In-Reply-To: <20171208133535.17562-1-linus.walleij@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Dec 8, 2017 at 11:35 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> <linux/of_gpio.h> is not used in this file, by
> <linux/gpio/consumer.h> is.

s/by/but

>
> Someone is just lucky with their implicit includes.
>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Other than this nit:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
