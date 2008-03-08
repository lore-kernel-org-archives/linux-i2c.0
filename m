From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Keep client->driver and client->dev.driver in
	sync
Date: Sat, 8 Mar 2008 21:49:11 +0100
Message-ID: <20080308214911.5344eba9@hyperion.delvare>
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
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>

Ensures that client->driver is set to NULL if the probe() returns an
error (this keeps client->driver and client->dev.driver in sync).

Signed-off-by: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
Hans, I've updated your patch a bit to make i2c_device_probe() look
more like i2c_device_remove(); hope you don't mind.

David, this fix looks correct to me, I'll send it to Linus quickly if
you have no objection.

 drivers/i2c/i2c-core.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- linux-2.6.25-rc4.orig/drivers/i2c/i2c-core.c	2008-03-08 17:57:52.000000000 +0100
+++ linux-2.6.25-rc4/drivers/i2c/i2c-core.c	2008-03-08 21:43:11.000000000 +0100
@@ -90,12 +90,15 @@ static int i2c_device_probe(struct devic
 {
 	struct i2c_client	*client = to_i2c_client(dev);
 	struct i2c_driver	*driver = to_i2c_driver(dev->driver);
+	int status;
 
 	if (!driver->probe)
 		return -ENODEV;
-	client->driver = driver;
 	dev_dbg(dev, "probe\n");
-	return driver->probe(client);
+	status = driver->probe(client);
+	if (status == 0)
+		client->driver = driver;
+	return status;
 }
 
 static int i2c_device_remove(struct device *dev)


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
