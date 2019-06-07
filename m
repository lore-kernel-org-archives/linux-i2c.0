From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v2 1/8] i2c: i2c-qcom-geni: Provide support for ACPI
Date: Fri, 7 Jun 2019 13:08:25 +0200
Message-ID: <CAKv+Gu_SP7qBggCrVkF41BimV3PnCQXb5OUKyCsE0bBxa68RZA@mail.gmail.com>
References: <20190607082901.6491-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190607082901.6491-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alokc@codeaurora.org, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, wsa+renesas@sang-engineering.com, Bjorn Andersson <bjorn.andersson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, balbi@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Jeffrey Hugo <jlhugo@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 7 Jun 2019 at 10:29, Lee Jones <lee.jones@linaro.org> wrote:
>
> Add a match table to allow automatic probing of ACPI device
> QCOM0220.  Ignore clock attainment errors.  Set default clock
> frequency value.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index db075bc0d952..0fa93b448e8d 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
>
> +#include <linux/acpi.h>
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
> @@ -483,6 +484,12 @@ static const struct i2c_algorithm geni_i2c_algo = {
>         .functionality  = geni_i2c_func,
>  };
>
> +static const struct acpi_device_id geni_i2c_acpi_match[] = {
> +       { "QCOM0220"},
> +       { },
> +};
> +MODULE_DEVICE_TABLE(acpi, geni_i2c_acpi_match);
> +

We usually put #ifdef CONFIG_ACPI/#endif around these, otherwise you
end up with acpi:XXXX modaliases even though ACPI is not compiled in.

>  static int geni_i2c_probe(struct platform_device *pdev)
>  {
>         struct geni_i2c_dev *gi2c;
> @@ -502,7 +509,7 @@ static int geni_i2c_probe(struct platform_device *pdev)
>                 return PTR_ERR(gi2c->se.base);
>
>         gi2c->se.clk = devm_clk_get(&pdev->dev, "se");

Can we avoid this call altogether in ACPI mode? Also, please use
'has_acpi_companion()' to test whether we are probing via ACPI.

> -       if (IS_ERR(gi2c->se.clk)) {
> +       if (IS_ERR(gi2c->se.clk) && !ACPI_HANDLE(&pdev->dev)) {


>                 ret = PTR_ERR(gi2c->se.clk);
>                 dev_err(&pdev->dev, "Err getting SE Core clk %d\n", ret);
>                 return ret;
> @@ -510,12 +517,19 @@ static int geni_i2c_probe(struct platform_device *pdev)
>
>         ret = device_property_read_u32(&pdev->dev, "clock-frequency",
>                                                         &gi2c->clk_freq_out);
> -       if (ret) {
> +       if (ret && !ACPI_HANDLE(&pdev->dev)) {
>                 dev_info(&pdev->dev,
>                         "Bus frequency not specified, default to 100kHz.\n");
>                 gi2c->clk_freq_out = KHZ(100);
>         }
>
> +       if (ACPI_HANDLE(&pdev->dev)) {
> +               ACPI_COMPANION_SET(&gi2c->adap.dev, ACPI_COMPANION(&pdev->dev));
> +
> +               /* Using default, same as the !ACPI case above */
> +               gi2c->clk_freq_out = KHZ(100);
> +       }
> +

You are overriding the speed to 100 kHz even if the ACPI device has a
"clock-frequency" property.

>         gi2c->irq = platform_get_irq(pdev, 0);
>         if (gi2c->irq < 0) {
>                 dev_err(&pdev->dev, "IRQ error for i2c-geni\n");
> @@ -660,6 +674,7 @@ static struct platform_driver geni_i2c_driver = {
>                 .name = "geni_i2c",
>                 .pm = &geni_i2c_pm_ops,
>                 .of_match_table = geni_i2c_dt_match,
> +               .acpi_match_table = ACPI_PTR(geni_i2c_acpi_match),
>         },
>  };
>
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
