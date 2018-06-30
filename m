From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 5/6] i2c: Add Actions Semi OWL family S900 I2C driver
Date: Sat, 30 Jun 2018 15:14:37 +0300
Message-ID: <CAHp75Vd__qOXVxZTdxREwD6p1sEw49R2Kqb+esAmr_EhtT=gFg@mail.gmail.com>
References: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org> <20180628181042.2239-6-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180628181042.2239-6-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Linus Walleij <linus.walleij@linaro.org>, linux-i2c <linux-i2c@vger.kernel.org>, =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>, mp-cs@actions-semi.com, 96boards@ucrobotics.com, devicetree <devicetree@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, amit.kucheria@linaro.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, hzhang@ucrobotics.com, bdong@ucrobotics.com, Mani Sadhasivam <manivannanece23@gmail.com>, Thomas Liau <thomas.liau@actions-semi.com>, jeff.chen@actions-semi.com
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 28, 2018 at 9:10 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> Add Actions Semi OWL family S900 I2C driver.

> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>

> +#include <linux/io.h>

Perhaps keep in order?

> +#define OWL_I2C_DEFAULT_SPEED  100000
> +#define OWL_I2C_MAX_SPEED      400000

..._SPEED -> ..._SPEED_HZ ?

DEFAULT -> DEF ?

> +static int owl_i2c_reset(struct owl_i2c_dev *i2c_dev)
> +{
> +       unsigned int val, timeout = 0;
> +
> +       owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +                               OWL_I2C_CTL_EN, false);

> +       mdelay(1);

1 ms keeping CPU busy for nothing. Perhaps usleep_range() / msleep()?
Is it called in atomic context?

> +       owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +                               OWL_I2C_CTL_EN, true);
> +
> +       /* Reset FIFO */
> +       owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_FIFOCTL,
> +                               OWL_I2C_FIFOCTL_RFR | OWL_I2C_FIFOCTL_TFR,
> +                               true);
> +
> +       /* Wait 50ms for FIFO reset complete */
> +       do {
> +               val = readl(i2c_dev->base + OWL_I2C_REG_FIFOCTL);
> +               if (!(val & (OWL_I2C_FIFOCTL_RFR | OWL_I2C_FIFOCTL_TFR)))
> +                       break;

> +               mdelay(1);

Ditto.

> +       } while (timeout++ < OWL_I2C_MAX_RETRIES);

OK, I see you call it from IRQ context. 50ms for IRQ handler is
inappropriate. (1ms either, but at least not so drastically).

> +}

> +static irqreturn_t owl_i2c_interrupt(int irq, void *_dev)
> +{

> +       stat = readl(i2c_dev->base + OWL_I2C_REG_STAT);
> +       if (stat & OWL_I2C_STAT_BEB) {
> +               dev_dbg(&i2c_dev->adap.dev, "bus error");

> +               owl_i2c_reset(i2c_dev);

This is questionable to be here (looking at so loong delays in it).

> +               goto stop;
> +       }

> +       return IRQ_HANDLED;
> +}

> +static int owl_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> +                               int num)
> +{

> +       int ret = 0, idx;

Redundant assignment.

> +       ret = owl_i2c_hw_init(i2c_dev);
> +       if (ret)
> +               return ret;

> +}

> +static const struct i2c_algorithm owl_i2c_algorithm = {
> +       .master_xfer    = owl_i2c_master_xfer,

> +       .functionality  = owl_i2c_func

Slightly better to keep comma at the end

> +};
> +
> +static const struct i2c_adapter_quirks owl_i2c_quirks = {
> +       .flags          = I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST,
> +       .max_read_len   = 240,
> +       .max_write_len  = 240,
> +       .max_comb_1st_msg_len = 6,
> +       .max_comb_2nd_msg_len = 240

Ditto.

> +};

-- 
With Best Regards,
Andy Shevchenko
