From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 1/8] i2c: i2c-qcom-geni: Provide support for ACPI
Date: Wed, 12 Jun 2019 11:40:11 +0100
Message-ID: <20190612104011.GA4660@dell>
References: <20190610084213.1052-1-lee.jones@linaro.org>
 <20190612103453.ccet2pneairnlpcc@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190612103453.ccet2pneairnlpcc@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: alokc@codeaurora.org, andy.gross@linaro.org, david.brown@linaro.org, wsa+renesas@sang-engineering.com, bjorn.andersson@linaro.org, linus.walleij@linaro.org, balbi@kernel.org, gregkh@linuxfoundation.org, ard.biesheuvel@linaro.org, jlhugo@gmail.com, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 12 Jun 2019, Wolfram Sang wrote:

> On Mon, Jun 10, 2019 at 09:42:06AM +0100, Lee Jones wrote:
> > Add a match table to allow automatic probing of ACPI device
> > QCOM0220.  Ignore clock attainment errors.  Set default clock
> > frequency value.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Sadly, there is no cover-letter describing if there is a dependency or
> not. I assume there is, otherwise I would get the I2C patches only? But
> what is the suggested way upstream then?

There are no cross-subsystem build dependencies on any of these
patches.  The only reason they are bundled together in the same
patch-set is for cross-subsystem visibility and understanding.

There is wide interest in these devices.

> Also, the current maintainer entry for this driver looks like:
> 
> drivers/i2c/busses/i2c-qcom-geni.c:
>         Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
>         David Brown <david.brown@linaro.org> (maintainer:ARM/QUALCOMM SUPPORT)
>         Alok Chauhan <alokc@codeaurora.org> (supporter:QUALCOMM GENERIC INTERFACE I2C DRIVER)
> 
> I didn't hear from those people yet, would be great to have their acks.

I will see if I can rouse them from their slumber.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
