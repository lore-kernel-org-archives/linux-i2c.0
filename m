From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/9] I2C ACPI operation region handler support
Date: Wed, 16 Apr 2014 21:24:33 +0800
Message-ID: <1397654682-7094-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, awilliam-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

ACPI 5.0 spec(5.5.2.4.5) defines GenericSerialBus(i2c, spi, uart) operation
region. It allows ACPI aml code able to access such kind of devices to
implement some ACPI standard method.

On the Asus T100TA, Bios use GenericSerialBus operation region to access
i2c device to get battery info. So battery function depends on the I2C
operation region support. Here is the bug link.
https://bugzilla.kernel.org/show_bug.cgi?id=69011

This patchset is to add I2C ACPI operation region handler support.

[PATCH 1/9] ACPICA: Executer: Fix buffer allocation issue for
[PATCH 2/9] ACPICA: Export acpi_buffer_to_resource symbol
[PATCH 3/9] ACPI: Add acpi_bus_attach_private_data() to facilitate to
[PATCH 4/9] ACPI/Thermal: Use acpi_bus_attach_private_data() to
[PATCH 5/9] I2C: Add smbus quick read/write helper function
[PATCH 6/9] I2C: Add smbus word/block process call helper function
[PATCH 7/9] I2C/ACPI: Add i2c ACPI operation region support
[PATCH 8/9] I2C/ACPI: Move ACPI related code to i2c-acpi.c
[PATCH 9/9] I2C/ACPI: Add CONFIG_I2C_ACPI config
