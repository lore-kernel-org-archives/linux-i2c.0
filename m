From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] i2c: brcmstb: Allow enabling the driver on DSL SoCs
Date: Tue, 2 Oct 2018 13:27:53 +0300
Message-ID: <CAHp75Vf_daFqLZ+aYRRAR_6ZZKH2==r1+6Dc51MUpx1VSW3QKA@mail.gmail.com>
References: <20181001174349.26357-1-f.fainelli@gmail.com> <CAHp75Vd2js3QCJYjPDea5xapYLiOObSUF7_Q2hjG8RS=QYyPaQ@mail.gmail.com>
 <CAK8P3a22COa4YyWc7_pCSAy3TU0mne76RGwG8d73Aphad_ekwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a22COa4YyWc7_pCSAy3TU0mne76RGwG8d73Aphad_ekwg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kamal Dasu <kdasu.kdev@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jean Delvare <jdelvare@suse.de>, kramasub@codeaurora.org, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Eddie James <eajames@linux.vnet.ibm.com>, James Hogan <jhogan@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Oct 2, 2018 at 1:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Oct 1, 2018 at 8:13 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Oct 1, 2018 at 8:44 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > >
> > >  config I2C_BRCMSTB
> > > -       tristate "BRCM Settop I2C controller"
> > > -       depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
> > > +       tristate "BRCM Settop/DSL I2C controller"
> > > +       depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_63XX || \
> > > +                  COMPILE_TEST
> >
> > I would rather split this to two 'depends' entries, though it's
> > cosmetic and up to you.
>
> You can only split 'depends on A && B' into multiple lines, not
> 'depends on A || B'.

Indeed. What I was thinking of?

-- 
With Best Regards,
Andy Shevchenko
