From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] i2c: brcmstb: Allow enabling the driver on DSL SoCs
Date: Sat, 29 Sep 2018 09:55:08 +0200
Message-ID: <CAMuHMdVgpf2b8gOeygij7MGjTwxgBv8-Y0M5ggBBhNE0pS07pA@mail.gmail.com>
References: <20180928223947.20751-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928223947.20751-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kamal Dasu <kdasu.kdev@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jean Delvare <jdelvare@suse.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, M'boumba Cedric Madianga <cedric.madianga@gmail.com>, kramasub@codeaurora.org, Pierre-Yves MORDRET <pierre-yves.mordret@st.com>, eajames@linux.vnet.ibm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, manivannan.sadhasivam@linaro.org, Arnd Bergmann <arnd@arndb.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Florian,

On Sat, Sep 29, 2018 at 12:40 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> ARCH_BCM_63XX which is used by ARM-based DSL SoCs from Broadcom uses the
> same controller, make it possible to select the STB driver and update
> the Kconfig and help text a bit.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks for your patch!

> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -432,12 +432,13 @@ config I2C_BCM_KONA
>           If you do not need KONA I2C interface, say N.
>
>  config I2C_BRCMSTB
> -       tristate "BRCM Settop I2C controller"
> -       depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
> +       tristate "BRCM Settop/DSL I2C controller"
> +       depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST || \
> +                  ARCH_BCM_63XX

I think it would be good to keep the "|| COMPILE_TEST" as the last dependency.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
