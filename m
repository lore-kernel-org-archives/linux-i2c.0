From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Mon, 31 Jul 2017 18:24:47 +0200
Message-ID: <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Jan Kotas <jank@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-i2c@vger.kernel.org

Add core infrastructure to support I3C in Linux and document it.

This infrastructure is not complete yet and will be extended over
time.

There are a few design choices that are worth mentioning because they
impact the way I3C device drivers can interact with their devices:

- all functions used to send I3C/I2C frames must be called in
  non-atomic context. Mainly done this way to ease implementation, but
  this is still open to discussion. Please let me know if you think it's
  worth considering an asynchronous model here
- the bus element is a separate object and is not implicitly described
  by the master (as done in I2C). The reason is that I want to be able
  to handle multiple master connected to the same bus and visible to
  Linux.
  In this situation, we should only have one instance of the device and
  not one per master, and sharing the bus object would be part of the
  solution to gracefully handle this case.
  I'm not sure we will ever need to deal with multiple masters
  controlling the same bus and exposed under Linux, but separating the
  bus and master concept is pretty easy, hence the decision to do it
  like that.
  The other benefit of separating the bus and master concepts is that
  master devices appear under the bus directory in sysfs.
- I2C backward compatibility has been designed to be transparent to I2C
  drivers and the I2C subsystem. The I3C master just registers an I2C
  adapter which creates a new I2C bus. I'd say that, from a
  representation PoV it's not ideal because what should appear as a
  single I3C bus exposing I3C and I2C devices here appears as 2
  different busses connected to each other through the parenting (the
  I3C master is the parent of the I2C and I3C busses).
  On the other hand, I don't see a better solution if we want something
  that is not invasive.
- the whole API is exposed through a single header file (i3c.h), but I'm
  seriously considering the option of splitting the I3C driver/user API
  and the I3C master one, mainly to hide I3C core internals and restrict
  what I3C users can do to a limited set of functionalities (send
  I3C/I2C frames to a specific device and that's all).

Missing features in this preliminary version:
- no support for IBI (In Band Interrupts). This is something I'm working
  on, and I'm still unsure how to represent it: an irqchip or a
  completely independent representation that would be I3C specific.
  Right now, I'm more inclined to go for the irqchip approach, since
  this is something people are used to deal with already.
- no Hot Join support, which is similar to hotplug
- no support for multi-master and the associated concepts (mastership
  handover, support for secondary masters, ...)
- I2C devices can only be described using DT because this is the only
  use case I have. However, the framework can easily be extended with
  ACPI and board info support
- I3C slave framework. This has been completely omitted, but shouldn't
  have a huge impact on the I3C framework because I3C slaves don't see
  the whole bus, it's only about handling master requests and generating
  IBIs. Some of the struct, constant and enum definitions could be
  shared, but most of the I3C slave framework logic will be different

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 Documentation/i3c/conf.py               |   10 +
 Documentation/i3c/device-driver-api.rst |    7 +
 Documentation/i3c/index.rst             |    9 +
 Documentation/i3c/master-driver-api.rst |    8 +
 Documentation/i3c/protocol.rst          |  199 +++++
 Documentation/index.rst                 |    1 +
 drivers/Kconfig                         |    2 +
 drivers/Makefile                        |    2 +-
 drivers/i3c/Kconfig                     |   24 +
 drivers/i3c/Makefile                    |    3 +
 drivers/i3c/core.c                      |  532 ++++++++++++++
 drivers/i3c/device.c                    |  138 ++++
 drivers/i3c/internals.h                 |   45 ++
 drivers/i3c/master.c                    | 1225 +++++++++++++++++++++++++++++++
 drivers/i3c/master/Kconfig              |    0
 drivers/i3c/master/Makefile             |    0
 include/linux/i3c/ccc.h                 |  389 ++++++++++
 include/linux/i3c/device.h              |  212 ++++++
 include/linux/i3c/master.h              |  453 ++++++++++++
 include/linux/mod_devicetable.h         |   15 +
 20 files changed, 3273 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/i3c/conf.py
 create mode 100644 Documentation/i3c/device-driver-api.rst
 create mode 100644 Documentation/i3c/index.rst
 create mode 100644 Documentation/i3c/master-driver-api.rst
 create mode 100644 Documentation/i3c/protocol.rst
 create mode 100644 drivers/i3c/Kconfig
 create mode 100644 drivers/i3c/Makefile
 create mode 100644 drivers/i3c/core.c
 create mode 100644 drivers/i3c/device.c
 create mode 100644 drivers/i3c/internals.h
 create mode 100644 drivers/i3c/master.c
 create mode 100644 drivers/i3c/master/Kconfig
 create mode 100644 drivers/i3c/master/Makefile
 create mode 100644 include/linux/i3c/ccc.h
 create mode 100644 include/linux/i3c/device.h
 create mode 100644 include/linux/i3c/master.h

diff --git a/Documentation/i3c/conf.py b/Documentation/i3c/conf.py
new file mode 100644
index 000000000000..5a20832d59a7
--- /dev/null
+++ b/Documentation/i3c/conf.py
@@ -0,0 +1,10 @@
+# -*- coding: utf-8; mode: python -*-
+
+project = "Linux I3C Subsystem"
+
+tags.add("subproject")
+
+latex_documents = [
+    ('index', 'i3c.tex', project,
+     'The kernel development community', 'manual'),
+]
diff --git a/Documentation/i3c/device-driver-api.rst b/Documentation/i3c/device-driver-api.rst
new file mode 100644
index 000000000000..63c843f148a6
--- /dev/null
+++ b/Documentation/i3c/device-driver-api.rst
@@ -0,0 +1,7 @@
+=====================
+I3C device driver API
+=====================
+
+.. kernel-doc:: include/linux/i3c/device.h
+
+.. kernel-doc:: drivers/i3c/device.c
diff --git a/Documentation/i3c/index.rst b/Documentation/i3c/index.rst
new file mode 100644
index 000000000000..9c439220439d
--- /dev/null
+++ b/Documentation/i3c/index.rst
@@ -0,0 +1,9 @@
+=============
+I3C subsystem
+=============
+
+.. toctree::
+
+   protocol
+   device-driver-api
+   master-driver-api
diff --git a/Documentation/i3c/master-driver-api.rst b/Documentation/i3c/master-driver-api.rst
new file mode 100644
index 000000000000..017e7711cdf7
--- /dev/null
+++ b/Documentation/i3c/master-driver-api.rst
@@ -0,0 +1,8 @@
+================================
+I3C master controller driver API
+================================
+
+.. kernel-doc:: drivers/i3c/master.c
+
+.. kernel-doc:: include/linux/i3c/master.h
+
diff --git a/Documentation/i3c/protocol.rst b/Documentation/i3c/protocol.rst
new file mode 100644
index 000000000000..f140029d8175
--- /dev/null
+++ b/Documentation/i3c/protocol.rst
@@ -0,0 +1,199 @@
+============
+I3C protocol
+============
+
+Disclaimer
+==========
+
+This chapter will focus on aspects that matter to software developers. For
+everything hardware related (like how things are transmitted on the bus, how
+collisions are prevented, ...) please have a look at the I3C specification.
+
+This document is just a brief introduction to the I3C protocol and the concepts
+it brings on the table. If you need more information, please refer to the MIPI
+I3C specification.
+
+Introduction
+============
+
+The I3C (I-Cube-C) is a MIPI standardized protocol designed to overcome I2C
+limitations (limited speed, external signals needed for interrupts, no
+automatic detection of the devices connected to the bus, ...) while remaining
+power-efficient.
+
+I3C Bus
+=======
+
+An I3C bus is made of several I3C devices and possibly some I2C devices as
+well, but let's focus on I3C devices for now.
+
+An I3C device on the I3C bus can have one of the following roles:
+
+* Master: the device is driving the bus. It's the one in charge of initiating
+  transactions or deciding who is allowed to talk on the bus (slave generated
+  events are possible in I3C, see below).
+* Slave: the device acts as a slave, and is not able to send frames to another
+  slave on the bus. The device can still send events to the master on
+  its own initiative if the master allowed it.
+
+I3C is a multi-master protocol, so there might be several masters on a bus,
+though only one device can act as a master at a given time. In order to gain
+bus ownership, a master has to follow a specific procedure.
+
+Each device on the I3C bus has to be assigned a dynamic address to be able to
+communicate. Until this is done, the device should only respond to a limited
+set of commands. If it has a static address (also called legacy I2C address),
+the device can reply to I2C transfers.
+
+In addition to these per-device addresses, the protocol defines a broadcast
+address in order to address all devices on the bus.
+
+Once a dynamic address has been assigned to a device, this address will be used
+for any direct communication with the device. Note that even after being
+assigned a dynamic address, the device should still process broadcast messages.
+
+I3C Device discovery
+====================
+
+The I3C protocol defines a mechanism to automatically discover devices present
+on the bus, their capabilities and the functionalities they provide. In this
+regard I3C is closer to a discoverable bus like USB than it is to I2C or SPI.
+
+The discovery mechanism is called DAA (Dynamic Address Assignment), because it
+not only discovers devices but also assigns them a dynamic address.
+
+During DAA, each I3C device reports 3 important things:
+
+* BCR: Bus Characteristic Register. This 8-bit register describes the device bus
+  related capabilities
+* DCR: Device Characteristic Register. This 8-bit register describes the
+  functionalities provided by the device
+* Provisional ID: A 48-bit unique identifier. On a given bus there should be no
+  Provisional ID collision, otherwise the discovery mechanism may fail.
+
+I3C slave events
+================
+
+The I3C protocol allows slaves to generate events on their own, and thus allows
+them to take temporary control of the bus.
+
+This mechanism is called IBI for In Band Interrupts, and as stated in the name,
+it allows devices to generate interrupts without requiring an external signal.
+
+During DAA, each device on the bus has been assigned an address, and this
+address will serve as a priority identifier to determine who wins if 2 different
+devices are generating an interrupt at the same moment on the bus (the lower the
+dynamic address the higher the priority).
+
+Masters are allowed to inhibit interrupts if they want to. This inhibition
+request can be broadcasted (applies to all devices) or sent to a specific
+device.
+
+I3C Hot-Join
+============
+
+The Hot-Join mechanism is similart to USB hotplug. This mechanism allows
+slaves to join the bus after it has been initialized by the master.
+
+This covers the following use cases:
+* the device is not powered when the bus is probed
+* the device is hotplugged on the bus through an extension board
+
+This mechanism is relying on slave events to inform the master that a new
+device joined the bus and is waiting for a dynamic address.
+
+The master is then free to address the request as it wishes: ignore it or
+assign a dynamic address to the slave.
+
+I3C transfer types
+==================
+
+If you omit SMBus (which is just a standardization on how to access registers
+exposed by I2C devices), I2C has only one transfer type.
+
+I3C defines 3 different classes of transfer in addition to I2C transfers which
+are here for backward compatibility with I2C devices.
+
+I3C CCC commands
+----------------
+
+CCC (Common Command Code) commands are meant to be used for anything that is
+related to bus management and all features that are common to a set of devices.
+
+CCC commands contain an 8-bit CCC id describing the command that is executed.
+The MSB of this id specifies whether this is a broadcast command (bit7 = 0) or a
+unicast one (bit7 = 1).
+
+The command ID can be followed by a payload. Depending on the command, this
+payload is either sent by the master sending the command (write CCC command),
+or sent by the slave receiving the command (read CCC command). Of course, read
+accesses only apply to unicast commands.
+Note that, when sending a CCC command to a specific device, the device address
+is passed in the first byte of the payload.
+
+The payload length is not explicitly passed on the bus, and should be extracted
+from the CCC id.
+
+Note that vendors can use a dedicated range of CCC ids for their own commands
+(0x61-0x7f and 0xe0-0xef).
+
+I3C Private SDR transfers
+-------------------------
+
+Private SDR (Single Data Rate) transfers should be used for anything that is
+device specific and does not require high transfer speed.
+
+It is the equivalent of I2C transfers but in the I3C world. Each transfer is
+passed the device address (dynamic address assigned during DAA), a payload
+and a direction.
+
+The only difference with I2C is that the transfer is much faster (typical SCL
+frequency is 12.5MHz).
+
+I3C Private HDR commands
+------------------------
+
+HDR commands should be used for anything that is device specific and requires
+high transfer speed.
+
+The first thing attached to an HDR command is the HDR mode. There are currently
+3 different modes defined by the I3C specification (refer to the specification
+for more details):
+
+* HDR-DDR: Double Data Rate mode
+* HDR-TSP: Ternary Symbol Pure. Only usable on busses with no I2C devices
+* HDR-TSL: Ternary Symbol Legacy. Usable on busses with I2C devices
+
+When sending an HDR command, the whole bus has to enter HDR mode, which is done
+using a broadcast CCC command.
+Once the bus has entered a specific HDR mode, the master sends the HDR command.
+An HDR command is made of:
+
+* one 16-bits command word
+* N 16-bits data words
+
+Those words may be wrapped with specific preambles/post-ambles which depend on
+the chosen HDR mode and are detailed here (see the specification for more
+details).
+
+The 16-bits command word is made of:
+
+* bit[15]: direction bit, read is 1 write is 0
+* bit[14:8]: command code. Identifies the command being executed, the amount of
+  data words and their meaning
+* bit[7:1]: I3C address of the device this command is addressed to
+* bit[0]: reserved/parity-bit
+
+Backward compatibility with I2C devices
+=======================================
+
+The I3C protocol has been designed to be backward compatible with I2C devices.
+This backward compatibility allows one to connect a mix of I2C and I3C devices
+on the same bus, though, in order to be really efficient, I2C devices should
+be equipped with 50 ns spike filters.
+
+I2C devices can't be discovered like I3C ones and have to be statically
+declared. In order to let the master know what these devices are capable of
+(both in terms of bus related limitations and functionalities), the software
+has to provide some information, which is done through the LVR (Legacy I2C
+Virtual Register).
diff --git a/Documentation/index.rst b/Documentation/index.rst
index cb7f1ba5b3b1..da041b972fb1 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -75,6 +75,7 @@ needed).
    sound/index
    crypto/index
    filesystems/index
+   i3c/index
 
 Architecture-specific documentation
 -----------------------------------
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 505c676fa9c7..281e883bbdaf 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -54,6 +54,8 @@ source "drivers/char/Kconfig"
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/i3c/Kconfig"
+
 source "drivers/spi/Kconfig"
 
 source "drivers/spmi/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index dfdcda00bfe3..e2a74abbd5b1 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -111,7 +111,7 @@ obj-$(CONFIG_SERIO)		+= input/serio/
 obj-$(CONFIG_GAMEPORT)		+= input/gameport/
 obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_RTC_LIB)		+= rtc/
