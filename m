From: "M'boumba Cedric Madianga" <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/5] i2c: Add STM32F4 I2C driver
Date: Wed, 30 Nov 2016 18:07:41 +0100
Message-ID: <CAOAejn2UDbsLRLmthOitTtkWOcN97WYhg93r9nyxQdBzGGegcg@mail.gmail.com>
References: <1466439771-2741-1-git-send-email-cedric.madianga@gmail.com>
 <1466439771-2741-3-git-send-email-cedric.madianga@gmail.com>
 <20160722070219.GB1605@katana> <CAOAejn0BZNH82kY_7UR1EjV7M1G+9jGihGb4-uCs9=XiPHUYxQ@mail.gmail.com>
 <20161130162353.GC1441@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161130162353.GC1441@katana>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,


2016-11-30 17:23 GMT+01:00 Wolfram Sang <wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>:
> Hi,
>
>> I was too busy in another project but now I am ready to complete the
>> upstream of the STM32F4 I2C driver.
>
> Nice.
>
>> >> +static void stm32f4_i2c_set_periph_clk_freq(struct stm32f4_i2c_dev *i2c_dev)
>> >> +{
>> >> +     u32 clk_rate, cr2, freq;
>> >> +
>> >> +     cr2 = readl_relaxed(i2c_dev->base + STM32F4_I2C_CR2);
>> >> +     cr2 &= ~STM32F4_I2C_CR2_FREQ_MASK;
>> >> +
>> >> +     clk_rate = clk_get_rate(i2c_dev->clk);
>> >> +     freq = clk_rate / MHZ_TO_HZ;
>> >> +
>> >> +     if (freq > STM32F4_I2C_MAX_FREQ)
>> >> +             freq = STM32F4_I2C_MAX_FREQ;
>> >> +     if (freq < STM32F4_I2C_MIN_FREQ)
>> >> +             freq = STM32F4_I2C_MIN_FREQ;
>> >
>> > clamp() to enforce the range?
>> Sorry but what do you mean by "clamp()" ?
>
> The kernel has a clamp() function which would fit this purpose, I think.
Ok I got it. I will fix it in the V4.
Thanks

>
> Regards,
>
>    Wolfram
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
