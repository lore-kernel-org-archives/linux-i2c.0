From: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v1 36/40] i2c: synquacer: Use generic definitions for bus frequencies
Date: Mon, 24 Feb 2020 16:18:37 +0100
Message-ID: <CAKv+Gu-syv58pi7OMV3bDn7P5ZhBhMpjiFmLYoJ7t=KuWxVH1g@mail.gmail.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com> <20200224151530.31713-36-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbgBXPSv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:18:51 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18F0C2084E
        for <linux-i2c@vger.kernel.org>; Mon, 24 Feb 2020 15:18:50 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id y17so2019229wrn.6
        for <linux-i2c@vger.kernel.org>; Mon, 24 Feb 2020 07:18:50 -0800 (PST)
In-Reply-To: <20200224151530.31713-36-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>

On Mon, 24 Feb 2020 at 16:15, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Since we have generic definitions for bus frequencies, let's use them.
>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/i2c/busses/i2c-synquacer.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-synquacer.c b/drivers/i2c/busses/i2c-synquacer.c
> index 86026798b4f7..ccd2ed4fa2f1 100644
> --- a/drivers/i2c/busses/i2c-synquacer.c
> +++ b/drivers/i2c/busses/i2c-synquacer.c
> @@ -67,10 +67,10 @@
>
>  /* STANDARD MODE frequency */
>  #define SYNQUACER_I2C_CLK_MASTER_STD(rate)                     \
> -       DIV_ROUND_UP(DIV_ROUND_UP((rate), 100000) - 2, 2)
> +       DIV_ROUND_UP(DIV_ROUND_UP((rate), I2C_STANDARD_MODE_FREQ) - 2, 2)
>  /* FAST MODE frequency */
>  #define SYNQUACER_I2C_CLK_MASTER_FAST(rate)                    \
> -       DIV_ROUND_UP((DIV_ROUND_UP((rate), 400000) - 2) * 2, 3)
> +       DIV_ROUND_UP((DIV_ROUND_UP((rate), I2C_FAST_MODE_FREQ) - 2) * 2, 3)
>
>  /* (clkrate <= 18000000) */
>  /* calculate the value of CS bits in CCR register on standard mode */
> @@ -111,11 +111,11 @@
>                                         & SYNQUACER_I2C_CSR_CS_MASK)
>
>  /* min I2C clock frequency 14M */
> -#define SYNQUACER_I2C_MIN_CLK_RATE     (14 * 1000000)
> +#define SYNQUACER_I2C_MIN_CLK_RATE     (14 * HZ_PER_MHZ)
>  /* max I2C clock frequency 200M */
> -#define SYNQUACER_I2C_MAX_CLK_RATE     (200 * 1000000)
> +#define SYNQUACER_I2C_MAX_CLK_RATE     (200 * HZ_PER_MHZ)
>  /* I2C clock frequency 18M */
> -#define SYNQUACER_I2C_CLK_RATE_18M     (18 * 1000000)
> +#define SYNQUACER_I2C_CLK_RATE_18M     (18 * HZ_PER_MHZ)
>
>  #define SYNQUACER_I2C_SPEED_FM         400     // Fast Mode
>  #define SYNQUACER_I2C_SPEED_SM         100     // Standard Mode
> @@ -602,7 +602,7 @@ static int synquacer_i2c_probe(struct platform_device *pdev)
>         i2c->adapter.nr = pdev->id;
>         init_completion(&i2c->completion);
>
> -       if (bus_speed < 400000)
> +       if (bus_speed < I2C_FAST_MODE_FREQ)
>                 i2c->speed_khz = SYNQUACER_I2C_SPEED_SM;
>         else
>                 i2c->speed_khz = SYNQUACER_I2C_SPEED_FM;
> --
> 2.25.0
>
