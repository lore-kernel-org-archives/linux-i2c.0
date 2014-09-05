From: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 3/3] gpio: add support for the Diolan DLN-2 USB GPIO driver
Date: Fri, 5 Sep 2014 19:04:51 +0300
Message-ID: <CAE1zotK4QkA9PWW=uOmM-j=N=MNuBt1v3CgdA+GXctdFUZ3QKA@mail.gmail.com>
References: <1409930279-1382-1-git-send-email-octavian.purdila@intel.com>
	<1409930279-1382-4-git-send-email-octavian.purdila@intel.com>
	<20140905153835.GC13242@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140905153835.GC13242@localhost>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Sep 5, 2014 at 6:38 PM, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Sep 05, 2014 at 06:17:59PM +0300, Octavian Purdila wrote:
>
>> +static int dln2_do_remove(struct dln2_gpio *dln2)
>> +{
>> +     /* When removing the DLN2 USB device, gpiochip_remove may fail
>> +      * due to i2c drivers holding a GPIO pin. However, the i2c bus
>> +      * will eventually be removed triggering an i2c driver remove
>> +      * which will release the GPIO pin. So retrying the operation
>> +      * later should succeed. */
>> +     int ret = gpiochip_remove(&dln2->gpio);
>> +     struct device *dev = dln2->gpio.dev;
>> +
>> +     if (ret < 0) {
>> +             if (ret == -EBUSY)
>> +                     schedule_delayed_work(&dln2->remove_work.work, HZ/10);
>> +             else
>> +                     dev_warn(dev, "error removing gpio chip: %d\n", ret);
>> +     } else {
>> +             kfree(dln2);
>> +     }
>> +
>> +     return ret;
>> +}
>
> Apparently, the return value from gpiochip_remove is going away:
>
>         "Start to kill off the return value from gpiochip_remove() by
>         removing the __must_check attribute and removing all checks
>         inside the drivers/gpio directory. The rationale is: well what
>         were we supposed to do if there is an error code? Not much:
>         print an error message. And gpiolib already does that. So make
>         this function return void eventually."
>
>         https://www.mail-archive.com/linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg03468.html
>

Oh, I missed this, thanks for pointing it out.

> Also, have you considered what happens if there are gpios exported
> through sysfs? These may never be released.
>
> In general, how well have these patches been tested with disconnect
> events? At least gpiolib is known to blow up (sooner or later) when a
> gpiochip is removed when having requested gpios.
>

I do disconnect tests regularly. Since switching to the new irq
interface the following patch is needed:

https://lkml.org/lkml/2014/9/5/408

With it and the current patch sets things seems to work well.
