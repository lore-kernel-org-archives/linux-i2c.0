From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v5 1/2] i2c: Add Imagination Technologies I2C SCB driver
Date: Mon, 10 Nov 2014 12:53:41 -0800
Message-ID: <CAL1qeaEd-NeoC4Zc3u99WYSojr7HJVxmUweO6taBo8BhAxDJcQ@mail.gmail.com>
References: <1415647816-16415-1-git-send-email-ezequiel.garcia@imgtec.com>
	<1415647816-16415-2-git-send-email-ezequiel.garcia@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415647816-16415-2-git-send-email-ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Ezequiel,

On Mon, Nov 10, 2014 at 11:30 AM, Ezequiel Garcia
<ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org> wrote:
> From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>
> Add support for the IMG I2C Serial Control Bus (SCB) found on the
> Pistachio and TZ1090 SoCs.
>
> Signed-off-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> [Ezequiel: code cleaning and rebasing]
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

A few minor comments below, otherwise:

Reviewed-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c

> +/* Force a bus reset sequence and wait for it to complete */
> +static void img_i2c_reset_bus(struct img_i2c *i2c)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&i2c->lock, flags);
> +       reinit_completion(&i2c->msg_complete);
> +       img_i2c_reset_start(i2c);
> +       spin_unlock_irqrestore(&i2c->lock, flags);
> +
> +       wait_for_completion_timeout(&i2c->msg_complete, IMG_I2C_TOUT);

Check return value here?

> +static int img_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
> +                       int num)
> +{
> +       struct img_i2c *i2c = i2c_get_adapdata(i2c_adap);
> +       bool atomic = false;
> +       int i, ret;
> +
> +       if (i2c->mode == MODE_SUSPEND) {
> +               WARN(1, "refusing to service transaction in suspended state\n");
> +               return -EIO;
> +       }
> +
> +       if (i2c->mode == MODE_FATAL)
> +               return -EIO;
> +
> +       for (i = 0; i < num; i++) {
> +               if (likely(msgs[i].len))
> +                       continue;
> +               /*
> +                * 0 byte reads are not possible because the slave could try
> +                * and pull the data line low, preventing a stop bit.
> +                */
> +               if (unlikely(msgs[i].flags & I2C_M_RD))
> +                       return -EIO;
> +               /*
> +                * 0 byte writes are possible and used for probing, but we
> +                * cannot do them in automatic mode, so use atomic mode
> +                * instead.
> +                */
> +               atomic = true;
> +       }
> +
> +       ret = clk_prepare_enable(i2c->scb_clk);
> +       if (ret)
> +               return ret;
> +
> +       for (i = 0; i < num; i++) {
> +               struct i2c_msg *msg = &msgs[i];
> +               unsigned long flags;
> +
> +               spin_lock_irqsave(&i2c->lock, flags);
> +
> +               /*
> +                * Make a copy of the message struct. We mustn't modify the
> +                * original or we'll confuse drivers and i2c-dev.
> +                */
> +               i2c->msg = *msg;
> +               i2c->msg_status = 0;
> +
> +               /*
> +                * After the last message we must have waited for a stop bit.
> +                * Not waiting can cause problems when the clock is disabled
> +                * before the stop bit is sent, and the linux I2C interface
> +                * requires separate transfers not to joined with repeated
> +                * start.
> +                */
> +               i2c->last_msg = (i == num - 1);
> +               reinit_completion(&i2c->msg_complete);
> +
> +               if (atomic)
> +                       img_i2c_atomic_start(i2c);
> +               else if (msg->flags & I2C_M_RD)
> +                       img_i2c_read(i2c);
> +               else
> +                       img_i2c_write(i2c);
> +               spin_unlock_irqrestore(&i2c->lock, flags);
> +
> +               wait_for_completion_timeout(&i2c->msg_complete, IMG_I2C_TOUT);

... and here?

> +               del_timer_sync(&i2c->check_timer);
> +               if (i2c->msg_status)
> +                       break;
> +       }
> +
> +       clk_disable_unprepare(i2c->scb_clk);
> +
> +       return i2c->msg_status ? i2c->msg_status : num;
> +}

