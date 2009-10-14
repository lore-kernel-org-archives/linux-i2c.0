From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/3] i2c-powermac: Simplify pmac_i2c_adapter_to_bus
Date: Wed, 14 Oct 2009 16:57:43 +0200
Message-ID: <20091014165743.279789a4@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

pmac_i2c_adapter_to_bus can be simplified. We no longer need to walk
the list of buses, we can get the right bus directly.

The only case where it makes a difference is if the provided adapter
is _not_ a pmac_i2c_bus, but it is not supposed to happen anyway. So
we can also drop the error checks.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
---
 arch/powerpc/platforms/powermac/low_i2c.c   |    7 +------
 drivers/macintosh/windfarm_lm75_sensor.c    |    2 --
 drivers/macintosh/windfarm_max6690_sensor.c |    2 --
 drivers/macintosh/windfarm_smu_sat.c        |    2 --
 sound/aoa/codecs/onyx.c                     |    2 --
 sound/aoa/codecs/tas.c                      |    2 --
 6 files changed, 1 insertion(+), 16 deletions(-)

--- linux-2.6.32-rc4.orig/arch/powerpc/platforms/powermac/low_i2c.c	2009-10-14 15:56:23.000000000 +0200
+++ linux-2.6.32-rc4/arch/powerpc/platforms/powermac/low_i2c.c	2009-10-14 15:57:42.000000000 +0200
@@ -1020,12 +1020,7 @@ EXPORT_SYMBOL_GPL(pmac_i2c_get_adapter);
 
 struct pmac_i2c_bus *pmac_i2c_adapter_to_bus(struct i2c_adapter *adapter)
 {
-	struct pmac_i2c_bus *bus;
-
-	list_for_each_entry(bus, &pmac_i2c_busses, link)
-		if (&bus->adapter == adapter)
-			return bus;
-	return NULL;
+	return container_of(adapter, struct pmac_i2c_bus, adapter);
 }
 EXPORT_SYMBOL_GPL(pmac_i2c_adapter_to_bus);
 
--- linux-2.6.32-rc4.orig/drivers/macintosh/windfarm_lm75_sensor.c	2009-10-05 10:45:49.000000000 +0200
+++ linux-2.6.32-rc4/drivers/macintosh/windfarm_lm75_sensor.c	2009-10-14 15:57:42.000000000 +0200
@@ -173,8 +173,6 @@ static int wf_lm75_attach(struct i2c_ada
 	DBG("wf_lm75: adapter %s detected\n", adapter->name);
 
 	bus = pmac_i2c_adapter_to_bus(adapter);
-	if (bus == NULL)
-		return -ENODEV;
 	busnode = pmac_i2c_get_bus_node(bus);
 
 	DBG("wf_lm75: bus found, looking for device...\n");
--- linux-2.6.32-rc4.orig/drivers/macintosh/windfarm_max6690_sensor.c	2009-10-05 10:45:49.000000000 +0200
+++ linux-2.6.32-rc4/drivers/macintosh/windfarm_max6690_sensor.c	2009-10-14 15:57:42.000000000 +0200
@@ -135,8 +135,6 @@ static int wf_max6690_attach(struct i2c_
 	const char *loc;
 
 	bus = pmac_i2c_adapter_to_bus(adapter);
-	if (bus == NULL)
-		return -ENODEV;
 	busnode = pmac_i2c_get_bus_node(bus);
 
 	while ((dev = of_get_next_child(busnode, dev)) != NULL) {
--- linux-2.6.32-rc4.orig/drivers/macintosh/windfarm_smu_sat.c	2009-10-05 10:45:49.000000000 +0200
+++ linux-2.6.32-rc4/drivers/macintosh/windfarm_smu_sat.c	2009-10-14 15:57:42.000000000 +0200
@@ -359,8 +359,6 @@ static int wf_sat_attach(struct i2c_adap
 	struct pmac_i2c_bus *bus;
 
 	bus = pmac_i2c_adapter_to_bus(adapter);
-	if (bus == NULL)
-		return -ENODEV;
 	busnode = pmac_i2c_get_bus_node(bus);
 
 	while ((dev = of_get_next_child(busnode, dev)) != NULL)
--- linux-2.6.32-rc4.orig/sound/aoa/codecs/onyx.c	2009-10-01 09:44:36.000000000 +0200
+++ linux-2.6.32-rc4/sound/aoa/codecs/onyx.c	2009-10-14 15:57:42.000000000 +0200
@@ -1077,8 +1077,6 @@ static int onyx_i2c_attach(struct i2c_ad
 	struct pmac_i2c_bus *bus;
 
 	bus = pmac_i2c_adapter_to_bus(adapter);
-	if (bus == NULL)
-		return -ENODEV;
 	busnode = pmac_i2c_get_bus_node(bus);
 
 	while ((dev = of_get_next_child(busnode, dev)) != NULL) {
--- linux-2.6.32-rc4.orig/sound/aoa/codecs/tas.c	2009-10-05 10:45:51.000000000 +0200
+++ linux-2.6.32-rc4/sound/aoa/codecs/tas.c	2009-10-14 15:57:42.000000000 +0200
@@ -958,8 +958,6 @@ static int tas_i2c_attach(struct i2c_ada
 	struct pmac_i2c_bus *bus;
 
 	bus = pmac_i2c_adapter_to_bus(adapter);
-	if (bus == NULL)
-		return -ENODEV;
 	busnode = pmac_i2c_get_bus_node(bus);
 
 	while ((dev = of_get_next_child(busnode, dev)) != NULL) {


-- 
Jean Delvare
