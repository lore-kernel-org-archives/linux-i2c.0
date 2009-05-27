From: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Simplified CONFIG_I2C=n interface.
Date: Wed, 27 May 2009 16:28:44 +0900
Message-ID: <20090527072843.GB11221@linux-sh.org>
References: <20090527070850.GA11221@linux-sh.org> <20090527091831.26b60d6d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090527091831.26b60d6d-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, May 27, 2009 at 09:18:31AM +0200, Jean Delvare wrote:
> On Wed, 27 May 2009 16:08:50 +0900, Paul Mundt wrote:
> > Another day, another module-related failure due to the i2c interface
> > being used in code that optionally uses it:
> > 
> > ERROR: "i2c_new_device" [drivers/media/video/soc_camera.ko] undefined!
> > ERROR: "i2c_get_adapter" [drivers/media/video/soc_camera.ko] undefined!
> > ERROR: "i2c_put_adapter" [drivers/media/video/soc_camera.ko] undefined!
> > ERROR: "i2c_unregister_device" [drivers/media/video/soc_camera.ko] undefined!
> > make[2]: *** [__modpost] Error 1
> > make[1]: *** [modules] Error 2
> > make: *** [sub-make] Error 2
> > 
> > In the interest of not continually inserting i2c ifdefs in to every
> > driver that supports an optional i2c interface, this provides a stubbed
> > set of interfaces for the CONFIG_I2C=n case.
> > 
> > I've covered the obvious ones that cause the majority of the build
> > failures, anything more involved really ought to have its dependencies
> > fixed instead.
> 
> Violent nack. Drivers which optionally use I2C are a minority.

If they were a minority we wouldn't be hitting them on a weekly basis,
and other busses already do similar things for similar reasons. You may
not like it, but it's much less distasteful than littering random i2c
ifdefs around every driver that chooses to have an optional i2c
interface. If every multi-bus driver was forced to go through these sorts
of hoops, the drivers would be even less readable than they already are
today.
