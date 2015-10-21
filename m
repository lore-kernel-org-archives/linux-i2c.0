From: Ken Xue <Ken.Xue@amd.com>
Subject: Re: [PATCH 1/2] i2c: designware: register clkdev during acpi device
 configuration
Date: Wed, 21 Oct 2015 17:37:53 +0800
Message-ID: <1445420273.2977.10.camel@kxue-X58A-UD3R>
References: <1445323081.3380.25.camel@kxue-X58A-UD3R>
	 <20151020111737.GF1526@lahna.fi.intel.com>
	 <1445389893.2483.3.camel@kxue-X58A-UD3R>
	 <20151021072817.GM1526@lahna.fi.intel.com>
	 <1445416943.2977.8.camel@kxue-X58A-UD3R>
	 <20151021092553.GX1526@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20151021092553.GX1526@lahna.fi.intel.com>
Sender: stable-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: baruch@tkos.co.il, SPG_Linux_Kernel@amd.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 2015-10-21 at 12:25 +0300, Mika Westerberg wrote:
> On Wed, Oct 21, 2015 at 04:42:23PM +0800, Ken Xue wrote:
> > On Wed, 2015-10-21 at 10:28 +0300, Mika Westerberg wrote:
> > > On Wed, Oct 21, 2015 at 09:11:33AM +0800, Ken Xue wrote:
> > > > On Tue, 2015-10-20 at 14:17 +0300, Mika Westerberg wrote:
> > > > > On Tue, Oct 20, 2015 at 02:38:01PM +0800, Ken Xue wrote:
> > > > > > DW I2C driver tries to register a clk from id->driver_data as an
> > > > > > alternative way besides intel lpss. But code doesn't register the
> > > > > > clk to clkdev. So, devm_clk_get will fail during probe.
> > > > > > 
> > > > > > The patch can fix this issue.
> > > > > 
> > > > > Since you now have drivers/acpi/acpi_apd.c for AMD ACPI stuff, can you
> > > > > create the clock there just like we do for Intel stuff?
> > > > Sure. APD already creates the clock for AMD0010 as you expected. And the
> > > > next patch([PATCH 2/2] i2c: designware: remove freq definition for
> > > > "AMD0010" in acpi_device_id) is dropping the old way for getting freq.
> > > 
> > > So this patch is not necessary, right?
> > Even though there is no use case that getting freq from id->driver_data,
> > But if we want to keep this design, then we should use current patch for
> > fixing the potential issue. So, the patch is nice to have.
> 
> What potential issue?
devm_clk_get will fail during probe for AMD0010 without current patch.

> 
> If you pass clock from drivers/acpi/acpi_apd.c and drop the hard coded
> freq for AMD0010 in the I2C designware driver, the driver still works
> just fine.
> 
> > Otherwise, we have to revert whole old design(a445900c).
> 
> Yes please :-)
Glad to do.
