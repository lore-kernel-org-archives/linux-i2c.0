From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 0/6] i2c: Get rid of the legacy binding model
Date: Sat, 2 May 2009 11:38:56 +0200
Message-ID: <20090502113856.39940f1e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

As the last few remaining legacy i2c drivers are being converted, we
can finally get rid of the legacy binding model supporting code in
i2c-core. Here come 6 patches which do exactly that:

[1/6] i2c: Kill client_register and client_unregister methods
[2/6] i2c: Get rid of the legacy binding model
[3/6] i2c: Drop i2c_probe function
[4/6] i2c: Merge i2c_attach_client into i2c_new_device
[5/6] i2c: Kill is_newstyle_driver
[6/6] i2c: Kill the redundant client list

As one would expect, the size reduction is very significant:

 Documentation/feature-removal-schedule.txt |   10 -
 Documentation/i2c/writing-clients          |   16 -
 drivers/i2c/i2c-core.c                     |  366 +++--------------------------
 include/linux/i2c.h                        |   57 +----
 4 files changed, 48 insertions(+), 401 deletions(-)

>From a binary perspective, "size" announces an 18% shrink.

There are two things which should still be investigated.

1* In i2c_device_uevent() there is the following piece of code:

	/* by definition, legacy drivers can't hotplug */
	if (dev->driver)
		return 0;

David, I presume this can go away?

2* Core locking should be checked. I am not completely sure what
core_lock was supposed to protect, nor what it should protect now. I
think it should protect at least i2c_adapter_idr, driver->detect()
calls (which may add a device to the driver->clients list) and
driver->attach_adapter() calls (for the same reason), although for the
latter two, a per-driver lock may be more appropriate.

At the moment, we also hold the lock for all of i2c_register_adapter(),
i2c_del_adapter() and i2c_del_driver(), but not i2c_register_driver(),
which seems a little inconsistent. David, do you know if we need to
serialize the calls to device_register() and device_unregister(), or if
the driver core takes care of this for us?

Anything else needs to be protected?

-- 
Jean Delvare
