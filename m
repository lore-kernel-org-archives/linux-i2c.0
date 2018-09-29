From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] i2c: brcmstb: Allow enabling the driver on DSL SoCs
Date: Sat, 29 Sep 2018 13:37:13 -0700
Message-ID: <34253924-54D8-4CB1-822E-21123EB503CA@gmail.com>
References: <20180928223947.20751-1-f.fainelli@gmail.com> <CAMuHMdVgpf2b8gOeygij7MGjTwxgBv8-Y0M5ggBBhNE0pS07pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVgpf2b8gOeygij7MGjTwxgBv8-Y0M5ggBBhNE0pS07pA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kamal Dasu <kdasu.kdev@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jean Delvare <jdelvare@suse.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, M'boumba Cedric Madianga <cedric.madianga@gmail.com>, kramasub@codeaurora.org, Pierre-Yves MORDRET <pierre-yves.mordret@st.com>, eajames@linux.vnet.ibm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, manivannan.sadhasivam@linaro.org, Arnd Bergmann <arnd@arndb.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org



On September 29, 2018 12:55:08 AM PDT, Geert Uytterhoeven <geert@linux-m68=
k=2Eorg> wrote:
>Hi Florian,
>
>On Sat, Sep 29, 2018 at 12:40 AM Florian Fainelli
><f=2Efainelli@gmail=2Ecom> wrote:
>> ARCH_BCM_63XX which is used by ARM-based DSL SoCs from Broadcom uses
>the
>> same controller, make it possible to select the STB driver and update
>> the Kconfig and help text a bit=2E
>>
>> Signed-off-by: Florian Fainelli <f=2Efainelli@gmail=2Ecom>
>
>Thanks for your patch!
>
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -432,12 +432,13 @@ config I2C_BCM_KONA
>>           If you do not need KONA I2C interface, say N=2E
>>
>>  config I2C_BRCMSTB
>> -       tristate "BRCM Settop I2C controller"
>> -       depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
>> +       tristate "BRCM Settop/DSL I2C controller"
>> +       depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST || \
>> +                  ARCH_BCM_63XX
>
>I think it would be good to keep the "|| COMPILE_TEST" as the last
>dependency=2E

Makes sense, v2 coming, thank you!
--=20
Florian
