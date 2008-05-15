From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c-pcf8575: check for errors when accessing the chip
Date: Thu, 15 May 2008 16:35:27 +0200
Message-ID: <1210862127-9493-1-git-send-email-w.sang@pengutronix.de>
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
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: bart.vanassche-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hennerich-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Make the driver check and report error cases when reading from or writing to
the chip. It used to assume 'always success' and could even deliver bogus
values.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---

The PCF on my system seems broken, it does not respond (and I can't probe as my
master doesn't support smbus_quick). The broken chip went unnoticed as the
driver reported some (= bogus) values. So, I can only test the properly
reported error cases, hopefully someone else can confirm the working case.
(Michael and Bart, sorry for double post)

 drivers/i2c/chips/pcf8575.c |   29 +++++++++++++++++++++--------
 1 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/chips/pcf8575.c b/drivers/i2c/chips/pcf8575.c
index 3ea08ac..4a4247d 100644
--- a/drivers/i2c/chips/pcf8575.c
+++ b/drivers/i2c/chips/pcf8575.c
@@ -67,15 +67,22 @@ static ssize_t show_read(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	int status, retval = -EIO;
 	u16 val;
 	u8 iopin_state[2];
 
-	i2c_master_recv(client, iopin_state, 2);
+	status = i2c_master_recv(client, iopin_state, 2);
 
-	val = iopin_state[0];
-	val |= iopin_state[1] << 8;
+	if (status == 2) {
+		val = iopin_state[0];
+		val |= iopin_state[1] << 8;
+		return sprintf(buf, "%u\n", val);
+	}
+
+	if (status < 0)
+	    retval = status;
 
-	return sprintf(buf, "%u\n", val);
+	return retval;
 }
 
 static DEVICE_ATTR(read, S_IRUGO, show_read, NULL);
@@ -95,19 +102,25 @@ static ssize_t set_write(struct device *dev, struct device_attribute *attr,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pcf8575_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+	int status, retval = -EIO;
 	u8 iopin_state[2];
 
 	if (val > 0xffff)
 		return -EINVAL;
 
-	data->write = val;
-
 	iopin_state[0] = val & 0xFF;
 	iopin_state[1] = val >> 8;
 
-	i2c_master_send(client, iopin_state, 2);
+	status = i2c_master_send(client, iopin_state, 2);
+
+	if (status == 2)
+		retval = count;
+	else if (status < 0)
+		retval = status;
+
+	data->write = (status == 2) ? val : retval;
 
-	return count;
+	return retval;
 }
 
 static DEVICE_ATTR(write, S_IWUSR | S_IRUGO, show_write, set_write);
-- 
1.5.5.1


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
