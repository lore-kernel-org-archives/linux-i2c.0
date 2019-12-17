From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 06/10] mfd: Add core driver for AD242x A2B transceivers
Date: Tue, 17 Dec 2019 13:46:17 +0000
Message-ID: <20191217134617.GK18955@dell>
References: <20191209183511.3576038-1-daniel@zonque.org>
 <20191209183511.3576038-8-daniel@zonque.org>
 <20191217133952.GJ18955@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191217133952.GJ18955@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, broonie@kernel.org, lars@metafoo.de, pascal.huerst@gmail.com
List-Id: linux-i2c@vger.kernel.org

On Tue, 17 Dec 2019, Lee Jones wrote:

> On Mon, 09 Dec 2019, Daniel Mack wrote:
> 
> > The core driver for these devices is split into several parts.
> > 
> > The master node driver is an I2C client. It is responsible for
> > bringing up the bus topology and discovering the slave nodes.
> > This process requries some knowlegde of the slave node configuration
> > to program the bus timings correctly, so the master drivers walks
> > the tree of nodes in the devicetree. The slave driver handles platform
> > devices that are instantiated by the master node driver after
> > discovery has finished.
> > 
> > Master nodes expose two addresses on the I2C bus, one (referred to as
> > 'BASE' in the datasheet) for accessing registers on the transceiver
> > node itself, and one (referred to as 'BUS') for accessing remote
> > registers, either on the remote transceiver itself, or on I2C hardware
> > connected to that remote transceiver, which then acts as a remote I2C
> > bus master.
> > 
> > In order to allow MFD sub-devices to be registered as children of
> > either the master or any slave node, the details on how to access the
> > registers are hidden behind a regmap config. A pointer to the regmap
> > is then exposed in the struct shared with the sub-devices.
> > 
> > The ad242x-bus driver is a simple proxy that occupies the BUS I2C
> > address and which is referred to through a devicetree handle by the
> > master driver.
> > 
> > For the discovery process, the driver has to wait for an interrupt
> > to occur. In case no interrupt is configured in DT, the driver falls
> > back to interrupt polling. After the discovery phase is completed,
> > interrupts are only needed for error handling and GPIO handling,
> > both of which is not currenty implemented.
> > 
> > Code common to both the master and the slave driver lives in
> > 'ad242x-node.c'.
> > 
> > Signed-off-by: Daniel Mack <daniel@zonque.org>
> > 
> > mfd
> 
> ?
> 
> > ---
> >  drivers/mfd/Kconfig         |  11 +
> >  drivers/mfd/Makefile        |   1 +
> >  drivers/mfd/ad242x-bus.c    |  42 +++
> >  drivers/mfd/ad242x-master.c | 611 ++++++++++++++++++++++++++++++++++++
> >  drivers/mfd/ad242x-node.c   | 262 ++++++++++++++++
> >  drivers/mfd/ad242x-slave.c  | 234 ++++++++++++++
> >  include/linux/mfd/ad242x.h  | 400 +++++++++++++++++++++++
> 
> This device, or at least the way it's been coded is batty!
> 
> It's going to need a lot of massaging before being accepted.

One thing I should mention upfront; there is too much code "doing
things" in here for it to be an MFD.  MFDs don't care about; syncs,
slots, TDM, inverting lines, upstreams, downstreams, etc etc etc.
Anything remotely technical or functional, the code that "does things"
should be moved out to the relevant areas.  In the case of this
device, that's looking like one of the Audio related subsystems.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
