From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 09/10] clk: Add support for AD242x clock output providers
Date: Mon, 23 Dec 2019 23:46:38 -0800
Message-ID: <20191224074639.1589220706@mail.kernel.org>
References: <20191209183511.3576038-1-daniel@zonque.org> <20191209183511.3576038-11-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191209183511.3576038-11-daniel@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mturquette@baylibre.com, robh+dt@kernel.org, broonie@kernel.org, lee.jones@linaro.org, lars@metafoo.de, pascal.huerst@gmail.com, Daniel Mack <daniel@zonque.org>
List-Id: linux-i2c@vger.kernel.org

Quoting Daniel Mack (2019-12-09 10:35:10)
> diff --git a/drivers/clk/clk-ad242x.c b/drivers/clk/clk-ad242x.c
> new file mode 100644
> index 000000000000..201789d8f174
> --- /dev/null
> +++ b/drivers/clk/clk-ad242x.c
> @@ -0,0 +1,231 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/clk.h>

Is this include used?

> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>

Is this include used?

> +#include <linux/mfd/ad242x.h>

Any way we can avoid this build dependency? Maybe just put defines in
this driver that deals with the clk bits of the device?

> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/adi,ad242x.h>
> +
> +#define AD242X_NUM_CLKS 2
> +
> +struct ad242x_clk_hw {
> +       struct clk_hw hw;
> +       struct clk_init_data init;

Do we need to keep around this init data after probe? I'd rather leave
this out.

> +       struct ad242x_node *node;

What's the point of this structure? Can we use dev->parent->regmap and
just store the struct regmap pointer here instead of using this custom
struct?

> +       u8 reg;
> +};
> +
> +struct ad242x_clk_driver_data {
> +       struct ad242x_clk_hw hw[AD242X_NUM_CLKS];

If this is the only drvdata, then I'd prefer just the array and not
another struct so we can have clarity.

> +};
> +
> +static inline struct ad242x_clk_hw *to_ad242x_clk(struct clk_hw *hw)
> +{
> +       return container_of(hw, struct ad242x_clk_hw, hw);
> +}
> +
[...]
> +
> +static long ad242x_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> +                                 unsigned long *parent_rate)
> +{
> +       unsigned long pll_rate =3D *parent_rate * 2048UL;
> +       unsigned long prediv, div;
> +
> +       if (rate > pll_rate / 4 || rate < pll_rate / 1024UL)
> +               return -EINVAL;

This callback should round the rate to something valid. If the rate is
larger than pll_rate / 4 then it should clamp to be the highest rate
supported. Likewise for something slow.

> +
> +       ad242x_do_div(rate, pll_rate, &prediv, &div);
> +
> +       return pll_rate / (prediv * div);
> +}
> +
[...]
> +
> +static struct clk_hw *
> +ad242x_of_clk_get(struct of_phandle_args *clkspec, void *data)
> +{
> +       struct ad242x_clk_driver_data *drvdata =3D data;
> +       unsigned int idx =3D clkspec->args[0];
> +
> +       return &drvdata->hw[idx].hw;

It looks quite a bit like of_clk_hw_onecell_get(). Can that be used? Or
at least check for out of bounds and return failure?

> +}
> +
> +static int ad242x_clk_probe(struct platform_device *pdev)
> +{
> +       const char *clk_names[AD242X_NUM_CLKS] =3D { "clkout1", "clkout2"=
 };
> +       u8 regs[AD242X_NUM_CLKS] =3D { AD242X_CLK1CFG, AD242X_CLK2CFG };
> +       struct ad242x_clk_driver_data *drvdata;
> +       struct device *dev =3D &pdev->dev;
> +       const char *sync_clk_name;
> +       struct ad242x_node *node;
> +       int i, ret;
> +
> +       if (!dev->of_node)
> +               return -ENODEV;

Please drop this. It's not useful.

> +
> +       drvdata =3D devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> +       if (!drvdata)
> +               return -ENOMEM;
> +
> +       node =3D dev_get_drvdata(dev->parent);

Add a NULL check on node?

> +       sync_clk_name =3D ad242x_master_get_clk_name(node->master);
> +
> +       for (i =3D 0; i < AD242X_NUM_CLKS; i++) {
> +               const char *name;
> +
> +               if (of_property_read_string_index(dev->of_node,
> +                                                 "clock-output-names",
> +                                                 i, &name) =3D=3D 0)
> +                       drvdata->hw[i].init.name =3D name;
> +               else
> +                       drvdata->hw[i].init.name =3D clk_names[i];

Do you need unique names? Or can you generate psuedo unique names based
on the device name and clk number?

> +
> +               drvdata->hw[i].reg =3D regs[i];
> +               drvdata->hw[i].init.ops =3D &ad242x_clk_ops;
> +               drvdata->hw[i].init.num_parents =3D 1;
> +               drvdata->hw[i].init.parent_names =3D &sync_clk_name;
> +               drvdata->hw[i].hw.init =3D &drvdata->hw[i].init;
> +               drvdata->hw[i].node =3D node;
> +
> +               ret =3D devm_clk_hw_register(dev, &drvdata->hw[i].hw);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       return devm_of_clk_add_hw_provider(dev, ad242x_of_clk_get, drvdat=
a);
> +}
