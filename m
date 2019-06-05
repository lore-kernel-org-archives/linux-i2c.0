From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 7/8] usb: dwc3: qcom: Start USB in 'host mode' on the
 SDM845
Date: Wed, 5 Jun 2019 20:29:26 +0100
Message-ID: <20190605192926.GW4797@dell>
References: <20190604104455.8877-1-lee.jones@linaro.org>
 <20190604104455.8877-7-lee.jones@linaro.org>
 <20190605070029.GN22737@tuxbook-pro>
 <20190605083454.GO4797@dell>
 <20190605191453.GJ4814@minitux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190605191453.GJ4814@minitux>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: alokc@codeaurora.org, kramasub@codeaurora.org, andy.gross@linaro.org, david.brown@linaro.org, wsa+renesas@sang-engineering.com, linus.walleij@linaro.org, balbi@kernel.org, gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, jlhugo@gmail.com, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 05 Jun 2019, Bjorn Andersson wrote:

> On Wed 05 Jun 01:34 PDT 2019, Lee Jones wrote:
> 
> > On Wed, 05 Jun 2019, Bjorn Andersson wrote:
> > 
> > > On Tue 04 Jun 03:44 PDT 2019, Lee Jones wrote:
> > > 
> > > > When booting with Device Tree, the current default boot configuration
> > > > table option, the request to boot via 'host mode' comes from the
> > > > "dr_mode" property.
> > > 
> > > This has been the default on the MTP, but this is changing as this is
> > > causing issues when connected downstream from a hub (the typical
> > > development case for the primary USB port of a phone like device) and
> > > more importantly we don't have support for the PMIC blocks that control
> > > VBUS.
> > 
> > My point is not about which mode is currently chosen.  It's more about
> > the capability of choosing which mode is appropriate for a given
> > system via DT.
> > 
> > > Once these issues are resolved the dr_mode would be "otg".
> > 
> > OTG doesn't work on this H/W, so we need to specify "host" mode.
> 
> My objection is that when you say "this H/W" you mean a particular
> product, but you're making this decision for all SDM845 based products
> using ACPI.
> 
> I don't know if there is a Windows phone based on SDM845, but if there
> is then I don't think forcing it to host would be correct.

You mean if someone wanted to boot Linux on a Windows phone?  Not sure
how likely that is, but even if a) there is an SDM845 based Windows
phone and b) someone is crazy enough to run Linux on it, it should be
trivial for them to conduct some device matching and choose a
different property based on the result.

[...]

> > > And this driver is used on a range of different Qualcomm platforms, so I
> > > don't think this is SDM845 specific.
> > 
> > ACPI based platforms?
> > 
> > All the ones I've seen use the XHCI USB driver directly ("PNP0D10").
> 
> MSM8998 (835) has the same controller, so this should affect those
> laptops as well.

This would also be the correct configuration for them too.  OTG
doesn't make much sense for a laptop form factor.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
