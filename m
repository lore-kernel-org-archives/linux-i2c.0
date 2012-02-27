From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/3] mfd: Add basic support for the Congatec CGEB BIOS
 interface
Date: Mon, 27 Feb 2012 18:24:43 +0100
Message-ID: <20120227172443.GD3852@pengutronix.de>
References: <1328102793-4313-1-git-send-email-s.hauer@pengutronix.de>
 <1328102793-4313-2-git-send-email-s.hauer@pengutronix.de>
 <20120220163927.GY5387@sortiz-mobl>
 <20120220180752.GV3852@pengutronix.de>
 <20120227135827.GM27687@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120227135827.GM27687@sortiz-mobl>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, kernel@pengutronix.de
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 27, 2012 at 02:58:27PM +0100, Samuel Ortiz wrote:
> Hi Sascha,
> 
> 
> On Mon, Feb 20, 2012 at 07:07:52PM +0100, Sascha Hauer wrote:
> > Hi Samuel,
> > 
> > On Mon, Feb 20, 2012 at 05:39:27PM +0100, Samuel Ortiz wrote:
> > > Hi Sascha,
> > > 
> > > On Wed, Feb 01, 2012 at 02:26:31PM +0100, Sascha Hauer wrote:
> > > > The Congatec CGEB is a BIOS interface found on some Congatec x86
> > > > modules. It provides access to on board peripherals like I2C busses
> > > > and watchdogs. This driver contains the basic support for accessing
> > > > the CGEB interface and registers the child devices.
> > > After looking at the code, I'm not entirely sure this one belongs to
> > > drivers/mfd/. Have you thought about putting it under arch/x86/platform/ ?
> > > There are similar examples there, like uv or olpc.
> > 
> > I don't mind putting it in arch/x86/platform instead. I'm an ARM guy and
> > on ARM there currently is a rush to move everything looking remotely
> > like a driver out of arch/arm/ to drivers/, so putting it under
> > drivers/mfd/ seemed logical to me.
> Yes, this seems to be the trend apparently. Could you try pushing that into
> the x86/platform, please ? If they put you under fire, I guess I could take
> this patchset. But they have several "BIOS interfaces" there already...

Ok, I'll put on my asbestos suit and give it a try.

Thanks
 Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
