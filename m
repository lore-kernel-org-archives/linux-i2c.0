From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v3 1/8] i2c: i2c-qcom-geni: Provide support for ACPI
Date: Mon, 10 Jun 2019 10:44:19 +0200
Message-ID: <CAKv+Gu9UYQmPS0UxYztNTiFLYA1kqtL4HxttqFQovc26hffwmg@mail.gmail.com>
References: <20190610084213.1052-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610084213.1052-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alokc@codeaurora.org, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, wsa+renesas@sang-engineering.com, Bjorn Andersson <bjorn.andersson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, balbi@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jeffrey Hugo <jlhugo@gmail.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 10 Jun 2019 at 10:42, Lee Jones <lee.jones@linaro.org> wrote:
>
> Add a match table to allow automatic probing of ACPI device
> QCOM0220.  Ignore clock attainment errors.  Set default clock
> frequency value.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index db075bc0d952..9e3b8a98688d 100644
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
> @@ -483,6 +484,14 @@ static const struct i2c_algorithm geni_i2c_algo = {
>         .functionality  = geni_i2c_func,
>  };
>
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id geni_i2c_acpi_match[] = {
> +       { "QCOM0220"},
> +       { },
> +};
> +MODULE_DEVICE_TABLE(acpi, geni_i2c_acpi_match);
> +#endif
> +
>  static int geni_i2c_probe(struct platform_device *pdev)
>  {
>         struct geni_i2c_dev *gi2c;
> @@ -502,7 +511,7 @@ static int geni_i2c_probe(struct platform_device *pdev)
>                 return PTR_ERR(gi2c->se.base);
>
>         gi2c->se.clk = devm_clk_get(&pdev->dev, "se");
> -       if (IS_ERR(gi2c->se.clk)) {
> +       if (IS_ERR(gi2c->se.clk) && !has_acpi_companion(&pdev->dev)) {
>                 ret = PTR_ERR(gi2c->se.clk);
>                 dev_err(&pdev->dev, "Err getting SE Core clk %d\n", ret);
>                 return ret;
> @@ -516,6 +525,9 @@ static int geni_i2c_probe(struct platform_device *pdev)
>                 gi2c->clk_freq_out = KHZ(100);
>         }
>
> +       if (has_acpi_companion(&pdev->dev))
> +               ACPI_COMPANION_SET(&gi2c->adap.dev, ACPI_COMPANION(&pdev->dev));
> +
>         gi2c->irq = platform_get_irq(pdev, 0);
>         if (gi2c->irq < 0) {
>                 dev_err(&pdev->dev, "IRQ error for i2c-geni\n");
> @@ -660,6 +672,7 @@ static struct platform_driver geni_i2c_driver = {
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
