From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC PATCH 0/2] runtime PM support for I2C clients
Date: Tue, 20 Aug 2013 17:03:34 +0300
Message-ID: <1377007416-13851-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi all,

With the advent of ACPI 5.0 we are starting to see I2C client devices
described in ACPI namespace that support power management by the means of
standard ACPI _PSx-methods. For example Intel Haswell based platforms might
have touch screen or sensor-hub connected to the I2C bus that can be
powered on and off by calling _PS0 and _PS3 -methods.

In order to support such I2C client devices, we decided to hook the ACPI
power management for these to the standard Linux runtime PM framework.

These patches implement runtime PM support for I2C client devices in a
similar way that is done already for the PCI bus. Just before a driver is
bound to an I2C client device the device runtime PM is being prepared for
that device.

If the device in question has an ACPI handle we attach it to the ACPI power
domain that then makes sure that the right _PSx methods are called in
response to runtime PM events the driver generates.

A driver that wants to participate in runtime PM and power manage its
device should:
 1) Implement device specific runtime PM callbacks if needed.
 2) Call pm_runtime_put() (or some variant of that) to decrease the runtime
    PM reference count.

If the driver doesn't do anything the device is regarded as runtime PM
active and powered on.

Even though this series has been developed specifically for ACPI enumerated
I2C client devices, I believe it can be useful for other I2C client drivers
because the I2C core now prepares the runtime PM on behalf of the driver
and thus reduces the amount of code a driver writer needs to add.

Aaron Lu (1):
  i2c: prepare runtime PM support for I2C client devices

Lv Zheng (1):
  i2c: attach/detach I2C client device to the ACPI power domain

 drivers/i2c/i2c-core.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

-- 
1.8.4.rc2
