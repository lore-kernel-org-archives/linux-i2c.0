From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v2] i2c: aspeed: Deassert reset in probe
Date: Wed, 18 Oct 2017 10:40:28 -0700
Message-ID: <CAFd5g45H-FowZ7F2PnT1+iksTtUKLCT4JANM4fSgOjC3qrXKKw@mail.gmail.com>
References: <20171018142930.13052-1-joel@jms.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171018142930.13052-1-joel@jms.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Stanley <joel@jms.id.au>
Cc: Wolfram Sang <wsa@the-dreams.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 18, 2017 at 7:29 AM, Joel Stanley <joel@jms.id.au> wrote:
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
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2: Sort the headers
>
>  drivers/i2c/busses/i2c-aspeed.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 284f8670dbeb..a2006376322f 100644
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
> @@ -847,6 +850,9 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
>         /* We just need the clock rate, we don't actually use the clk object. */
>         devm_clk_put(&pdev->dev, parent_clk);
>
> +       bus->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
> +       reset_control_deassert(bus->rst);
> +
>         ret = of_property_read_u32(pdev->dev.of_node,
>                                    "bus-frequency", &bus->bus_frequency);
>         if (ret < 0) {
> @@ -919,6 +925,8 @@ static int aspeed_i2c_remove_bus(struct platform_device *pdev)
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
>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
