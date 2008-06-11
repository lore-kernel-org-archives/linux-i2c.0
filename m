From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH, RFC] Earlier I2C initialization
Date: Wed, 11 Jun 2008 10:00:16 +0100
Message-ID: <20080611090016.GA5338@flint.arm.linux.org.uk>
References: <200806091541.43899.u.luckas@road.de> <484DA046.4010804@bluewatersys.com> <20080610085708.12c2d2a2@hyperion.delvare> <200806101355.07792.david-b@pacbell.net> <20080611101130.1a667abe@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757279AbYFKJFG@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080611101130.1a667abe@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: David Brownell <david-b@pacbell.net>, Ryan Mallon <ryan@bluewatersys.com>, Uli Luckas <u.luckas@road.de>, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 11, 2008 at 10:11:30AM +0200, Jean Delvare wrote:
> Hi David,
> 
> On Tue, 10 Jun 2008 13:55:07 -0700, David Brownell wrote:
> > > Why don't you simply initialize the drivers in question with
> > > subsys_initcall()? That's what i2c-pnx, i2c-omap, i2c-davinci and
> > > tps65010 are doing at the moment.
> > 
> > If they happen to sit outside the I2C tree and *before* it in
> > link order, things will misbehave.
> 
> Well, i2c system bus drivers shouldn't sit outside of the I2C tree, so
> that's not a problem. If you start accepting that drivers live at
> random places in the source tree, then there's simply no way to get
> things right.

That's simply not a realistic view.  As I've already pointed out,
framebuffer devices have I2C busses for reading the DDC information
from monitors.  These I2C bus drivers live in drivers/video.

Video grabbers have I2C busses for controlling, eg, tuners and video
decoders.  These live in drivers/media.

If I follow your argument, would you like cyber2000fb.c to be moved
entirely from drivers/video into drivers/i2c/busses because it contains
an i2c bus driver?  Clearly not.
