From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Added driver for ISL29003 ambient light sensor
Date: Thu, 26 Feb 2009 09:50:49 +0100
Message-ID: <20090226095049.461271b1@hyperion.delvare>
References: <1235592618-10880-1-git-send-email-daniel@caiaq.de>
	<20090225212119.67402391@hyperion.delvare>
	<20090225234004.GA19039@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090225234004.GA19039-ahpEBR4enfnCULTFXS99ULNAH6kLmebB@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 26 Feb 2009 00:40:04 +0100, Daniel Mack wrote:
> Hi Jean,
> 
> On Wed, Feb 25, 2009 at 09:21:19PM +0100, Jean Delvare wrote:
> > On Wed, 25 Feb 2009 21:10:18 +0100, Daniel Mack wrote:
> > > This patch adds a driver for Intersil's ISL29003 ambient light sensor
> > > device plus some documentation. Inspired by tsl2550.c, a driver for a
> > > similar device.
> > > 
> > > Signed-off-by: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
> > > ---
> > >  Documentation/i2c/chips/isl29003 |   62 +++++
> > >  drivers/i2c/chips/Kconfig        |   10 +
> > >  drivers/i2c/chips/Makefile       |    1 +
> > 
> > Please read the header of these 2 files again.
> 
> Ok, I missed that. But drivers for I2C based devices will still be
> submitted via this list?

In last resort only. Ideally all drivers would fit in a subsystem and
that subsystem's mailing list is the best place to post. Unless you
have I2C-specific problems, of course, in which case you can ask here.

-- 
Jean Delvare