> +static int img_i2c_init(struct img_i2c *i2c)
> +{
> +       unsigned int clk_khz, bitrate_khz, clk_period, tckh, tckl, tsdh;
> +       unsigned int i, ret, data, prescale, inc, int_bitrate;
> +       unsigned int filt, filt_disable, filt_bypass;
> +       struct img_i2c_timings timing;
> +       u32 rev;
> +
> +       ret = clk_prepare_enable(i2c->scb_clk);
> +       if (ret)
> +               return ret;
> +
> +       rev = img_i2c_readl(i2c, SCB_CORE_REV_REG);
> +       if ((rev & 0x00ffffff) < 0x00020200) {
> +               dev_info(i2c->adap.dev.parent,
> +                        "Unknown hardware revision (%d.%d.%d.%d)\n",
> +                        (rev >> 24) & 0xff, (rev >> 16) & 0xff,
> +                        (rev >> 8) & 0xff, rev & 0xff);
> +               clk_disable_unprepare(i2c->scb_clk);
> +               return -EINVAL;
> +       }
> +
> +       if (rev == REL_SOC_IP_SCB_2_2_1)
> +               i2c->need_wr_rd_fence = true;
> +
> +       bitrate_khz = i2c->bitrate / 1000;
> +       clk_khz = clk_get_rate(i2c->scb_clk) / 1000;
> +
> +       /* Determine what mode we're in from the bitrate */
> +       timing = timings[0];
> +       for (i = 0; i < ARRAY_SIZE(timings); i++) {
> +               if (i2c->bitrate <= timings[i].max_bitrate) {
> +                       timing = timings[i];
> +                       break;
> +               }
> +       }
> +
> +       /* Find the prescale that would give us that inc (approx delay = 0) */
> +       prescale = SCB_OPT_INC * clk_khz / (256 * 16 * bitrate_khz);
> +       prescale = clamp_t(unsigned int, prescale, 1, 8);
> +       clk_khz /= prescale;
> +
> +       /* Setup the clock increment value */
> +       inc = ((256 * 16 * bitrate_khz) /
> +              (clk_khz - (16 * bitrate_khz * (clk_khz / 1000) *
> +                          i2c->busdelay) / 10000));
> +
> +       /* Setup the filter clock value */
> +       filt_bypass = 0;
> +       filt_disable = 0;
> +       filt = 0;
> +       if (clk_khz < 20000) {
> +               filt_disable = SCB_FILT_DISABLE;
> +       } else if (clk_khz < 40000) {
> +               filt_bypass = SCB_FILT_BYPASS;
> +       } else {
> +               /* Calculate filter clock */
> +               filt = ((640000) / ((clk_khz / 1000) * (250 - i2c->busdelay)));
> +               if ((640000) % ((clk_khz / 1000) * (250 - i2c->busdelay))) {
> +                       /* Scale up */
> +                       inc++;
> +               }
> +               if (filt > SCB_FILT_INC_MASK)
> +                       filt = SCB_FILT_INC_MASK;
> +       }
> +       data = filt_disable | filt_bypass |
> +              ((filt & SCB_FILT_INC_MASK) << SCB_FILT_INC_SHIFT) |
> +              ((inc & SCB_INC_MASK) << SCB_INC_SHIFT) |
> +              (prescale - 1);
> +       img_i2c_writel(i2c, SCB_CLK_SET_REG, data);

Do filt_bypass/filt_disable really need to be separate variables?
Can't we just use filt in all three cases?

> +#ifdef CONFIG_PM_SLEEP
> +static int img_i2c_suspend(struct device *dev)
> +{
> +       struct img_i2c *i2c = dev_get_drvdata(dev);
> +
> +       img_i2c_switch_mode(i2c, MODE_SUSPEND);
> +
> +       clk_disable(i2c->sys_clk);

Why not unprepare as well?

> +
> +       return 0;
> +}
> +
> +static int img_i2c_resume(struct device *dev)
> +{
> +       struct img_i2c *i2c = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = clk_enable(i2c->sys_clk);

... and then prepare here?

> +       if (ret)
> +               return ret;
> +
> +       img_i2c_init(i2c);
> +
> +       return 0;
> +}
> +#endif /* CONFIG_PM_SLEEP */
