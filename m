From: Adrian Bunk <bunk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [13/17] i2c: use bcd2bin/bin2bcd
Date: Fri, 8 Aug 2008 19:34:55 +0300
Message-ID: <20080808163455.GT14495@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch changes i2c to use the new bcd2bin/bin2bcd functions instead 
of the obsolete BCD2BIN/BIN2BCD macros.

Signed-off-by: Adrian Bunk <bunk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

---

 drivers/i2c/chips/menelaus.c |   34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

09bb671f208260e5a191d57101169860680fc163 
diff --git a/drivers/i2c/chips/menelaus.c b/drivers/i2c/chips/menelaus.c
index b36db17..4deb4c7 100644
--- a/drivers/i2c/chips/menelaus.c
+++ b/drivers/i2c/chips/menelaus.c
@@ -833,52 +833,52 @@ static irqreturn_t menelaus_irq(int irq, void *_menelaus)
 
 static void menelaus_to_time(char *regs, struct rtc_time *t)
 {
-	t->tm_sec = BCD2BIN(regs[0]);
-	t->tm_min = BCD2BIN(regs[1]);
+	t->tm_sec = bcd2bin(regs[0]);
+	t->tm_min = bcd2bin(regs[1]);
 	if (the_menelaus->rtc_control & RTC_CTRL_MODE12) {
-		t->tm_hour = BCD2BIN(regs[2] & 0x1f) - 1;
+		t->tm_hour = bcd2bin(regs[2] & 0x1f) - 1;
 		if (regs[2] & RTC_HR_PM)
 			t->tm_hour += 12;
 	} else
-		t->tm_hour = BCD2BIN(regs[2] & 0x3f);
-	t->tm_mday = BCD2BIN(regs[3]);
-	t->tm_mon = BCD2BIN(regs[4]) - 1;
-	t->tm_year = BCD2BIN(regs[5]) + 100;
+		t->tm_hour = bcd2bin(regs[2] & 0x3f);
+	t->tm_mday = bcd2bin(regs[3]);
+	t->tm_mon = bcd2bin(regs[4]) - 1;
+	t->tm_year = bcd2bin(regs[5]) + 100;
 }
 
 static int time_to_menelaus(struct rtc_time *t, int regnum)
 {
 	int	hour, status;
 
-	status = menelaus_write_reg(regnum++, BIN2BCD(t->tm_sec));
+	status = menelaus_write_reg(regnum++, bin2bcd(t->tm_sec));
 	if (status < 0)
 		goto fail;
 
-	status = menelaus_write_reg(regnum++, BIN2BCD(t->tm_min));
+	status = menelaus_write_reg(regnum++, bin2bcd(t->tm_min));
 	if (status < 0)
 		goto fail;
 
 	if (the_menelaus->rtc_control & RTC_CTRL_MODE12) {
 		hour = t->tm_hour + 1;
 		if (hour > 12)
-			hour = RTC_HR_PM | BIN2BCD(hour - 12);
+			hour = RTC_HR_PM | bin2bcd(hour - 12);
 		else
-			hour = BIN2BCD(hour);
+			hour = bin2bcd(hour);
 	} else
-		hour = BIN2BCD(t->tm_hour);
+		hour = bin2bcd(t->tm_hour);
 	status = menelaus_write_reg(regnum++, hour);
 	if (status < 0)
 		goto fail;
 
-	status = menelaus_write_reg(regnum++, BIN2BCD(t->tm_mday));
+	status = menelaus_write_reg(regnum++, bin2bcd(t->tm_mday));
 	if (status < 0)
 		goto fail;
 
-	status = menelaus_write_reg(regnum++, BIN2BCD(t->tm_mon + 1));
+	status = menelaus_write_reg(regnum++, bin2bcd(t->tm_mon + 1));
 	if (status < 0)
 		goto fail;
 
-	status = menelaus_write_reg(regnum++, BIN2BCD(t->tm_year - 100));
+	status = menelaus_write_reg(regnum++, bin2bcd(t->tm_year - 100));
 	if (status < 0)
 		goto fail;
 
@@ -915,7 +915,7 @@ static int menelaus_read_time(struct device *dev, struct rtc_time *t)
 	}
 
 	menelaus_to_time(regs, t);
-	t->tm_wday = BCD2BIN(regs[6]);
+	t->tm_wday = bcd2bin(regs[6]);
 
 	return 0;
 }
@@ -928,7 +928,7 @@ static int menelaus_set_time(struct device *dev, struct rtc_time *t)
 	status = time_to_menelaus(t, MENELAUS_RTC_SEC);
 	if (status < 0)
 		return status;
-	status = menelaus_write_reg(MENELAUS_RTC_WKDAY, BIN2BCD(t->tm_wday));
+	status = menelaus_write_reg(MENELAUS_RTC_WKDAY, bin2bcd(t->tm_wday));
 	if (status < 0) {
 		dev_err(&the_menelaus->client->dev, "rtc write reg %02x "
 				"err %d\n", MENELAUS_RTC_WKDAY, status);


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
