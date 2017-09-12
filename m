From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v4 1/2] i2c: davinci: Add PM Runtime Support
Date: Tue, 12 Sep 2017 14:52:02 +0530
Message-ID: <d8ee0f47-fa69-3aca-6c5d-24f25505fa05@ti.com>
References: <20170911201145.31257-1-fcooper@ti.com>
 <20170911201145.31257-2-fcooper@ti.com>
 <CAMz4kuLGVes6a4iCF0VbG1ErWPR5at=HKgeGv3cMr1zv7aLzJg@mail.gmail.com>
 <021a99bb-3670-fff5-6835-b14d28827929@ti.com>
 <CAMz4ku+_saDS8VBf1kXb+HMDqvx2O2o4qwcU4dEjFvtyE_9JKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:49087 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751419AbdILJWl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 12 Sep 2017 05:22:41 -0400
In-Reply-To: <CAMz4ku+_saDS8VBf1kXb+HMDqvx2O2o4qwcU4dEjFvtyE_9JKg@mail.gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Franklin S Cooper Jr <fcooper@ti.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, linux@armlinux.org.uk, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, grygorii.strashko@ti.com, vigneshr@ti.com

On Tuesday 12 September 2017 02:44 PM, Baolin Wang wrote:
> Hi,
> 
> On 12 September 2017 at 16:48, Sekhar Nori <nsekhar@ti.com> wrote:
>> On Tuesday 12 September 2017 07:28 AM, Baolin Wang wrote:
>>>> @@ -802,13 +821,24 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>>>>         dev->clk = devm_clk_get(&pdev->dev, NULL);
>>>>         if (IS_ERR(dev->clk))
>>>>                 return PTR_ERR(dev->clk);
>>>> -       clk_prepare_enable(dev->clk);
>>
>>> You removed clk enable here, I think it can not work if we did not
>>> open CONFIG_PM macro. I think you should keep clk enable here, and set
>>
>> What do you mean by "open CONFIG_PM macro" ?
> 
> If you did not open CONFIG_PM macro, then the pm_runtime_xxx() will be
> dummy functions, but now the i2c driver can not work since you did not
> enable clock, right?

Ah, okay. I am not sure thats a concern on platforms on which this
driver is used. Without PM runtime support, most likely the platforms
will not boot and multiple drivers will fail.

Thanks,
Sekhar
