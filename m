From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Check for address business before creating
	clients
Date: Fri, 8 Aug 2008 10:44:01 +0200
Message-ID: <20080808104401.1fb904ef@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

We check for address business in i2c_probe_address(),
i2c_detect_address() and i2c_new_probed_device(), but this isn't
sufficient. Drivers can call i2c_attach_client() and
i2c_new_device() on any address, so we must check the address there
as well.

This fixes bug #11239:
http://bugzilla.kernel.org/show_bug.cgi?id=11239

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/i2c-core.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- linux-2.6.27-rc2.orig/drivers/i2c/i2c-core.c	2008-08-08 09:12:08.000000000 +0200
+++ linux-2.6.27-rc2/drivers/i2c/i2c-core.c	2008-08-08 09:16:48.000000000 +0200
@@ -813,7 +813,12 @@ static int i2c_check_addr(struct i2c_ada
 int i2c_attach_client(struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
-	int res = 0;
+	int res;
+
+	/* Check for address business */
+	res = i2c_check_addr(adapter, client->addr);
+	if (res)
+		return res;
 
 	client->dev.parent = &client->adapter->dev;
 	client->dev.bus = &i2c_bus_type;


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
