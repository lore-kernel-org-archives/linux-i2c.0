From: Bill Gatliff <bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org>
Subject: Power up/down of an I2C client?
Date: Mon, 15 Nov 2010 20:44:10 -0800
Message-ID: <AANLkTinjBBxiq4K6wn8raOgooKtBhF3sW-k2FUSWNDzY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Guys:


I have several boards that can control the power supply to their i2c
chips, and I need to power down/up those chips when the boards go
through suspend/resume.  The problem is, I'm using the same chip on
all of the boards but the mechanism for controlling the power supply
to each one is different on each board.

For platform devices, I deal with the above problem by declaring a
board-specific, "parent" device that gets the suspend/resume events
after/before the actual chip driver does.  I fiddle with the power
supplies in those parent suspend/resume methods.  Something like this:

static int parent_probe(struct platform_device *this)
{
       platform_device_register_data(&this->dev, "child", -1, NULL, 0);
       return 0;
}

static int parent_suspend(struct device *this)
{
     /* power down the child device--- it has already been suspended */
     gpio_direction_output(..., 0);
     return 0;
}

static int parent_resume(struct device *this)
{
     /* power up the child device--- it will get resumed after we return */
     gpio_direction_output(..., 1);
     return 0;
}

static struct dev_pm_ops parent_pm_ops = {
       .suspend = parent_suspend,
       .resume = parent_resume,
};

static struct platform_driver parent_driver = {
       .probe = parent_probe,
       .driver = {
               .name = "parent",
               .pm = &parent_pm_ops,
               .owner = THIS_MODULE,
       },
};

...

     platform_device_register_simple("parent", -1, NULL, 0);


The above code may seem complicated, but it lets me completely
separate the power mechanism from the rest of the driver.  As such, it
gives me the freedom to completely change how power is managed to the
chip on a given board, without having to edit--- or even recompile---
chip driver code itself.  I write the chip driver code once, and it
stays written forever!

Trouble is, I can't come up with an equivalent approach for i2c
devices.  The i2c system uses both parents and buses itself, leaving
me without a convenient hook for catching events.  Is there no way to
"wrap" i2c devices the way you can for platform devices?

Reparenting the i2c adapter itself seems like the only alternative
here, and I might be able to live with that--- but it becomes a bit of
a nightmare when each chip on the bus is configurable as to whether it
will be a wakeup source (and therefore shouldn't be powered down), or
not.  That means I have to find and walk the device list to see who
needs to stay powered up, and who gets put to sleep...

I can't help but think that I'm missing something that would let me
have i2c chip-specific power controllers like I have for my platform
devices.  Any suggestions here would be greatly appreciated.

Thanks!


b.g.
-- 
Bill Gatliff
bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org
