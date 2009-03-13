From: Michael Lawnick <nospam_lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: [PATCH]i2c: Make test for force on client probe possible
Date: Fri, 13 Mar 2009 11:15:57 +0100
Message-ID: <49BA325D.7030308@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: public-khali-PUYAD+kWke1g9hUCZPvPmw-8ByrlEUxsivZ+VzJOa5vwg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

in new driver model 'kind' is no more provided for client's probe
function. The driver frame work creates the path
sys/bus/i2c/devices/[bus]-[dev]/ and populates it with the entries
modalias, name, subsystem@ and uevent. If probe fails (because the
device is not on bus at the moment) the client's sysFs-entries are not
created, but the entries above remain.
This patch provides means to get modules force parameter in probe
function. Clients should test and create entries despite test fail. Of
course entry callbacks should return -EIO as long as device stays
unreachable.

Signed-off-by: <nospam_lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/i2c-core.c |    29 ++
 include/linux/i2c.h    |     2 +
 2 files changed, 31 insertions(+), 0 deletion(-)

--- linux-2.6.28.7_org/drivers/i2c/i2c-core.c   2009-02-20
23:41:27.000000000 +0100
+++ linux-2.6.28.7/drivers/i2c/i2c-core.c       2009-03-12
13:08:35.000000000 +0100
@@ -323,6 +323,34 @@
 }
 EXPORT_SYMBOL_GPL(i2c_unregister_device);

+int i2c_client_is_forced (struct i2c_client *client)
+{
+       int forced = 0;
+
+       if (client->driver->address_data->forces) {
+               int adap_id = i2c_adapter_id(client->adapter);
+               const unsigned short * const *forces =
client->driver->address_data->forces;
+               int kind, i;
+
+               for (kind = 0; forces[kind]; kind++) {
+                       for (i = 0; forces[kind][i] != I2C_CLIENT_END;
+                            i += 2) {
+                               if ((forces[kind][i] == adap_id
+                                || forces[kind][i] == ANY_I2C_BUS)
+                                && forces[kind][i+1] == client->addr) {
+                                       dev_dbg(&client->dev, "forced "
+                                               "probe for adapter %d, "
+                                               "addr 0x%02x, kind %d\n",
+                                               adap_id, forces[kind][i
+ 1],
+                                               kind);
+                                       forced = 1;
+                               }
+                       }
+               }
+       }
+       return forced;
+}
+EXPORT_SYMBOL_GPL(i2c_client_is_forced);

 static const struct i2c_device_id dummy_id[] = {
        { "dummy", 0 },
--- linux-2.6.28.7_org/include/linux/i2c.h      2009-02-20
23:41:27.000000000 +0100
+++ linux-2.6.28.7/include/linux/i2c.h  2009-03-13 11:07:43.000000000 +0100
@@ -301,6 +301,8 @@

 extern void i2c_unregister_device(struct i2c_client *);

+extern int i2c_client_is_forced(struct i2c_client *client);
+
 /* Mainboard arch_initcall() code should register all its I2C devices.
  * This is done at arch_initcall time, before declaring any i2c adapters.
  * Modules for add-on boards must use other calls.
