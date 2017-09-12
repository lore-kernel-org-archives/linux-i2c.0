From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v4 1/2] i2c: davinci: Add PM Runtime Support
Date: Tue, 12 Sep 2017 17:14:42 +0800
Message-ID: <CAMz4ku+_saDS8VBf1kXb+HMDqvx2O2o4qwcU4dEjFvtyE_9JKg@mail.gmail.com>
References: <20170911201145.31257-1-fcooper@ti.com> <20170911201145.31257-2-fcooper@ti.com>
 <CAMz4kuLGVes6a4iCF0VbG1ErWPR5at=HKgeGv3cMr1zv7aLzJg@mail.gmail.com> <021a99bb-3670-fff5-6835-b14d28827929@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:37239 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbdILJOn (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 12 Sep 2017 05:14:43 -0400
Received: by mail-io0-f181.google.com with SMTP id j141so42785053ioj.4
        for <linux-i2c@vger.kernel.org>; Tue, 12 Sep 2017 02:14:42 -0700 (PDT)
In-Reply-To: <021a99bb-3670-fff5-6835-b14d28827929@ti.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Franklin S Cooper Jr <fcooper@ti.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, linux@armlinux.org.uk, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, grygorii.strashko@ti.com, vigneshr@ti.com

Hi,

On 12 September 2017 at 16:48, Sekhar Nori <nsekhar@ti.com> wrote:
> On Tuesday 12 September 2017 07:28 AM, Baolin Wang wrote:
>>> @@ -802,13 +821,24 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>>>         dev->clk = devm_clk_get(&pdev->dev, NULL);
>>>         if (IS_ERR(dev->clk))
>>>                 return PTR_ERR(dev->clk);
>>> -       clk_prepare_enable(dev->clk);
>
>> You removed clk enable here, I think it can not work if we did not
>> open CONFIG_PM macro. I think you should keep clk enable here, and set
>
> What do you mean by "open CONFIG_PM macro" ?

If you did not open CONFIG_PM macro, then the pm_runtime_xxx() will be
dummy functions, but now the i2c driver can not work since you did not
enable clock, right?

>
>> rpm active by pm_runtime_set_active() before issuing
>> pm_runtime_enable().
>
> Can you explain why you want to do this instead of relying on
> pm_runtime_get_sync() to enable clock?

What I mean is you should compatible whether CONFIG_PM is enabled or not.

-- 
Baolin.wang
Best Regards
