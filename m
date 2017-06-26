From: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
Subject: Re: [PATCH v2 2/2] i2c: Add Spreadtrum I2C controller driver
Date: Mon, 26 Jun 2017 17:29:27 +0800
Message-ID: <20170626092927.GB19042@spreadtrum.com>
References: <7bc5c69030b6e491cfb2519eb1b21c1b0adc70c3.1498029380.git.baolin.wang@spreadtrum.com>
 <01e8aa0450b294c0a9b4aeefcf99f35ced953fc9.1498029380.git.baolin.wang@spreadtrum.com>
 <CAHp75Vem3mG6BW4WdPOZAXz+m+2ANeJ8qiS5GH1z-BYUnTq9Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vem3mG6BW4WdPOZAXz+m+2ANeJ8qiS5GH1z-BYUnTq9Og-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Andy,

On 日,  6月 25, 2017 at 06:06:44下午 +0300, Andy Shevchenko wrote:
> On Wed, Jun 21, 2017 at 10:23 AM, Baolin Wang
> <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org> wrote:
> > This patch adds the I2C controller driver for Spreadtrum platform.
> 
> Needs more work.
> See my comments below.
> 
> 
> 
> > +#include <linux/init.h>
> 
> > +#include <linux/module.h>
> 
> Since your answer to the comment about arch_initcall you perhaps need
> to get rid of tristate (use bool) and drop module.h here and all
> leftovers like MODULE_*() calls.

Will remove them in next version.

> 
> > +#include <linux/slab.h>
> 
> Should we include this still explicitly (after kernel.h)?

Will remove it.

> 
> > +
> > +#define I2C_CTL                        0x0
> > +#define I2C_ADDR_CFG           0x4
> > +#define I2C_COUNT              0x8
> > +#define I2C_RX                 0xC
> > +#define I2C_TX                 0x10
> > +#define I2C_STATUS             0x14
> > +#define I2C_HSMODE_CFG         0x18
> > +#define I2C_VERSION            0x1C
> > +#define ADDR_DVD0              0x20
> > +#define ADDR_DVD1              0x24
> > +#define ADDR_STA0_DVD          0x28
> > +#define ADDR_RST               0x2C
> 
> 1. Please, use fixed sized values
> 0x00 and so on.
> 2. Please, low case.

OK.

> 
> > +#define SPRD_I2C_TIMEOUT       (msecs_to_jiffies(1000))
> 
> Redundant parens.

OK.

> 
> > +static void sprd_i2c_dump_reg(struct sprd_i2c *i2c_dev)
> 
> If you switch your driver to regmap API, you may drop this function completely.

Now we have no use to switch i2c driver to regmap API and we really need
these registers info to debug I2C driver when we met something wrong. So
I think I should still keep this function for debugging.

> 
> > +               writel(tmp & (~STP_EN), i2c_dev->base + I2C_CTL);
> 
> Redundant parens.
> Also pay attention to other similar places.

OK, Will check the whole file.

> 
> 
> > +static void sprd_i2c_write_bytes(struct sprd_i2c *i2c_dev, u8 *buf, u32 len)
> 
> So, isn't better to provide a writesb(), readsb() to ia64 instead of
> doing below?

When I change to writesb/readsb, it will compile failed on my x86 platform.
So I guess I should still keep writeb/readb now.

