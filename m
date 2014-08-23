From: Mark Roszko <mark.roszko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Implementing bus recovery
Date: Fri, 22 Aug 2014 20:41:58 -0400
Message-ID: <CAJjB1q+_KbLBKXNMvG6DWHcuVOvmJs3XmT3B8yb-_a0K12ZJtw@mail.gmail.com>
References: <53F796B1.2000400@aqwary.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53F796B1.2000400-IfRblWqrl23QT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Lindgren <simon-IfRblWqrl23QT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Prepare_recovery and unprepare_recovery are to configure the pad
multiplexer since thats platform specific. You don't care about the
adapter reference as you just need the scl_gpio and sda_gpio values to
know what pins to reconfigure.

In fact Atmel's pad mux functions look like this:

at91_set_A_periph(unsigned pin, int use_pullup)
at91_set_B_periph(unsigned pin, int use_pullup)
at91_set_C_periph(unsigned pin, int use_pullup)
.....


Here's the latest(or close) driver specific patch that slipped through
the cracks it seems?
http://www.spinics.net/lists/linux-i2c/msg11357.html


Bus_recovery itself you have to call in the at91 driver on a
controller timeout just like the patch does.
 if (ret == 0) {
                 dev_err(dev->dev, "controller timed out\n");
-                at91_init_twi_bus(dev);
 +                if (i2c_recover_bus(dev->adapter->bus_recovery_info) < 0)
 +                      at91_init_twi_bus(dev);

                 ret = -ETIMEDOUT;
                 goto error;
}

the call stack looks something like this

--at91_twi_xfer
----- i2c_recover_bus
--------- i2c_generic_gpio_recovery
-------------i2c_get_gpios_for_recovery  (requests gpios)
-------------i2c_generic_recovery
----------------prepare_recovery         (configure padmux to put gpio
on the pin)
----------------get_sda, get_scl          (get gpio value, generic
function by default is fine for atmel)
----------------set_scl                       (set scl value, generic
function by default is fine for atmel)
----------------unrepare_recovery       (configure padmux to put twi
back on the pin)
-------------i2c_put_gpios_for_recovery (frees gpios)


Somewhere in at91_twi_probe before the adapter is registered you also
have to setup the bus_recovery_info struct and set recover_bus to the
i2c_generic_gpio_recovery function similar to the patch linked.
