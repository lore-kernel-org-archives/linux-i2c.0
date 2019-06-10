From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 4/8] pinctrl: qcom: sdm845: Provide ACPI support
Date: Mon, 10 Jun 2019 10:22:45 +0100
Message-ID: <20190610092245.GN4797@dell>
References: <20190610084213.1052-1-lee.jones@linaro.org>
 <20190610084213.1052-4-lee.jones@linaro.org>
 <CAKv+Gu_s7i8JC4cv-dJMvm1_0cGzzhzf+Dxu0rxcF7iugF=vHg@mail.gmail.com>
 <20190610085542.GL4797@dell>
 <CAKv+Gu8rhxciy1cOG3B3pda9+p4R_COGrrqa7S_Rj9y2HeBxYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8rhxciy1cOG3B3pda9+p4R_COGrrqa7S_Rj9y2HeBxYw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: alokc@codeaurora.org, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, wsa+renesas@sang-engineering.com, Bjorn Andersson <bjorn.andersson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, balbi@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jeffrey Hugo <jlhugo@gmail.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 10 Jun 2019, Ard Biesheuvel wrote:

> On Mon, 10 Jun 2019 at 10:55, Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Mon, 10 Jun 2019, Ard Biesheuvel wrote:
> >
> > > On Mon, 10 Jun 2019 at 10:42, Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > This patch provides basic support for booting with ACPI instead
> > > > of the currently supported Device Tree.  When doing so there are a
> > > > couple of differences which we need to taken into consideration.
> > > >
> > > > Firstly, the SDM850 ACPI tables omit information pertaining to the
> > > > 4 reserved GPIOs on the platform.  If Linux attempts to touch/
> > > > initialise any of these lines, the firmware will restart the
> > > > platform.
> > > >
> > > > Secondly, when booting with ACPI, it is expected that the firmware
> > > > will set-up things like; Regulators, Clocks, Pin Functions, etc in
> > > > their ideal configuration.  Thus, the possible Pin Functions
> > > > available to this platform are not advertised when providing the
> > > > higher GPIOD/Pinctrl APIs with pin information.
> > > >
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > >
> > > For the ACPI probing boilerplate:
> > > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > >
> > > *However*, I really don't like hardcoding reserved GPIOs like this.
> > > What guarantee do we have that each and every ACPI system
> > > incorporating the QCOM0217 device has the exact same list of reserved
> > > GPIOs?
> >
> > This is SDM845 specific, so the chances are reduced.
> 
> You don't know that.

All the evidence I have to hand tells me that this is the case.  Even
on very closely related variants Qualcomm uses different H/W blocks
for GPIO.

> > However, if another SDM845 variant does crop up, also lacking the
> > "gpios" property, we will have to find another differentiating factor
> > between them and conduct some matching.  What else can you do with
> > platforms supporting non-complete/non-forthcoming ACPI tables?
> >
> 
> Either we don't touch any pins at all if they are not referenced
> explicitly anywhere

I guess this would require an API change, which is out of scope of
this patch-set.  Happy to change this implementation later if the
subsystem allows for it though.

> or we parse the PEP tables, which seem to cover
> some of this information (if Bjorn's analysis is correct)

Maybe someone can conduct some further work on this when we start to
enable or write a driver for the PEP (Windows-compatible System Power
Management Controller).  The tables for the PEP look pretty complex,
so this task would be extremely difficult if not impossible without
Qualcomm's help.  I wouldn't even know how to extrapolate this
information from the tables.

> (if Bjorn's analysis is correct)

Bjorn is about to provide his Reviewed-by for this implementation.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
