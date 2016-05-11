From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v8 3/8] i2c: rk3x: Remove redundant rk3x_i2c_clean_ipd()
Date: Wed, 11 May 2016 20:26:52 +0200
Message-ID: <2477327.hJjg0APDhg@phil>
References: <1462908252-27016-1-git-send-email-david.wu@rock-chips.com> <1462908252-27016-4-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:55141 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692AbcEKS1F (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 11 May 2016 14:27:05 -0400
In-Reply-To: <1462908252-27016-4-git-send-email-david.wu@rock-chips.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: wsa@the-dreams.de, robh+dt@kernel.org, dianders@chromium.org, andy.shevchenko@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, briannorris@google.com, davidriley@google.com, huangtao@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Am Mittwoch, 11. Mai 2016, 03:24:07 schrieb David Wu:
> Call rk3x_i2c_setup() before rk3x_i2c_start()

That beginning of the sentence could use a tiny improvement, like

----
rk3x_i2c_setup() gets called directly before rk3x_i2c_start()
----

to make it obvious what happens in the code.

But a nice small improvement
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> and the last thing in setup was to clean the IPD,
> so no reason to do it at the beginning of start.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> Change in v8:
> - none
> 
>  drivers/i2c/busses/i2c-rk3x.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index 1e2677a..9eeb4e5 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -174,7 +174,6 @@ static void rk3x_i2c_start(struct rk3x_i2c *i2c)
>  {
>  	u32 val;
> 
> -	rk3x_i2c_clean_ipd(i2c);
>  	i2c_writel(i2c, REG_INT_START, REG_IEN);
> 
>  	/* enable adapter with correct mode, send START condition */
