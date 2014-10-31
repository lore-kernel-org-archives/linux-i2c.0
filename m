From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: Add Imagination Technologies I2C SCB driver
Date: Fri, 31 Oct 2014 14:17:31 -0700
Message-ID: <CAL1qeaEquLhpuSXd5=t9oEXi2iOArDbFFbfVrhOmyu70GR-z7w@mail.gmail.com>
References: <1414612641-4259-1-git-send-email-ezequiel.garcia@imgtec.com>
	<1414612641-4259-2-git-send-email-ezequiel.garcia@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414612641-4259-2-git-send-email-ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ezequiel,

> From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>
> Add support for the IMG I2C Serial Control Bus (SCB) found on the
> Pistachio and TZ1090 SoCs.
>
> Signed-off-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> [Ezequiel: code cleaning and rebasing]
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

Looks mostly good.  A few comments below.

> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
> new file mode 100644

> +#define INT_ENABLE_MASK_ATOMIC         (INT_TRANSACTION_DONE | \
> +                                        INT_SLAVE_EVENT      | \
> +                                        INT_ADDR_ACK_ERR     | \
> +                                        INT_WRITE_ACK_ERR    | \
> +                                        INT_ADDR_ACK_ERR)

INT_ADDR_ACK_ERR is repeated here.

> +/*
> + * Bits to return from interrupt handler functions for different modes.
> + * This delays completion until we've finished with the registers, so that the
> + * function waiting for completion can safely disable the clock to save power.
> + */
> +#define ISR_COMPLETE_M         0x80000000
> +#define ISR_FATAL_M            0x40000000
> +#define ISR_WAITSTOP           0x20000000
> +#define ISR_ATDATA_M           0x0ff00000
> +#define ISR_ATDATA_S           20
> +#define ISR_ATCMD_M            0x000f0000
> +#define ISR_ATCMD_S            16
> +#define ISR_STATUS_M           0x0000ffff      /* contains +ve errno */
> +#define ISR_COMPLETE(ERR)      (ISR_COMPLETE_M | (ISR_STATUS_M & (ERR)))
> +#define ISR_FATAL(ERR)         (ISR_COMPLETE(ERR) | ISR_FATAL_M)

Macro parameters are generally lower-case.

> +#define ISR_ATOMIC(CMD, DATA)  ((ISR_ATCMD_M & ((CMD) << ISR_ATCMD_S)) \
> +                               | (ISR_ATDATA_M & ((DATA) << ISR_ATDATA_S)))

What's the point of encoding the atomic command and data here?  I
don't see them being extracted from the return value anywhere.

> +struct img_i2c {
> +       struct i2c_adapter adap;
> +
> +       void __iomem *base;
> +
> +       /*
> +        * The clock is used to get the input frequency, and to disable it
> +        * after every set of transactions to save some power.
> +        */
> +       struct clk *clk;
> +       unsigned int bitrate;
> +       unsigned int busdelay;
> +       bool need_wr_rd_fence;
> +
> +       /* state */
> +       struct completion msg_complete;
> +       spinlock_t lock;        /* lock before doing anything with the state */
> +       struct i2c_msg msg;
> +
> +       /* After the last transaction, wait for a stop bit */
> +       bool last_msg;
> +       int msg_status;
> +
> +       enum img_i2c_mode mode;
> +       u32 int_enable;         /* depends on mode */
> +       u32 line_status;        /* line status over command */
> +
> +       /*
> +        * To avoid slave event interrupts in automatic mode, use a timer to
> +        * poll the abort condition if we don't get an interrupt for too long.
> +        */

Why would polling be better than taking the interrupt?  Are an
excessive number of interrupts generated during normal operation?

> +       struct timer_list check_timer;
> +       bool t_halt;
> +
> +       /* atomic mode state */
> +       bool at_t_done;
> +       bool at_slave_event;
> +       int at_cur_cmd;
> +       u8 at_cur_data;
> +
> +       /* Sequence: either reset or stop. See img_i2c_sequence. */
> +       u8 *seq;
> +
> +       /* raw mode */
> +       unsigned int raw_timeout;
> +};

> +static void img_i2c_writel(void __iomem *base, u32 offset, u32 value)
> +{
> +       writel(value, base + offset);
> +}
> +
> +static u32 img_i2c_readl(void __iomem *base, u32 offset)
> +{
> +       return readl(base + offset);
> +}

These don't really add anything if they require the base address.  It
would be more useful if they took a struct img_i2c and did the
dereference.

> +/*
> + * Timer function to check if something has gone wrong in automatic mode (so we
> + * don't have to handle so many interrupts just to catch an exception).
> + */
> +static void img_i2c_check_timer(unsigned long arg)

When are slave event interrupts generated during normal operation?
It's not clear from the TRM I have.

> +/* Force a bus reset sequence and wait for it to complete */
> +static void i2c_img_reset_bus(struct img_i2c *i2c)

Perhaps call this img_i2c_reset_bus() to match the convention the rest
of the file is using?

