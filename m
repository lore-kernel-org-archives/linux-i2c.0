From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH v3] i2c: aspeed: Deassert reset in probe
Date: Mon, 30 Oct 2017 17:09:21 +0100
Message-ID: <CA+gwMccgGGNctf0iJb6548amRxUMxBUxrMDN8LvMmcx-LSqRsw@mail.gmail.com>
References: <20171030034438.26482-1-joel@jms.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:50200 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751475AbdJ3QJX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 30 Oct 2017 12:09:23 -0400
In-Reply-To: <20171030034438.26482-1-joel@jms.id.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Joel Stanley <joel@jms.id.au>
Cc: Wolfram Sang <wsa@the-dreams.de>, Brendan Higgins <brendanhiggins@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Mon, Oct 30, 2017 at 4:44 AM, Joel Stanley <joel@jms.id.au> wrote:
> In order to use i2c from a cold boot, the i2c peripheral must be taken
> out of reset. We request a shared reset controller each time a bus
> driver is loaded, as the reset is shared between the 14 i2c buses.
>
> On remove the reset is asserted, which only touches the hardware once
> the last i2c bus is removed.
>
> The request is optional, so if a device tree does not specify a reset
> controller (or the driver is not built in), the driver continues to
> probe.
>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v3: Check for bad reset controller probe (caused by eg. bad device tree)
>     and set ->rst to NULL so assert/desassert does not cause a warning to
>     be printed
> v2: Sort the headers
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 284f8670dbeb..5dec00d663eb 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -12,6 +12,7 @@
>
>  #include <linux/clk.h>
>  #include <linux/completion.h>
> +#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/i2c.h>
> @@ -27,6 +28,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>
>  /* I2C Register */
> @@ -132,6 +134,7 @@ struct aspeed_i2c_bus {
>         struct i2c_adapter              adap;
>         struct device                   *dev;
>         void __iomem                    *base;
> +       struct reset_control            *rst;
>         /* Synchronizes I/O mem access to base. */
>         spinlock_t                      lock;
>         struct completion               cmd_complete;
> @@ -847,6 +850,13 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
>         /* We just need the clock rate, we don't actually use the clk object. */
>         devm_clk_put(&pdev->dev, parent_clk);
>
> +       bus->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
> +       if (IS_ERR(bus->rst)) {
> +               dev_err(&pdev->dev, "invalid reset controller in device tree");
> +               bus->rst = NULL;
> +       } else
> +               reset_control_deassert(bus->rst);

devm_reset_control_get_optional_shared returns NULL if no reset is
given in the device tree,
and reset_control_deassert will just ignore a NULL parameter. I would
suggest to change this to:

        bus->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
        if (IS_ERR(bus->rst)) {
                dev_err(&pdev->dev, "invalid reset controller in device tree");
                return PTR_ERR(bus->rst);
        }
        reset_control_deassert(bus->rst);

> +
>         ret = of_property_read_u32(pdev->dev.of_node,
>                                    "bus-frequency", &bus->bus_frequency);
>         if (ret < 0) {
> @@ -919,6 +929,8 @@ static int aspeed_i2c_remove_bus(struct platform_device *pdev)
>
>         i2c_del_adapter(&bus->adap);
>
> +       reset_control_assert(bus->rst);
> +
>         return 0;
>  }
>
> --
> 2.14.1

regards
Philipp
