From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: New style I2C driver for KXSD9 accelerometer
Date: Mon, 22 Sep 2008 12:30:38 +0100
Message-ID: <48D781DE.4010403@cam.ac.uk>
References: <20125.80062.qm@web7902.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20125.80062.qm-lNdE0ozIhWIn1dgYqARqB/xNefe2kvS0AL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: invincible_6-/E1597aS9LQxFYw1CcD5bw@public.gmane.org
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

First question is whether you are interested in getting this into mainline?

The reason for asking is that at current time, how you code up the driver
is very dependent on what you want it for. See discussions of industrialio
on lkml for more on this.
 
> I m implementing a driver for accelerometer KXSD9 in linux kernel
> 2.6.24.7 for OMAP-3430. KXSD9 sensor will be connected to the i2c bus so
> it will be an i2c client.

Interesting looking chip. I hadn't come across that one before! I'll see if
I can get hold of one to have a play.
> 
> I m implementing a new style driver, so following are the steps that I m
> following:
> 
> 3. My requirement is that I need to export the file operations (specific
> ioctl commands) to the user space. I am not sure how it has to be done
> from this driver????
What sort of commands are we talking about?  In the vast majority of cases
it's preferable to do things like setting offsets etc via a sysfs interface
and only use character devices for high speed reading and passing events
up to userspace. 
> 
>  
> 
> I thought of the following approach:
> 
> Registering a misc device to export the file operations
> 
>  
> 
> int __init KXSD9_driver_init()
> 
> {
> 
>            /*Provide /dev interface to user space and export the file  
> 
>              operations */
> 
>            misc_register(&KXSD9_misc_device);
> 
>  
> 
>            /*Request the IRQ and install the interrupt handler*/
> 
>            request_irq(.. KXSD9_IRQ . .);
> 
>  
> 
>            /*Add the i2c_driver*/
> 
>            i2c_add_driver(&KXSD9_i2c_driver);
> 
> }
> 
>  
> 
> Is this the correct way of doing it???????? Or the file operations
> should be exported using some other method in case of i2c_drivers????
The key thing about init functions is that they are typically run once when
the driver module is inserted (or on initial boot up if the driver is built 
into the kernel)  If you want a unified character device for all such
accelerometers this would probably be the right place to do it.
(in this case we basically mean a single major number)

You would then need to add some registration code to the probe function
so that each accelerometer present is allocated a separate minor number,
thus allowing you to distinguish between them.

You could also take the more general approach used in iio (cribbed from
the input subsystem) to allow all accelerometer like sensors to share
a common major number then switch the file operations when the individual
character devices are opened to the set relevant to a particular
sensor.

Alternatively whilst I'm always in favour of people writing properly
structured drivers useful to anyone else with the same device,
you could just hard code all of the above into a driver along the lines
of exactly what you have suggested perhaps with a few to cleaning it
up and integrating with more general subsystems at a later date.

If you are interested in iio drop me an email and I'll send you a much
cleaner patch set that has yet been posted. (few bits to clean up yet
before I do a proper posting of a patch set).  Unfortunately it might
be a bit tricky to back port to 2.6.24 as I think there have been a
few changes in i2c since then.

Cheers
