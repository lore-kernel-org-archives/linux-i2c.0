From: "David.Wu" <david.wu@rock-chips.com>
Subject: Re: [PATCH v8 3/8] i2c: rk3x: Remove redundant rk3x_i2c_clean_ipd()
Date: Thu, 12 May 2016 09:11:29 +0800
Message-ID: <5733D841.1020905@rock-chips.com>
References: <1462908252-27016-1-git-send-email-david.wu@rock-chips.com>
 <1462908252-27016-4-git-send-email-david.wu@rock-chips.com>
 <2477327.hJjg0APDhg@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2477327.hJjg0APDhg@phil>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: wsa@the-dreams.de, robh+dt@kernel.org, dianders@chromium.org, andy.shevchenko@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, briannorris@google.com, davidriley@google.com, huangtao@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Heiko

=E5=9C=A8 2016/5/12 2:26, Heiko Stuebner =E5=86=99=E9=81=93:
> Am Mittwoch, 11. Mai 2016, 03:24:07 schrieb David Wu:
>> Call rk3x_i2c_setup() before rk3x_i2c_start()
>
> That beginning of the sentence could use a tiny improvement, like
>
> ----
> rk3x_i2c_setup() gets called directly before rk3x_i2c_start()
> ----
>

Okay, i will add it in next version, Thanks.

> to make it obvious what happens in the code.
>
> But a nice small improvement
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
>> and the last thing in setup was to clean the IPD,
>> so no reason to do it at the beginning of start.
>>
>> Signed-off-by: David Wu <david.wu@rock-chips.com>
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>> ---
>> Change in v8:
>> - none
>>
>>   drivers/i2c/busses/i2c-rk3x.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-=
rk3x.c
>> index 1e2677a..9eeb4e5 100644
>> --- a/drivers/i2c/busses/i2c-rk3x.c
>> +++ b/drivers/i2c/busses/i2c-rk3x.c
>> @@ -174,7 +174,6 @@ static void rk3x_i2c_start(struct rk3x_i2c *i2c)
>>   {
>>   	u32 val;
>>
>> -	rk3x_i2c_clean_ipd(i2c);
>>   	i2c_writel(i2c, REG_INT_START, REG_IEN);
>>
>>   	/* enable adapter with correct mode, send START condition */
>
>
>
>
