From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] ANDROID: i2c: exynos5: remove default enable in Kconfig
Date: Thu, 5 Dec 2019 16:29:15 +0100
Message-ID: <CAJKOXPemBE2AHW4aju+SzvHA-rRCNwYhpHpG8ThsY_W2v1tzoA@mail.gmail.com>
References: <20191205150500.21762-1-hyunki00.koo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191205150500.21762-1-hyunki00.koo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hyunki Koo <hyunki00.koo@gmail.com>
Cc: wsa@the-dreams.de, Hyunki Koo <hyunki00.koo@samsung.com>, Jean Delvare <jdelvare@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Max Staudt <max@enpas.org>, Juergen Fitschen <jfi@ssv-embedded.de>, Elie Morisse <syniurge@gmail.com>, Stefan Roese <sr@denx.de>, Baolin Wang <baolin.wang@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 5 Dec 2019 at 16:05, Hyunki Koo <hyunki00.koo@gmail.com> wrote:
>
> From: Hyunki Koo <hyunki00.koo@samsung.com>
>
> There are many exynos device and not all exynos device does not have
> HSI2C controllers. Thus remove select this by default
>
> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> ---
>  drivers/i2c/busses/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

Thanks for the patch but this is not a proper solution because:
1. Basically you disabled this driver on exynos, multi_v7 and ARMv8 defconfigs.
2. We provide one kernel for all ARMv7 Exynos and one for all ARMv8
platforms therefore this driver should be there. Having unnecessary
driver also does not hurt - it will not match by compatible.

So really no.

Best regards,
Krzysztof

> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 6a0aa76859f3..3955315f48c7 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -612,7 +612,6 @@ config I2C_EMEV2
>  config I2C_EXYNOS5
>         tristate "Exynos5 high-speed I2C driver"
>         depends on ARCH_EXYNOS && OF
> -       default y
>         help
>           High-speed I2C controller on Exynos5 based Samsung SoCs.
>
> --
> 2.17.1
>
