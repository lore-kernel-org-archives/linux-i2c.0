From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] i2c: rk3x: add proper kerneldoc header
Date: Thu, 18 Jan 2018 00:19:52 +0100
Message-ID: <3433285.yBKRl3OqfX@phil>
References: <20180117231817.26955-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:41232 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752901AbeAQXTy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 17 Jan 2018 18:19:54 -0500
In-Reply-To: <20180117231817.26955-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-rockchip@lists.infradead.org

Am Donnerstag, 18. Januar 2018, 00:18:17 CET schrieb Wolfram Sang:
> gcc noticed the kerneldoc was wrongly formatted. Fix it!
> 
> drivers/i2c/busses/i2c-rk3x.c:164: warning:
>   Cannot understand  * @grf_offset: ...
>   on line 164 - I thought it was a doc line
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

If you need it,
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
> 
> It also found this, but I leave this for now. Maybe someone else is interested:
> 
> drivers/i2c/busses/i2c-rk3x.c:247: warning: No description found for parameter 'i2c'
> drivers/i2c/busses/i2c-rk3x.c:268: warning: No description found for parameter 'i2c'
> drivers/i2c/busses/i2c-rk3x.c:306: warning: No description found for parameter 'i2c'
> drivers/i2c/busses/i2c-rk3x.c:337: warning: No description found for parameter 'i2c'
> drivers/i2c/busses/i2c-rk3x.c:975: warning: No description found for parameter 'i2c'
> 
>  drivers/i2c/busses/i2c-rk3x.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index 1f80960c5ae1c8..e1a18d989f8307 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -161,6 +161,7 @@ enum rk3x_i2c_state {
>  };
>  
>  /**
> + * struct rk3x_i2c_soc_data:
>   * @grf_offset: offset inside the grf regmap for setting the i2c type
>   * @calc_timings: Callback function for i2c timing information calculated
>   */
> 
