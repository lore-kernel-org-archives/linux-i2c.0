From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] i2c: rk3x: init module as subsys call
Date: Tue, 05 Jan 2016 08:02:41 +0100
Message-ID: <2513923.8oltbpbAin@phil>
References: <1451962938-17398-1-git-send-email-jay.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:56083 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722AbcAEHC4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 5 Jan 2016 02:02:56 -0500
In-Reply-To: <1451962938-17398-1-git-send-email-jay.xu@rock-chips.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "jianqun.xu" <jay.xu@rock-chips.com>
Cc: wsa@the-dreams.de, wdc@rock-chips.com, huangtao@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jianqun,

Am Dienstag, 5. Januar 2016, 11:02:18 schrieb jianqun.xu:
> From: Xu Jianqun <jay.xu@rock-chips.com>
> 
> There is a requirement from pmic device, which is on the i2c bus,
> that the pmic needs to be called earlier then devices powered by
> the outputs of the pmic, if not, the devices maybe fail to probe.
> 
> For example, a pmic on i2c0, and touchscreen device on i2c2,
> i2c0: - pmic(rk818)
> i2c2: - ts(gt911), powered by rk818 on i2c0
> 
> The problem will happen if the i2c2 node in dts file is ordered
> before i2c0 node, then ts(gt911) will be probed before pmic(rk818),
> since the power from the pmic(rk818) for ts(gt911) hasn't enabled,
> so ts(gt911) will fail to probe due to the failure of i2c test.
> 
> But if we set the i2c0 node before i2c2, there is no this issue.
> 
> The stable way to make sure that pmic can be intalized before other
> peripher devices is to make the pmic module be subsys call, the i2c
> module need to be subsys call firstly.

I do believe that came up in the past already and the direction from then 
was (and most likely still is) that drivers should make use of the probe-
deferral mechanism instead of wiggling with the initcall ordering.

Your touchscreen will have a "xyz-supply" property and I think the 
regulator-framework should already emit a -EPROBE_DEFER at regulator_get, 
when the regulator is specified but not available yet.


Heiko

> 
> Signed-off-by: Xu Jianqun <jay.xu@rock-chips.com>
> ---
>  drivers/i2c/busses/i2c-rk3x.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index c1935eb..00e5959 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -1037,7 +1037,17 @@ static struct platform_driver rk3x_i2c_driver = {
>  	},
>  };
> 
> -module_platform_driver(rk3x_i2c_driver);
> +static int __init rk3x_i2c_init(void)
> +{
> +	return platform_driver_register(&rk3x_i2c_driver);
> +}
> +subsys_initcall(rk3x_i2c_init);
> +
> +static void __exit rk3x_i2c_exit(void)
> +{
> +	platform_driver_unregister(&rk3x_i2c_driver);
> +}
> +module_exit(rk3x_i2c_exit);
> 
>  MODULE_DESCRIPTION("Rockchip RK3xxx I2C Bus driver");
>  MODULE_AUTHOR("Max Schwarz <max.schwarz@online.de>");
