From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: clock driver
Date: Wed, 27 May 2015 11:54:42 -0700
Message-ID: <20150527185442.GA6607@roeck-us.net>
References: <5564C58B.9050400@freescale.com>
 <20150526223829.GA26454@roeck-us.net>
 <55650DBA.5000304@freescale.com>
 <5565108D.2020502@freescale.com>
 <20150527173055.22384.74368@quantum>
 <556602BC.6040203@freescale.com>
 <20150527181521.GA19448@roeck-us.net>
 <55660BF2.6000002@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55660BF2.6000002@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: York Sun <yorksun@freescale.com>
Cc: Michael Turquette <mturquette@linaro.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, andrey@elphel.com, sebastian.hesselbarth@gmail.com, rabeeh@solid-run.com
List-Id: linux-i2c@vger.kernel.org

On Wed, May 27, 2015 at 11:24:50AM -0700, York Sun wrote:
> 
> > 
> > Someone suggested earlier that the clocks should be set from the PCIe driver.
> > Question here is really if you need to control the clocks from user space.
> > Even if you do, the driver for the chip _using_ the clocks would be better
> > suited for changing the clock rates than the clock driver itself. This way it
> > can ensure that the clock rates are sane for the given use case, and the use
> > case is kept out of the clock driver.
> > 
> >> I wrote a driver for the PCIe card to load FPGA images. To setup the clocks, I
> >> rewrote the SI5338 driver and set the desired frequencies using sysfs. This
> >> driver has a feature to import/dump the raw configuration data. That's one
> >> feature I plan to use, at least for debugging.
> >>
> > With the above in mind, the idea would be for the PCIe driver to set the clock
> > rates.
> 
> I am interested in this path. Can you explain a little bit more about setting
> the clock rates? I have no experience on CCF.
> 
The API functions are documented in include/linux/clk.h. What you are looking
for here would be clk_set_rate() and related functions such as clk_round_rate(),
and of course support functions such as devm_clk_get(), clk_prepare_enable(),
and clk_disable_unprepare().

You can find lots of examples on how this works if you search for clk_set_rate()
in the kernel source.

> > 
> >> I don't think device tree is the best for my application because I will have
> >> about 30 clock chips to program in the complete system. It is easier to use user
> >> space application to do so from I2C bus.
> >>
> > Devicetree is static, so you might have to use devicetree overlays if the
> > programming changes at runtime. Not sure why the number of clock chips
> > would make that non-feasible, though.
> 
> I mean the existence is unknown for many chips. The baseline is I can't use
> static data.
> 
> > 
> > On a side note, we are using devicetree a lot for PCIe devices.
> 
> It's tempting. I want to explore this direction at a later phase of my project.
> I will appreciate if you can point me to something.
> 
I can send you some devicetree files if you think that would help. Note that we
are heavily using devicetree overlays, so this is all a bit WIP.

> > 
> >> Earlier Guenter helped me to comb through the idea and we concluded CCF may not
> >> be the best fit for this application. I wonder if CCF is the only way to get
> > 
> > Well, you did ;-). I think it would be feasible, but you would have to change
> > your viewpoint (in respect to how to control the clocks).
> 
> Right, I did. I will revisit this after bring up the platform initially, when I
> have more knowledge about those clocks. Maybe I should add an interface for my
> FPGA driver to request clock rates, instead of setting them from clock driver.
> It sounds better.
> 
Yes, that would be the idea. Essentially your FPGA driver could either determine
the clock rate(s) it needs internally, or you could set the clock rate(s)
through sysfs attributes attached to the FPGA driver. The FPGA driver would then
use clk_set_rate() to set the rate in the clock chip.

Guenter
