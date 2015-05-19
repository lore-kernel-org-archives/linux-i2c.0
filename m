From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [V3, 1/2] i2c: brcmstb: Add Broadcom settop SoC i2c controller driver
Date: Tue, 19 May 2015 12:25:48 -0400
Message-ID: <CAC=U0a1UhmLvMBK1SuV2m3Md5_ihFwpe-JWqRMDhO+N_ohs2bg@mail.gmail.com>
References: <1431536390-9761-1-git-send-email-kdasu.kdev@gmail.com>
	<555630DE.2090100@broadcom.com>
	<55563407.9070409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55563407.9070409-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Gregory Fong <gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list" <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, rajeev kumar <rajeevkumar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list" <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Ray,

"I don't think you answered my question on whether or not you can add
a dependency on COMPILE_TEST during the previous review."

 Added it.

" picky, but in alphabetical order, delay.h should be before device.h
there's an unexpected tab after #define. This was brought up in the
previous review but not addressed"

Fixed both the comments.

"Again, previous comment unanswered or addressed:
So you only allow an exact rate match? I think a round down of the
rate when not exactly matched might be sufficient?"

I prefer to use the exact rate match, to match what the hardware is
doing. Would like to keep it this way.

>+/* i2c xfer completion function, handles both irq and polling mode */
>+static int brcmstb_i2c_wait_for_completion(struct brcmstb_i2c_dev *dev)
>+{
>+       int ret = 0;
>+       unsigned long timeout = msecs_to_jiffies(I2C_TIMEOUT);
>+
+       if (dev->irq >= 0) {
>+               if (!wait_for_completion_timeout(&dev->done, timeout))

"I've mentioned this during the previous review. If timeout happens
and interrupt did not fire, you exit and leave the interrupt enabled.
This should be fixed."

Missed this one last time,  fixed this.

[snip]
> +            ret = -ETIMEDOUT;
> +    } else {
> +        /* we are in polling mode */
> +        u32 bsc_intrp;
> +        unsigned long time_left = jiffies + timeout;
> +
> +        do {
> +            bsc_intrp = bsc_readl(dev, iic_enable) &
> +                BSC_IIC_EN_INTRP_MASK;
> +            if (time_after(jiffies, time_left)) {
> +                ret = -ETIMEDOUT;
> +                break;
> +            }
> +            cpu_relax();
> +        } while (!bsc_intrp);
> +        brcmstb_i2c_enable_disable_irq(dev, INT_DISABLE);

"My question was, why do you need to disable interrupt in the end of
the polling loop? Do you use interrupt at all in polling mode? If so,
why?"

 Need to enable the level 2 interrupt else the interrupt does not fire
if I do not enable and have to clear it too.

>+       if (msg->flags & I2C_M_TEN) {
>+

"Redundant space. Again, I menioned this in the previous review."

Fixed this

"Previous question:
Why do you need a specific DT property to specify the interrupt name?
Why can't you simply set it to pdev->name?"

The pdev->name will have a format like this "f040a200.i2c", based on
how current device tree node is defined as shown in the binding
documentation. This is not helpful to the user. Hence I am using the
int name which is in readable form.

>+
>+       brcmstb_i2c_set_bsc_reg_defaults(dev);

"In the previous review, I asked you:
Don't you want to do this before calling i2c_add_adapter?"

You answered:
Will make the change.
But you did not make the change."

Will make sure I change it this time.

> +       dev_info(dev->device, "%s@%dhz registered in %s mode\n",
> +                int_name ? int_name : " ", dev->clk_freq_hz,
> +                (dev->irq >= 0) ? "interrupt" : "polling");
> +
> +       return 0;
> +
> +probe_errorout:
> +       kfree(dev->bsc_regmap);


"bsc_regmap is allocated by devm_kzalloc, so you don't need to free it here."

> +       return rc;
> +}
> +
> +static int brcmstb_i2c_remove(struct platform_device *pdev)
> +{
> +       struct brcmstb_i2c_dev *dev = platform_get_drvdata(pdev);
> +
> +       i2c_del_adapter(&dev->adapter);
> +       kfree(dev->bsc_regmap);

"No need to free bsc_regmap."

Removed the kfree(dev->bsc_regmap) from the above two places.

Thanks
Kamal
