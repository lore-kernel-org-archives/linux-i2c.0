From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] i2c: riic: remove fixed clock restriction
Date: Fri, 29 Sep 2017 18:26:45 +0200
Message-ID: <CAMuHMdW4yWVwwpzHb4wmj3dfb4-YrsqRu7-O+0G=c_f7EDUzaQ@mail.gmail.com>
References: <20170929153259.105408-1-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34506 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbdI2Q0r (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 29 Sep 2017 12:26:47 -0400
In-Reply-To: <20170929153259.105408-1-chris.brandt@renesas.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>

Hi Chris,

On Fri, Sep 29, 2017 at 5:32 PM, Chris Brandt <chris.brandt@renesas.com> wrote:
> Most systems with this i2c are going to have a clock of either 33.3MHz or
> 32MHz. That 4% difference is not reason enough to warrant that the driver
> to completely fail.
>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
>  drivers/i2c/busses/i2c-riic.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
> index c811af4c8d81..0a61beeb384a 100644
> --- a/drivers/i2c/busses/i2c-riic.c
> +++ b/drivers/i2c/busses/i2c-riic.c
> @@ -299,12 +299,13 @@ static int riic_init_hw(struct riic_dev *riic, u32 spd)
>
>         /*
>          * TODO: Implement formula to calculate the timing values depending on
> -        * variable parent clock rate and arbitrary bus speed
> +        * variable parent clock rate and arbitrary bus speed.
> +        * For now, just use calculations based on a 33325000Hz clock.
>          */
>         rate = clk_get_rate(riic->clk);
> -       if (rate != 33325000) {
> +       if (!rate) {
>                 dev_err(&riic->adapter.dev,
> -                       "invalid parent clk (%lu). Must be 33325000Hz\n", rate);
> +                       "invalid parent clk (%lu)\n", rate);

The printed rate is always zero here.

>                 clk_disable_unprepare(riic->clk);
>                 return -EINVAL;
>         }

Gr{oetje,eeting}s,

                        Geert
