From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: sirf: get the i2c pin group by pinctrl api
Date: Mon, 18 Mar 2013 14:11:10 +0530
Message-ID: <5146D326.1090409@ti.com>
References: <1363591361-5992-1-git-send-email-Barry.Song@csr.com> <5146C9C6.2030507@ti.com> <CAGsJ_4yAhUKyH14UEq8WBUmHAq7ZzhNLyX-zcEehR-wr5H6NUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGsJ_4yAhUKyH14UEq8WBUmHAq7ZzhNLyX-zcEehR-wr5H6NUA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,
On Monday 18 March 2013 01:53 PM, Barry Song wrote:
> 2013/3/18 Sourav Poddar<sourav.poddar-l0cyMroinI0@public.gmane.org>:
>> Hi,
>>
>> On Monday 18 March 2013 12:52 PM, Barry Song wrote:
>>> From: Barry Song<Baohua.Song-kQvG35nSl+M@public.gmane.org>
>>>
>>> hardcode set i2c pin group to i2c function before, here we
>>> move to use standard pinctrl API to get pins of the group.
>>>
>>> Signed-off-by: Barry Song<Baohua.Song-kQvG35nSl+M@public.gmane.org>
>>> Cc: Linus Walleij<linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>> ---
>>>    drivers/i2c/busses/i2c-sirf.c |    9 +++++++++
>>>    1 files changed, 9 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
>>> index 5a7ad24..dd4004e 100644
>>> --- a/drivers/i2c/busses/i2c-sirf.c
>>> +++ b/drivers/i2c/busses/i2c-sirf.c
>>> @@ -16,6 +16,7 @@
>>>    #include<linux/clk.h>
>>>    #include<linux/err.h>
>>>    #include<linux/io.h>
>>> +#include<linux/pinctrl/consumer.h>
>>>
>>>    #define SIRFSOC_I2C_CLK_CTRL          0x00
>>>    #define SIRFSOC_I2C_STATUS            0x0C
>>> @@ -265,6 +266,7 @@ static int i2c_sirfsoc_probe(struct platform_device
>>> *pdev)
>>>          struct i2c_adapter *adap;
>>>          struct resource *mem_res;
>>>          struct clk *clk;
>>> +       struct pinctrl *pinctrl;
>>>          int bitrate;
>>>          int ctrl_speed;
>>>          int irq;
>>> @@ -272,6 +274,12 @@ static int i2c_sirfsoc_probe(struct platform_device
>>> *pdev)
>>>          int err;
>>>          u32 regval;
>>>
>>> +       pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
>>> +       if (IS_ERR(pinctrl)) {
>>> +               err = PTR_ERR(pinctrl);
>>> +               goto failed_pin;
>>> +       }
>>> +
>> I think,  you should also add an "EPROBE_DEFER" check here ?
> why would the driver require a probe retry since getting the pinctrl
> has returned an error? before the driver executes, pinctrl driver has
> run earlier and DT has been extended.
>
There might be modules who need some early pinctrl muxing. Some
drivers might also use subsys_initcall instead of module_init. In such 
cases,
"EPROBE_DEFER" might be useful.
> all people are using  IS_ERR(pinctrl) to check the ret of
> devm_pinctrl_get_select_default.
>
Yes, we will keep using this check. DEFER check will be embedded inside 
this.
Something like below, which has been done for omap i2c..

+       dev->pins = devm_pinctrl_get_select_default(&pdev->dev);
+       if (IS_ERR(dev->pins)) {
+               if (PTR_ERR(dev->pins) == -EPROBE_DEFER)
+                       return -EPROBE_DEFER;
+
+               dev_warn(&pdev->dev, "did not get pins for i2c error: 
%li\n",
+                        PTR_ERR(dev->pins));
+               dev->pins = NULL;
+       }
+

>>>          clk = clk_get(&pdev->dev, NULL);
>>>          if (IS_ERR(clk)) {
>>>                  err = PTR_ERR(clk);
>>> @@ -385,6 +393,7 @@ err_clk_en:
>>>    err_clk_prep:
>>>          clk_put(clk);
>>>    err_get_clk:
>>> +failed_pin:
>>>          return err;
>>>    }
> -barry
~Sourav
