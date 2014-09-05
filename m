From: addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH] i2c: rk3x: fix divisor calculation for SCL frequency
Date: Fri, 05 Sep 2014 18:17:10 +0800
Message-ID: <54098DA6.4090704@rock-chips.com>
References: <1409884333-3544-1-git-send-email-addy.ke@rock-chips.com> <CAD=FV=W3JJM38v-X=pyLUjAzY3Ti88xUgWp9bMsX5dqp1gubpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAD=FV=W3JJM38v-X=pyLUjAzY3Ti88xUgWp9bMsX5dqp1gubpg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> Addy,
> 
> On Thu, Sep 4, 2014 at 7:32 PM, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>> I2C_CLKDIV register descripted in the previous version of
>> RK3x chip manual is incorrect. Plus 1 is required.
>>
>> The correct formula:
>> - T(SCL_HIGH) = T(PCLK) * (CLKDIVH + 1) * 8
>> - T(SCL_LOW) = T(PCLK) * (CLKDIVL + 1) * 8
>> - (SCL Divsor) = 8 * ((CLKDIVL + 1) + (CLKDIVH + 1))
>> - SCL = PCLK / (CLK Divsor)
> 
> I'll trust that you tested this with a scope
> 
Yes ,I have tested on RK3188 and RK3288, and confirmed by oscilloscope.
> 
>> It will be updated to the latest version of chip manual.
>>
>> Signed-off-by: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> ---
>>  drivers/i2c/busses/i2c-rk3x.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
>> index e637c32..76b6604 100644
>> --- a/drivers/i2c/busses/i2c-rk3x.c
>> +++ b/drivers/i2c/busses/i2c-rk3x.c
>> @@ -433,8 +433,8 @@ static void rk3x_i2c_set_scl_rate(struct rk3x_i2c *i2c, unsigned long scl_rate)
>>         unsigned long i2c_rate = clk_get_rate(i2c->clk);
>>         unsigned int div;
>>
>> -       /* SCL rate = (clk rate) / (8 * DIV) */
>> -       div = DIV_ROUND_UP(i2c_rate, scl_rate * 8);
>> +       /* SCL rate = (clk rate) / (8 * (DIV + 2)) */
>> +       div = DIV_ROUND_UP(i2c_rate, scl_rate * 8) - 2;
> 
> Given the bug I just fixed in the Rockchip SPI driver, I was a little
> worried about div becoming -1 (and thus being a really large positive
> number since div is unsigned).
> 
> However, it seems that you get saved by the next statement:
>   div = DIV_ROUND_UP(div, 2);
> 
> In the testing I did with the Linux macros, that magically transformed
> a div of 0xFFFFFFFF (-1) to 0, so it's not technically a bug.  ...but
> it's very non-obvious.  Can you do something a little cleaner?

The following modifications is reasonable?

static void rk3x_i2c_set_scl_rate(struct rk3x_i2c *i2c, unsigned long scl_rate)
{
        unsigned long i2c_rate = clk_get_rate(i2c->clk);
        unsigned int div;

        /* set DIV = DIVH = DIVL
         * SCL rate = (clk rate) / (8 * (DIVH + 1 + DIVL + 1))
         *          = (clk rate) / (16 * (DIV + 1))
         */
        div = DIV_ROUND_UP(i2c_rate, scl_rate * 16) - 1;

        i2c_writel(i2c, (div << 16) | (div & 0xffff), REG_CLKDIV);
}
> 
> -Doug
> 
> 
> 
