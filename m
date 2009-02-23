From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: Re: Finding 'orphaned' i2c drivers
Date: Mon, 23 Feb 2009 15:51:42 +0100
Message-ID: <20090223145142.GB18378@buzzloop.caiaq.de>
References: <20090223110052.GE15722@buzzloop.caiaq.de> <20090223144343.GC2078@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090223144343.GC2078-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 23, 2009 at 02:43:44PM +0000, Mark Brown wrote:
> On Mon, Feb 23, 2009 at 12:00:52PM +0100, Daniel Mack wrote:
> 
> > it is communicating with? More specificly, I implemented a driver for a
> > Maxim clock generator and would like to use a proprietary interface with
> > it from a alsa-soc module. I just can't find a sane way to access the
> > driver's instance from there. It does exist somewhere in the linux
> > device tree, but is there a simple function that iterates over it and
> > returns it to me by name? Reading include/linux/device.h didn't point me
> > to anything that could fit.
> 
> You probably want to either have the device register with the ASoC core
> and discover it that way or have the driver be part of your machine
> driver (as the neo1973 driver does for the external amplifier).

Ok, I might miss a general thing here. All I do is add a driver which is
loaded via the module_init() mechanism and registers itself for that
specific device by name.

In the board support file, I add a list of i2c_board_infos by calling
i2s_register_board_info() and then the driver is magically instanciated
in some lower layer.

The question is: how do I access this instance at a later point? Without
messing around with static pointers, of course.

Daniel