> 
> > +{
> > +       u32 i = 0;
> > +
> > +       for (i = 0; i < len; i++) {
> > +               writel(buf[i], i2c_dev->base + I2C_TX);
> 
> > +               dev_dbg(&i2c_dev->adap.dev, "write bytes[%d] = %x\n", i, buf[i]);
> 
> Moreover, don't waste lines in the kernel log buffer by doing this.
> Choose either
> 
> %*ph (up to 64 bytes)
> 
> or
> 
> print_hex_dump()
> 
> (Same for _read_bytes() below)

OK.

> 
> > +       }
> > +}
> 
> > +static void sprd_i2c_set_full_thld(struct sprd_i2c *i2c_dev, u32 full_thld)
> > +{
> > +       unsigned int tmp = readl(i2c_dev->base + I2C_CTL);
> > +
> > +       tmp &= ~(0xf << FIFO_AF_LVL);
> 
> Magic.
> Define it using GENMASK()

OK. Will use GENMASK instead of magic number.

> 
> > +       tmp |= (full_thld << FIFO_AF_LVL);
> 
> Redundant parens.

OK.

> 
> > +       tmp &= ~(0xf << FIFO_AE_LVL);
> > +       tmp |= (empty_thld << FIFO_AE_LVL);
> 
> Same.

OK.

> 
> > +static void sprd_i2c_opt_mode(struct sprd_i2c *i2c_dev, int rw)
> > +{
> > +       unsigned int cmd = readl(i2c_dev->base + I2C_CTL) & (~I2C_MODE);
> 
> Redundant parens.

OK.

> 
> > +       writel((cmd | rw << 3), i2c_dev->base + I2C_CTL);
> 
> Ditto.
> 
> It's a C, and not a LISP :-)

OK.

> 
> > +}
> 
> > +static void sprd_i2c_data_transfer(struct sprd_i2c *i2c_dev)
> > +{
> 
> > +       if ((msg->flags & I2C_M_RD)) {
> 
> Redundant parens.

Will remove it.

> 
> > +       /* Reset rx/tx fifos */
> 
> Noise.
> 
> > +       /* Set device address */
> 
> Ditto.
> 
> > +       /* Set I2C read or write bytes count */
> 
> Ditto.
> 
> > +       if ((msg->flags & I2C_M_RD)) {
> > +               /* Set read operation */
> > +               sprd_i2c_opt_mode(i2c_dev, 1);
> > +               /* Last byte transmission should excute stop operation */
> > +               sprd_i2c_send_stop(i2c_dev, 1);
> 
> Same comments as above.

Will remove theese reduandant comments.

> 
> > +       } else {
> 
> > +               /* Set write operation */
> 
> Noise.
> 
> > +               /* Last byte transmission should excute stop operation */
> > +               if (is_last_msg)
> > +                       sprd_i2c_send_stop(i2c_dev, 1);
> > +               else
> > +                       sprd_i2c_send_stop(i2c_dev, 0);
> 
>     sprd_i2c_send_stop(i2c_dev, !!is_last_msg);
> 
> Though, consider to make is_last_msg boolean.

OK.

> 
> > +static int sprd_i2c_master_xfer(struct i2c_adapter *i2c_adap,
> > +                               struct i2c_msg *msgs, int num)
> > +{
> > +       struct sprd_i2c *i2c_dev = i2c_adap->algo_data;
> > +       int im, ret;
> > +
> > +       ret = pm_runtime_get_sync(i2c_dev->dev);
> > +       if (ret < 0)
> > +               return ret;
> > +
> 
> > +       for (im = 0; im != num; im++)
> 
> im < num - 1, and...
> 
>         ret = sprd_i2c_handle_msg(i2c_adap, &msgs[im], 0);
> ... ret = sprd_i2c_handle_msg(i2c_adap, &msgs[im++], 1);
> 
> ...and we clearly see that you have messed up with returned code on
> each itteration here

Yes, will re-check and modify this loop.

> 
> > +       pm_runtime_mark_last_busy(i2c_dev->dev);
> > +       pm_runtime_put_autosuspend(i2c_dev->dev);
> 
> 
> > +       return (ret >= 0) ? im : ret;
> 
> Usual pattern is
> ret < 0 ? ret : im;

OK.

> 
> 
> > +static void sprd_i2c_set_clk(struct sprd_i2c *i2c_dev, unsigned int freq)
> > +{
> > +       u32 apb_clk = i2c_dev->src_clk;
> > +       u32 i2c_dvd = apb_clk / (4 * freq) - 1;
> > +       u32 high = ((i2c_dvd << 1) * 2) / 5;
> > +       u32 low = ((i2c_dvd << 1) * 3) / 5;
> 
> > +       u32 div0 = (high & 0xffff) << 16 | (low & 0xffff);
> > +       u32 div1 =  (high & 0xffff0000) | ((low & 0xffff0000) >> 16);
> 
> Magic masks all over.
> 
> Also it needs a comment what formula is used and how.

Will add comments to explain the formula.

> 
> > +
> > +       writel(div0, i2c_dev->base + ADDR_DVD0);
> > +       writel(div1, i2c_dev->base + ADDR_DVD1);
> > +
> 
> > +       if (freq == 400000)
> > +               writel((6 * apb_clk) / 10000000, i2c_dev->base + ADDR_STA0_DVD);
> > +       else if (freq == 100000)
> > +               writel((4 * apb_clk) / 1000000, i2c_dev->base + ADDR_STA0_DVD);
> 
> What about 3400000?
> 
> What about the rest of the speeds, shouldn't you return an error from here?

Now we only support 100000 and 400000, otherwise will be error. I will check this
in probe() function.

> 
> > +}
> > +
> > +static void sprd_i2c_enable(struct sprd_i2c *i2c_dev)
> > +{
> > +       unsigned int tmp = readl(i2c_dev->base + I2C_CTL);
> > +
> > +       tmp &= ~(I2C_EN | I2C_TRIM_OPT | (0xF << FIFO_AF_LVL) |
> > +                (0xF << FIFO_AE_LVL));
> 
> Magic masks (I saw them already above).

OK.

> 
> 
> > +       /* Set rx fifo full data threshold */
> 
> Drop noise comments. They don't bring any value since you have nice
> function names.

OK.

> 
> > +       sprd_i2c_set_full_thld(i2c_dev, I2C_FIFO_FULL_THLD);
> > +       /* Set tx fifo empty data threshold */
> > +       sprd_i2c_set_empty_thld(i2c_dev, I2C_FIFO_EMPTY_THLD);
> > +
> > +       sprd_i2c_set_clk(i2c_dev, i2c_dev->bus_freq);
> > +       /* Reset rx/tx fifo */
> > +       sprd_i2c_reset_fifo(i2c_dev);
> > +       sprd_i2c_clear_irq(i2c_dev);
> 
> > +static int sprd_i2c_clk_init(struct sprd_i2c *i2c_dev)
> > +{
> > +       struct clk *clk_i2c, *clk_parent;
> > +       struct device_node *np = i2c_dev->adap.dev.of_node;
> > +
> 
> > +       clk_i2c = of_clk_get_by_name(np, "i2c");
> 
> What the issue to use resource agnostic API here, i.e. devm_clk_get() ?

You are right, and will replace with devm_clk_get().

> 
> > +       clk_parent = of_clk_get_by_name(np, "source");
> 
> Ditto.
> 
> > +       i2c_dev->clk = of_clk_get_by_name(np, "enable");
> 
> Ditto.
> 
> > +       if (!of_property_read_u32(dev->of_node, "clock-frequency", &prop))
> > +               i2c_dev->bus_freq = prop;
> > +
> > +       sprd_i2c_clk_init(i2c_dev);
> > +       platform_set_drvdata(pdev, i2c_dev);
> > +
> > +       ret = clk_prepare_enable(i2c_dev->clk);
> > +       if (ret)
> > +               return ret;
> > +
> > +       sprd_i2c_enable(i2c_dev);
> > +
> 
> > +error:
> 
> I would put it as
> 
> err_rpm_put:

OK. Very appreciate for your helpful comments. Thanks a lot.

> 
> > +       pm_runtime_put_noidle(i2c_dev->dev);
> > +       pm_runtime_disable(i2c_dev->dev);
> > +       clk_disable_unprepare(i2c_dev->clk);
> > +       return ret;
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
