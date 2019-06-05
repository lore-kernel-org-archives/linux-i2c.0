From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/8] pinctrl: qcom: sdm845: Provide ACPI support
Date: Wed, 5 Jun 2019 20:35:44 +0100
Message-ID: <20190605193544.GX4797@dell>
References: <20190604104455.8877-1-lee.jones@linaro.org>
 <20190604104455.8877-4-lee.jones@linaro.org>
 <20190605061721.GK22737@tuxbook-pro>
 <20190605073133.GL4797@dell>
 <20190605190614.GI4814@minitux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190605190614.GI4814@minitux>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: alokc@codeaurora.org, kramasub@codeaurora.org, andy.gross@linaro.org, david.brown@linaro.org, wsa+renesas@sang-engineering.com, linus.walleij@linaro.org, balbi@kernel.org, gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, jlhugo@gmail.com, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 05 Jun 2019, Bjorn Andersson wrote:

> On Wed 05 Jun 00:31 PDT 2019, Lee Jones wrote:
> 
> > On Tue, 04 Jun 2019, Bjorn Andersson wrote:
> > 
> > > On Tue 04 Jun 03:44 PDT 2019, Lee Jones wrote:
> > > 
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
> > > > ---
> > > >  drivers/pinctrl/qcom/Kconfig          |  2 +-
> > > >  drivers/pinctrl/qcom/pinctrl-sdm845.c | 35 ++++++++++++++++++++++++++-
> > > >  2 files changed, 35 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> > > > index 2e66ab72c10b..aafbe932424f 100644
> > > > --- a/drivers/pinctrl/qcom/Kconfig
> > > > +++ b/drivers/pinctrl/qcom/Kconfig
> > > > @@ -168,7 +168,7 @@ config PINCTRL_SDM660
> > > >  
> > > >  config PINCTRL_SDM845
> > > >         tristate "Qualcomm Technologies Inc SDM845 pin controller driver"
> > > > -       depends on GPIOLIB && OF
> > > > +       depends on GPIOLIB && (OF || ACPI)
> > > >         select PINCTRL_MSM
> > > >         help
> > > >           This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> > > > diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> > > > index c97f20fca5fd..7188bee3cf3e 100644
> > > > --- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
> > > > +++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> > > > @@ -3,6 +3,7 @@
> > > >   * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> > > >   */
> > > >  
> > > > +#include <linux/acpi.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/of.h>
> > > >  #include <linux/platform_device.h>
> > > > @@ -1277,6 +1278,10 @@ static const struct msm_pingroup sdm845_groups[] = {
> > > >  	UFS_RESET(ufs_reset, 0x99f000),
> > > >  };
> > > >  
> > > > +static const int sdm845_acpi_reserved_gpios[] = {
> > > > +	0, 1, 2, 3, 81, 82, 83, 84, -1
> > > > +};
> > > > +
> > > >  static const struct msm_pinctrl_soc_data sdm845_pinctrl = {
> > > >  	.pins = sdm845_pins,
> > > >  	.npins = ARRAY_SIZE(sdm845_pins),
> > > > @@ -1284,14 +1289,41 @@ static const struct msm_pinctrl_soc_data sdm845_pinctrl = {
> > > >  	.nfunctions = ARRAY_SIZE(sdm845_functions),
> > > >  	.groups = sdm845_groups,
> > > >  	.ngroups = ARRAY_SIZE(sdm845_groups),
> > > > +	.reserved_gpios = sdm845_acpi_reserved_gpios,
> > > 
> > > The reason why put these in DT is because the list is board/firmware
> > > dependent. E.g. the firmware on db845c does not support the peripherals
> > > that sits on these 8 pins and as such these are not reserved.
> > 
> > If we need to be more particular about which platform(s) this affects,
> > we could add matching based on their differences (some ACPI HID or F/W
> > version/descriptor, etc) as and when we enable them for booting with
> > ACPI.
> > 
> 
> You're making an assumption that all SDM845 (the platform) devices using
> ACPI will have this list of GPIOs reserved for secure firmware to use,
> this is questionable but I don't have any better suggestion.

Yes, I am, since this is the first and currently only device which
ticks those boxes.  If/when there are others AND if they require a
different configuration, we can look at the differences and conduct
some suitable matching on them at the time.

> But you do this by adding a new struct msm_pinctrl_soc_data
> sdm845_acpi_pinctrl, specifically for the ACPI case. And then, on the
> line I object to here, you add this list as the list of reserved GPIOs
> for the DT case as well.

Ohhhh, now I see what you're getting at.  Yes, that's a mistake left
over from testing.  That needs removing -- good spot.

> > > But given that the two structs looks identical now, did you perhaps not
> > > intend to add.reserved_gpios for the non-ACPI case?
> > 
> > Given your example above, I think it's best that we let the
> > configuration tables advertise these in the first instance.  I only
> > add them here because it is not possible to obtain them from
> > elsewhere.
> > 
> 
> Then add it for ACPI only - which I still presume you intended to do by
> adding sdm845_acpi_pinctrl (which is now identical to sdm845_pinctrl).

We're arguing about the same thing - sorry for the confusion.

I will fix this.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