> +static int img_i2c_init(struct img_i2c *i2c)
> +{
> +       int opt_inc, data, prescale, inc, filt, clk_period, int_bitrate;
> +       int clk_khz, bitrate_khz, tckh, tckl, tsdh, i;

Most of these should be unsigned, I think.

> +       struct img_i2c_timings timing;
> +       u32 rev;
> +
> +       clk_prepare_enable(i2c->clk);
> +
> +       rev = img_i2c_readl(i2c->base, SCB_CORE_REV_REG);
> +       if ((rev & 0x00ffffff) < 0x00020200) {
> +               dev_info(i2c->adap.dev.parent,
> +                        "Unknown hardware revision (%d.%d.%d.%d)\n",
> +                        (rev >> 24) & 0xff, (rev >> 16) & 0xff,
> +                        (rev >> 8) & 0xff, rev & 0xff);
> +               clk_disable_unprepare(i2c->clk);
> +               return -EINVAL;
> +       }
> +
> +       if (rev == REL_SOC_IP_SCB_2_2_1)
> +               i2c->need_wr_rd_fence = true;
> +
> +       bitrate_khz = i2c->bitrate / 1000;
> +       clk_khz = clk_get_rate(i2c->clk) / 1000;
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
> +       /*
> +        * Worst incs are 1 (innacurate) and 16*256 (irregular).
> +        * So a sensible inc is the logarithmic mean: 64 (2^6), which is
> +        * in the middle of the valid range (0-127).
> +        */
> +       opt_inc = 64;
> +
> +       /* Find the prescale that would give us that inc (approx delay = 0) */
> +       prescale = opt_inc * clk_khz / (256 * 16 * bitrate_khz);
> +       if (prescale > 8)
> +               prescale = 8;
> +       else if (prescale < 1)
> +               prescale = 1;
> +       clk_khz /= prescale;
> +
> +       /* Setup the clock increment value */
> +       inc = ((256 * 16 * bitrate_khz) /
> +              (clk_khz - (16 * bitrate_khz * (clk_khz / 1000) *
> +                          i2c->busdelay) / 10000));
> +       /* Setup the filter clock value */
> +       if (clk_khz < 20000) {
> +               /* Filter disable */
> +               filt = 0x8000;
> +       } else if (clk_khz < 40000) {
> +               /* Filter bypass */
> +               filt = 0x4000;
> +       } else {
> +               /* Calculate filter clock */
> +               filt = ((640000) / ((clk_khz / 1000) *
> +                                   (250 - i2c->busdelay)));
> +               if ((640000) % ((clk_khz / 1000) *
> +                               (250 - i2c->busdelay))) {
> +                       /* Scale up */
> +                       inc++;
> +               }
> +               if (filt > 0x7f)
> +                       filt = 0x7f;
> +       }
> +       data = ((filt & 0xffff) << 16) | ((inc & 0x7f) << 8) | (prescale - 1);
> +       img_i2c_writel(i2c->base, SCB_CLK_SET_REG, data);

These masks and shifts should probably be #defines, as well as the
FILT_DISABLE and FILT_BYPASS bits.

> +static int i2c_img_probe(struct platform_device *pdev)
> +{
> +       struct device_node *node = pdev->dev.of_node;
> +       struct img_i2c *i2c;
> +       struct resource *res;
> +       int irq, ret;
> +       u32 val;
> +
> +       i2c = devm_kzalloc(&pdev->dev, sizeof(struct img_i2c), GFP_KERNEL);
> +       if (!i2c)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       i2c->base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(i2c->base))
> +               return PTR_ERR(i2c->base);
> +
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0) {
> +               dev_err(&pdev->dev, "can't get irq number\n");
> +               return irq;
> +       }
> +
> +       /*
> +        * Get the bus number from the devicetree. Other I2C adapters may be
> +        * reserved for non-Linux core. Instead of letting Linux pick any
> +        * number, it's useful to fix the bus number so users get a consistent
> +        * view.
> +        */
> +       ret = of_property_read_u32(node, "linux,i2c-index", &val);
> +       if (!ret)
> +               i2c->adap.nr = val;
> +       else
> +               i2c->adap.nr = pdev->id;
> +
> +       snprintf(i2c->adap.name, sizeof(i2c->adap.name),
> +                "IMG i2c%d", i2c->adap.nr);
> +
> +       i2c->clk = devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(i2c->clk)) {
> +               dev_err(&pdev->dev, "can't get clock\n");
> +               return PTR_ERR(i2c->clk);
> +       }
> +
> +       ret = devm_request_irq(&pdev->dev, irq, img_i2c_isr, 0,
> +                              pdev->name, i2c);
> +       if (ret) {
> +               dev_err(&pdev->dev, "can't request irq %d\n", irq);
> +               return ret;
> +       }
> +
> +       /* Set up the exception check timer */
> +       init_timer(&i2c->check_timer);
> +       i2c->check_timer.function = img_i2c_check_timer;
> +       i2c->check_timer.data = (unsigned long)i2c;
> +
> +       i2c->bitrate = timings[0].max_bitrate;
> +       if (!of_property_read_u32(node, "clock-frequency", &val))
> +               i2c->bitrate = val;
> +
> +       i2c->busdelay = 0;
> +       if (!of_property_read_u32(node, "bus-delay", &val))
> +               i2c->busdelay = val;

"bus-delay" does not appear to be a generic property.  It should
probably have an "img" prefix.

> +static struct platform_driver i2c_img_driver = {
> +       .driver = {
> +               .name           = "img-i2c-scb",
> +               .of_match_table = i2c_img_match,
> +               .pm             = &img_i2c_pm,
> +       },
> +       .probe = i2c_img_probe,
> +       .remove = i2c_img_remove,
> +};
> +
> +module_platform_driver(i2c_img_driver);

No newline before module_platform_driver().
