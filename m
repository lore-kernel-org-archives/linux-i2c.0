From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 2/2] i2c: sh_mobile: drop needless check for of_node
Date: Fri, 19 May 2017 09:46:45 +0200
Message-ID: <CAMuHMdUWEsr9n7EkWb+Dr0M1r2_Vv=H9TqnoK0tHygnUOogmhQ@mail.gmail.com>
References: <20170518211140.12023-1-wsa+renesas@sang-engineering.com> <20170518211140.12023-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:35423 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750788AbdESHqr (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 19 May 2017 03:46:47 -0400
In-Reply-To: <20170518211140.12023-3-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Thu, May 18, 2017 at 11:11 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> After removal of platform_data support, we can simplify OF handling.
> of_match_device() evaluates to NULL if !CONFIG_OF or if there is no node
> pointer for that device, so we can remove the check for the node ptr.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/i2c/busses/i2c-sh_mobile.c
> +++ b/drivers/i2c/busses/i2c-sh_mobile.c

> +       if (match) {
> +               const struct sh_mobile_dt_config *config;
>
> -                       config = match->data;
> -                       pd->clks_per_count = config->clks_per_count;
> +               config = match->data;

You could have combined the assignment with the variable declaration.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
