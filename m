From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-mux-gpio platform device ID issue
Date: Wed, 25 Jul 2012 16:39:13 +0200
Message-ID: <20120725163913.60fffd1a@endymion.delvare>
References: <20120725144409.1e47bd95@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120725144409.1e47bd95-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 25 Jul 2012 14:44:09 +0200, Jean Delvare wrote:
> If a per-driver IDA isn't acceptable, then we can go for a global IDA,
> but then we can't re-use pdev->id == -1 for it. We'd have to introduce
> pdev->id == -2 for drivers which want a dynamically allocated unique
> ID. Actually this might be a better approach, as it's less intrusive.

A possible implementation of this would be:

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: platform: Add support for automatic device IDs

Right now we have support for explicit platform device IDs, as well as
ID-less platform devices when a given device type can only have one
instance. However there are cases where multiple instances of a device
type can exist, and their IDs aren't (and can't be) known in advance
and do not matter. In that case we need automatic device IDs to avoid
device name collisions.

I am using magic ID value -4 for this (I left -2 and -3 free in case
we ever need a couple of other magic values.) The automatically
allocated device IDs are global (to avoid an additional per-driver
cost) and are stored internally as negative numbers, starting with -4.
This is required so that the IDs can be freed later. Externally the
positive value is used.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
If anyone has a problem with the -4 or using negative device IDs
internally, it would be possible to avoid that by adding a boolean
attribute to every platform device to record whether the ID needs to
be freed. This would cost some memory.

The code assumes that a given platform driver doesn't mix devices
with explicit IDs and devices with automatic IDs. This seems
reasonable to me. If not, we'll need separate namespaces for both
types.

 drivers/base/platform.c |   30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

--- linux-3.5.orig/drivers/base/platform.c	2012-07-21 22:58:29.000000000 +0200
+++ linux-3.5/drivers/base/platform.c	2012-07-25 16:37:03.707518815 +0200
@@ -20,9 +20,12 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
+#include <linux/idr.h>
 
 #include "base.h"
 
+static DEFINE_IDA(platform_ida);
+
 #define to_platform_driver(drv)	(container_of((drv), struct platform_driver, \
 				 driver))
 
@@ -273,10 +276,27 @@ int platform_device_add(struct platform_
 
 	pdev->dev.bus = &platform_bus_type;
 
-	if (pdev->id != -1)
+	switch (pdev->id) {
+	default:
 		dev_set_name(&pdev->dev, "%s.%d", pdev->name,  pdev->id);
-	else
+		break;
+	case -1:
 		dev_set_name(&pdev->dev, "%s", pdev->name);
+		break;
+	case -4:
+		/*
+		 * Automatically allocated device ID. Stored as a negative
+		 * number so that we remember it must be freed. We use the
+		 * opposite in the device name so that the user still sees a
+		 * positive device ID.
+		 */
+		i = ida_simple_get(&platform_ida, 4, 0, GFP_KERNEL);
+		if (i < 0)
+			return i;
+		pdev->id = -i;
+		dev_set_name(&pdev->dev, "%s.%d", pdev->name, -pdev->id);
+		break;
+	}
 
 	for (i = 0; i < pdev->num_resources; i++) {
 		struct resource *p, *r = &pdev->resource[i];
@@ -309,6 +329,9 @@ int platform_device_add(struct platform_
 		return ret;
 
  failed:
+	if (pdev->id <= -4)
+		ida_simple_remove(&platform_ida, -pdev->id);
+
 	while (--i >= 0) {
 		struct resource *r = &pdev->resource[i];
 		unsigned long type = resource_type(r);
@@ -336,6 +359,9 @@ void platform_device_del(struct platform
 	if (pdev) {
 		device_del(&pdev->dev);
 
+		if (pdev->id <= -4)
+			ida_simple_remove(&platform_ida, -pdev->id);
+
 		for (i = 0; i < pdev->num_resources; i++) {
 			struct resource *r = &pdev->resource[i];
 			unsigned long type = resource_type(r);

-- 
Jean Delvare
