From: liguo zhang <liguo.zhang@mediatek.com>
Subject: Re: [PATCH] i2c: m65xx: drop superfluous quirk structure
Date: Tue, 7 Mar 2017 10:36:01 +0800
Message-ID: <1488854161.8977.3.camel@mhfsdcap03>
References: <20170227192505.6449-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([218.249.47.111]:50406 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754770AbdCGC7c (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 6 Mar 2017 21:59:32 -0500
In-Reply-To: <20170227192505.6449-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Eddie Huang <eddie.huang@mediatek.com>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Kurtz <djkurtz@chromium.org>, Yingjoe Chen <yingjoe.chen@mediatek.com>, JunGao <jun.gao@mediatek.com>

On Mon, 2017-02-27 at 20:25 +0100, Wolfram Sang wrote:
> All length fields in Linux I2C are u16, so a HW length limitation of 16
> bit lengths is not a limitation. Remove the quirk structure.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
We have tested this patch and it is OK.
Tested-by:Jun Gao <jun.gao@mediatek.com>

> Compile tested only, don't have the hardware. Would appreciate if one of you
> had the time to test this. Thank you!
> 
>  drivers/i2c/busses/i2c-mt65xx.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> index 4a7d9bc2142ba3..45d61714c81bd2 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -172,14 +172,6 @@ static const struct i2c_adapter_quirks mt6577_i2c_quirks = {
>  	.max_comb_2nd_msg_len = 31,
>  };
>  
> -static const struct i2c_adapter_quirks mt8173_i2c_quirks = {
> -	.max_num_msgs = 65535,
> -	.max_write_len = 65535,
> -	.max_read_len = 65535,
> -	.max_comb_1st_msg_len = 65535,
> -	.max_comb_2nd_msg_len = 65535,
> -};
> -
>  static const struct mtk_i2c_compatible mt6577_compat = {
>  	.quirks = &mt6577_i2c_quirks,
>  	.pmic_i2c = 0,
> @@ -199,7 +191,6 @@ static const struct mtk_i2c_compatible mt6589_compat = {
>  };
>  
>  static const struct mtk_i2c_compatible mt8173_compat = {
> -	.quirks = &mt8173_i2c_quirks,
>  	.pmic_i2c = 0,
>  	.dcm = 1,
>  	.auto_restart = 1,
