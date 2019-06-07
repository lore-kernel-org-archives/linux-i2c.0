From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v2 4/8] pinctrl: qcom: sdm845: Provide ACPI support
Date: Fri, 7 Jun 2019 13:12:36 +0200
Message-ID: <CAKv+Gu85kHUDYPDkYVLmZ2pq22wtKP-+8vPUX7qsV_2TixWcFA@mail.gmail.com>
References: <20190607082901.6491-1-lee.jones@linaro.org> <20190607082901.6491-4-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190607082901.6491-4-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alokc@codeaurora.org, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, wsa+renesas@sang-engineering.com, Bjorn Andersson <bjorn.andersson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, balbi@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Jeffrey Hugo <jlhugo@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 7 Jun 2019 at 10:30, Lee Jones <lee.jones@linaro.org> wrote:
>
> This patch provides basic support for booting with ACPI instead
> of the currently supported Device Tree.  When doing so there are a
> couple of differences which we need to taken into consideration.
>
> Firstly, the SDM850 ACPI tables omit information pertaining to the
> 4 reserved GPIOs on the platform.  If Linux attempts to touch/
> initialise any of these lines, the firmware will restart the
> platform.
>
> Secondly, when booting with ACPI, it is expected that the firmware
> will set-up things like; Regulators, Clocks, Pin Functions, etc in
> their ideal configuration.  Thus, the possible Pin Functions
> available to this platform are not advertised when providing the
> higher GPIOD/Pinctrl APIs with pin information.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pinctrl/qcom/Kconfig          |  2 +-
>  drivers/pinctrl/qcom/pinctrl-sdm845.c | 35 ++++++++++++++++++++++++++-
>  2 files changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 2e66ab72c10b..aafbe932424f 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -168,7 +168,7 @@ config PINCTRL_SDM660
>
>  config PINCTRL_SDM845
>         tristate "Qualcomm Technologies Inc SDM845 pin controller driver"
> -       depends on GPIOLIB && OF
> +       depends on GPIOLIB && (OF || ACPI)
>         select PINCTRL_MSM
>         help
>           This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> index c97f20fca5fd..7188bee3cf3e 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> @@ -1277,6 +1278,10 @@ static const struct msm_pingroup sdm845_groups[] = {
>         UFS_RESET(ufs_reset, 0x99f000),
>  };
>
> +static const int sdm845_acpi_reserved_gpios[] = {
> +       0, 1, 2, 3, 81, 82, 83, 84, -1
> +};
> +
>  static const struct msm_pinctrl_soc_data sdm845_pinctrl = {
>         .pins = sdm845_pins,
>         .npins = ARRAY_SIZE(sdm845_pins),
> @@ -1284,14 +1289,41 @@ static const struct msm_pinctrl_soc_data sdm845_pinctrl = {
>         .nfunctions = ARRAY_SIZE(sdm845_functions),
>         .groups = sdm845_groups,
>         .ngroups = ARRAY_SIZE(sdm845_groups),
> +       .reserved_gpios = sdm845_acpi_reserved_gpios,
> +       .ngpios = 150,
> +};
> +
> +static const struct msm_pinctrl_soc_data sdm845_acpi_pinctrl = {
> +       .pins = sdm845_pins,
> +       .npins = ARRAY_SIZE(sdm845_pins),
> +       .groups = sdm845_groups,
> +       .ngroups = ARRAY_SIZE(sdm845_groups),
> +       .reserved_gpios = sdm845_acpi_reserved_gpios,
>         .ngpios = 150,
>  };
>
>  static int sdm845_pinctrl_probe(struct platform_device *pdev)
>  {
> -       return msm_pinctrl_probe(pdev, &sdm845_pinctrl);
> +       int ret;
> +
> +       if (pdev->dev.of_node) {
> +               ret = msm_pinctrl_probe(pdev, &sdm845_pinctrl);
> +       } else if (ACPI_HANDLE(&pdev->dev)) {

Please use has_acpi_companion() here

> +               ret = msm_pinctrl_probe(pdev, &sdm845_acpi_pinctrl);
> +       } else {
> +               dev_err(&pdev->dev, "DT and ACPI disabled\n");
> +               return -EINVAL;
> +       }
> +
> +       return ret;
>  }
>
> +static const struct acpi_device_id sdm845_pinctrl_acpi_match[] = {
> +       { "QCOM0217"},
> +       { },
> +};
> +MODULE_DEVICE_TABLE(acpi, sdm845_pinctrl_acpi_match);
> +

Put this in a #ifdef CONFIG_ACPI please

>  static const struct of_device_id sdm845_pinctrl_of_match[] = {
>         { .compatible = "qcom,sdm845-pinctrl", },
>         { },
> @@ -1302,6 +1334,7 @@ static struct platform_driver sdm845_pinctrl_driver = {
>                 .name = "sdm845-pinctrl",
>                 .pm = &msm_pinctrl_dev_pm_ops,
>                 .of_match_table = sdm845_pinctrl_of_match,
> +               .acpi_match_table = ACPI_PTR(sdm845_pinctrl_acpi_match),
>         },
>         .probe = sdm845_pinctrl_probe,
>         .remove = msm_pinctrl_remove,
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
