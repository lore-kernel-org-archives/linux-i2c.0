From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] i2c: brcmstb: Allow enabling the driver on DSL SoCs
Date: Tue, 2 Oct 2018 12:22:24 +0200
Message-ID: <CAK8P3a22COa4YyWc7_pCSAy3TU0mne76RGwG8d73Aphad_ekwg@mail.gmail.com>
References: <20181001174349.26357-1-f.fainelli@gmail.com> <CAHp75Vd2js3QCJYjPDea5xapYLiOObSUF7_Q2hjG8RS=QYyPaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vd2js3QCJYjPDea5xapYLiOObSUF7_Q2hjG8RS=QYyPaQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kamal Dasu <kdasu.kdev@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, jarkko.nikula@linux.intel.com, Jean Delvare <jdelvare@suse.de>, kramasub@codeaurora.org, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, eajames@linux.vnet.ibm.com, James Hogan <jhogan@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 1, 2018 at 8:13 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Oct 1, 2018 at 8:44 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> >  config I2C_BRCMSTB
> > -       tristate "BRCM Settop I2C controller"
> > -       depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
> > +       tristate "BRCM Settop/DSL I2C controller"
> > +       depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_63XX || \
> > +                  COMPILE_TEST
>
> I would rather split this to two 'depends' entries, though it's
> cosmetic and up to you.

You can only split 'depends on A && B' into multiple lines, not
'depends on A || B'.

      Arnd
