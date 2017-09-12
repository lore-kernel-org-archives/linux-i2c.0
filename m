From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 1/2] i2c: davinci: Add PM Runtime Support
Date: Tue, 12 Sep 2017 14:18:08 +0530
Message-ID: <021a99bb-3670-fff5-6835-b14d28827929@ti.com>
References: <20170911201145.31257-1-fcooper@ti.com>
 <20170911201145.31257-2-fcooper@ti.com>
 <CAMz4kuLGVes6a4iCF0VbG1ErWPR5at=HKgeGv3cMr1zv7aLzJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMz4kuLGVes6a4iCF0VbG1ErWPR5at=HKgeGv3cMr1zv7aLzJg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 12 September 2017 07:28 AM, Baolin Wang wrote:
>> @@ -802,13 +821,24 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>>         dev->clk = devm_clk_get(&pdev->dev, NULL);
>>         if (IS_ERR(dev->clk))
>>                 return PTR_ERR(dev->clk);
>> -       clk_prepare_enable(dev->clk);

> You removed clk enable here, I think it can not work if we did not
> open CONFIG_PM macro. I think you should keep clk enable here, and set

What do you mean by "open CONFIG_PM macro" ?

> rpm active by pm_runtime_set_active() before issuing
> pm_runtime_enable().

Can you explain why you want to do this instead of relying on
pm_runtime_get_sync() to enable clock?

Thanks,
Sekhar
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
