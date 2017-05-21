From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] i2c: designware: don't infer timings described by ACPI
 from clock rate
Date: Sun, 21 May 2017 08:09:16 +0000
Message-ID: <CAKv+Gu9x_KCdEGBBOw9yaYOcYBcYtxJX-xTX=4kQuWqY=VK0PA@mail.gmail.com>
References: <20170519085640.15111-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:37234 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751983AbdEUIJX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 21 May 2017 04:09:23 -0400
Received: by mail-it0-f46.google.com with SMTP id g126so65555223ith.0
        for <linux-i2c@vger.kernel.org>; Sun, 21 May 2017 01:09:17 -0700 (PDT)
In-Reply-To: <20170519085640.15111-1-ard.biesheuvel@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On 19 May 2017 at 09:56, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Commit bd698d24b1b57 ("i2c: designware: Get selected speed mode
> sda-hold-time via ACPI") updated the logic that reads the timing
> parameters for various I2C bus rates from the DSDT, to only read
> the timing parameters for the currently selected mode.
>
> This causes a WARN_ON() splat on platforms that legally omit the clock
> frequency from the ACPI description, because in the new situation, the
> core I2C designware driver still accesses the fields in the driver
> struct that we no longer populate, and proceeds to calculate them from
> the clock frequency. Since the clock frequency is unspecified, the
> driver complains loudly using a WARN_ON().
>
> So revert back to the old situation, where the struct fields for all
> timings are populated, but retain the new logic which chooses the SDA
> hold time from the timing mode that is currently in use.
>
> Fixes: bd698d24b1b57 ("i2c: designware: Get selected speed mode ...")
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index f2acd4b6bf01..6283b99d2b17 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -96,6 +96,7 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
>         struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
>         acpi_handle handle = ACPI_HANDLE(&pdev->dev);
>         const struct acpi_device_id *id;
> +       u32 ss_ht, fp_ht, hs_ht, fs_ht;

Should these be initialized to zero? I realized that
dw_i2c_acpi_params() could fail, resulting in bogus hold time values
being returnted, but it is unclear to me how that affects the logic in
the core driver.

>         struct acpi_device *adev;
>         const char *uid;
>
> @@ -107,23 +108,24 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
>          * Try to get SDA hold time and *CNT values from an ACPI method for
>          * selected speed modes.
>          */
> +       dw_i2c_acpi_params(pdev, "SSCN", &dev->ss_hcnt, &dev->ss_lcnt, &ss_ht);
> +       dw_i2c_acpi_params(pdev, "FPCN", &dev->fp_hcnt, &dev->fp_lcnt, &fp_ht);
> +       dw_i2c_acpi_params(pdev, "HSCN", &dev->hs_hcnt, &dev->hs_lcnt, &hs_ht);
> +       dw_i2c_acpi_params(pdev, "FMCN", &dev->fs_hcnt, &dev->fs_lcnt, &fs_ht);
> +
>         switch (dev->clk_freq) {
>         case 100000:
> -               dw_i2c_acpi_params(pdev, "SSCN", &dev->ss_hcnt, &dev->ss_lcnt,
> -                                  &dev->sda_hold_time);
> +               dev->sda_hold_time = ss_ht;
>                 break;
>         case 1000000:
> -               dw_i2c_acpi_params(pdev, "FPCN", &dev->fp_hcnt, &dev->fp_lcnt,
> -                                  &dev->sda_hold_time);
> +               dev->sda_hold_time = fp_ht;
>                 break;
>         case 3400000:
> -               dw_i2c_acpi_params(pdev, "HSCN", &dev->hs_hcnt, &dev->hs_lcnt,
> -                                  &dev->sda_hold_time);
> +               dev->sda_hold_time = hs_ht;
>                 break;
>         case 400000:
>         default:
> -               dw_i2c_acpi_params(pdev, "FMCN", &dev->fs_hcnt, &dev->fs_lcnt,
> -                                  &dev->sda_hold_time);
> +               dev->sda_hold_time = fs_ht;
>                 break;
>         }
>
> --
> 2.9.3
>
