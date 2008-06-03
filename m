From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Simplify i2c_device_probe
Date: Tue, 3 Jun 2008 20:29:54 +0200
Message-ID: <20080603202954.64d5971c@hyperion.delvare>
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
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

i2c_driver.id_table is mandatory now, so we can simplify
i2c_device_probe() a bit.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/i2c-core.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- linux-2.6.26-rc4.orig/drivers/i2c/i2c-core.c	2008-06-03 10:57:55.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/i2c-core.c	2008-06-03 16:38:37.000000000 +0200
@@ -101,19 +101,14 @@ static int i2c_device_probe(struct devic
 {
 	struct i2c_client	*client = to_i2c_client(dev);
 	struct i2c_driver	*driver = to_i2c_driver(dev->driver);
-	const struct i2c_device_id *id;
 	int status;
 
-	if (!driver->probe)
+	if (!driver->probe || !driver->id_table)
 		return -ENODEV;
 	client->driver = driver;
 	dev_dbg(dev, "probe\n");
 
-	if (driver->id_table)
-		id = i2c_match_id(driver->id_table, client);
-	else
-		id = NULL;
-	status = driver->probe(client, id);
+	status = driver->probe(client, i2c_match_id(driver->id_table, client));
 	if (status)
 		client->driver = NULL;
 	return status;


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
