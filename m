From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] i2c: designware-platdrv: get fast/std speed scl high/low
 count from DT
Date: Thu, 7 Apr 2016 21:05:35 +0300
Message-ID: <CAHp75VcHNdAUeob2iR6U1HbUQzEccdjPy8ffuG4mB_=ZX7EokQ@mail.gmail.com>
References: <1459927680-5480-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33821 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757147AbcDGSFg (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 7 Apr 2016 14:05:36 -0400
In-Reply-To: <1459927680-5480-1-git-send-email-jszhang@marvell.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, ijc+devicetree <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>

On Wed, Apr 6, 2016 at 10:28 AM, Jisheng Zhang <jszhang@marvell.com> wrote:
> Sometimes, it's convenient to define the scl's high/low count directly,
> e.g HW people would do some measurement then directly give out the
> optimum counts. Previously, we solved the sda falling time and scl
> falling time by i2c_dw_scl_hcnt() and i2c_dw_scl_lcnt(), then put them
> into dt, but what we really care isn't the sda/scl falling time.
>
> From another side, the dw_i2c_acpi_configure() on ACPI platform also
> get hcnt/lcnt values rather than the sda/scl falling time from ACPI
> method, we want similar feature for DT platforms.
>

Instead of duplicating some words maybe better to explicitly define
two groups of parameters and one which supersedes the other.

> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-designware.txt | 16 ++++++++++++++++
>  drivers/i2c/busses/i2c-designware-platdrv.c              |  8 ++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> index fee26dc..05176fbf 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> @@ -20,6 +20,22 @@ Optional properties :
>   - i2c-sda-falling-time-ns : should contain the SDA falling time in nanoseconds.
>     This value which is by default 300ns is used to compute the tHIGH period.
>
> + - i2c-ss-scl-high-count : should contain the standard speed i2c clock SCL high
> +   count. If defined, the i2c-scl-falling-time-ns and i2c-sda-falling-time-ns
> +   will be ignored.
> +
> + - i2c-ss-scl-low-count : should contain the standard speed i2c clock SCL low
> +   count. If defined, the i2c-scl-falling-time-ns and i2c-sda-falling-time-ns
> +   will be ignored.
> +
> + - i2c-fs-scl-high-count : should contain the fast speed i2c clock SCL high
> +   count. If defined, the i2c-scl-falling-time-ns and i2c-sda-falling-time-ns
> +   will be ignored.
> +
> + - i2c-fs-scl-low-count : should contain the fast speed i2c clock SCL low
> +   count. If defined, the i2c-scl-falling-time-ns and i2c-sda-falling-time-ns
> +   will be ignored.
> +
>  Example :
>
>         i2c@f0000 {
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index d656657..8739a60 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -188,6 +188,14 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>                                          &dev->scl_falling_time);
>                 device_property_read_u32(&pdev->dev, "clock-frequency",
>                                          &clk_freq);
> +               device_property_read_u16(&pdev->dev, "i2c-ss-scl-high-count",
> +                                        &dev->ss_hcnt);
> +               device_property_read_u16(&pdev->dev, "i2c-ss-scl-low-count",
> +                                        &dev->ss_lcnt);
> +               device_property_read_u16(&pdev->dev, "i2c-fs-scl-high-count",
> +                                        &dev->fs_hcnt);
> +               device_property_read_u16(&pdev->dev, "i2c-fs-scl-low-count",
> +                                        &dev->fs_lcnt);
>         }
>
>         if (has_acpi_companion(&pdev->dev))
> --
> 2.8.0.rc3
>



-- 
With Best Regards,
Andy Shevchenko
