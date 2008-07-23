From: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 03/03] i2c-i801: Fix minor style issues
Date: Wed, 23 Jul 2008 18:57:37 +0200
Message-ID: <48876301.9020903@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080603000307030900000401"
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
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Mark M. Hoffman" <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
Cc: Hans de Goede <j.w.r.degoede-fbo2DhPpy/Q@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is a multi-part message in MIME format.
--------------080603000307030900000401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes minor style issues warned about by checkPatch

Signed-off-by: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---

[PATCH 00/03] i2c-i801: Add basic interrupt support



--------------080603000307030900000401
Content-Type: text/plain;
 name="patch3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch3.diff"

--- __new	2008-07-23 10:51:28.000000000 +0200
+++ _new	2008-07-23 10:53:06.000000000 +0200
@@ -381,9 +381,8 @@ static int i801_block_transaction_byte_b
 		do {
 			msleep(1);
 			temp = inb_p(SMBHSTSTS);
-		}
-		while ((!(temp & SMBHSTSTS_BYTE_DONE))
-		       && (timeout++ < MAX_TIMEOUT));
+		} while ((!(temp & SMBHSTSTS_BYTE_DONE))
+			 && (timeout++ < MAX_TIMEOUT));
 
 		/* If the SMBus is still busy, we give up */
 		if (timeout >= MAX_TIMEOUT) {
@@ -502,7 +501,7 @@ static int i801_block_transaction(union 
 }
 
 /* Return -1 on error. */
-static s32 i801_access(struct i2c_adapter * adap, u16 addr,
+static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 		       unsigned short flags, char read_write, u8 command,
 		       int size, union i2c_smbus_data * data)
 {
@@ -574,7 +573,7 @@ static s32 i801_access(struct i2c_adapte
 	else
 		outb_p(inb_p(SMBAUXCTL) & (~SMBAUXCTL_CRC), SMBAUXCTL);
 
-	if(block)
+	if (block)
 		ret = i801_block_transaction(data, read_write, size, hwpec);
 	else
 		ret = i801_transaction(xact | ENABLE_INT9);
@@ -586,9 +585,9 @@ static s32 i801_access(struct i2c_adapte
 		outb_p(inb_p(SMBAUXCTL) & ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B),
 		       SMBAUXCTL);
 
-	if(block)
+	if (block)
 		return ret;
-	if(ret)
+	if (ret)
 		return -1;
 	if ((read_write == I2C_SMBUS_WRITE) || (xact == I801_QUICK))
 		return 0;

--------------080603000307030900000401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--------------080603000307030900000401--
