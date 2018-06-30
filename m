From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 5/6] i2c: Add Actions Semiconductor Owl family S900 I2C driver
Date: Sun, 1 Jul 2018 00:11:00 +0300
Message-ID: <CAHp75VcVNb51tJzKbCU3pqf0XYPCUZWpv38nfaV1711vyf2S0Q@mail.gmail.com>
References: <20180630133330.23858-1-manivannan.sadhasivam@linaro.org> <20180630133330.23858-6-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180630133330.23858-6-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Linus Walleij <linus.walleij@linaro.org>, linux-i2c <linux-i2c@vger.kernel.org>, =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>, mp-cs@actions-semi.com, 96boards@ucrobotics.com, devicetree <devicetree@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, amit.kucheria@linaro.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, hzhang@ucrobotics.com, bdong@ucrobotics.com, Mani Sadhasivam <manivannanece23@gmail.com>, Thomas Liau <thomas.liau@actions-semi.com>, jeff.chen@actions-semi.com
List-Id: linux-i2c@vger.kernel.org

On Sat, Jun 30, 2018 at 4:33 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> Add Actions Semiconductor Owl family S900 I2C driver.

Thanks for an update. Few left comments and it would LGTM.

> +static int owl_i2c_reset(struct owl_i2c_dev *i2c_dev)
> +{

> +       mdelay(1);

But now, since it's not used in atomic context, we may switch to
usleep_range() / msleep() instead.

> +       owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> +                               OWL_I2C_CTL_EN, true);
> +

> +       /* Wait 50ms for FIFO reset complete */
> +       do {

> +               mdelay(1);

Especially in this case it's very important.

> +       } while (timeout++ < OWL_I2C_MAX_RETRIES);

> +}

> +       val = (i2c_dev->clk_rate + i2c_dev->bus_freq * 16 - 1) /
> +                               (i2c_dev->bus_freq * 16);

This is effectively DIV_ROUND_UP(->clk_rate, ->bus_freq * 16).

> +       /*
> +        * By default, 0 will be returned if interrupt occurred but no
> +        * read or write happened. Else if msg_ptr equals to message length,
> +        * message count will be returned.
> +        */

> +       if (i2c_dev->msg_ptr == msg->len)
> +               ret = num;

I dunno if

ret = ->msg_ptr == len ? num : 0;

would be slightly more explicit (yes, I aware about ret == 0).

Up to you to choose.

> +       /* We support only frequencies of 100k and 400k for now */
> +       if (i2c_dev->bus_freq != OWL_I2C_DEF_SPEED_HZ &&
> +                       i2c_dev->bus_freq > OWL_I2C_MAX_SPEED_HZ) {

I think it should be != in the second case as well.

> +               dev_err(dev, "invalid clock-frequency %d\n", i2c_dev->bus_freq);
> +               return -EINVAL;
> +       }

-- 
With Best Regards,
Andy Shevchenko
