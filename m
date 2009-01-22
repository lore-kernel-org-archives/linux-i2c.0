From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Again on virtual i2c adapter support.
Date: Thu, 22 Jan 2009 16:02:30 +0100
Message-ID: <20090122150230.GA10952@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Jean,

I'm working again on virtual i2c adapter support :) since I received
several letters asking for this support. That's why I'd like to have
from you some advice in order to propose a working code.

Looking at latest i2c code I suppose we can modify the
i2c_del_driver() function as follow:

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index b1c9abe..3454878 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -799,10 +799,10 @@ void i2c_del_driver(struct i2c_driver *driver)
        class_for_each_device(&i2c_adapter_class, NULL, driver,
                              __detach_adapter);

+       mutex_unlock(&core_lock);
+
        driver_unregister(&driver->driver);
        pr_debug("i2c-core: driver [%s] unregistered\n",
        driver->driver.name);
-
-       mutex_unlock(&core_lock);
 }
 EXPORT_SYMBOL(i2c_del_driver);

Unluckely I'm not an i2c guru so I'd like to ask to you. If such
modification is correct I can provide a simple support with no
modifications to the i2c core! Apart this one, of course... :)

If you agree I can send a patchset, but everything is based on the
above change...

Thanks for your suggestions,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
