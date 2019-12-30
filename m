From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 5/5] i2c: Enable compile testing for some of drivers
Date: Mon, 30 Dec 2019 20:11:03 +0100
Message-ID: <CAMuHMdUXJo3=x32xbfSUXs3O3JHaFpfxt0mHupEb+vzi=5+S4g@mail.gmail.com>
References: <20191230172751.17985-1-krzk@kernel.org>
 <20191230172751.17985-5-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191230172751.17985-5-krzk@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vladimir Zapolskiy <vz@mleia.com>, Max Staudt <max@enpas.org>, Elie Morisse <syniurge@gmail.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Linux I2C <linux-i2c@vger.kernel.org>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Juergen Fitschen <jfi@ssv-embedded.de>, Jean Delvare <jdelvare@suse.de>
List-Id: linux-i2c@vger.kernel.org

Hi Krzysztof,

On Mon, Dec 30, 2019 at 6:28 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Some of the I2C bus drivers can be compile tested to increase build
> coverage.  This requires also:
> 1. Adding dependencies on COMMON_CLK for BCM2835 and Meson I2C
>    controllers,
> 2. Adding 'if' conditional to 'default y' so they will not get enabled
>    by default on all other architectures,
> 3. Limiting few compile test options to supported architectures (which
>    provide the readsX()/writesX() primitives).
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks for your patch!

> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -367,7 +367,7 @@ comment "I2C system bus drivers (mostly embedded / system-on-chip)"
>
>  config I2C_ALTERA
>         tristate "Altera Soft IP I2C"
> -       depends on (ARCH_SOCFPGA || NIOS2) && OF
> +       depends on (ARCH_SOCFPGA || NIOS2 || COMPILE_TEST) && OF

Might be easier to read and maintain by splitting in "hard" and "useful"
dependencies:

    depends on OF
    depends on ARCH_SOCFPGA || NIOS2 || COMPILE_TEST

> @@ -611,8 +612,8 @@ config I2C_EMEV2
>
>  config I2C_EXYNOS5
>         tristate "Exynos5 high-speed I2C driver"
> -       depends on ARCH_EXYNOS && OF
> -       default y
> +       depends on (ARCH_EXYNOS && OF) || COMPILE_TEST

This means it is only useful on DT-based Exynos platforms, but compiles
everywhere?

Do you still have support for non-DT Exynos platforms?
ARCH_EXYNOS depends on ARCH_MULTI_V7?
(and its help text mentions Exynos 4/5 only, no 3?)

> @@ -1055,15 +1057,15 @@ config I2C_SYNQUACER
>
>  config I2C_TEGRA
>         tristate "NVIDIA Tegra internal I2C controller"
> -       depends on ARCH_TEGRA
> +       depends on ARCH_TEGRA || (COMPILE_TEST && (ARC || ARM || ARM64 || M68K || RISCV || SUPERH || SPARC))

Perhaps

    depends on ARCH_TEGRA || COMPILE_TEST
    depends on ARC || ARM || ARM64 || M68K || RISCV || SUPERH || SPARC
# needs <foo>

to remember which <foo> feature is needed?

> @@ -1403,8 +1405,8 @@ config I2C_OPAL
>
>  config I2C_ZX2967
>         tristate "ZTE ZX2967 I2C support"
> -       depends on ARCH_ZX
> -       default y
> +       depends on ARCH_ZX || (COMPILE_TEST && (ARC || ARM || ARM64 || M68K || RISCV || SUPERH || SPARC))

Same here/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
