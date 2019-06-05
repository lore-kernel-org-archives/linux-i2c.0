From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/8] i2c: i2c-qcom-geni: Signify successful driver probe
Date: Wed, 5 Jun 2019 10:55:27 +0200
Message-ID: <20190605085527.GE29637@localhost>
References: <20190604104455.8877-1-lee.jones@linaro.org>
 <20190604104455.8877-2-lee.jones@linaro.org>
 <20190605062020.GL22737@tuxbook-pro>
 <20190605071625.GK4797@dell>
 <20190605075656.GC29637@localhost>
 <20190605082047.GM4797@dell>
 <20190605083353.GD29637@localhost>
 <20190605084921.GQ4797@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190605084921.GQ4797@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, balbi@kernel.org, wsa+renesas@sang-engineering.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, david.brown@linaro.org, alokc@codeaurora.org, kramasub@codeaurora.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, andy.gross@linaro.org, jlhugo@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 05, 2019 at 09:49:21AM +0100, Lee Jones wrote:
> On Wed, 05 Jun 2019, Johan Hovold wrote:
> 
> > On Wed, Jun 05, 2019 at 09:20:47AM +0100, Lee Jones wrote:
> > > On Wed, 05 Jun 2019, Johan Hovold wrote:
 
> > > > There are plenty of options for debugging already ranging from adding a
> > > > temporary dev_info() to the probe function in question to using dynamic
> > > > debugging to have driver core log every successful probe.
> > > 
> > > This is what I ended up doing.  It was time consuming to parse though
> > > a log of that size when you have no paging or keyboard.
> > 
> > With the right command-line option to enable dynamic debugging you get
> > one line per successful probe, just like you wanted. Or are you now
> > saying that one-line per device is too much after all? ;)
> 
> Which command line option are you pertaining to?

To enable dynamic debugging in driver core you could use something like

	CONFIG_CMDLINE="dyndbg=\"func really_probe =p\""

That gives you two printouts per successful probe, for example:

	bus: 'usb-serial': really_probe: probing driver edgeport_ti_1 with device ttyUSB0
	bus: 'usb-serial': really_probe: bound device ttyUSB0 to driver edgeport_ti_1

Or you can of course just change the corresponding pr_debug to pr_info
while debugging.

Johan
