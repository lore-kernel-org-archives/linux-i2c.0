From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] i2c: rk3x: populate correct variable for sda_falling_time
Date: Wed, 25 Nov 2015 08:08:06 -0800
Message-ID: <CAD=FV=UoW1UBtXEW1n5hSs1g_dC-pfZWWbr9xgumdhJAxbhXqA@mail.gmail.com>
References: <1448467098-10198-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:36337 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbbKYQIH (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 25 Nov 2015 11:08:07 -0500
Received: by ykdr82 with SMTP id r82so60397108ykd.3
        for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2015 08:08:07 -0800 (PST)
In-Reply-To: <1448467098-10198-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>

Wolfram,

On Wed, Nov 25, 2015 at 7:58 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  drivers/i2c/busses/i2c-rk3x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index c1935ebd6a9c38..9096d17beb5bb0 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -908,7 +908,7 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
>                                  &i2c->scl_fall_ns))
>                 i2c->scl_fall_ns = 300;
>         if (of_property_read_u32(pdev->dev.of_node, "i2c-sda-falling-time-ns",
> -                                &i2c->scl_fall_ns))
> +                                &i2c->sda_fall_ns))
>                 i2c->sda_fall_ns = i2c->scl_fall_ns;
>
>         strlcpy(i2c->adap.name, "rk3x-i2c", sizeof(i2c->adap.name));

Thanks for the fix!  In my dts files I never specified
"i2c-sda-falling-time-ns" (since realistically SDA and SCL nearly
always fall with the same rate) so I never saw the issue.  ...but it's
definitely a good idea to fix.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
