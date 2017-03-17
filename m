From: "M'boumba Cedric Madianga" <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/5] i2c: i2c-stm32f7: add driver
Date: Fri, 17 Mar 2017 14:52:44 +0100
Message-ID: <CAOAejn0Hs7QOgcrHM2t3NsFQeD9dyvThDK-8iM1Lvb7Qv4fGGQ@mail.gmail.com>
References: <1489744738-21632-1-git-send-email-cedric.madianga@gmail.com>
 <1489744738-21632-4-git-send-email-cedric.madianga@gmail.com> <6ae90186-0e8d-654b-c9e3-2d1b4daf6198@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6ae90186-0e8d-654b-c9e3-2d1b4daf6198-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Pierre-Yves MORDRET <pierre-yves.mordret-qxv4g6HH51o@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,


>> +static int stm32f7_i2c_hw_config(struct stm32f7_i2c_dev *i2c_dev)
>> +{
>> +     struct device_node *of_node = i2c_dev->dev->of_node;
>> +     u32 timing;
>> +     int ret;
>> +
>> +     ret = of_property_read_u32(of_node, "st,i2c-timing", &timing);
>> +     if (ret) {
>> +             dev_err(i2c_dev->dev, "Error: missing i2c timing property\n");
>> +             return ret;
>> +     }
>> +
>> +     /* Timing settings */
>> +     writel_relaxed(timing, i2c_dev->base + STM32F7_I2C_TIMINGR);
>
> Hi,
>
> Using a register value in DT is quite ugly since the requirement to calculate the timings
> is quite easy, and well documented.
>
> I wrote it for Zephyr, you can find it here :
> https://github.com/zephyrproject-rtos/zephyr/blob/master/drivers/i2c/i2c_stm32lx.c#L31

Thanks for this code. It is very interesting.
With our formula, I just notice that we don't use any i2c rise time or
fall time but they have some impacts in i2c timing computation.
So, the user could not be able to select these values for him use case. Right ?


>
> Another point, maybe you should find a better name for the driver, since this I2C IP is share
> with the STM32Lx also and is not tied to STM32F7.

As far as I know, we don't have any STM32Lx SoC integrated in the
linux kernel mainline.
I choose i2c-stm32f7 name as it is the first Soc integrated in the
linux kernel mainline where this IP could be used.

BR,
Cedric
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
