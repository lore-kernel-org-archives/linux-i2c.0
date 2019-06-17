From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 4/6] usb: dwc3: qcom: Add support for booting with ACPI
Date: Mon, 17 Jun 2019 13:43:29 +0100
Message-ID: <20190617124329.GH16364@dell>
References: <20190612142654.9639-1-lee.jones@linaro.org>
 <20190612142654.9639-5-lee.jones@linaro.org>
 <20190617102146.GG16364@dell>
 <87y320gzp4.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87y320gzp4.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: alokc@codeaurora.org, agross@kernel.org, david.brown@linaro.org, wsa+renesas@sang-engineering.com, bjorn.andersson@linaro.org, gregkh@linuxfoundation.org, ard.biesheuvel@linaro.org, jlhugo@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 17 Jun 2019, Felipe Balbi wrote:

> Hi,
> 
> Lee Jones <lee.jones@linaro.org> writes:
> >> In Linux, the DWC3 core exists as its own independent platform device.
> >> Thus when describing relationships in Device Tree, the current default
> >> boot configuration table option, the DWC3 core often resides as a child
> >> of the platform specific node.  Both of which are given their own
> >> address space descriptions and the drivers can be mostly agnostic to
> >> each other.
> >> 
> >> However, other Operating Systems have taken a more monolithic approach,
> >> which is evident in the configuration ACPI tables for the Qualcomm
> >> Snapdragon SDM850, where all DWC3 (core and platform) components are
> >> described under a single IO memory region.
> >> 
> >> To ensure successful booting using the supplied ACPI tables, we need to
> >> devise a way to chop up the address regions provided and subsequently
> >> register the DWC3 core with the resultant information, which is
> >> precisely what this patch aims to achieve.
> >> 
> >> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >> ---
> >>  drivers/usb/dwc3/Kconfig     |   2 +-
> >>  drivers/usb/dwc3/dwc3-qcom.c | 206 ++++++++++++++++++++++++++++++-----
> >>  2 files changed, 179 insertions(+), 29 deletions(-)
> >
> > I'm starting to get a little twitchy about these patches now.  Due to
> > the release cadence of the larger Linux distros, it's pretty important
> > that these changes land in v5.3.  Without them, it is impossible to
> > install Linux on some pretty high profile emerging platforms.
> >
> > It's already -rc5 and I'm concerned that we're going to miss the
> > merge-window.  Would you be kind enough to review these patches
> > please?  The Pinctrl and I2C parts of the set have already been
> > merged.
> 
> I don't seem to have this series in my inbox. This is the only email I
> have in this series.

I did wonder, which is why I made sure I sent this to your Intel
address as well.  Is your @kernel.org address broken?

Will re-send the patches to your Intel address, give me a few
minutes.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
