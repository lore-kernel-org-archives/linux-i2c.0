From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [v2] ACPI: support for NXP i2c controller
Date: Fri, 6 Sep 2019 13:31:56 +0300
Message-ID: <CAHp75Vcz+ruwvq_yu6Oj69XTezsdnne049Ma=oTRPjRXJKnhPQ@mail.gmail.com>
References: <20190906075319.21244-1-biwen.li@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190906075319.21244-1-biwen.li@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Biwen Li <biwen.li@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Leo Li <leoyang.li@nxp.com>, Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>, Udit Kumar <udit.kumar@nxp.com>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Chuanhua Han <chuanhua.han@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Sep 6, 2019 at 11:03 AM Biwen Li <biwen.li@nxp.com> wrote:
>
> From: Chuanhua Han <chuanhua.han@nxp.com>
>
> Enable NXP i2c controller to boot with ACPI
>

Thanks, the code looks good to me,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

though...

> Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Signed-off-by: Udit Kumar <udit.kumar@nxp.com>
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>

This SoB chain is a bit odd. Who is the author of this? The first SoB
in the chain usually points to the first (main) author. There is also
possible to change that, though in that case for the rest we now use
Co-developed-by tag rather than SoB.
In any case, if Rafael and Wolfram are okay with this, I have no objections.

> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
> Change in v2:
>         - Simplify code
>         - Adjust header file order
>         - Not use ACPI_PTR()
>
>  drivers/acpi/acpi_apd.c      |  7 +++++++
>  drivers/i2c/busses/i2c-imx.c | 17 +++++++++++++----
>  2 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> index 7cd0c9ac71ea..71511ae2dfcd 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -160,11 +160,17 @@ static const struct apd_device_desc hip08_i2c_desc = {
>         .setup = acpi_apd_setup,
>         .fixed_clk_rate = 250000000,
>  };
> +
>  static const struct apd_device_desc thunderx2_i2c_desc = {
>         .setup = acpi_apd_setup,
>         .fixed_clk_rate = 125000000,
>  };
>
> +static const struct apd_device_desc nxp_i2c_desc = {
> +       .setup = acpi_apd_setup,
> +       .fixed_clk_rate = 350000000,
> +};
> +
>  static const struct apd_device_desc hip08_spi_desc = {
>         .setup = acpi_apd_setup,
>         .fixed_clk_rate = 250000000,
> @@ -238,6 +244,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
>         { "HISI02A1", APD_ADDR(hip07_i2c_desc) },
>         { "HISI02A2", APD_ADDR(hip08_i2c_desc) },
>         { "HISI0173", APD_ADDR(hip08_spi_desc) },
> +       { "NXP0001", APD_ADDR(nxp_i2c_desc) },
>  #endif
>         { }
>  };
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 15f6cde6452f..a3b61336fe55 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -20,6 +20,7 @@
>   *
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/delay.h>
> @@ -255,6 +256,12 @@ static const struct of_device_id i2c_imx_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, i2c_imx_dt_ids);
>
> +static const struct acpi_device_id i2c_imx_acpi_ids[] = {
> +       {"NXP0001", .driver_data = (kernel_ulong_t)&vf610_i2c_hwdata},
> +       { }
> +};
> +MODULE_DEVICE_TABLE(acpi, i2c_imx_acpi_ids);
> +
>  static inline int is_imx1_i2c(struct imx_i2c_struct *i2c_imx)
>  {
>         return i2c_imx->hwdata->devtype == IMX1_I2C;
> @@ -1048,14 +1055,13 @@ static const struct i2c_algorithm i2c_imx_algo = {
>
>  static int i2c_imx_probe(struct platform_device *pdev)
>  {
> -       const struct of_device_id *of_id = of_match_device(i2c_imx_dt_ids,
> -                                                          &pdev->dev);
>         struct imx_i2c_struct *i2c_imx;
>         struct resource *res;
>         struct imxi2c_platform_data *pdata = dev_get_platdata(&pdev->dev);
>         void __iomem *base;
>         int irq, ret;
>         dma_addr_t phy_addr;
> +       const struct imx_i2c_hwdata *match;
>
>         dev_dbg(&pdev->dev, "<%s>\n", __func__);
>
> @@ -1075,8 +1081,9 @@ static int i2c_imx_probe(struct platform_device *pdev)
>         if (!i2c_imx)
>                 return -ENOMEM;
>
> -       if (of_id)
> -               i2c_imx->hwdata = of_id->data;
> +       match = device_get_match_data(&pdev->dev);
> +       if (match)
> +               i2c_imx->hwdata = match;
>         else
>                 i2c_imx->hwdata = (struct imx_i2c_hwdata *)
>                                 platform_get_device_id(pdev)->driver_data;
> @@ -1089,6 +1096,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
>         i2c_imx->adapter.nr             = pdev->id;
>         i2c_imx->adapter.dev.of_node    = pdev->dev.of_node;
>         i2c_imx->base                   = base;
> +       ACPI_COMPANION_SET(&i2c_imx->adapter.dev, ACPI_COMPANION(&pdev->dev));
>
>         /* Get I2C clock */
>         i2c_imx->clk = devm_clk_get(&pdev->dev, NULL);
> @@ -1247,6 +1255,7 @@ static struct platform_driver i2c_imx_driver = {
>                 .name = DRIVER_NAME,
>                 .pm = &i2c_imx_pm_ops,
>                 .of_match_table = i2c_imx_dt_ids,
> +               .acpi_match_table = i2c_imx_acpi_ids,
>         },
>         .id_table = imx_i2c_devtype,
>  };
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
