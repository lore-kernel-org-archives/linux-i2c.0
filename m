From: "David.Wu" <david.wu@rock-chips.com>
Subject: Re: [PATCH] i2c: rk3x: Restore clock settings at resume time
Date: Thu, 1 Sep 2016 10:10:08 +0800
Message-ID: <19e4d0bf-28c9-0f10-fac9-c05d1e69d510@rock-chips.com>
References: <1472505756-8302-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:60936 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753885AbcIACKQ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 31 Aug 2016 22:10:16 -0400
In-Reply-To: <1472505756-8302-1-git-send-email-dianders@chromium.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>, wsa@the-dreams.de, heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org, wxt@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Doug,

Last replied email HTML HEAD error, resend it.

ÔÚ 2016/8/30 5:22, Douglas Anderson Ð´µÀ:
> Depending on a number of factors including:
> - Which exact Rockchip SoC we're working with
> - How deep we suspend
> - Which i2c port we're on
>
> We might lose the state of the i2c registers at suspend time.
> Specifically we've found that on rk3399 the i2c ports that are not in
> the PMU power domain lose their state with the current suspend depth
> configured by ARM Tursted Firmware.
>
> Note that there are very few actual i2c registers that aren't configured
> per transfer anyway so all we actually need to re-configure are the
> clock config registers.  We'll just add a call to rk3x_i2c_adapt_div()
> at resume time and be done with it.
>
> NOTE: On rk3399 on ports whose power was lost, I put printouts in at
> resume time.  I saw things like:
>   before: con=0x00010300, div=0x00060006
>   after:  con=0x00010200, div=0x00180025
>

I do the suspend/resume stress test on my rk3399 & rk3288 board more 
than 24 hours,

the patch works well, it looks nice to me.

Reviewed-by: David Wu <david.wu@rock-chips.com>
Tested-by: David Wu <david.wu@rock-chips.com>

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Tested on chromeos-4.4 kernel with backports.
>
> drivers/i2c/busses/i2c-rk3x.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index 3b87afe82f63..0df5ad6bfa31 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -1111,6 +1111,15 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
>  	return ret < 0 ? ret : num;
>  }
>
> +static __maybe_unused int rk3x_i2c_resume(struct device *dev)
> +{
> +	struct rk3x_i2c *i2c = dev_get_drvdata(dev);
> +
> +	rk3x_i2c_adapt_div(i2c, clk_get_rate(i2c->clk));
> +
> +	return 0;
> +}
> +
>  static u32 rk3x_i2c_func(struct i2c_adapter *adap)
>  {
>  	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_PROTOCOL_MANGLING;
> @@ -1332,12 +1341,15 @@ static int rk3x_i2c_remove(struct platform_device *pdev)
>  	return 0;
>  }
>
> +static const SIMPLE_DEV_PM_OPS(rk3x_i2c_pm_ops, NULL, rk3x_i2c_resume);
> +
>  static struct platform_driver rk3x_i2c_driver = {
>  	.probe   = rk3x_i2c_probe,
>  	.remove  = rk3x_i2c_remove,
>  	.driver  = {
>  		.name  = "rk3x-i2c",
>  		.of_match_table = rk3x_i2c_match,
> +		.pm = &rk3x_i2c_pm_ops,
>  	},
>  };
>
>
