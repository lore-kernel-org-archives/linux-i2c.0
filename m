From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] i2c: imx: make bus recovery through pinctrl optional
Date: Mon, 30 Nov 2015 13:55:19 +0100
Message-ID: <CACRpkdbb-GFJSVvxOLda6CVG_fB2zAPPC2MMzQ6P1mAfvsrkPw@mail.gmail.com>
References: <1448055950-21190-1-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1448055950-21190-1-git-send-email-leoli@freescale.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Li Yang <leoli@freescale.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Gao Pan <b54642@freescale.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, Nov 20, 2015 at 10:45 PM, Li Yang <leoli@freescale.com> wrote:

> -       if (IS_ERR(i2c_imx->pinctrl)) {
> +       /* bailout on -ENOMEM or -EPROBE_DEFER, continue for other errors */
> +       if (PTR_ERR(i2c_imx->pinctrl) == -ENOMEM ||
> +                       PTR_ERR(i2c_imx->pinctrl) == -EPROBE_DEFER) {

This is one of the evils of deferred probe: you never know if
something will eventually turn up. It feels wrong to bail out
on deferred probe...

I have no better idea though.
Acked-by

Yours,
Linus Walleij
