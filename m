From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/8] pinctrl: msm: Add ability for drivers to supply a
 reserved GPIO list
Date: Mon, 10 Jun 2019 08:57:30 +0100
Message-ID: <20190610075730.GH4797@dell>
References: <20190605114302.22509-1-lee.jones@linaro.org>
 <20190605114302.22509-3-lee.jones@linaro.org>
 <CACRpkdaEe3uKAsSuhbToevXH1cMsuMUvwaopLPuD+JkDTnuEnQ@mail.gmail.com>
 <20190608041044.GK24059@builder>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190608041044.GK24059@builder>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, alokc@codeaurora.org, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, jlhugo@gmail.com, linux-i2c@vger.kernel.org, MSM <linux-arm-msm@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-usb@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 07 Jun 2019, Bjorn Andersson wrote:

> On Fri 07 Jun 16:02 PDT 2019, Linus Walleij wrote:
> 
> > On Wed, Jun 5, 2019 at 1:43 PM Lee Jones <lee.jones@linaro.org> wrote:
> > 
> > > When booting MSM based platforms with Device Tree or some ACPI
> > > implementations, it is possible to provide a list of reserved pins
> > > via the 'gpio-reserved-ranges' and 'gpios' properties respectively.
> > > However some ACPI tables are not populated with this information,
> > > thus it has to come from a knowledgable device driver instead.
> > >
> > > Here we provide the MSM common driver with additional support to
> > > parse this informtion and correctly populate the widely used
> > > 'valid_mask'.
> > >
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > 
> > Exactly how we should use of the API, so if Björn can supply an
> > ACK to patches 3 and 4 I'm happy to apply them.
> > 
> > Björn?
> > 
> 
> I'm waiting for a version that does not specify the reserved_gpios for
> struct msm_pinctrl_soc_data sdm845_pinctrl {}, as this would override
> the ability of getting these from DT.
> 
> I haven't seen such revision yet, will review it once I find it.

Just testing it now.  It should be on the list by the time you start.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
