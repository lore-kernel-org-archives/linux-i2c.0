From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 6/8] usb: dwc3: qcom: Add support for booting with ACPI
Date: Wed, 5 Jun 2019 10:55:24 +0100
Message-ID: <20190605095524.GS4797@dell>
References: <20190604104455.8877-1-lee.jones@linaro.org>
 <20190604104455.8877-6-lee.jones@linaro.org>
 <20190605063507.GM22737@tuxbook-pro>
 <20190605070928.GJ4797@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190605070928.GJ4797@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: alokc@codeaurora.org, kramasub@codeaurora.org, andy.gross@linaro.org, david.brown@linaro.org, wsa+renesas@sang-engineering.com, linus.walleij@linaro.org, balbi@kernel.org, gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, jlhugo@gmail.com, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 05 Jun 2019, Lee Jones wrote:

> On Tue, 04 Jun 2019, Bjorn Andersson wrote:
> 
> > On Tue 04 Jun 03:44 PDT 2019, Lee Jones wrote:
> > > diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> > [..]
> > > @@ -373,7 +416,7 @@ static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom, int count)
> > >  
> > >  	qcom->num_clocks = count;
> > >  
> > > -	if (!count)
> > > +	if (!count || ACPI_HANDLE(dev))
> > >  		return 0;
> > 
> > Afaict you call this with count = of_count_phandle_with_args(), which
> > should be 0. But why not skip calling this at all?
> 
> Actually count can be <0, which is why I must have needed it at the
> beginning.  There is another patch in this set which checks for
> errors, thus the ACPI_HANDLE() call should now be superfluous.  I
> will test and remove it.

Just looked into this - it is still required.

of_count_phandle_with_args() returns an error not to be heeded in the
ACPI case.  So the logic goes:

[This patch]
 * It's fine to boot DT with no clocks to initialise (return 0)
 * There are no clocks to enable when booting ACPI (return 0)

[Another patch]
 * It's not fine to boot DT and for 'count < 0' (return count)

> > >  	qcom->clks = devm_kcalloc(dev, qcom->num_clocks,
> > > @@ -409,12 +452,28 @@ static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom, int count)
> > >  	return 0;
> > >  }
> > >  
> > > +static const struct dwc3_acpi_pdata sdm845_acpi_pdata = {
> > > +	.qscratch_base_offset = SDM845_QSCRATCH_BASE_OFFSET,
> > > +	.qscratch_base_size = SDM845_QSCRATCH_SIZE,
> > > +	.dwc3_core_base_size = SDM845_DWC3_CORE_SIZE,
> > > +	.hs_phy_irq_index = 1,
> > > +	.dp_hs_phy_irq_index = 4,
> > > +	.dm_hs_phy_irq_index = 3,
> > > +	.ss_phy_irq_index = 2
> > > +};
> > > +
> > > +static const struct acpi_device_id dwc3_qcom_acpi_match[] = {
> > > +	{ "QCOM2430", (unsigned long)&sdm845_acpi_pdata },
> > > +	{ },
> > > +};
> > > +MODULE_DEVICE_TABLE(acpi, dwc3_qcom_acpi_match);
> > 
> > Analog to of_device_get_match_data() there seems to be a
> > acpi_device_get_match_data(), if you use this you should be able to
> > have you acpi_device_id array next to the of_device_id.
> 
> Do you mean "Analogous"?
> 
> I will try to group them, thanks.
> 
> > > +
> > >  static int dwc3_qcom_probe(struct platform_device *pdev)
> > 
> > It seems that all that's left unconditional on ACPI_HANDLE() in this
> > function are the optional pieces and the tail. Wouldn't it be cleaner to
> > split it out in different functions?
> 
> There are ~50 lines of shared code in dwc3_qcom_probe(), most of it is
> interspersed between the configuration table (DT, ACPI) pieces, which
> is why it's formatted in the current way.
> 
> I can split a few things out into separate functions if you think
> it'll help.
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