-obj-y				+= i2c/ media/
+obj-y				+= i2c/ i3c/ media/
 obj-$(CONFIG_PPS)		+= pps/
 obj-y				+= ptp/
 obj-$(CONFIG_W1)		+= w1/
diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
new file mode 100644
index 000000000000..0165c1072ac6
--- /dev/null
+++ b/drivers/i3c/Kconfig
@@ -0,0 +1,24 @@
+menu "I3C support"
+
+config I3C
+	tristate "I3C support"
+	---help---
+	  I3C (pronounce: I-cube-C) is a serial protocol standardized by the
+	  MIPI alliance.
+
+	  It's supposed to be backward compatible with I2C while providing
+	  support for high speed transfers and native interrupt support
+	  without the need for extra pins.
+
+	  The I3C protocol also standardizes the slave device types and is
+	  mainly design to communicate with sensors.
+
+	  If you want I3C support, you should say Y here and also to the
+	  specific driver for your bus adapter(s) below.
+
+	  This I3C support can also be built as a module.  If so, the module
+	  will be called i3c.
+
+source "drivers/i3c/master/Kconfig"
+
+endmenu
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
new file mode 100644
index 000000000000..0605a275f47b
--- /dev/null
+++ b/drivers/i3c/Makefile
@@ -0,0 +1,3 @@
+i3c-y				:= core.o device.o master.o
+obj-$(CONFIG_I3C)		+= i3c.o
+obj-$(CONFIG_I3C)		+= master/
diff --git a/drivers/i3c/core.c b/drivers/i3c/core.c
new file mode 100644
index 000000000000..c000fb458547
--- /dev/null
+++ b/drivers/i3c/core.c
@@ -0,0 +1,532 @@
+/*
+ * Copyright (C) 2017 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/idr.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+
+#include "internals.h"
+
+static DEFINE_IDR(i3c_bus_idr);
+static DEFINE_MUTEX(i3c_core_lock);
+
+void i3c_bus_lock(struct i3c_bus *bus, bool exclusive)
+{
+	if (exclusive)
+		down_write(&bus->lock);
+	else
+		down_read(&bus->lock);
+}
+
+void i3c_bus_unlock(struct i3c_bus *bus, bool exclusive)
+{
+	if (exclusive)
+		up_write(&bus->lock);
+	else
+		up_read(&bus->lock);
+}
+
+static ssize_t bcr_show(struct device *dev,
+			struct device_attribute *da,
+			char *buf)
+{
+	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
+	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
+	ssize_t ret;
+
+	i3c_bus_lock(bus, false);
+	ret = sprintf(buf, "%x\n", i3cdev->info.bcr);
+	i3c_bus_unlock(bus, false);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(bcr);
+
+static ssize_t dcr_show(struct device *dev,
+			struct device_attribute *da,
+			char *buf)
+{
+	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
+	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
+	ssize_t ret;
+
+	i3c_bus_lock(bus, false);
+	ret = sprintf(buf, "%x\n", i3cdev->info.dcr);
+	i3c_bus_unlock(bus, false);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(dcr);
+
+static ssize_t pid_show(struct device *dev,
+			struct device_attribute *da,
+			char *buf)
+{
+	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
+	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
+	ssize_t ret;
+
+	i3c_bus_lock(bus, false);
+	ret = sprintf(buf, "%llx\n", i3cdev->info.pid);
+	i3c_bus_unlock(bus, false);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(pid);
+
+static ssize_t address_show(struct device *dev,
+			    struct device_attribute *da,
+			    char *buf)
+{
+	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
+	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
+	ssize_t ret;
+
+	i3c_bus_lock(bus, false);
+	ret = sprintf(buf, "%02x\n", i3cdev->info.dyn_addr);
+	i3c_bus_unlock(bus, false);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(address);
+
+static const char * const hdrcap_strings[] = {
+	"hdr-ddr", "hdr-tsp", "hdr-tsl",
+};
+
+static ssize_t hdrcap_show(struct device *dev,
+			   struct device_attribute *da,
+			   char *buf)
+{
+	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
+	struct i3c_bus *bus = i3c_device_get_bus(i3cdev);
+	unsigned long caps = i3cdev->info.hdr_cap;
+	ssize_t offset = 0, ret;
+	int mode;
+
+	i3c_bus_lock(bus, false);
+	for_each_set_bit(mode, &caps, 8) {
+		if (mode >= ARRAY_SIZE(hdrcap_strings))
+			break;
+
+		if (!hdrcap_strings[mode])
+			continue;
+
+		ret = sprintf(buf + offset, "%s\n", hdrcap_strings[mode]);
+		if (ret < 0)
+			goto out;
+
+		offset += ret;
+	}
+	ret = offset;
+
+out:
+	i3c_bus_unlock(bus, false);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(hdrcap);
+
+static struct attribute *i3c_device_attrs[] = {
+	&dev_attr_bcr.attr,
+	&dev_attr_dcr.attr,
+	&dev_attr_pid.attr,
+	&dev_attr_address.attr,
+	&dev_attr_hdrcap.attr,
+	NULL,
+};
+
+static const struct attribute_group i3c_device_group = {
+	.attrs = i3c_device_attrs,
+};
+
+static const struct attribute_group *i3c_device_groups[] = {
+	&i3c_device_group,
+	NULL,
+};
+
+static int i3c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
+	u16 manuf = I3C_PID_MANUF_ID(i3cdev->info.pid);
+	u16 part = I3C_PID_PART_ID(i3cdev->info.pid);
+	u16 ext = I3C_PID_EXTRA_INFO(i3cdev->info.pid);
+
+	if (I3C_PID_RND_LOWER_32BITS(i3cdev->info.pid))
+		return add_uevent_var(env, "MODALIAS=i3c:dcr%02Xmanuf%04X",
+				      i3cdev->info.dcr, manuf);
+
+	return add_uevent_var(env,
+			      "MODALIAS=i3c:dcr%02Xmanuf%04Xpart%04xext%04x",
+			      i3cdev->info.dcr, manuf, part, ext);
+}
+
+const struct device_type i3c_device_type = {
+	.groups	= i3c_device_groups,
+	.uevent = i3c_device_uevent,
+};
+
+static const struct attribute_group *i3c_master_groups[] = {
+	&i3c_device_group,
+	NULL,
+};
+
+const struct device_type i3c_master_type = {
+	.groups	= i3c_master_groups,
+};
+
+static const char * const i3c_bus_mode_strings[] = {
+	[I3C_BUS_MODE_PURE] = "pure",
+	[I3C_BUS_MODE_MIXED_FAST] = "mixed-fast",
+	[I3C_BUS_MODE_MIXED_SLOW] = "mixed-slow",
+};
+
+static ssize_t mode_show(struct device *dev,
+			 struct device_attribute *da,
+			 char *buf)
+{
+	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
+	ssize_t ret;
+
+	i3c_bus_lock(i3cbus, false);
+	if (i3cbus->mode < 0 ||
+	    i3cbus->mode > ARRAY_SIZE(i3c_bus_mode_strings) ||
+	    !i3c_bus_mode_strings[i3cbus->mode])
+		ret = sprintf(buf, "unknown\n");
+	else
+		ret = sprintf(buf, "%s\n", i3c_bus_mode_strings[i3cbus->mode]);
+	i3c_bus_unlock(i3cbus, false);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(mode);
+
+static ssize_t current_master_show(struct device *dev,
+				   struct device_attribute *da,
+				   char *buf)
+{
+	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
+	ssize_t ret;
+
+	i3c_bus_lock(i3cbus, false);
+	ret = sprintf(buf, "%s\n", dev_name(&i3cbus->cur_master->dev));
+	i3c_bus_unlock(i3cbus, false);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(current_master);
+
+static ssize_t i3c_scl_frequency_show(struct device *dev,
+				      struct device_attribute *da,
+				      char *buf)
+{
+	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
+	ssize_t ret;
+
+	i3c_bus_lock(i3cbus, false);
+	ret = sprintf(buf, "%ld\n", i3cbus->scl_rate.i3c);
+	i3c_bus_unlock(i3cbus, false);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(i3c_scl_frequency);
+
+static ssize_t i2c_scl_frequency_show(struct device *dev,
+				      struct device_attribute *da,
+				      char *buf)
+{
+	struct i3c_bus *i3cbus = container_of(dev, struct i3c_bus, dev);
+	ssize_t ret;
+
+	i3c_bus_lock(i3cbus, false);
+	ret = sprintf(buf, "%ld\n", i3cbus->scl_rate.i2c);
+	i3c_bus_unlock(i3cbus, false);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(i2c_scl_frequency);
+
+static struct attribute *i3c_busdev_attrs[] = {
+	&dev_attr_mode.attr,
+	&dev_attr_current_master.attr,
+	&dev_attr_i3c_scl_frequency.attr,
+	&dev_attr_i2c_scl_frequency.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(i3c_busdev);
+
+static const struct device_type i3c_busdev_type = {
+	.groups	= i3c_busdev_groups,
+};
+
+static const struct i3c_device_id *
+i3c_device_match_id(struct i3c_device *i3cdev,
+		    const struct i3c_device_id *id_table)
+{
+	const struct i3c_device_id *id;
+
+	/*
+	 * The lower 32bits of the provisional ID is just filled with a random
+	 * value, try to match using DCR info.
+	 */
+	if (!I3C_PID_RND_LOWER_32BITS(i3cdev->info.pid)) {
+		u16 manuf = I3C_PID_MANUF_ID(i3cdev->info.pid);
+		u16 part = I3C_PID_PART_ID(i3cdev->info.pid);
+		u16 ext_info = I3C_PID_EXTRA_INFO(i3cdev->info.pid);
+
+		/* First try to match by manufacturer/part ID. */
+		for (id = id_table; id->match_flags != 0; id++) {
+			if ((id->match_flags & I3C_MATCH_MANUF_AND_PART) !=
+			    I3C_MATCH_MANUF_AND_PART)
+				continue;
+
+			if (manuf != id->manuf_id || part != id->part_id)
+				continue;
+
+			if ((id->match_flags & I3C_MATCH_EXTRA_INFO) &&
+			    ext_info != id->extra_info)
+				continue;
+
+			return id;
+		}
+	}
+
+	/* Fallback to DCR match. */
+	for (id = id_table; id->match_flags != 0; id++) {
+		if ((id->match_flags & I3C_MATCH_DCR) &&
+		    id->dcr == i3cdev->info.dcr)
+			return id;
+	}
+
+	return NULL;
+}
+
+static int i3c_device_match(struct device *dev, struct device_driver *drv)
+{
+	struct i3c_device *i3cdev;
+	struct i3c_driver *i3cdrv;
+
+	if (dev->type != &i3c_device_type)
+		return 0;
+
+	i3cdev = dev_to_i3cdev(dev);
+	i3cdrv = drv_to_i3cdrv(drv);
+	if (i3c_device_match_id(i3cdev, i3cdrv->id_table))
+		return 1;
+
+	return 0;
+}
+
+static int i3c_device_probe(struct device *dev)
+{
+	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
+	struct i3c_driver *driver = drv_to_i3cdrv(dev->driver);
+
+	return driver->probe(i3cdev);
+}
+
+static int i3c_device_remove(struct device *dev)
+{
+	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
+	struct i3c_driver *driver = drv_to_i3cdrv(dev->driver);
+
+	return driver->remove(i3cdev);
+}
+
+struct bus_type i3c_bus_type = {
+	.name = "i3c",
+	.match = i3c_device_match,
+	.probe = i3c_device_probe,
+	.remove = i3c_device_remove,
+};
+
+enum i3c_addr_slot_status i3c_bus_get_addr_slot_status(struct i3c_bus *bus,
+						       u16 addr)
+{
+	int status, bitpos = addr * 2;
+
+	if (addr > I2C_MAX_ADDR)
+		return I3C_ADDR_SLOT_RSVD;
+
+	status = bus->addrslots[bitpos / BITS_PER_LONG];
+	status >>= bitpos % BITS_PER_LONG;
+
+	return status & I3C_ADDR_SLOT_STATUS_MASK;
+}
+
+void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
+				  enum i3c_addr_slot_status status)
+{
+	int bitpos = addr * 2;
+	unsigned long *ptr;
+
+	if (addr > I2C_MAX_ADDR)
+		return;
+
+	ptr = bus->addrslots + (bitpos / BITS_PER_LONG);
+	*ptr &= ~(I3C_ADDR_SLOT_STATUS_MASK << (bitpos % BITS_PER_LONG));
+	*ptr |= status << (bitpos % BITS_PER_LONG);
+}
+
+bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
+{
+	enum i3c_addr_slot_status status;
+
+	status = i3c_bus_get_addr_slot_status(bus, addr);
+
+	return status == I3C_ADDR_SLOT_FREE;
+}
+
+int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr)
+{
+	enum i3c_addr_slot_status status;
+	u8 addr;
+
+	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
+		status = i3c_bus_get_addr_slot_status(bus, addr);
+		if (status == I3C_ADDR_SLOT_FREE)
+			return addr;
+	}
+
+	return -ENOMEM;
+}
+
+static void i3c_bus_init_addrslots(struct i3c_bus *bus)
+{
+	int i;
+
+	/* Addresses 0 to 7 are reserved. */
+	for (i = 0; i < 8; i++)
+		i3c_bus_set_addr_slot_status(bus, i, I3C_ADDR_SLOT_RSVD);
+
+	/*
+	 * Reserve broadcast address and all addresses that might collide
+	 * with the broadcast address when facing a single bit error.
+	 */
+	i3c_bus_set_addr_slot_status(bus, I3C_BROADCAST_ADDR,
+				     I3C_ADDR_SLOT_RSVD);
+	for (i = 0; i < 7; i++)
+		i3c_bus_set_addr_slot_status(bus, I3C_BROADCAST_ADDR ^ BIT(i),
+					     I3C_ADDR_SLOT_RSVD);
+}
+
+void i3c_bus_destroy(struct i3c_bus *bus)
+{
+	mutex_lock(&i3c_core_lock);
+	idr_remove(&i3c_bus_idr, bus->id);
+	mutex_unlock(&i3c_core_lock);
+
+	kfree(bus);
+}
+
+struct i3c_bus *i3c_bus_create(struct device *parent)
+{
+	struct i3c_bus *i3cbus;
+	int ret;
+
+	i3cbus = kzalloc(sizeof(*i3cbus), GFP_KERNEL);
+	if (!i3cbus)
+		return ERR_PTR(-ENOMEM);
+
+	init_rwsem(&i3cbus->lock);
+	INIT_LIST_HEAD(&i3cbus->devs.i2c);
+	INIT_LIST_HEAD(&i3cbus->devs.i3c);
+	i3c_bus_init_addrslots(i3cbus);
+	i3cbus->mode = I3C_BUS_MODE_PURE;
+	i3cbus->dev.parent = parent;
+	i3cbus->dev.of_node = parent->of_node;
+	i3cbus->dev.bus = &i3c_bus_type;
+	i3cbus->dev.type = &i3c_busdev_type;
+
+	mutex_lock(&i3c_core_lock);
+	ret = idr_alloc(&i3c_bus_idr, i3cbus, 0, 0, GFP_KERNEL);
+	mutex_unlock(&i3c_core_lock);
+	if (ret < 0)
+		goto err_free_bus;
+
+	i3cbus->id = ret;
+
+	return i3cbus;
+
+err_free_bus:
+	kfree(i3cbus);
+
+	return ERR_PTR(ret);
+}
+
+void i3c_bus_unregister(struct i3c_bus *bus)
+{
+	device_unregister(&bus->dev);
+}
+
+int i3c_bus_register(struct i3c_bus *i3cbus)
+{
+	struct i2c_device *i2cdev;
+
+	i3c_bus_for_each_i2cdev(i3cbus, i2cdev) {
+		switch (i2cdev->lvr & I3C_LVR_I2C_INDEX_MASK) {
+		case I3C_LVR_I2C_INDEX(0):
+			if (i3cbus->mode < I3C_BUS_MODE_MIXED_FAST)
+				i3cbus->mode = I3C_BUS_MODE_MIXED_FAST;
+			break;
+
+		case I3C_LVR_I2C_INDEX(1):
+		case I3C_LVR_I2C_INDEX(2):
+			if (i3cbus->mode < I3C_BUS_MODE_MIXED_SLOW)
+				i3cbus->mode = I3C_BUS_MODE_MIXED_SLOW;
+			break;
+
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (!i3cbus->scl_rate.i3c)
+		i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
+
+	if (!i3cbus->scl_rate.i2c) {
+		if (i3cbus->mode == I3C_BUS_MODE_MIXED_SLOW)
+			i3cbus->scl_rate.i2c = I3C_BUS_I2C_FM_SCL_RATE;
+		else
+			i3cbus->scl_rate.i2c = I3C_BUS_I2C_FM_PLUS_SCL_RATE;
+	}
+
+	/*
+	 * I3C/I2C frequency may have been overridden, check that user-provided
+	 * values are not exceeding max possible frequency.
+	 */
+	if (i3cbus->scl_rate.i3c > I3C_BUS_MAX_I3C_SCL_RATE ||
+	    i3cbus->scl_rate.i2c > I3C_BUS_I2C_FM_PLUS_SCL_RATE) {
+		return -EINVAL;
+	}
+
+	dev_set_name(&i3cbus->dev, "i3c-%d", i3cbus->id);
+
+	return device_register(&i3cbus->dev);
+}
+
+static int __init i3c_init(void)
+{
+	return bus_register(&i3c_bus_type);
+}
+subsys_initcall(i3c_init);
+
+static void __exit i3c_exit(void)
+{
+	bus_unregister(&i3c_bus_type);
+}
+module_exit(i3c_exit);
diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
new file mode 100644
index 000000000000..31fb7cc9e12d
--- /dev/null
+++ b/drivers/i3c/device.c
@@ -0,0 +1,138 @@
+/*
+ * Copyright (C) 2017 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include "internals.h"
+
+/**
+ * i3c_device_do_priv_xfers() - do I3C SDR private transfers directed to a
+ *				specific device
+ *
+ * @dev: device with which the transfers should be done
+ * @xfers: array of transfers
+ * @nxfers: number of transfers
+ *
+ * Initiate one or several private SDR transfers with @dev.
+ *
+ * This function can sleep and thus cannot be called in atomic context.
+ *
+ * Return: 0 in case of success, a negative error core otherwise.
+ */
+int i3c_device_do_priv_xfers(struct i3c_device *dev,
+			     struct i3c_priv_xfer *xfers,
+			     int nxfers)
+{
+	struct i3c_master_controller *master;
+	int i, ret;
+
+	master = i3c_device_get_master(dev);
+	if (!master)
+		return -EINVAL;
+
+	i3c_bus_lock(master->bus, false);
+	for (i = 0; i < nxfers; i++)
+		xfers[i].addr = dev->info.dyn_addr;
+
+	ret = i3c_master_do_priv_xfers_locked(master, xfers, nxfers);
+	i3c_bus_unlock(master->bus, false);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_device_do_priv_xfers);
+
+/**
+ * i3c_device_send_hdr_cmds() - send HDR commands to a specific device
+ *
+ * @dev: device to which these commands should be sent
+ * @cmds: array of commands
+ * @ncmds: number of commands
+ *
+ * Send one or several HDR commands to @dev.
+ *
+ * This function can sleep and thus cannot be called in atomic context.
+ *
+ * Return: 0 in case of success, a negative error core otherwise.
+ */
+int i3c_device_send_hdr_cmds(struct i3c_device *dev,
+			     struct i3c_hdr_cmd *cmds,
+			     int ncmds)
+{
+	struct i3c_master_controller *master;
+	enum i3c_hdr_mode mode;
+	int ret, i;
+
+	if (ncmds < 1)
+		return 0;
+
+	mode = cmds[0].mode;
+	for (i = 1; i < ncmds; i++) {
+		if (mode != cmds[i].mode)
+			return -EINVAL;
+	}
+
+	master = i3c_device_get_master(dev);
+	if (!master)
+		return -EINVAL;
+
+	i3c_bus_lock(master->bus, false);
+	for (i = 0; i < ncmds; i++)
+		cmds[i].addr = dev->info.dyn_addr;
+
+	ret = i3c_master_send_hdr_cmds_locked(master, cmds, ncmds);
+	i3c_bus_unlock(master->bus, false);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_device_send_hdr_cmds);
+
+void i3c_device_get_info(struct i3c_device *dev,
+			 struct i3c_device_info *info)
+{
+	if (info)
+		*info = dev->info;
+}
+EXPORT_SYMBOL_GPL(i3c_device_get_info);
+
+/**
+ * i3c_driver_register_with_owner() - register an I3C device driver
+ *
+ * @drv: driver to register
+ * @owner: module that owns this driver
+ *
+ * Register @drv to the core.
+ *
+ * Return: 0 in case of success, a negative error core otherwise.
+ */
+int i3c_driver_register_with_owner(struct i3c_driver *drv, struct module *owner)
+{
+	drv->driver.owner = owner;
+	drv->driver.bus = &i3c_bus_type;
+
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(i3c_driver_register_with_owner);
+
+/**
+ * i3c_driver_unregister() - unregister an I3C device driver
+ *
+ * @drv: driver to unregister
+ *
+ * Unregister @drv.
+ */
+void i3c_driver_unregister(struct i3c_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(i3c_driver_unregister);
diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
new file mode 100644
index 000000000000..4d5438e471b5
--- /dev/null
+++ b/drivers/i3c/internals.h
@@ -0,0 +1,45 @@
+/*
+ * Copyright (C) 2017 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#ifndef I3C_INTERNALS_H
+#define I3C_INTERNALS_H
+
+#include <linux/i3c/master.h>
+
+extern struct bus_type i3c_bus_type;
+extern const struct device_type i3c_master_type;
+extern const struct device_type i3c_device_type;
+
+void i3c_bus_destroy(struct i3c_bus *bus);
+struct i3c_bus *i3c_bus_create(struct device *parent);
+void i3c_bus_unregister(struct i3c_bus *bus);
+int i3c_bus_register(struct i3c_bus *i3cbus);
+void i3c_bus_lock(struct i3c_bus *bus, bool exclusive);
+void i3c_bus_unlock(struct i3c_bus *bus, bool exclusive);
+int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr);
+bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr);
+void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
+				  enum i3c_addr_slot_status status);
+enum i3c_addr_slot_status i3c_bus_get_addr_slot_status(struct i3c_bus *bus,
+						       u16 addr);
+
+int i3c_master_do_priv_xfers_locked(struct i3c_master_controller *master,
+				    const struct i3c_priv_xfer *xfers,
+				    int nxfers);
+int i3c_master_send_hdr_cmds_locked(struct i3c_master_controller *master,
+				    const struct i3c_hdr_cmd *cmds, int ncmds);
+
+#endif /* I3C_INTERNAL_H */
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
new file mode 100644
index 000000000000..b8a6ae4f81bf
--- /dev/null
+++ b/drivers/i3c/master.c
@@ -0,0 +1,1225 @@
+/*
+ * Copyright (C) 2017 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/slab.h>
+
+#include "internals.h"
+
+static inline struct i3c_master_controller *
+i2c_adapter_to_i3c_master(struct i2c_adapter *adap)
+{
+	return container_of(adap, struct i3c_master_controller, i2c);
+}
+
+static inline struct i2c_adapter *
+i3c_master_to_i2c_adapter(struct i3c_master_controller *master)
+{
+	return &master->i2c;
+}
+
+static void i3c_i2c_dev_init(struct i3c_master_controller *master,
+			     struct i3c_i2c_dev *dev, bool i2cdev)
+{
+	dev->bus = master->bus;
+	dev->master = master;
+}
+
+static struct i2c_device *
+i3c_master_alloc_i2c_dev(struct i3c_master_controller *master,
+			 const struct i2c_board_info *info, u8 lvr)
+{
+	struct i2c_device *dev;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	i3c_i2c_dev_init(master, &dev->common, true);
+	dev->info = *info;
+	dev->lvr = lvr;
+	dev->info.of_node = of_node_get(info->of_node);
+	i3c_bus_set_addr_slot_status(master->bus, info->addr,
+				     I3C_ADDR_SLOT_I2C_DEV);
+
+	return dev;
+}
+
+static void i3c_master_init_i3c_dev(struct i3c_master_controller *master,
+				    struct i3c_device *dev,
+				    const struct i3c_device_info *info,
+				    const struct device_type *type)
+{
+	i3c_i2c_dev_init(master, &dev->common, false);
+	dev->dev.parent = &master->bus->dev;
+	dev->dev.type = type;
+	dev->dev.bus = &i3c_bus_type;
+	dev->info = *info;
+	dev_set_name(&dev->dev, "%d-%llx", master->bus->id, info->pid);
+}
+
+static int i3c_master_send_ccc_cmd_locked(struct i3c_master_controller *master,
+					  struct i3c_ccc_cmd *cmd)
+{
+	if (WARN_ON(!rwsem_is_locked(&master->bus->lock)))
+		return -EINVAL;
+
+	if (!cmd || !master)
+		return -EINVAL;
+
+	if (!master->ops->send_ccc_cmd)
+		return -ENOTSUPP;
+
+	if ((cmd->id & I3C_CCC_DIRECT)) {
+		enum i3c_addr_slot_status status;
+		int i;
+
+		if (!cmd->dests || !cmd->ndests)
+			return -EINVAL;
+
+		for (i = 0; i < cmd->ndests; i++) {
+			status = i3c_bus_get_addr_slot_status(master->bus,
+							cmd->dests[i].addr);
+			if (status != I3C_ADDR_SLOT_I3C_DEV)
+				return -EINVAL;
+		}
+	}
+
+	if (master->ops->supports_ccc_cmd &&
+	    !master->ops->supports_ccc_cmd(master, cmd))
+		return -ENOTSUPP;
+
+	return master->ops->send_ccc_cmd(master, cmd);
+}
+
+int i3c_master_send_hdr_cmds_locked(struct i3c_master_controller *master,
+				    const struct i3c_hdr_cmd *cmds, int ncmds)
+{
+	int i;
+
+	if (!cmds || !master || ncmds <= 0)
+		return -EINVAL;
+
+	if (!master->ops->send_hdr_cmds)
+		return -ENOTSUPP;
+
+	for (i = 0; i < ncmds; i++) {
+		if (!(master->base.info.hdr_cap & BIT(cmds->mode)))
+			return -ENOTSUPP;
+	}
+
+	return master->ops->send_hdr_cmds(master, cmds, ncmds);
+}
+
+/**
+ * i3c_master_send_hdr_cmds() - send HDR commands on the I3C bus
+ *
+ * @master: master used to send frames on the bus.
+ * @cmds: array of HDR commands.
+ * @ncmds: number of commands to send.
+ *
+ * Send one or several HDR commands.
+ *
+ * This function can sleep and thus cannot be called in atomic context.
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int i3c_master_send_hdr_cmds(struct i3c_master_controller *master,
+			     const struct i3c_hdr_cmd *cmds, int ncmds)
+{
+	int ret;
+
+	i3c_bus_lock(master->bus, false);
+	ret = i3c_master_send_hdr_cmds_locked(master, cmds, ncmds);
+	i3c_bus_unlock(master->bus, false);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_master_send_hdr_cmds);
+
+int i3c_master_do_priv_xfers_locked(struct i3c_master_controller *master,
+				    const struct i3c_priv_xfer *xfers,
+				    int nxfers)
+{
+	int i;
+
+	if (!xfers || !master || nxfers <= 0)
+		return -EINVAL;
+
+	if (!master->ops->priv_xfers)
+		return -ENOTSUPP;
+
+	for (i = 0; i < nxfers; i++) {
+		enum i3c_addr_slot_status status;
+
+		status = i3c_bus_get_addr_slot_status(master->bus,
+						      xfers[i].addr);
+		if (status != I3C_ADDR_SLOT_I3C_DEV)
+			return -EINVAL;
+	}
+
+	return master->ops->priv_xfers(master, xfers, nxfers);
+}
+
+/**
+ * i3c_master_do_priv_xfers() - do SDR private transfers on the I3C bus
+ *
+ * @master: master used to send frames on the bus
+ * @xfers: array of SDR private transfers
+ * @nxfers: number of transfers
+ *
+ * Do one or several private SDR I3C transfers.
+ *
+ * This function can sleep and thus cannot be called in atomic context.
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int i3c_master_do_priv_xfers(struct i3c_master_controller *master,
+			     const struct i3c_priv_xfer *xfers,
+			     int nxfers)
+{
+	int ret;
+
+	i3c_bus_lock(master->bus, false);
+	ret = i3c_master_do_priv_xfers_locked(master, xfers, nxfers);
+	i3c_bus_unlock(master->bus, false);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_master_do_priv_xfers);
+
+/**
+ * i3c_master_do_i2c_xfers() - do I2C transfers on the I3C bus
+ *
+ * @master: master used to send frames on the bus
+ * @xfers: array of I2C transfers
+ * @nxfers: number of transfers
+ *
+ * Does one or several I2C transfers.
+ *
+ * This function can sleep and thus cannot be called in atomic context.
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int i3c_master_do_i2c_xfers(struct i3c_master_controller *master,
+			    const struct i2c_msg *xfers,
+			    int nxfers)
+{
+	int ret, i;
+
+	if (!xfers || !master || nxfers <= 0)
+		return -EINVAL;
+
+	if (!master->ops->i2c_xfers)
+		return -ENOTSUPP;
+
+	i3c_bus_lock(master->bus, false);
+
+	for (i = 0; i < nxfers; i++) {
+		enum i3c_addr_slot_status status;
+
+		status = i3c_bus_get_addr_slot_status(master->bus,
+						      xfers[i].addr);
+		if (status != I3C_ADDR_SLOT_I2C_DEV) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	ret = master->ops->i2c_xfers(master, xfers, nxfers);
+
+out:
+	i3c_bus_unlock(master->bus, false);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_master_do_i2c_xfers);
+
+/**
+ * i3c_master_get_free_addr() - get a free address on the bus
+ *
+ * @master: I3C master object
+ * @start_addr: where to start searching
+ *
+ * This function must be called with the bus lock held in write mode.
+ *
+ * Return: the first free address starting at @start_addr (included) or -ENOMEM
+ * if there's no more address available.
+ */
+int i3c_master_get_free_addr(struct i3c_master_controller *master,
+			     u8 start_addr)
+{
+	return i3c_bus_get_free_addr(master->bus, start_addr);
+}
+EXPORT_SYMBOL_GPL(i3c_master_get_free_addr);
+
+/**
+ * i3c_master_set_info() - set master device information
+ *
+ * @master: master used to send frames on the bus
+ * @info: I3C device information
+ *
+ * Set master device info. This should be done in
+ * &i3c_master_controller_ops->bus_init().
+ *
+ * Not all &i3c_device_info fields are meaningful for a master device.
+ * Here is a list of fields that should be properly filled:
+ *
+ * - &i3c_device_info->dyn_addr
+ * - &i3c_device_info->bcr
+ * - &i3c_device_info->dcr
+ * - &i3c_device_info->pid
+ * - &i3c_device_info->hdr_cap if %I3C_BCR_HDR_CAP bit is set in
+ *   &i3c_device_info->bcr
+ *
+ * This function must be called with the bus lock held in write mode.
+ *
+ * Return: 0 if @info contains valid information (not every piece of
+ * information can be checked, but we can at least make sure @info->dyn_addr
+ * and @info->bcr are correct), -EINVAL otherwise.
+ */
+int i3c_master_set_info(struct i3c_master_controller *master,
+			const struct i3c_device_info *info)
+{
+	if (!i3c_bus_dev_addr_is_avail(master->bus, info->dyn_addr))
+		return -EINVAL;
+
+	if (I3C_BCR_DEVICE_ROLE(info->bcr) == I3C_BCR_I3C_MASTER &&
+	    master->secondary)
+		return -EINVAL;
+
+	i3c_master_init_i3c_dev(master, &master->base, info, &i3c_master_type);
+	i3c_bus_set_addr_slot_status(master->bus, info->dyn_addr,
+				     I3C_ADDR_SLOT_I3C_DEV);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i3c_master_set_info);
+
+static struct i3c_device *
+i3c_master_alloc_i3c_dev(struct i3c_master_controller *master,
+			 const struct i3c_device_info *info)
+{
+	struct i3c_device *dev;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	i3c_master_init_i3c_dev(master, dev, info, &i3c_device_type);
+
+	return dev;
+}
+
+/**
+ * i3c_master_rstdaa_locked() - reset dev(s) dynamic address
+ *
+ * @master: master used to send frames on the bus
+ * @addr: a valid I3C device address or %I3C_BROADCAST_ADDR
+ *
+ * Send a RSTDAA CCC command to ask a specific slave (or all slave if @addr is
+ * %I3C_BROADCAST_ADDR) to drop their dynamic address.
+ *
+ * This function must be called with the bus lock held in write mode.
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int i3c_master_rstdaa_locked(struct i3c_master_controller *master, u8 addr)
+{
+	struct i3c_ccc_cmd_dest dest = { };
+	struct i3c_ccc_cmd cmd = { };
+	enum i3c_addr_slot_status addrstat;
+	int ret;
+
+	if (!master)
+		return -EINVAL;
+
+	addrstat = i3c_bus_get_addr_slot_status(master->bus, addr);
+	if (addr != I3C_BROADCAST_ADDR && addrstat != I3C_ADDR_SLOT_I3C_DEV)
+		return -EINVAL;
+
+	dest.addr = addr;
+	cmd.dests = &dest;
+	cmd.ndests = 1;
+	cmd.rnw = false;
+	cmd.id = I3C_CCC_RSTDAA(addr == I3C_BROADCAST_ADDR);
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i3c_master_rstdaa_locked);
+
+/**
+ * i3c_master_entdaa_locked() - start a DAA (Dynamic Address Assignment)
+ *				procedure
+ *
+ * @master: master used to send frames on the bus
+ *
+ * Send a ENTDAA CCC command to start a DAA procedure.
+ *
+ * Note that this function only sends the ENTDAA CCC command, all the logic
+ * behind dynamic address assignment has to be handled in the I3C master
+ * driver.
+ *
+ * This function must be called with the bus lock held in write mode.
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int i3c_master_entdaa_locked(struct i3c_master_controller *master)
+{
+	struct i3c_ccc_cmd_dest dest = { };
+	struct i3c_ccc_cmd cmd = { };
+	int ret;
+
+	dest.addr = I3C_BROADCAST_ADDR;
+	cmd.dests = &dest;
+	cmd.ndests = 1;
+	cmd.rnw = false;
+	cmd.id = I3C_CCC_ENTDAA;
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i3c_master_entdaa_locked);
+
+/**
+ * i3c_master_disec_locked() - send a DISEC CCC command
+ *
+ * @master: master used to send frames on the bus
+ * @addr: a valid I3C slave address or %I3C_BROADCAST_ADDR
+ * @evts: events to disable
+ *
+ * Send a DISEC CCC command to disable some or all events coming from a
+ * specific slave, or all devices if @addr is %I3C_BROADCAST_ADDR.
+ *
+ * This function must be called with the bus lock held in write mode.
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int i3c_master_disec_locked(struct i3c_master_controller *master, u8 addr,
+			    const struct i3c_ccc_events *evts)
+{
+	struct i3c_ccc_events events = *evts;
+	struct i3c_ccc_cmd_dest dest = {
+		.addr = addr,
+		.payload.len = sizeof(events),
+		.payload.data = &events,
+	};
+	struct i3c_ccc_cmd cmd = {
+		.id = I3C_CCC_DISEC(addr == I3C_BROADCAST_ADDR),
+		.dests = &dest,
+		.ndests = 1,
+	};
+
+	return i3c_master_send_ccc_cmd_locked(master, &cmd);
+}
+EXPORT_SYMBOL_GPL(i3c_master_disec_locked);
+
+/**
+ * i3c_master_defslvs_locked() - send a DEFSLVS CCC command
+ *
+ * @master: master used to send frames on the bus
+ *
+ * Send a DEFSLVS CCC command containing all the devices known to the @master.
+ * This is useful when you have secondary masters on the bus to propagate
+ * device information.
+ *
+ * This should be called after all I3C devices have been discovered (in other
+ * words, after the DAA procedure has finished) and instantiated in
+ * i3c_master_controller_ops->bus_init().
+ * It should also be called if a master ACKed an Hot-Join request and assigned
+ * a dynamic address to the device joining the bus.
+ *
+ * This function must be called with the bus lock held in write mode.
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int i3c_master_defslvs_locked(struct i3c_master_controller *master)
+{
+	struct i3c_ccc_cmd_dest dest = {
+		.addr = I3C_BROADCAST_ADDR,
+	};
+	struct i3c_ccc_cmd cmd = {
+		.id = I3C_CCC_DEFSLVS,
+		.dests = &dest,
+		.ndests = 1,
+	};
+	struct i3c_ccc_defslvs *defslvs;
+	struct i3c_ccc_dev_desc *desc;
+	struct i3c_device *i3cdev;
+	struct i2c_device *i2cdev;
+	struct i3c_bus *bus;
+	bool send = false;
+	int ndevs, ret;
+
+	if (!master)
+		return -EINVAL;
+
+	bus = i3c_master_get_bus(master);
+	i3c_bus_for_each_i3cdev(bus, i3cdev) {
+		ndevs++;
+		if (I3C_BCR_DEVICE_ROLE(i3cdev->info.bcr) == I3C_BCR_I3C_MASTER)
+			send = true;
+	}
+
+	/* No other master on the bus, skip DEFSLVS. */
+	if (!send)
+		return 0;
+
+	i3c_bus_for_each_i2cdev(bus, i2cdev)
+		ndevs++;
+
+	dest.payload.len = sizeof(*defslvs) +
+			   (ndevs * sizeof(struct i3c_ccc_dev_desc));
+	defslvs = kzalloc(dest.payload.len, GFP_KERNEL);
+	if (!defslvs)
+		return -ENOMEM;
+
+	dest.payload.data = defslvs;
+
+	defslvs->count = ndevs + 1;
+	defslvs->master.bcr = master->base.info.bcr;
+	defslvs->master.dcr = master->base.info.dcr;
+	defslvs->master.dyn_addr = master->base.info.dyn_addr;
+	defslvs->master.static_addr = master->base.info.static_addr;
+
+	desc = defslvs->slaves;
+	i3c_bus_for_each_i2cdev(bus, i2cdev) {
+		desc->lvr = i2cdev->lvr;
+		desc->static_addr = i2cdev->info.addr;
+		desc++;
+	}
+
+	i3c_bus_for_each_i3cdev(bus, i3cdev) {
+		desc->bcr = i3cdev->info.bcr;
+		desc->dcr = i3cdev->info.dcr;
+		desc->dyn_addr = i3cdev->info.dyn_addr;
+		desc->static_addr = i3cdev->info.static_addr;
+		desc++;
+	}
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	kfree(defslvs);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_master_defslvs_locked);
+
+static int i3c_master_getmrl_locked(struct i3c_master_controller *master,
+				    struct i3c_device_info *info)
+{
+	struct i3c_ccc_mrl mrl;
+	struct i3c_ccc_cmd_dest dest = {
+		.addr = info->dyn_addr,
+		.payload.len = sizeof(mrl),
+		.payload.data = &mrl,
+	};
+	struct i3c_ccc_cmd cmd = {
+		.rnw = true,
+		.id = I3C_CCC_GETMRL,
+		.dests = &dest,
+		.ndests = 1,
+	};
+	int ret;
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		return ret;
+
+	if (dest.payload.len != sizeof(mrl))
+		return -EIO;
+
+	info->max_read_len = be16_to_cpu(mrl.read_len);
+
+	if (info->bcr & I3C_BCR_IBI_PAYLOAD)
+		info->max_ibi_len = mrl.ibi_len;
+
+	return 0;
+}
+
+static int i3c_master_getmwl_locked(struct i3c_master_controller *master,
+				    struct i3c_device_info *info)
+{
+	struct i3c_ccc_mwl mwl;
+	struct i3c_ccc_cmd_dest dest = {
+		.addr = info->dyn_addr,
+		.payload.len = sizeof(mwl),
+		.payload.data = &mwl,
+	};
+	struct i3c_ccc_cmd cmd = {
+		.rnw = true,
+		.id = I3C_CCC_GETMWL,
+		.dests = &dest,
+		.ndests = 1,
+	};
+	int ret;
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		return ret;
+
+	if (dest.payload.len != sizeof(mwl))
+		return -EIO;
+
+	info->max_write_len = be16_to_cpu(mwl.len);
+
+	return 0;
+}
+
+static int i3c_master_getmxds_locked(struct i3c_master_controller *master,
+				     struct i3c_device_info *info)
+{
+	struct i3c_ccc_getmxds getmaxds;
+	struct i3c_ccc_cmd_dest dest = {
+		.addr = info->dyn_addr,
+		.payload.len = sizeof(getmaxds),
+		.payload.data = &getmaxds,
+	};
+	struct i3c_ccc_cmd cmd = {
+		.rnw = true,
+		.id = I3C_CCC_GETMXDS,
+		.dests = &dest,
+		.ndests = 1,
+	};
+	int ret;
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		return ret;
+
+	if (dest.payload.len != 2 && dest.payload.len != 5)
+		return -EIO;
+
+	info->max_read_ds = getmaxds.maxrd;
+	info->max_read_ds = getmaxds.maxwr;
+	if (dest.payload.len == 5)
+		info->max_read_turnaround = getmaxds.maxrdturn[0] |
+					    ((u32)getmaxds.maxrdturn[1] << 8) |
+					    ((u32)getmaxds.maxrdturn[2] << 16);
+
+	return 0;
+}
+
+static int i3c_master_gethdrcap_locked(struct i3c_master_controller *master,
+				       struct i3c_device_info *info)
+{
+	struct i3c_ccc_gethdrcap gethdrcap;
+	struct i3c_ccc_cmd_dest dest = {
+		.addr = info->dyn_addr,
+		.payload.len = sizeof(gethdrcap),
+		.payload.data = &gethdrcap,
+	};
+	struct i3c_ccc_cmd cmd = {
+		.rnw = true,
+		.id = I3C_CCC_GETHDRCAP,
+		.dests = &dest,
+		.ndests = 1,
+	};
+	int ret;
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		return ret;
+
+	if (dest.payload.len != 1)
+		return -EIO;
+
+	info->hdr_cap = gethdrcap.modes;
+
+	return 0;
+}
+
+static int i3c_master_getpid_locked(struct i3c_master_controller *master,
+				    struct i3c_device_info *info)
+{
+	struct i3c_ccc_getpid getpid;
+	struct i3c_ccc_cmd_dest dest = {
+		.addr = info->dyn_addr,
+		.payload.len = sizeof(struct i3c_ccc_getpid),
+		.payload.data = &getpid,
+	};
+	struct i3c_ccc_cmd cmd = {
+		.rnw = true,
+		.id = I3C_CCC_GETPID,
+		.dests = &dest,
+		.ndests = 1,
+	};
+	int ret, i;
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		return ret;
+
+	info->pid = 0;
+	for (i = 0; i < sizeof(getpid.pid); i++) {
+		int sft = (sizeof(getpid.pid) - i - 1) * 8;
+
+		info->pid |= (u64)getpid.pid[i] << sft;
+	}
+
+	return 0;
+}
+
+static int i3c_master_getbcr_locked(struct i3c_master_controller *master,
+				    struct i3c_device_info *info)
+{
+	struct i3c_ccc_getbcr getbcr;
+	struct i3c_ccc_cmd_dest dest = {
+		.addr = info->dyn_addr,
+		.payload.len = sizeof(struct i3c_ccc_getbcr),
+		.payload.data = &getbcr,
+	};
+	struct i3c_ccc_cmd cmd = {
+		.rnw = true,
+		.id = I3C_CCC_GETBCR,
+		.dests = &dest,
+		.ndests = 1,
+	};
+	int ret;
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		return ret;
+
+	info->bcr = getbcr.bcr;
+
+	return 0;
+}
+
+static int i3c_master_getdcr_locked(struct i3c_master_controller *master,
+				    struct i3c_device_info *info)
+{
+	struct i3c_ccc_getdcr getdcr;
+	struct i3c_ccc_cmd_dest dest = {
+		.addr = info->dyn_addr,
+		.payload.len = sizeof(struct i3c_ccc_getdcr),
+		.payload.data = &getdcr,
+	};
+	struct i3c_ccc_cmd cmd = {
+		.rnw = true,
+		.id = I3C_CCC_GETDCR,
+		.dests = &dest,
+		.ndests = 1,
+	};
+	int ret;
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		return ret;
+
+	info->dcr = getdcr.dcr;
+
+	return 0;
+}
+
+static int i3c_master_retrieve_dev_info(struct i3c_master_controller *master,
+					struct i3c_device_info *info, u8 addr)
+{
+	enum i3c_addr_slot_status slot_status;
+	int ret;
+
+	if (!master || !info)
+		return -EINVAL;
+
+	memset(info, 0, sizeof(*info));
+	info->dyn_addr = addr;
+
+	slot_status = i3c_bus_get_addr_slot_status(master->bus,
+						   info->dyn_addr);
+	if (slot_status == I3C_ADDR_SLOT_RSVD ||
+	    slot_status == I3C_ADDR_SLOT_I2C_DEV)
+		return -EINVAL;
+
+	ret = i3c_master_getpid_locked(master, info);
+	if (ret)
+		return ret;
+
+	ret = i3c_master_getbcr_locked(master, info);
+	if (ret)
+		return ret;
+
+	ret = i3c_master_getdcr_locked(master, info);
+	if (ret)
+		return ret;
+
+	ret = i3c_master_getmxds_locked(master, info);
+	if (ret && (info->bcr & I3C_BCR_MAX_DATA_SPEED_LIM))
+		return -EINVAL;
+
+	if (info->bcr & I3C_BCR_IBI_PAYLOAD)
+		info->max_ibi_len = 1;
+
+	i3c_master_getmrl_locked(master, info);
+	i3c_master_getmwl_locked(master, info);
+
+	if (info->bcr & I3C_BCR_HDR_CAP) {
+		ret = i3c_master_gethdrcap_locked(master, info);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * i3c_master_add_i3c_dev_locked() - add an I3C slave to the bus
+ *
+ * @master: master used to send frames on the bus
+ * @addr: I3C slave dynamic address assigned to the device
+ *
+ * This function is instantiating an I3C device object and adding it to the
+ * I3C device list. All device information are automatically retrieved using
+ * standard CCC commands.
+ *
+ * The I3C device object is returned in case the master wants to attach
+ * private data to it using i3c_device_set_master_data().
+ *
+ * This function must be called with the bus lock held in write mode.
+ *
+ * Return: a pointer to a &struct i3c_device object in case of success,
+ * an ERR_PTR() otherwise.
+ */
+struct i3c_device *
+i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master, u8 addr)
+{
+	enum i3c_addr_slot_status status;
+	struct i3c_device *i3cdev;
+	struct i3c_device_info info;
+	int ret;
+
+	if (!master)
+		return ERR_PTR(-EINVAL);
+
+	status = i3c_bus_get_addr_slot_status(master->bus, addr);
+	if (status != I3C_ADDR_SLOT_FREE)
+		return ERR_PTR(-EINVAL);
+
+	i3c_bus_set_addr_slot_status(master->bus, addr, I3C_ADDR_SLOT_I3C_DEV);
+
+	ret = i3c_master_retrieve_dev_info(master, &info, addr);
+	if (ret)
+		goto err_release_addr;
+
+	i3cdev = i3c_master_alloc_i3c_dev(master, &info);
+	if (IS_ERR(i3cdev)) {
+		ret = PTR_ERR(i3cdev);
+		goto err_release_addr;
+	}
+
+	list_add_tail(&i3cdev->common.node, &master->bus->devs.i3c);
+
+	return i3cdev;
+
+err_release_addr:
+	i3c_bus_set_addr_slot_status(master->bus, addr, I3C_ADDR_SLOT_FREE);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(i3c_master_add_i3c_dev_locked);
+
+static int of_i3c_master_add_dev(struct i3c_master_controller *master,
+				 struct device_node *node)
+{
+	struct device *dev = master->base.dev.parent;
+	struct i2c_board_info info = { };
+	struct i2c_device *i2cdev;
+	u32 lvr, addr;
+	int ret;
+
+	if (!master || !node)
+		return -EINVAL;
+
+	/*
+	 * This node is not describing an I2C device, skip it.
+	 * We only add I2C devices here (i.e. nodes with an i3c-lvr property).
+	 * I3C devices will be discovered during DAA, even if they have a
+	 * static address.
+	 */
+	if (of_property_read_u32(node, "reg", &addr) ||
+	    of_property_read_u32(node, "i3c-lvr", &lvr))
+		return 0;
+
+	ret = of_i2c_get_board_info(master->base.dev.parent, node, &info);
+	if (ret)
+		return ret;
+
+	/*
+	 * We do not register the I2C device here, because the bus is not
+	 * necessarily ready to transmit I2C frames, and the I2C adapter has
+	 * not been registered yet.
+	 * This is done in i3c_master_i2c_adapter_init() once everything is
+	 * ready.
+	 */
+	i2cdev = i3c_master_alloc_i2c_dev(master, &info, lvr);
+	if (IS_ERR(i2cdev)) {
+		dev_err(dev, "Failed to allocate device %02x\n", addr);
+		return ret;
+	}
+
+	if (lvr & I3C_LVR_I2C_FM_MODE)
+		master->bus->scl_rate.i2c = I3C_BUS_I2C_FM_SCL_RATE;
+
+	list_add_tail(&i2cdev->common.node, &master->bus->devs.i2c);
+
+	return 0;
+}
+
+static void i3c_master_remove_devs(struct i3c_master_controller *master)
+{
+	while (!list_empty(&master->bus->devs.i2c)) {
+		struct i2c_device *i2cdev;
+
+		i2cdev = list_first_entry(&master->bus->devs.i2c,
+					  struct i2c_device, common.node);
+		list_del(&i2cdev->common.node);
+		of_node_put(i2cdev->info.of_node);
+		kfree(i2cdev);
+	}
+
+	while (!list_empty(&master->bus->devs.i3c)) {
+		struct i3c_device *i3cdev;
+
+		i3cdev = list_first_entry(&master->bus->devs.i3c,
+					  struct i3c_device, common.node);
+		list_del(&i3cdev->common.node);
+		of_node_put(i3cdev->dev.of_node);
+		kfree(i3cdev);
+	}
+}
+
+static int of_populate_i3c_bus(struct i3c_master_controller *master)
+{
+	struct device *dev = &master->bus->dev;
+	struct device_node *i3cbus_np = dev->of_node;
+	struct device_node *node;
+	int ret;
+	u32 val;
+
+	if (!i3cbus_np)
+		return 0;
+
+	for_each_available_child_of_node(i3cbus_np, node) {
+		ret = of_i3c_master_add_dev(master, node);
+		if (ret)
+			goto err_remove_devs;
+	}
+
+	/*
+	 * The user might want to limit I2C and I3C speed in case some devices
+	 * on the bus are not supporting typical rates, or if the bus topology
+	 * prevents it from using max possible rate.
+	 */
+	if (!of_property_read_u32(i3cbus_np, "i2c-scl-frequency", &val))
+		master->bus->scl_rate.i2c = val;
+
+	if (!of_property_read_u32(i3cbus_np, "i3c-scl-frequency", &val))
+		master->bus->scl_rate.i3c = val;
+
+	return 0;
+
+err_remove_devs:
+	i3c_master_remove_devs(master);
+
+	return ret;
+}
+
+static int i3c_master_i2c_adapter_xfer(struct i2c_adapter *adap,
+				       struct i2c_msg *xfers, int nxfers)
+{
+	struct i3c_master_controller *master = i2c_adapter_to_i3c_master(adap);
+	int i, ret;
+
+	for (i = 0; i < nxfers; i++) {
+		enum i3c_addr_slot_status status;
+
+		status = i3c_bus_get_addr_slot_status(master->bus,
+						      xfers[i].addr);
+		if (status != I3C_ADDR_SLOT_I2C_DEV)
+			return -EINVAL;
+	}
+
+	ret = i3c_master_do_i2c_xfers(master, xfers, nxfers);
+	if (ret)
+		return ret;
+
+	return nxfers;
+}
+
+static u32 i3c_master_i2c_functionalities(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR;
+}
+
+static const struct i2c_algorithm i3c_master_i2c_algo = {
+	.master_xfer = i3c_master_i2c_adapter_xfer,
+	.functionality = i3c_master_i2c_functionalities,
+};
+
+static int i3c_master_i2c_adapter_init(struct i3c_master_controller *master)
+{
+	struct i2c_adapter *adap = i3c_master_to_i2c_adapter(master);
+	struct i2c_device *i2cdev;
+	int ret;
+
+	adap->dev.parent = master->parent;
+	adap->owner = master->parent->driver->owner;
+	adap->algo = &i3c_master_i2c_algo;
+	strncpy(adap->name, dev_name(master->base.dev.parent),
+		sizeof(adap->name));
+
+	/* FIXME: Should we allow i3c masters to override these values? */
+	adap->timeout = 1000;
+	adap->retries = 3;
+
+	ret = i2c_add_adapter(adap);
+	if (ret)
+		return ret;
+
+	/*
+	 * We silently ignore failures here. The bus should keep working
+	 * correctly even if one or more i2c devices are not registered.
+	 */
+	i3c_bus_for_each_i2cdev(master->bus, i2cdev)
+		i2cdev->client = i2c_new_device(adap, &i2cdev->info);
+
+	return 0;
+}
+
+static void i3c_master_i2c_adapter_cleanup(struct i3c_master_controller *master)
+{
+	i2c_del_adapter(&master->i2c);
+}
+
+static void i3c_master_unregister_i3c_devs(struct i3c_master_controller *master)
+{
+	struct i3c_device *i3cdev;
+
+	i3c_bus_for_each_i3cdev(master->bus, i3cdev) {
+		if (device_is_registered(&i3cdev->dev))
+			device_unregister(&i3cdev->dev);
+	}
+}
+
+static int i3c_master_register_i3c_devs(struct i3c_master_controller *master)
+{
+	struct i3c_device *i3cdev;
+	int ret;
+
+	i3c_bus_for_each_i3cdev(master->bus, i3cdev) {
+		ret = device_register(&i3cdev->dev);
+		if (ret)
+			goto err_unregister_devs;
+	}
+
+	return 0;
+
+err_unregister_devs:
+	i3c_master_unregister_i3c_devs(master);
+
+	return ret;
+}
+
+static int i3c_master_init_bus(struct i3c_master_controller *master)
+{
+	int ret;
+
+	if (!master->ops->bus_init)
+		return 0;
+
+	/*
+	 * Take an exclusive lock on the bus before calling ->bus_init(), so
+	 * that all _locked() helpers can safely be called within this hook.
+	 */
+	i3c_bus_lock(master->bus, true);
+	ret = master->ops->bus_init(master);
+	i3c_bus_unlock(master->bus, true);
+
+	return ret;
+}
+
+static void i3c_master_cleanup_bus(struct i3c_master_controller *master)
+{
+	if (master->ops->bus_cleanup) {
+		/*
+		 * Take an exclusive lock on the bus before calling
+		 * ->bus_cleanup(), so that all _locked() helpers can safely be
+		 * called within this hook.
+		 */
+		i3c_bus_lock(master->bus, true);
+		master->ops->bus_cleanup(master);
+		i3c_bus_unlock(master->bus, true);
+	}
+}
+
+static void i3c_master_destroy_bus(struct i3c_master_controller *master)
+{
+	i3c_bus_unregister(master->bus);
+	i3c_bus_destroy(master->bus);
+}
+
+static int i3c_master_create_bus(struct i3c_master_controller *master)
+{
+	struct i3c_bus *i3cbus;
+	int ret;
+
+	i3cbus = i3c_bus_create(master->parent);
+	if (IS_ERR(i3cbus))
+		return PTR_ERR(i3cbus);
+
+	i3cbus->cur_master = &master->base;
+	master->bus = i3cbus;
+
+	if (i3cbus->dev.of_node) {
+		ret = of_populate_i3c_bus(master);
+		if (ret)
+			goto err_destroy_bus;
+	}
+
+	ret = i3c_bus_register(i3cbus);
+	if (ret)
+		goto err_destroy_bus;
+
+	return 0;
+
+err_destroy_bus:
+	i3c_bus_destroy(i3cbus);
+
+	return ret;
+}
+
+/**
+ * i3c_master_register() - register an I3C master
+ *
+ * @master: master used to send frames on the bus
+ * @parent: the parent device (the one that provides this I3C master
+ *	    controller)
+ * @ops: the master controller operations
+ * @secondary: true if you are registering a secondary master. Will return
+ *	       -ENOTSUPP if set to true since secondary masters are not yet
+ *	       supported.
+ *
+ * This function takes care of everything for you:
+ *
+ * - creates and initializes the I3C bus
+ * - populates the bus with static I2C devs if @parent->of_node is not
+ *   NULL
+ * - registers all I3C devices added by the controller during bus
+ *   initialization
+ * - registers the I2C adapter and all I2C devices
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int i3c_master_register(struct i3c_master_controller *master,
+			struct device *parent,
+			const struct i3c_master_controller_ops *ops,
+			bool secondary)
+{
+	int ret;
+
+	/* We do not support secondary masters yet. */
+	if (secondary)
+		return -ENOTSUPP;
+
+	master->parent = parent;
+	master->ops = ops;
+	master->secondary = secondary;
+
+	ret = i3c_master_create_bus(master);
+	if (ret)
+		return ret;
+
+	/*
+	 * Before doing any operation on the bus, we need to initialize it.
+	 * This operation is highly controller dependent, but it is expected
+	 * to do the following operations:
+	 * 1/ reset all addresses of all devices on the bus (using RSTDAA CCC
+	 *    command)
+	 * 2/ start a DAA (Dynamic Address Assignment) procedure
+	 * 3/ populate the bus with all I3C devices discovered during DAA using
+	 *
+	 */
+	ret = i3c_master_init_bus(master);
+	if (ret)
+		goto err_destroy_bus;
+
+	/*
+	 * Register a dummy device to represent this master under the I3C bus
+	 * in sysfs.
+	 */
+	ret = device_register(&master->base.dev);
+	if (ret)
+		goto err_cleanup_bus;
+
+	/* Register all I3C devs that have been added during DAA. */
+	ret = i3c_master_register_i3c_devs(master);
+	if (ret)
+		goto err_unreg_master_dev;
+
+	/*
+	 * This is the last step: expose our i3c bus as an i2c adapter so that
+	 * i2c devices are exposed through the i2c subsystem.
+	 */
+	ret = i3c_master_i2c_adapter_init(master);
+	if (ret)
+		goto err_unreg_i3c_devs;
+
+	return 0;
+
+err_unreg_i3c_devs:
+	i3c_master_unregister_i3c_devs(master);
+
+err_unreg_master_dev:
+	device_unregister(&master->base.dev);
+
+err_cleanup_bus:
+	i3c_master_cleanup_bus(master);
+
+err_destroy_bus:
+	i3c_master_destroy_bus(master);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_master_register);
+
+/**
+ * i3c_master_unregister() - unregister an I3C master
+ *
+ * @master: master used to send frames on the bus
+ *
+ * Basically undo everything done in i3c_master_register().
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int i3c_master_unregister(struct i3c_master_controller *master)
+{
+	i3c_master_i2c_adapter_cleanup(master);
+
+	i3c_master_unregister_i3c_devs(master);
+
+	i3c_master_cleanup_bus(master);
+
+	i3c_master_remove_devs(master);
+
+	i3c_master_destroy_bus(master);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i3c_master_unregister);
diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/include/linux/i3c/ccc.h b/include/linux/i3c/ccc.h
new file mode 100644
index 000000000000..81848081b9cd
--- /dev/null
+++ b/include/linux/i3c/ccc.h
@@ -0,0 +1,389 @@
+/*
+ * Copyright (C) 2017 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#ifndef I3C_CCC_H
+#define I3C_CCC_H
+
+/* I3C CCC (Common Command Codes) related definitions */
+#define I3C_CCC_DIRECT			BIT(7)
+
+#define I3C_CCC_ID(id, broadcast)	\
+	((id) | ((broadcast) ? 0 : I3C_CCC_DIRECT))
+
+/* Commands valid in both broadcast and unicast modes */
+#define I3C_CCC_ENEC(broadcast)		I3C_CCC_ID(0x0, broadcast)
+#define I3C_CCC_DISEC(broadcast)	I3C_CCC_ID(0x1, broadcast)
+#define I3C_CCC_ENTAS(as, broadcast)	I3C_CCC_ID(0x2 + (as), broadcast)
+#define I3C_CCC_RSTDAA(broadcast)	I3C_CCC_ID(0x6, broadcast)
+#define I3C_CCC_SETMWL(broadcast)	I3C_CCC_ID(0x9, broadcast)
+#define I3C_CCC_SETMRL(broadcast)	I3C_CCC_ID(0xa, broadcast)
+#define I3C_CCC_SETXTIME(broadcast)	((broadcast) ? 0x28 : 0x98)
+#define I3C_CCC_VENDOR(id, broadcast)	((id) + ((broadcast) ? 0x61 : 0xe0))
+
+/* Broadcast-only commands */
+#define I3C_CCC_ENTDAA			I3C_CCC_ID(0x7, true)
+#define I3C_CCC_DEFSLVS			I3C_CCC_ID(0x8, true)
+#define I3C_CCC_ENTTM			I3C_CCC_ID(0xb, true)
+#define I3C_CCC_ENTHDR(x)		I3C_CCC_ID(0x20 + (x), true)
+
+/* Unicast-only commands */
+#define I3C_CCC_SETDASA			I3C_CCC_ID(0x7, false)
+#define I3C_CCC_SETNEWDA		I3C_CCC_ID(0x8, false)
+#define I3C_CCC_GETMWL			I3C_CCC_ID(0xb, false)
+#define I3C_CCC_GETMRL			I3C_CCC_ID(0xc, false)
+#define I3C_CCC_GETPID			I3C_CCC_ID(0xd, false)
+#define I3C_CCC_GETBCR			I3C_CCC_ID(0xe, false)
+#define I3C_CCC_GETDCR			I3C_CCC_ID(0xf, false)
+#define I3C_CCC_GETSTATUS		I3C_CCC_ID(0x10, false)
+#define I3C_CCC_GETACCMST		I3C_CCC_ID(0x11, false)
+#define I3C_CCC_SETBRGTGT		I3C_CCC_ID(0x13, false)
+#define I3C_CCC_GETMXDS			I3C_CCC_ID(0x14, false)
+#define I3C_CCC_GETHDRCAP		I3C_CCC_ID(0x15, false)
+#define I3C_CCC_GETXTIME		I3C_CCC_ID(0x19, false)
+
+#define I3C_CCC_EVENT_SIR		BIT(0)
+#define I3C_CCC_EVENT_MR		BIT(1)
+#define I3C_CCC_EVENT_HJ		BIT(3)
+
+/**
+ * struct i3c_ccc_events - payload passed to ENEC/DISEC CCC
+ *
+ * @events: bitmask of I3C_CCC_EVENT_xxx events.
+ *
+ * Depending on the CCC command, the specific events coming from all devices
+ * (broadcast version) or a specific device (unicast version) will be
+ * enabled (ENEC) or disabled (DISEC).
+ */
+struct i3c_ccc_events {
+	u8 events;
+} __packed;
+
+/**
+ * struct i3c_ccc_mwl - payload passed to SETMWL/GETMWL CCC
+ *
+ * @len: maximum write length in bytes
+ *
+ * The maximum write length is only applicable to SDR private messages or
+ * extended Write CCCs (like SETXTIME).
+ */
+struct i3c_ccc_mwl {
+	__be16 len;
+} __packed;
+
+/**
+ * struct i3c_ccc_mrl - payload passed to SETMRL/GETMRL CCC
+ *
+ * @len: maximum read length in bytes
+ * @ibi_len: maximum IBI payload length
+ *
+ * The maximum read length is only applicable to SDR private messages or
+ * extended Read CCCs (like GETXTIME).
+ * The IBI length is only valid if the I3C slave is IBI capable
+ * (%I3C_BCR_IBI_REQ_CAP is set).
+ */
+struct i3c_ccc_mrl {
+	__be16 read_len;
+	u8 ibi_len;
+} __packed;
+
+/**
+ * struct i3c_ccc_dev_desc - I3C/I3C device descriptor used for DEFSLVS
+ *
+ * @dyn_addr: dynamic address assigned to the I3C slave or 0 if the entry is
+ *	      describing an I2C slave.
+ * @dcr: DCR value (not applicable to entries describing I2C devices)
+ * @lvr: LVR value (not applicable to entries describing I3C devices)
+ * @bcr: BCR value or 0 if this entry is describing an I2C slave
+ * @static_addr: static address or 0 if the device does not have a static
+ *		 address
+ *
+ * The DEFSLVS command should be passed an array of i3c_ccc_dev_desc
+ * descriptors (one entry per I3C/I2C dev controlled by the master).
+ */
+struct i3c_ccc_dev_desc {
+	u8 dyn_addr;
+	union {
+		u8 dcr;
+		u8 lvr;
+	};
+	u8 bcr;
+	u8 static_addr;
+} __packed;
+
+/**
+ * struct i3c_ccc_defslvs - payload passed to DEFSLVS CCC
+ *
+ * @count: number of dev descriptors
+ * @master: descriptor describing the current master
+ * @slaves: array of descriptors describing slaves controlled by the
+ *	    current master
+ *
+ * Information passed to the broadcast DEFSLVS to propagate device
+ * information to all masters currently acting as slaves on the bus.
+ * This is only meaningful if you have more than one master.
+ */
+struct i3c_ccc_defslvs {
+	u8 count;
+	struct i3c_ccc_dev_desc master;
+	struct i3c_ccc_dev_desc slaves[0];
+} __packed;
+
+/**
+ * enum i3c_ccc_test_mode - enum listing all available test modes
+ *
+ * @I3C_CCC_EXIT_TEST_MODE: exit test mode
+ * @I3C_CCC_VENDOR_TEST_MODE: enter vendor test mode
+ */
+enum i3c_ccc_test_mode {
+	I3C_CCC_EXIT_TEST_MODE,
+	I3C_CCC_VENDOR_TEST_MODE,
+};
+
+/**
+ * struct i3c_ccc_enttm - payload passed to ENTTM CCC
+ *
+ * @mode: one of the &enum i3c_ccc_test_mode modes
+ *
+ * Information passed to the ENTTM CCC to instruct an I3C device to enter a
+ * specific test mode.
+ */
+struct i3c_ccc_enttm {
+	u8 mode;
+} __packed;
+
+/**
+ * struct i3c_ccc_setda - payload passed to ENTTM CCC
+ *
+ * @mode: one of the &enum i3c_ccc_test_mode modes
+ *
+ * Information passed to the ENTTM CCC to instruct an I3C device to enter a
+ * specific test mode.
+ */
+struct i3c_ccc_setda {
+	u8 addr;
+} __packed;
+
+/**
+ * struct i3c_ccc_getpid - payload passed to GETPID CCC
+ *
+ * @pid: 48 bits PID in big endian
+ */
+struct i3c_ccc_getpid {
+	u8 pid[6];
+} __packed;
+
+/**
+ * struct i3c_ccc_getbcr - payload passed to GETBCR CCC
+ *
+ * @bcr: BCR (Bus Characteristic Register) value
+ */
+struct i3c_ccc_getbcr {
+	u8 bcr;
+} __packed;
+
+/**
+ * struct i3c_ccc_getdcr - payload passed to GETDCR CCC
+ *
+ * @dcr: DCR (Device Characteristic Register) value
+ */
+struct i3c_ccc_getdcr {
+	u8 dcr;
+} __packed;
+
+#define I3C_CCC_STATUS_PENDING_INT(status)	((status) & GENMASK(3, 0))
+#define I3C_CCC_STATUS_PROTOCOL_ERROR		BIT(5)
+#define I3C_CCC_STATUS_ACTIVITY_MODE(status)	\
+	(((status) & GENMASK(7, 6)) >> 6)
+
+/**
+ * struct i3c_ccc_getstatus - payload passed to GETSTATUS CCC
+ *
+ * @status: status of the I3C slave (see I3C_CCC_STATUS_xxx macros for more
+ *	    information).
+ */
+struct i3c_ccc_getstatus {
+	__be16 status;
+} __packed;
+
+/**
+ * struct i3c_ccc_getaccmst - payload passed to GETACCMST CCC
+ *
+ * @newmaster: address of the master taking bus ownership
+ */
+struct i3c_ccc_getaccmst {
+	u8 newmaster;
+} __packed;
+
+/**
+ * struct i3c_ccc_bridged_slave_desc - bridged slave descriptor
+ *
+ * @addr: dynamic address of the bridged device
+ * @id: ID of the slave device behind the bridge
+ */
+struct i3c_ccc_bridged_slave_desc {
+	u8 addr;
+	__be16 id;
+} __packed;
+
+/**
+ * struct i3c_ccc_setbrgtgt - payload passed to SETBRGTGT CCC
+ *
+ * @count: number of bridged slaves
+ * @bslaves: bridged slave descriptors
+ */
+struct i3c_ccc_setbrgtgt {
+	u8 count;
+	struct i3c_ccc_bridged_slave_desc bslaves[0];
+} __packed;
+
+/**
+ * enum i3c_sdr_max_data_rate - max data rate values for private SDR transfers
+ */
+enum i3c_sdr_max_data_rate {
+	I3C_SDR_DR_FSCL_MAX,
+	I3C_SDR_DR_FSCL_8MHZ,
+	I3C_SDR_DR_FSCL_6MHZ,
+	I3C_SDR_DR_FSCL_4MHZ,
+	I3C_SDR_DR_FSCL_2MHZ,
+};
+
+/**
+ * enum i3c_tsco - clock to data turn-around
+ */
+enum i3c_tsco {
+	I3C_TSCO_LT_8NS,
+	I3C_TSCO_LT_9NS,
+	I3C_TSCO_LT_10NS,
+	I3C_TSCO_LT_11NS,
+	I3C_TSCO_LT_12NS,
+};
+
+#define I3C_CCC_MAX_SDR_FSCL_MASK	GENMASK(2, 0)
+#define I3C_CCC_MAX_SDR_FSCL(x)		((x) & I3C_CCC_MAX_SDR_FSCL_MASK)
+
+/**
+ * struct i3c_ccc_getmxds - payload passed to GETMXDS CCC
+ *
+ * @maxwr: write limitations
+ * @maxrd: read limitations
+ * @maxrdturn: maximum read turn-around expressed micro-seconds and
+ *	       little-endian formatted
+ */
+struct i3c_ccc_getmxds {
+	u8 maxwr;
+	u8 maxrd;
+	u8 maxrdturn[3];
+} __packed;
+
+#define I3C_CCC_HDR_MODE(mode)		BIT(mode)
+
+/**
+ * struct i3c_ccc_gethdrcap - payload passed to GETHDRCAP CCC
+ *
+ * @modes: bitmap of supported HDR modes
+ */
+struct i3c_ccc_gethdrcap {
+	u8 modes;
+} __packed;
+
+/**
+ * enum i3c_ccc_setxtime_subcmd - SETXTIME sub-commands
+ */
+enum i3c_ccc_setxtime_subcmd {
+	I3C_CCC_SETXTIME_ST = 0x7f,
+	I3C_CCC_SETXTIME_DT = 0xbf,
+	I3C_CCC_SETXTIME_ENTER_ASYNC_MODE0 = 0xdf,
+	I3C_CCC_SETXTIME_ENTER_ASYNC_MODE1 = 0xef,
+	I3C_CCC_SETXTIME_ENTER_ASYNC_MODE2 = 0xf7,
+	I3C_CCC_SETXTIME_ENTER_ASYNC_MODE3 = 0xfb,
+	I3C_CCC_SETXTIME_ASYNC_TRIGGER = 0xfd,
+	I3C_CCC_SETXTIME_TPH = 0x3f,
+	I3C_CCC_SETXTIME_TU = 0x9f,
+	I3C_CCC_SETXTIME_ODR = 0x8f,
+};
+
+/**
+ * struct i3c_ccc_setxtime - payload passed to SETXTIME CCC
+ *
+ * @subcmd: one of the sub-commands ddefined in &enum i3c_ccc_setxtime_subcmd
+ * @data: sub-command payload. Amount of data is determined by
+ *	  &i3c_ccc_setxtime->subcmd
+ */
+struct i3c_ccc_setxtime {
+	u8 subcmd;
+	u8 data[0];
+} __packed;
+
+#define I3C_CCC_GETXTIME_SYNC_MODE	BIT(0)
+#define I3C_CCC_GETXTIME_ASYNC_MODE(x)	BIT((x) + 1)
+#define I3C_CCC_GETXTIME_OVERFLOW	BIT(7)
+
+/**
+ * struct i3c_ccc_getxtime - payload retrieved from GETXTIME CCC
+ *
+ * @supported_modes: bitmap describing supported XTIME modes
+ * @state: current status (enabled mode and overflow status)
+ * @frequency: slave's internal oscillator frequency in 500KHz steps
+ * @inaccuracy: slave's internal oscillator inaccuracy in 0.1% steps
+ */
+struct i3c_ccc_getxtime {
+	u8 supported_modes;
+	u8 state;
+	u8 frequency;
+	u8 inaccuracy;
+} __packed;
+
+/**
+ * struct i3c_ccc_cmd_payload - CCC payload
+ *
+ * @len: payload length
+ * @data: payload data
+ */
+struct i3c_ccc_cmd_payload {
+	u16 len;
+	void *data;
+};
+
+/**
+ * struct i3c_ccc_cmd_dest - CCC command destination
+ *
+ * @addr: can be an I3C device address or the broadcast address if this is a
+ *	  broadcast CCC
+ * @payload: payload to be sent to this device or broadcasted
+ */
+struct i3c_ccc_cmd_dest {
+	u8 addr;
+	struct i3c_ccc_cmd_payload payload;
+};
+
+/**
+ * struct i3c_ccc_cmd - CCC command
+ *
+ * @rnw: true if the CCC should retrieve data from the device. Only valid for
+ *	 unicast commands
+ * @id: CCC command id
+ * @dests: array of destinations and associated payload for this CCC. Most of
+ *	   the time, only one destination is provided
+ * @ndests: number of destinations. Should always be one for broadcast commands
+ */
+struct i3c_ccc_cmd {
+	bool rnw;
+	u8 id;
+	struct i3c_ccc_cmd_dest *dests;
+	int ndests;
+};
+
+#endif /* I3C_CCC_H */
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
new file mode 100644
index 000000000000..4c8675e01ddf
--- /dev/null
+++ b/include/linux/i3c/device.h
@@ -0,0 +1,212 @@
+/*
+ * Copyright (C) 2017 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#ifndef I3C_DEV_H
+#define I3C_DEV_H
+
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+
+/**
+ * enum i3c_hdr_mode - HDR mode ids
+ */
+enum i3c_hdr_mode {
+	I3C_HDR_DDR,
+	I3C_HDR_TSP,
+	I3C_HDR_TSL,
+};
+
+/**
+ * struct i3c_hdr_cmd - I3C HDR command
+ *
+ * @mode: HDR mode selected for this command
+ * @addr: I3C dynamic address
+ * @ndatawords: number of data words (a word is 16bits wide)
+ * @data: input/output buffer
+ */
+struct i3c_hdr_cmd {
+	enum i3c_hdr_mode mode;
+	u8 code;
+	u8 addr;
+	int ndatawords;
+	union {
+		u16 *in;
+		const u16 *out;
+	} data;
+};
+
+/* Private SDR read transfer */
+#define I3C_PRIV_XFER_READ		BIT(0)
+/*
+ * Instruct the controller to issue a STOP after a specific transfer instead
+ * of a REPEATED START.
+ */
+#define I3C_PRIV_XFER_STOP		BIT(1)
+
+/**
+ * struct i3c_priv_xfer - I3C SDR private transfer
+ *
+ * @addr: I3C dynamic address
+ * @len: transfer length in bytes of the transfer
+ * @flags: combination of I3C_PRIV_XFER_xxx flags
+ * @data: input/output buffer
+ */
+struct i3c_priv_xfer {
+	u8 addr;
+	u16 len;
+	u32 flags;
+	struct {
+		void *in;
+		const void *out;
+	} data;
+};
+
+/**
+ * enum i3c_dcr - I3C DCR values
+ */
+enum i3c_dcr {
+	I3C_DCR_GENERIC_DEVICE = 0,
+};
+
+#define I3C_PID_MANUF_ID(pid)		(((pid) & GENMASK_ULL(47, 33)) >> 33)
+#define I3C_PID_RND_LOWER_32BITS(pid)	(!!((pid) & BIT_ULL(32)))
+#define I3C_PID_RND_VAL(pid)		((pid) & GENMASK_ULL(31, 0))
+#define I3C_PID_PART_ID(pid)		(((pid) & GENMASK_ULL(31, 16)) >> 16)
+#define I3C_PID_INSTANCE_ID(pid)	(((pid) & GENMASK_ULL(15, 12)) >> 12)
+#define I3C_PID_EXTRA_INFO(pid)		((pid) & GENMASK_ULL(11, 0))
+
+#define I3C_BCR_DEVICE_ROLE(bcr)	((bcr) & GENMASK(7, 6))
+#define I3C_BCR_I3C_SLAVE		(0 << 6)
+#define I3C_BCR_I3C_MASTER		(1 << 6)
+#define I3C_BCR_HDR_CAP			BIT(5)
+#define I3C_BCR_BRIDGE			BIT(4)
+#define I3C_BCR_OFFLINE_CAP		BIT(3)
+#define I3C_BCR_IBI_PAYLOAD		BIT(2)
+#define I3C_BCR_IBI_REQ_CAP		BIT(1)
+#define I3C_BCR_MAX_DATA_SPEED_LIM	BIT(0)
+
+/**
+ * struct i3c_device_info - I3C device information
+ *
+ * @pid: Provisional ID
+ * @bcr: Bus Characteristic Register
+ * @dcr: Device Characteristic Register
+ * @static_addr: static/I2C address
+ * @dyn_addr: dynamic address
+ * @hdr_cap: supported HDR modes
+ * @max_read_ds: max read speed information
+ * @max_write_ds: max write speed information
+ * @max_ibi_len: max IBI payload length
+ * @max_read_turnaround: max read turn-around time in micro-seconds
+ * @max_read_len: max private SDR read length in bytes
+ * @max_write_len: max private SDR write length in bytes
+ *
+ * These are all basic information that should be advertised by an I3C device.
+ * Some of them are optional depending on the device type and device
+ * capabilities.
+ * For each I3C slave attached to a master with
+ * i3c_master_add_i3c_dev_locked(), the core will send the relevant CCC command
+ * to retrieve these data.
+ */
+struct i3c_device_info {
+	u64 pid;
+	u8 bcr;
+	u8 dcr;
+	u8 static_addr;
+	u8 dyn_addr;
+	u8 hdr_cap;
+	u8 max_read_ds;
+	u8 max_write_ds;
+	u8 max_ibi_len;
+	u32 max_read_turnaround;
+	u16 max_read_len;
+	u16 max_write_len;
+};
+
+/*
+ * I3C device internals are kept hidden from I3C device users. It's just
+ * simpler to refactor things when everything goes through getter/setters, and
+ * I3C device drivers should not have to worry about internal representation
+ * anyway.
+ */
+struct i3c_device;
+
+/* These macros should be used to i3c_device_id entries. */
+#define I3C_MATCH_MANUF_AND_PART (I3C_MATCH_MANUF | I3C_MATCH_PART)
+
+#define I3C_DEVICE(manuf, part)						\
+	{								\
+		.match_flags = I3C_MATCH_MANUF_AND_PART,		\
+		.manuf_id = manuf,					\
+		.part_id = part,					\
+	}
+
+#define I3C_DEVICE_EXTRA_INFO(manuf, part, info)			\
+	{								\
+		.match_flags = I3C_MATCH_MANUF_AND_PART |		\
+			       I3C_MATCH_EXTRA_INFO,			\
+		.manuf_id = manuf,					\
+		.part_id = part,					\
+		.extra_info = info,					\
+	}
+
+#define I3C_CLASS(__dcr)						\
+	{								\
+		.match_flags = I3C_MATCH_DCR,				\
+		.dcr = __dcr,						\
+	}
+
+/**
+ * struct i3c_driver - I3C device driver
+ * @driver: inherit from device_driver
+ * @probe: I3C device probe method
+ * @remove: I3C device remove method
+ * @id_table: I3C device match table. Will be used by the framework to decide
+ *	      which device to bind to this driver
+ */
+struct i3c_driver {
+	struct device_driver driver;
+	int (*probe)(struct i3c_device *dev);
+	int (*remove)(struct i3c_device *dev);
+	const struct i3c_device_id *id_table;
+};
+
+static inline struct i3c_driver *drv_to_i3cdrv(struct device_driver *drv)
+{
+	return container_of(drv, struct i3c_driver, driver);
+}
+
+int i3c_driver_register_with_owner(struct i3c_driver *drv,
+				   struct module *owner);
+void i3c_driver_unregister(struct i3c_driver *drv);
+
+#define i3c_driver_register(drv)	\
+	i3c_driver_register_with_owner(drv, THIS_MODULE)
+
+#define module_i3c_driver(i3cdrv) \
+	module_driver(i3cdrv, i3c_driver_register, i3c_driver_unregister)
+
+int i3c_device_do_priv_xfers(struct i3c_device *dev,
+			     struct i3c_priv_xfer *xfers,
+			     int nxfers);
+int i3c_device_send_hdr_cmds(struct i3c_device *dev,
+			     struct i3c_hdr_cmd *cmds,
+			     int ncmds);
+
+void i3c_device_get_info(struct i3c_device *dev, struct i3c_device_info *info);
+
+#endif /* I3C_DEV_H */
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
new file mode 100644
index 000000000000..4ff9c6475c92
--- /dev/null
+++ b/include/linux/i3c/master.h
@@ -0,0 +1,453 @@
+/*
+ * Copyright (C) 2017 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#ifndef I3C_MASTER_H
+#define I3C_MASTER_H
+
+#include <linux/i2c.h>
+#include <linux/i3c/ccc.h>
+#include <linux/i3c/device.h>
+
+#define I3C_HOT_JOIN_ADDR		0x2
+#define I3C_BROADCAST_ADDR		0x7e
+#define I3C_MAX_ADDR			GENMASK(6, 0)
+
+struct i3c_master_controller;
+struct i3c_bus;
+
+/**
+ * struct i3c_i2c_dev - I3C/I2C common information
+ *
+ * @node: node element used to insert the device into the I2C or I3C device
+ *	  list
+ * @bus: I3C bus this device is connected to
+ * @master: I3C master that instantiated this device. Will be used to send
+ *	    I2C/I3C frames on the bus
+ * @master_priv: master private data assigned to the device. Can be used to
+ *		 add master specific information
+ *
+ * This structure is describing common I3C/I2C dev information.
+ */
+struct i3c_i2c_dev {
+	struct list_head node;
+	struct i3c_bus *bus;
+	struct i3c_master_controller *master;
+	void *master_priv;
+};
+
+#define I3C_LVR_I2C_INDEX_MASK		GENMASK(7, 5)
+#define I3C_LVR_I2C_INDEX(x)		((x) << 5)
+#define I3C_LVR_I2C_FM_MODE		BIT(4)
+
+#define I2C_MAX_ADDR			GENMASK(9, 0)
+
+/**
+ * struct i2c_device - I2C device object
+ *
+ * @common: inherit common I3C/I2C description
+ * @info: I2C board info used to instantiate the I2C device. If you are
+ *	  using DT to describe your hardware, this will be filled for you.
+ * @client: I2C client object created by the I2C framework. This will only
+ *	    be valid after i3c_master_register() returns.
+ * @lvr: Legacy Virtual Register value as described in the I3C specification
+ *
+ * I2C device object. Note that the real I2C device is represented by
+ * i2c_device->client, but we need extra information to handle the device when
+ * it's connected to an I3C bus, hence the &struct i2c_device wrapper.
+ *
+ * The I2C framework is not impacted by this new representation.
+ */
+struct i2c_device {
+	struct i3c_i2c_dev common;
+	struct i2c_board_info info;
+	struct i2c_client *client;
+	u8 lvr;
+};
+
+/**
+ * struct i3c_device - I3C device object
+ *
+ * @common: inherit common I3C/I2C description
+ * @dev: device object to register the I3C dev to the device model
+ * @info: I3C device information. Will be automatically filled when you create
+ *	  your device with i3c_master_add_i3c_dev_locked().
+ *
+ * I3C device object. Every I3C devs on the I3C bus are represented, including
+ * I3C masters. For each of them, we have an instance of &struct i3c_device.
+ */
+struct i3c_device {
+	struct i3c_i2c_dev common;
+	struct device dev;
+	struct i3c_device_info info;
+};
+
+/*
+ * The I3C specification says the maximum number of devices connected on the
+ * bus is 11, but this number depends on external parameters like trace length,
+ * capacitive load per Device, and the types of Devices present on the Bus.
+ * I3C master can also have limitations, so this number is just here as a
+ * reference and should be adjusted on a per-controller/per-board basis.
+ */
+#define I3C_BUS_MAX_DEVS		11
+
+#define I3C_BUS_MAX_I3C_SCL_RATE	12900000
+#define I3C_BUS_TYP_I3C_SCL_RATE	12500000
+#define I3C_BUS_I2C_FM_PLUS_SCL_RATE	1000000
+#define I3C_BUS_I2C_FM_SCL_RATE		400000
+#define I3C_BUS_TLOW_OD_MIN_NS		200
+
+/**
+ * enum i3c_bus_mode - I3C bus mode
+ *
+ * @I3C_BUS_MODE_PURE: only I3C devices are connected to the bus. No limitation
+ *		       expected
+ * @I3C_BUS_MODE_MIXED_FAST: I2C devices with 50ns spike filter are present on
+ *			     the bus. The only impact in this mode is that the
+ *			     high SCL pulse has to stay below 50ns to trick I2C
+ *			     devices when transmitting I3C frames
+ * @I3C_BUS_MODE_MIXED_SLOW: I2C devices without 50ns spike filter are present
+ *			     on the bus
+ */
+enum i3c_bus_mode {
+	I3C_BUS_MODE_PURE,
+	I3C_BUS_MODE_MIXED_FAST,
+	I3C_BUS_MODE_MIXED_SLOW,
+};
+
+/**
+ * enum i3c_addr_slot_status - I3C address slot status
+ *
+ * @I3C_ADDR_SLOT_FREE: address is free
+ * @I3C_ADDR_SLOT_RSVD: address is reserved
+ * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
+ * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
+ * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
+ *
+ * On an I3C bus, addresses are assigned dynamically, and we need to know which
+ * addresses are free to use and which ones are already assigned.
+ *
+ * Addresses marked as reserved are those reserved by the I3C protocol
+ * (broadcast address, ...).
+ */
+enum i3c_addr_slot_status {
+	I3C_ADDR_SLOT_FREE,
+	I3C_ADDR_SLOT_RSVD,
+	I3C_ADDR_SLOT_I2C_DEV,
+	I3C_ADDR_SLOT_I3C_DEV,
+	I3C_ADDR_SLOT_STATUS_MASK = 3,
+};
+
+/**
+ * struct i3c_bus - I3C bus object
+ *
+ * @dev: device to be registered to the device-model
+ * @cur_master: I3C master currently driving the bus. Since I3C is multi-master
+ *		this can change over the time. Will be used to let a master
+ *		know whether it needs to request bus ownership before sending
+ *		a frame or not
+ * @addrslots: a bitmap with 2-bits per-slot to encode the address status and
+ *	       ease the DAA (Dynamic Address Assignment) procedure (see
+ *	       &enum i3c_addr_slot_status)
+ * @mode: bus mode (see &enum i3c_bus_mode)
+ * @scl_rate: SCL signal rate for I3C and I2C mode
+ * @devs: 2 lists containing all I3C/I2C devices connected to the bus
+ * @lock: read/write lock on the bus. This is needed to protect against
+ *	  operations that have an impact on the whole bus and the devices
+ *	  connected to it. For example, when asking slaves to drop their
+ *	  dynamic address (RSTDAA CCC), we need to make sure no one is trying
+ *	  to send I3C frames to these devices.
+ *	  Note that this lock does not protect against concurrency between
+ *	  devices: several drivers can send different I3C/I2C frames through
+ *	  the same master in parallel. This is the responsibility of the
+ *	  master to guarantee that frames are actually sent sequentially and
+ *	  not interlaced.
+ *
+ * The I3C bus is represented with its own object and not implicitly described
+ * by the I3C master to cope with the multi-master functionality, where one bus
+ * can be shared amongst several masters, each of them requesting bus ownership
+ * when they need to.
+ */
+struct i3c_bus {
+	struct device dev;
+	struct i3c_device *cur_master;
+	int id;
+	unsigned long addrslots[((I2C_MAX_ADDR + 1) * 2) / BITS_PER_LONG];
+	enum i3c_bus_mode mode;
+	struct {
+		unsigned long i3c;
+		unsigned long i2c;
+	} scl_rate;
+	struct {
+		struct list_head i3c;
+		struct list_head i2c;
+	} devs;
+	struct rw_semaphore lock;
+};
+
+static inline struct i3c_device *dev_to_i3cdev(struct device *dev)
+{
+	return container_of(dev, struct i3c_device, dev);
+}
+
+struct i3c_master_controller;
+
+/**
+ * struct i3c_master_controller_ops - I3C master methods
+ *
+ * @bus_init: hook responsible for the I3C bus initialization. This
+ *	      initialization should follow the steps described in the I3C
+ *	      specification. This hook is called with the bus lock held in
+ *	      write mode, which means all _locked() helpers can safely be
+ *	      called from there.
+ * @bus_cleanup: cleanup everything done in
+ *		 &i3c_master_controller_ops->bus_init(). This function is
+ *		 optional and should only be implemented if
+ *		 &i3c_master_controller_ops->bus_init() attached private data
+ *		 to I3C/I2C devices. This hook is called with the bus lock
+ *		 held in write mode, which means all _locked() helpers can
+ *		 safely be called from there.
+ * @supports_ccc_cmd: should return true if the CCC command is supported, false
+ *		      otherwise
+ * @send_ccc_cmd: send a CCC command
+ * @send_hdr_cmds: send one or several HDR commands. If there is more than one
+ *		   command, they should ideally be sent in the same HDR
+ *		   transaction
+ * @priv_xfers: do one or several private I3C SDR transfers
+ * @i2c_xfers: do one or several I2C transfers
+ *
+ * One of the most important hooks in these ops is
+ * &i3c_master_controller_ops->bus_init(). Here is a non-exhaustive list of
+ * things that should be done in &i3c_master_controller_ops->bus_init():
+ *
+ * 1) call i3c_master_set_info() with all information describing the master
+ * 2) ask all slaves to drop their dynamic address by sending the RSTDAA CCC
+ *    with i3c_master_rstdaa_locked()
+ * 3) ask all slaves to disable IBIs using i3c_master_disec_locked()
+ * 4) start a DDA procedure by sending the ENTDAA CCC with
+ *    i3c_master_entdaa_locked(), or using the internal DAA logic provided by
+ *    your controller
+ * 5) assign a dynamic address to each I3C device discovered during DAA and
+ *    for each of them, call i3c_master_add_i3c_dev_locked()
+ * 6) propagate device table to secondary masters by calling
+ *    i3c_master_defslvs_locked()
+ *
+ * Note that these steps do not include all controller specific initialization.
+ */
+struct i3c_master_controller_ops {
+	int (*bus_init)(struct i3c_master_controller *master);
+	void (*bus_cleanup)(struct i3c_master_controller *master);
+	bool (*supports_ccc_cmd)(struct i3c_master_controller *master,
+				 const struct i3c_ccc_cmd *cmd);
+	int (*send_ccc_cmd)(struct i3c_master_controller *master,
+			    struct i3c_ccc_cmd *cmd);
+	int (*send_hdr_cmds)(struct i3c_master_controller *master,
+			     const struct i3c_hdr_cmd *cmds,
+			     int ncmds);
+	int (*priv_xfers)(struct i3c_master_controller *master,
+			  const struct i3c_priv_xfer *xfers,
+			  int nxfers);
+	int (*i2c_xfers)(struct i3c_master_controller *master,
+			 const struct i2c_msg *xfers, int nxfers);
+};
+
+/**
+ * struct i3c_master_controller - I3C master controller object
+ *
+ * @parent: parent device that instantiated this master
+ * @base: inherit from &struct i3c_device. A master is just a I3C device that
+ *	  has to be represented on the bus
+ * @i2c: I2C adapter used for backward compatibility. This adapter is
+ *	 registered to the I2C subsystem to be as transparent as possible to
+ *	 existing I2C drivers
+ * @ops: master operations. See &struct i3c_master_controller_ops
+ * @secondary: true if the master is a secondary master
+ * @bus: I3C bus object created by this master
+ *
+ * A &struct i3c_master_controller has to be registered to the I3C subsystem
+ * through i3c_master_register(). None of &struct i3c_master_controller fields
+ * should be set manually, just pass appropriate values to
+ * i3c_master_register().
+ */
+struct i3c_master_controller {
+	struct device *parent;
+	struct i3c_device base;
+	struct i2c_adapter i2c;
+	const struct i3c_master_controller_ops *ops;
+	bool secondary;
+	struct i3c_bus *bus;
+};
+
+/**
+ * i3c_bus_for_each_i2cdev() - iterate over all I2C devices present on the bus
+ *
+ * @bus: the I3C bus
+ * @i2cdev: an I2C device updated to point to the current device at each loop
+ *	    iteration
+ *
+ * Iterate over all I2C devs present on the bus.
+ */
+#define i3c_bus_for_each_i2cdev(bus, i2cdev)				\
+	list_for_each_entry(i2cdev, &(bus)->devs.i2c, common.node)
+
+/**
+ * i3c_bus_for_each_i3cdev() - iterate over all I3C devices present on the bus
+ *
+ * @bus: the I3C bus
+ * @i3cdev: an I3C device updated to point to the current device at each loop
+ *	    iteration
+ *
+ * Iterate over all I3C devs present on the bus.
+ */
+#define i3c_bus_for_each_i3cdev(bus, i3cdev)				\
+	list_for_each_entry(i3cdev, &(bus)->devs.i3c, common.node)
+
+int i3c_master_send_hdr_cmds(struct i3c_master_controller *master,
+			     const struct i3c_hdr_cmd *cmds,
+			     int ncmds);
+int i3c_master_do_priv_xfers(struct i3c_master_controller *master,
+			     const struct i3c_priv_xfer *xfers,
+			     int nxfers);
+int i3c_master_do_i2c_xfers(struct i3c_master_controller *master,
+			    const struct i2c_msg *xfers,
+			    int nxfers);
+
+int i3c_master_disec_locked(struct i3c_master_controller *master, u8 addr,
+			    const struct i3c_ccc_events *evts);
+int i3c_master_rstdaa_locked(struct i3c_master_controller *master, u8 addr);
+int i3c_master_entdaa_locked(struct i3c_master_controller *master);
+int i3c_master_defslvs_locked(struct i3c_master_controller *master);
+
+int i3c_master_get_free_addr(struct i3c_master_controller *master,
+			     u8 start_addr);
+
+struct i3c_device *
+i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master, u8 addr);
+
+int i3c_master_set_info(struct i3c_master_controller *master,
+			const struct i3c_device_info *info);
+
+int i3c_master_register(struct i3c_master_controller *master,
+			struct device *parent,
+			const struct i3c_master_controller_ops *ops,
+			bool secondary);
+int i3c_master_unregister(struct i3c_master_controller *master);
+
+/**
+ * i3c_device_get_master_data() - get master private data attached to an I3C
+ *				  device
+ *
+ * @dev: the I3C dev to attach private data to
+ *
+ * Return: the private data previously attached with
+ *	   i3c_device_set_master_data() or NULL if no data has been attached
+ *	   to the device.
+ */
+static inline void *i3c_device_get_master_data(const struct i3c_device *dev)
+{
+	return dev->common.master_priv;
+}
+
+/**
+ * i3c_device_set_master_data() - attach master private data to an I3C device
+ *
+ * @dev: the I3C dev to attach private data to
+ * @data: private data
+ *
+ * This functions allows a master controller to attach per-device private data
+ * which can then be retrieved with i3c_device_get_master_data().
+ *
+ * Attaching private data to a device is usually done just after calling
+ * i3c_master_add_i3c_dev_locked().
+ */
+static inline void i3c_device_set_master_data(struct i3c_device *dev,
+					      void *data)
+{
+	dev->common.master_priv = data;
+}
+
+/**
+ * i2c_device_get_master_data() - get master private data attached to an I2C
+ *				  device
+ *
+ * @dev: the I2C dev to attach private data to
+ *
+ * Return: the private data previously attached with
+ *	   i2c_device_set_master_data() or NULL if no data has been attached
+ *	   to the device.
+ */
+static inline void *i2c_device_get_master_data(const struct i2c_device *dev)
+{
+	return dev->common.master_priv;
+}
+
+/**
+ * i2c_device_set_master_data() - attach master private data to an I2C device
+ *
+ * @dev: the I2C dev to attach private data to
+ * @data: private data
+ *
+ * This functions allows a master controller to attach per-device private data
+ * which can then be retrieved with i2c_device_get_master_data().
+ *
+ * Attaching private data to a device is usually done during
+ * &master_controller_ops->bus_init(), by iterating over all I2C devices
+ * instantiated by the core (using i3c_bus_for_each_i2cdev()).
+ */
+static inline void i2c_device_set_master_data(struct i2c_device *dev,
+					      void *data)
+{
+	dev->common.master_priv = data;
+}
+
+/**
+ * i3c_device_get_master() - get master used to communicate with a device
+ *
+ * @dev: I3C dev
+ *
+ * Return: the master controller driving @dev
+ */
+static inline struct i3c_master_controller *
+i3c_device_get_master(struct i3c_device *dev)
+{
+	return dev->common.master;
+}
+
+/**
+ * i3c_master_get_bus() - get the bus attached to a master
+ *
+ * @master: master object
+ *
+ * Return: the I3C bus @master is connected to
+ */
+static inline struct i3c_bus *
+i3c_master_get_bus(struct i3c_master_controller *master)
+{
+	return master->bus;
+}
+
+/**
+ * i3c_device_get_bus() - get the bus attached to a device
+ *
+ * @dev: an I3C device
+ *
+ * Return: the I3C bus @dev is connected to
+ */
+static inline struct i3c_bus *i3c_device_get_bus(struct i3c_device *dev)
+{
+	return i3c_master_get_bus(i3c_device_get_master(dev));
+}
+
+#endif /* I3C_MASTER_H */
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 3f74ef2281e8..df6c3a43b51c 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -438,6 +438,21 @@ struct pci_epf_device_id {
 	kernel_ulong_t driver_data;
 };
 
+/* i3c */
+
+#define I3C_MATCH_DCR			BIT(0)
+#define I3C_MATCH_MANUF			BIT(1)
+#define I3C_MATCH_PART			BIT(2)
+#define I3C_MATCH_EXTRA_INFO		BIT(3)
+
+struct i3c_device_id {
+	__u8 match_flags;
+	__u8 dcr;
+	__u16 manuf_id;
+	__u16 part_id;
+	__u16 extra_info;
+};
+
 /* spi */
 
 #define SPI_NAME_SIZE	32
-- 
2.7.4
