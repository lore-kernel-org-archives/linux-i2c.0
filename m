From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] i2c: designware: add reset interface
Date: Wed, 04 Jan 2017 15:55:24 +0100
Message-ID: <2921529.fKUMSWjgsl@wuerfel>
References: <1482500451-30137-1-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:52484 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965195AbdADO41 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 4 Jan 2017 09:56:27 -0500
In-Reply-To: <1482500451-30137-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, p.zabel@pengutronix.de, linux-i2c@vger.kernel.org

On Friday, December 23, 2016 9:40:51 PM CET Zhangfei Gao wrote:
> @@ -176,6 +177,14 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>         dev->irq = irq;
>         platform_set_drvdata(pdev, dev);
>  
> +       dev->rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
> +       if (IS_ERR(dev->rst)) {
> +               if (PTR_ERR(dev->rst) == -EPROBE_DEFER)
> +                       return -EPROBE_DEFER;
> +       } else {
> +               reset_control_deassert(dev->rst);
> +       }
> +

Sorry for the late reply, I only now stumbled over this. I think it's
generally wrong to ignore any error aside from -EPROBE_DEFER. It's
better to single-out the error conditions you want to ignore (e.g.
no reset specified) and ignore those but return an error for
all other problems.

> @@ -270,10 +280,18 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>         }
>  
>         r = i2c_dw_probe(dev);
> -       if (r && !dev->pm_runtime_disabled)
> -               pm_runtime_disable(&pdev->dev);
> +       if (r)
> +               goto exit_probe;
>  
>         return r;
> +
> +exit_probe:
> +       if (!dev->pm_runtime_disabled)
> +               pm_runtime_disable(&pdev->dev);
> +exit_reset:
> +       if (!IS_ERR_OR_NULL(dev->rst))
> +               reset_control_assert(dev->rst);
> +       return r;
> 

try to avoid the IS_ERR_OR_NULL() check, it usually indicates either
a bad interface, or that the interface is used wrong.

In this case, I think we can't get here with a NULL dev->rst
pointer, so it's better to only check IS_ERR, or to explicitly
set the pointer to NULL in case there is no reset line.

	Arnd
