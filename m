From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] i2c: brcmstb: Allow enabling the driver on DSL SoCs
Date: Mon, 1 Oct 2018 21:13:09 +0300
Message-ID: <CAHp75Vd2js3QCJYjPDea5xapYLiOObSUF7_Q2hjG8RS=QYyPaQ@mail.gmail.com>
References: <20181001174349.26357-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001174349.26357-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kamal Dasu <kdasu.kdev@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jean Delvare <jdelvare@suse.de>, kramasub@codeaurora.org, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Eddie James <eajames@linux.vnet.ibm.com>, James Hogan <jhogan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 1, 2018 at 8:44 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> ARCH_BCM_63XX which is used by ARM-based DSL SoCs from Broadcom uses the
> same controller, make it possible to select the STB driver and update
> the Kconfig and help text a bit.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes in v2:
>
> - Make COMPILE_TEST last, as per Geert's recommendation
>
>  drivers/i2c/busses/Kconfig | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 451d4ae50e66..56ccb1ea7da5 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -432,12 +432,13 @@ config I2C_BCM_KONA
>           If you do not need KONA I2C interface, say N.
>
>  config I2C_BRCMSTB
> -       tristate "BRCM Settop I2C controller"
> -       depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
> +       tristate "BRCM Settop/DSL I2C controller"
> +       depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_63XX || \
> +                  COMPILE_TEST

I would rather split this to two 'depends' entries, though it's
cosmetic and up to you.

>         default y
>         help
>           If you say yes to this option, support will be included for the
> -         I2C interface on the Broadcom Settop SoCs.
> +         I2C interface on the Broadcom Settop/DSL SoCs.
>
>           If you do not need I2C interface, say N.
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
