From: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: Add Spreadtrum I2C controller driver
Date: Wed, 21 Jun 2017 11:25:30 +0800
Message-ID: <20170621032529.GA1142@spreadtrum.com>
References: <7bc5c69030b6e491cfb2519eb1b21c1b0adc70c3.1497525667.git.baolin.wang@spreadtrum.com>
 <f3cdd27dcfa2ca6347502608928081fb9271c0b5.1497525667.git.baolin.wang@spreadtrum.com>
 <CAHp75Vf+qPa6i84yctSz+rAkim2owhX=zAsHsTF1EQRnouBwxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vf+qPa6i84yctSz+rAkim2owhX=zAsHsTF1EQRnouBwxg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Andy,

Sorry for late reply due to my business trip.

On 六,  6月 17, 2017 at 08:18:49下午 +0300, Andy Shevchenko wrote:
> On Thu, Jun 15, 2017 at 2:30 PM, Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org> wrote:
> > This patch adds the I2C controller driver for Spreadtrum platform.
> 
> 
> > +       i2c_dev->irq = platform_get_irq(pdev, 0);
> > +       if (i2c_dev->irq < 0) {
> > +               dev_err(&pdev->dev, "failed to get irq resource\n");
> 
> > +               return -ENXIO;
> 
> Why shadow actual error?

Sorry for missing this and will fix in next version.

> 
> > +       }
> 
> 
> > +       if (!of_property_read_u32(dev->of_node, "clock-frequency", &prop))
> > +               i2c_dev->bus_freq = prop;
> > +
> > +       sprd_i2c_clk_init(i2c_dev);
> > +       platform_set_drvdata(pdev, i2c_dev);
> > +
> > +       pm_runtime_set_autosuspend_delay(i2c_dev->dev, SPRD_I2C_PM_TIMEOUT);
> > +       pm_runtime_use_autosuspend(i2c_dev->dev);
> > +       pm_runtime_set_active(i2c_dev->dev);
> > +       pm_runtime_enable(i2c_dev->dev);
> > +
> > +       ret = pm_runtime_get_sync(i2c_dev->dev);
> > +       if (ret < 0) {
> > +               dev_err(&pdev->dev, "i2c%d pm runtime resume failed!\n",
> > +                       pdev->id);
> 
> > +               return ret;
> 
> goto error;

Yes, will fix it.

> 
> > +       }
> > +
> > +       ret = devm_request_threaded_irq(dev, i2c_dev->irq,
> > +               sprd_i2c_isr, sprd_i2c_isr_thread,
> > +               IRQF_NO_SUSPEND | IRQF_ONESHOT,
> > +               pdev->name, i2c_dev);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "failed to request irq %d\n", i2c_dev->irq);
> > +               goto error;
> > +       }
> > +
> > +       ret = i2c_add_numbered_adapter(&i2c_dev->adap);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "add adapter failed\n");
> > +               goto error;
> > +       }
> > +
> > +       pm_runtime_mark_last_busy(i2c_dev->dev);
> > +       pm_runtime_put_autosuspend(i2c_dev->dev);
> > +       return 0;
> > +
> > +error:
> > +       pm_runtime_put_noidle(i2c_dev->dev);
> > +       pm_runtime_disable(i2c_dev->dev);
> > +       return ret;
> > +}
> > +
> > +static int sprd_i2c_remove(struct platform_device *pdev)
> > +{
> > +       struct sprd_i2c *i2c_dev = platform_get_drvdata(pdev);
> > +       int ret;
> > +
> 
> > +       ret = pm_runtime_get_sync(i2c_dev->dev);
> > +       if (ret < 0)
> > +               return ret;
> 
> Does it make any sense? Doesn't device core power on the device before
> calling ->remove() ?

Yes, you are right. We need power on device in probe() function.

> 
> > +
> > +       i2c_del_adapter(&i2c_dev->adap);
> > +
> > +       if (!IS_ERR_OR_NULL(i2c_dev->clk))
> 
> _OR_NULL looks suspicious.

Since our ->clk can be NULL as one optional connfig in case we test I2C
driver on FPGA platform which does not support clock operation.

> 
> > +               clk_unprepare(i2c_dev->clk);
> > +
> > +       pm_runtime_put_noidle(i2c_dev->dev);
> > +       pm_runtime_disable(i2c_dev->dev);
> > +
> > +       return 0;
> > +}
> > +
> 
> > +#ifdef CONFIG_PM_SLEEP
> 
> __maybe_unused instead?

OK.

> 
> > +static int sprd_i2c_suspend_noirq(struct device *pdev)
> 
> > +static int sprd_i2c_resume_noirq(struct device *pdev)
> 
> > +#endif  /* CONFIG_PM_SLEEP */
> 
> > +#ifdef CONFIG_PM
> 
> Ditto.

OK.

> 
> > +static int sprd_i2c_runtime_suspend(struct device *pdev)
> 
> > +}
> 
> > +static int sprd_i2c_runtime_resume(struct device *pdev)
> > +{
> 
> > +       clk_prepare_enable(i2c_dev->clk);
> 
> This might fail.

Yes, will check return value.

> 
> 
> > +}
> > +#endif  /* CONFIG_PM */
> 
> 
> > +static struct platform_driver sprd_i2c_driver = {
> > +       .probe = sprd_i2c_probe,
> > +       .remove = sprd_i2c_remove,
> > +       .driver = {
> > +                  .name = "sprd-i2c",
> 
> > +                  .of_match_table = of_match_ptr(sprd_i2c_of_match),
> 
> of_match_ptr seems redundant.

OK.

> 
> > +                  .pm = &sprd_i2c_pm_ops,
> > +       },
> > +};
> > +
> 
> > +static int __init sprd_i2c_init(void)
> > +{
> > +       return platform_driver_register(&sprd_i2c_driver);
> > +}
> 
> > +arch_initcall_sync(sprd_i2c_init);
> 
> Why?

IN our Spreadtrum platform, our regulator driver will depend on I2C driver
and the regulator driver uses subsys_initcall() level to initialize. Moreover
some other drivers like GPU, they will depend on regulator to set voltage and
they also need initialization much earlier. Thanks for your comments.

> 
> -- 
> With Best Regards,
> Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
