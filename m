From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/2] i2c: Add Spreadtrum I2C controller driver
Date: Sat, 17 Jun 2017 20:18:49 +0300
Message-ID: <CAHp75Vf+qPa6i84yctSz+rAkim2owhX=zAsHsTF1EQRnouBwxg@mail.gmail.com>
References: <7bc5c69030b6e491cfb2519eb1b21c1b0adc70c3.1497525667.git.baolin.wang@spreadtrum.com>
 <f3cdd27dcfa2ca6347502608928081fb9271c0b5.1497525667.git.baolin.wang@spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33687 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbdFQRSu (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 17 Jun 2017 13:18:50 -0400
In-Reply-To: <f3cdd27dcfa2ca6347502608928081fb9271c0b5.1497525667.git.baolin.wang@spreadtrum.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Baolin Wang <baolin.wang@spreadtrum.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Baolin Wang <baolin.wang@linaro.org>

On Thu, Jun 15, 2017 at 2:30 PM, Baolin Wang <baolin.wang@spreadtrum.com> wrote:
> This patch adds the I2C controller driver for Spreadtrum platform.


> +       i2c_dev->irq = platform_get_irq(pdev, 0);
> +       if (i2c_dev->irq < 0) {
> +               dev_err(&pdev->dev, "failed to get irq resource\n");

> +               return -ENXIO;

Why shadow actual error?

> +       }


> +       if (!of_property_read_u32(dev->of_node, "clock-frequency", &prop))
> +               i2c_dev->bus_freq = prop;
> +
> +       sprd_i2c_clk_init(i2c_dev);
> +       platform_set_drvdata(pdev, i2c_dev);
> +
> +       pm_runtime_set_autosuspend_delay(i2c_dev->dev, SPRD_I2C_PM_TIMEOUT);
> +       pm_runtime_use_autosuspend(i2c_dev->dev);
> +       pm_runtime_set_active(i2c_dev->dev);
> +       pm_runtime_enable(i2c_dev->dev);
> +
> +       ret = pm_runtime_get_sync(i2c_dev->dev);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "i2c%d pm runtime resume failed!\n",
> +                       pdev->id);

> +               return ret;

goto error;

> +       }
> +
> +       ret = devm_request_threaded_irq(dev, i2c_dev->irq,
> +               sprd_i2c_isr, sprd_i2c_isr_thread,
> +               IRQF_NO_SUSPEND | IRQF_ONESHOT,
> +               pdev->name, i2c_dev);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to request irq %d\n", i2c_dev->irq);
> +               goto error;
> +       }
> +
> +       ret = i2c_add_numbered_adapter(&i2c_dev->adap);
> +       if (ret) {
> +               dev_err(&pdev->dev, "add adapter failed\n");
> +               goto error;
> +       }
> +
> +       pm_runtime_mark_last_busy(i2c_dev->dev);
> +       pm_runtime_put_autosuspend(i2c_dev->dev);
> +       return 0;
> +
> +error:
> +       pm_runtime_put_noidle(i2c_dev->dev);
> +       pm_runtime_disable(i2c_dev->dev);
> +       return ret;
> +}
> +
> +static int sprd_i2c_remove(struct platform_device *pdev)
> +{
> +       struct sprd_i2c *i2c_dev = platform_get_drvdata(pdev);
> +       int ret;
> +

> +       ret = pm_runtime_get_sync(i2c_dev->dev);
> +       if (ret < 0)
> +               return ret;

Does it make any sense? Doesn't device core power on the device before
calling ->remove() ?

> +
> +       i2c_del_adapter(&i2c_dev->adap);
> +
> +       if (!IS_ERR_OR_NULL(i2c_dev->clk))

_OR_NULL looks suspicious.

> +               clk_unprepare(i2c_dev->clk);
> +
> +       pm_runtime_put_noidle(i2c_dev->dev);
> +       pm_runtime_disable(i2c_dev->dev);
> +
> +       return 0;
> +}
> +

> +#ifdef CONFIG_PM_SLEEP

__maybe_unused instead?

> +static int sprd_i2c_suspend_noirq(struct device *pdev)

> +static int sprd_i2c_resume_noirq(struct device *pdev)

> +#endif  /* CONFIG_PM_SLEEP */

> +#ifdef CONFIG_PM

Ditto.

> +static int sprd_i2c_runtime_suspend(struct device *pdev)

> +}

> +static int sprd_i2c_runtime_resume(struct device *pdev)
> +{

> +       clk_prepare_enable(i2c_dev->clk);

This might fail.


> +}
> +#endif  /* CONFIG_PM */


> +static struct platform_driver sprd_i2c_driver = {
> +       .probe = sprd_i2c_probe,
> +       .remove = sprd_i2c_remove,
> +       .driver = {
> +                  .name = "sprd-i2c",

> +                  .of_match_table = of_match_ptr(sprd_i2c_of_match),

of_match_ptr seems redundant.

> +                  .pm = &sprd_i2c_pm_ops,
> +       },
> +};
> +

> +static int __init sprd_i2c_init(void)
> +{
> +       return platform_driver_register(&sprd_i2c_driver);
> +}

> +arch_initcall_sync(sprd_i2c_init);

Why?

-- 
With Best Regards,
Andy Shevchenko
