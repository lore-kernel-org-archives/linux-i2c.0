From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/8] i2c: i2c-qcom-geni: Signify successful driver probe
Date: Wed, 5 Jun 2019 19:49:41 +0100
Message-ID: <20190605184941.GU4797@dell>
References: <20190604104455.8877-1-lee.jones@linaro.org>
 <20190604104455.8877-2-lee.jones@linaro.org>
 <20190605062020.GL22737@tuxbook-pro>
 <20190605071625.GK4797@dell>
 <20190605075656.GC29637@localhost>
 <20190605082047.GM4797@dell>
 <20190605083353.GD29637@localhost>
 <20190605084921.GQ4797@dell>
 <20190605085527.GE29637@localhost>
 <20190605141812.GA962@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190605141812.GA962@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Johan Hovold <johan@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, balbi@kernel.org, wsa+renesas@sang-engineering.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, david.brown@linaro.org, alokc@codeaurora.org, kramasub@codeaurora.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, andy.gross@linaro.org, jlhugo@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 05 Jun 2019, Wolfram Sang wrote:

> 
> > To enable dynamic debugging in driver core you could use something like
> > 
> > 	CONFIG_CMDLINE="dyndbg=\"func really_probe =p\""
> > 
> > That gives you two printouts per successful probe, for example:
> > 
> > 	bus: 'usb-serial': really_probe: probing driver edgeport_ti_1 with device ttyUSB0
> > 	bus: 'usb-serial': really_probe: bound device ttyUSB0 to driver edgeport_ti_1
> 
> I agree that this scales much better than adding strings to every
> driver. Also, the driver core will report failed probes other than
> -ENODEV, or?
> 
> Regarding this patch, however, I don't care much. I'll let the driver
> maintainers decide.

I've downgraded this to dev_dbg() in v2.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
