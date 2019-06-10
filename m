From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/8] pinctrl: msm: Add ability for drivers to supply a
 reserved GPIO list
Date: Mon, 10 Jun 2019 09:02:58 +0100
Message-ID: <20190610080258.GI4797@dell>
References: <20190605114302.22509-1-lee.jones@linaro.org>
 <20190605114302.22509-3-lee.jones@linaro.org>
 <20190608040610.GJ24059@builder>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190608040610.GJ24059@builder>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: alokc@codeaurora.org, andy.gross@linaro.org, david.brown@linaro.org, wsa+renesas@sang-engineering.com, linus.walleij@linaro.org, balbi@kernel.org, gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, jlhugo@gmail.com, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 07 Jun 2019, Bjorn Andersson wrote:

> On Wed 05 Jun 04:42 PDT 2019, Lee Jones wrote:
> 
> > When booting MSM based platforms with Device Tree or some ACPI
> > implementations, it is possible to provide a list of reserved pins
> > via the 'gpio-reserved-ranges' and 'gpios' properties respectively.
> > However some ACPI tables are not populated with this information,
> > thus it has to come from a knowledgable device driver instead.
> > 
> > Here we provide the MSM common driver with additional support to
> > parse this informtion and correctly populate the widely used
> > 'valid_mask'.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/pinctrl/qcom/pinctrl-msm.c | 18 ++++++++++++++++++
> >  drivers/pinctrl/qcom/pinctrl-msm.h |  1 +
> >  2 files changed, 19 insertions(+)
> > 
> > diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> > index ee8119879c4c..3ac740b36508 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> > @@ -607,8 +607,23 @@ static int msm_gpio_init_valid_mask(struct gpio_chip *chip)
> >  	int ret;
> >  	unsigned int len, i;
> >  	unsigned int max_gpios = pctrl->soc->ngpios;
> > +	const int *reserved = pctrl->soc->reserved_gpios;
> >  	u16 *tmp;
> >  
> > +	/* Driver provided reserved list overrides DT and ACPI */
> > +	if (reserved) {
> > +		bitmap_fill(chip->valid_mask, max_gpios);
> > +		for (i = 0; reserved[i] >= 0; i++) {
> > +			if (i >= max_gpios || reserved[i] >= max_gpios) {
> 
> reserved is a list of GPIOs to reserve, I don't see a reason to check
> if that list is longer than the number of GPIOs (i.e. the first half of
> the condition).
> 
> It wouldn't make sense to be, but there's no logical issue with it and I
> had to read the conditional a few extra times to be sure what was going
> on.

If nothing else, it's an early hard stop in case someone forgot to
terminate the reserved array.

> Apart from that you have my
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks Bjorn.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
