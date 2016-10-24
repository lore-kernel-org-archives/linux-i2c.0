From: Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH] i2c: rk3x: Give the tuning value 0 during
 rk3x_i2c_v0_calc_timings
Date: Mon, 24 Oct 2016 19:55:32 +0800
Message-ID: <e2972b59-b648-88ed-ca0a-acd827b63c2b@rock-chips.com>
References: <1477125822-30644-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.139]:47655 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756858AbcJXLzp (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 24 Oct 2016 07:55:45 -0400
In-Reply-To: <1477125822-30644-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>, heiko@sntech.de, wsa@the-dreams.de
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi:


On 2016年10月22日 16:43, David Wu wrote:
> We found a bug that i2c transfer sometimes failed on 3066a board with
> stabel-4.8, the con register would be updated by uninitialized tuning
> value, it made the i2c transfer failed.
>
> So give the tuning value to be zero during rk3x_i2c_v0_calc_timings.
>
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
>   drivers/i2c/busses/i2c-rk3x.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index 50702c7..df22066 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -694,6 +694,8 @@ static int rk3x_i2c_v0_calc_timings(unsigned long clk_rate,
>   	t_calc->div_low--;
>   	t_calc->div_high--;
>   
> +	/* Give the tuning value 0, that would not update con register */
> +	t_calc->tuning = 0;
>   	/* Maximum divider supported by hw is 0xffff */
>   	if (t_calc->div_low > 0xffff) {
>   		t_calc->div_low = 0xffff;

rk3066a based board can't boot up(with endless i2c irq messages print 
out) from linux-4.8 without this fix.

Tested-by: Andy Yan <andy.yan@rock-chips.com>
