From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] i2c: qcom-geni: Provide an option to disable DMA
 processing
Date: Thu, 5 Sep 2019 15:34:23 +0100
Message-ID: <20190905143423.GG26880@dell>
References: <20190905075213.13260-1-lee.jones@linaro.org>
 <20190905075213.13260-2-lee.jones@linaro.org>
 <20190905091800.GD1157@kunai>
 <20190905092816.GD26880@dell>
 <20190905134338.GF1157@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190905134338.GF1157@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: alokc@codeaurora.org, agross@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, bjorn.andersson@linaro.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, vkoul@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 05 Sep 2019, Wolfram Sang wrote:

> On Thu, Sep 05, 2019 at 10:28:16AM +0100, Lee Jones wrote:
> > On Thu, 05 Sep 2019, Wolfram Sang wrote:
> > 
> > > 
> > > > Fixes: 8bc529b25354 ("soc: qcom: geni: Add support for ACPI")
> > > 
> > > Are you sure? From visual inspection, I don't see a correlation between
> > > this commit and the fix here.
> > 
> > This patch should have been part of the commit, or at the very least,
> > part of the set, alluded to above.  Unfortunately, I was carrying
> > Bjorn's hack which simply returned early from geni_se_rx_dma_prep()
> > with an error, so it masked the issue.
> 
> I still don't see why this basic ACPI enabling code (not touching DMA
> but only clocks and pinctrl) causes and additional handling for DMA. Am
> I overlooking something obvious?

Please ignore, I'm discussing with another patch in mind.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
