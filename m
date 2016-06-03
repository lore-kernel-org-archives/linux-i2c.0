From: "M'boumba Cedric Madianga" <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/5] i2c: Add STM32F4 I2C driver
Date: Fri, 3 Jun 2016 09:44:43 +0200
Message-ID: <CAOAejn06djk8h3GLmrXdfX6Y7Rj1W38gih_mgCQ5aLNZAgAvFQ@mail.gmail.com>
References: <1462980974-22091-1-git-send-email-cedric.madianga@gmail.com>
 <1462980974-22091-3-git-send-email-cedric.madianga@gmail.com>
 <CALszF6A-jiCBtSO1RFDdgHKTKmsonRXFVs0x2zHha1LJ3UhwtQ@mail.gmail.com>
 <CAOAejn0Fsizp9fK1mNn3BBeL2LeoVgt5_zF5656La4G2uDPH7g@mail.gmail.com>
 <CAOAejn1NQDJpGrTwGtpvSfVOGg3UuCkj8wLJ7B5LnW1-Z2VrQA@mail.gmail.com>
 <CALszF6ADLuZ0wK=L68FDzy5M5_eSPRTbNOjSoQw=dWDOjsPqCA@mail.gmail.com>
 <CAOAejn0G3JzATKME5DaMV0GEBwQVWjkB1=ei-7LOQ98vzkUeVw@mail.gmail.com> <CALszF6A9m1gwTg-HeGSukqbRUUz1cPv5R_-586uKzeVkkpQ93g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CALszF6A9m1gwTg-HeGSukqbRUUz1cPv5R_-586uKzeVkkpQ93g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Maxime,

2016-06-02 18:02 GMT+02:00 Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Hi Cedric,
>
> 2016-06-02 17:35 GMT+02:00 M'boumba Cedric Madianga <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> Hi,
>>
>>>> +
>>>> +/**
>>>> + * stm32f4_i2c_xfer() - Transfer combined I2C message
>>>> + * @i2c_adap: Adapter pointer to the controller
>>>> + * @msgs: Pointer to data to be written.
>>>> + * @num: Number of messages to be executed
>>>> + */
>>>> +static int stm32f4_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[],
>>>> +                           int num)
>>>> +{
>>>> +       struct stm32f4_i2c_dev *i2c_dev = i2c_get_adapdata(i2c_adap);
>>>> +       int ret, i;
>>>> +
>>>> +       i2c_dev->busy = true;
>>>> +
>>>> +       ret = clk_prepare_enable(i2c_dev->clk);
>>>> +       if (ret) {
>>>> +               dev_err(i2c_dev->dev, "Failed to prepare_enable clock\n");
>>>> +               return ret;
>>>> +       }
>>>> +
>>>> +       stm32f4_i2c_hw_config(i2c_dev);
>>> Maybe you could call this only at probe and resume time?
>>> You would save some register accesses.
>> Some clarification about this point.
>> We need to call stm32f4_i2c_hw_config before each I2C transfer as at
>> the end of I2C communication the peripheral is automatically disabled
>> and configuration registers are reset.
>
> Ok, but I wonder how the IP knows this is the last i2c message to be sent?
When the IP is enabled we could generated a STOP at any moment by
setting a bit in CR1 register.
At this moment, the IP knows that this is the last byte to be sent.
After STOP generation, I notice that all registers are automatically
set with their reset values

> Or maybe it gets re-initialized as soon as the clk is disabled?
Not really because they are all re-initialized before disabling the clock

>
> Thanks for the inputs,
> Maxime
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
