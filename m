From: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-ocores: add common clock support
Date: Thu, 22 Jan 2015 18:01:24 +0300
Message-ID: <CAMo8Bf+XJY_bY+OB2i_SZQmAavwERG39BR8FVj202V-E3UidPg@mail.gmail.com>
References: <1421230899-7843-1-git-send-email-jcmvbkbc@gmail.com>
	<20150122144522.GF3413@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150122144522.GF3413@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 22, 2015 at 5:45 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>> @@ -320,9 +322,23 @@ static int ocores_i2c_of_probe(struct platform_device *pdev,
>>       }
>>
>>       if (of_property_read_u32(np, "clock-frequency", &val)) {
>> -             dev_err(&pdev->dev,
>> -                     "Missing required parameter 'clock-frequency'\n");
>> -             return -ENODEV;
>> +             struct clk *clk = devm_clk_get(&pdev->dev, NULL);
>> +
>> +             if (!IS_ERR(clk)) {
>> +                     int ret = clk_prepare_enable(clk);
>> +
>> +                     if (ret) {
>> +                             dev_err(&pdev->dev,
>> +                                     "clk_prepare_enable failed: %d\n", ret);
>> +                             return ret;
>> +                     }
>> +                     i2c->clk = clk;
>> +                     val = clk_get_rate(clk);
>> +             } else {
>> +                     dev_err(&pdev->dev,
>> +                             "Missing required parameter 'clock-frequency'\n");
>> +                     return -ENODEV;
>> +             }
>
> Either NAK or I don't understand the logic here :) If a dts does NOT
> have the bus-speed set by 'clock-frequency', then we take the value of
> the clock assigned to this platform_device?
>
> The usual thing to do when 'clock-frequency' is not set is to default to
> 100kHz.

The clock here is not the i2c bus clock, but the clock input of the
controller. The function ocores_init initializes the prescaler register of
the controller so that the bus clock equals 100kHz (internal clock
runs at 500kHz):

static void ocores_init(struct ocores_i2c *i2c)
{
        int prescale;
...
        prescale = (i2c->clock_khz / (5*100)) - 1;
        oc_setreg(i2c, OCI2C_PRELOW, prescale & 0xff);
        oc_setreg(i2c, OCI2C_PREHIGH, prescale >> 8);
...

Then yes, when there's no 'clock-frequency' we take the value of the
clock assigned to this platform_device, which in turn comes from the
'clk' property.

-- 
Thanks.
-- Max
