From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Simplified CONFIG_I2C=n interface.
Date: Wed, 27 May 2009 09:18:31 +0200
Message-ID: <20090527091831.26b60d6d@hyperion.delvare>
References: <20090527070850.GA11221@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090527070850.GA11221-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Cc: linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 27 May 2009 16:08:50 +0900, Paul Mundt wrote:
> Another day, another module-related failure due to the i2c interface
> being used in code that optionally uses it:
> 
> ERROR: "i2c_new_device" [drivers/media/video/soc_camera.ko] undefined!
> ERROR: "i2c_get_adapter" [drivers/media/video/soc_camera.ko] undefined!
> ERROR: "i2c_put_adapter" [drivers/media/video/soc_camera.ko] undefined!
> ERROR: "i2c_unregister_device" [drivers/media/video/soc_camera.ko] undefined!
> make[2]: *** [__modpost] Error 1
> make[1]: *** [modules] Error 2
> make: *** [sub-make] Error 2
> 
> In the interest of not continually inserting i2c ifdefs in to every
> driver that supports an optional i2c interface, this provides a stubbed
> set of interfaces for the CONFIG_I2C=n case.
> 
> I've covered the obvious ones that cause the majority of the build
> failures, anything more involved really ought to have its dependencies
> fixed instead.

Violent nack. Drivers which optionally use I2C are a minority.
Designing them in such a way that a single #ifdef CONFIG_I2C will make
them work can't be that hard, really. Not to mention that having a
dozen stubs in i2c.h in the CONFIG_I2C=n case won't save you much work
at the driver level anyway, because you certainly need to run different
code paths depending on how the device is connected, and you also have
to differentiate between the "I2C support is missing" case and the "I2C
device registration failed" case, etc.

-- 
Jean Delvare
