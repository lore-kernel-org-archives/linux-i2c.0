From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 1/8] I2C: S3C2410: Check ACK on byte transmission
Date: Thu, 29 May 2008 14:22:45 +0100
Message-ID: <20080529132405.971048345@fluff.org.uk>
References: <20080529132244.818543231@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/simtec-drivers-i2c-s3c2410-fixack.patch
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
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

We should check for the reception of an ACK after transmissint each
data byte. The address send has been correctly checking this, but the
data write byte state should have also been checking for these failures.

As part of the same fix, we remove the ACK checking from the receive
path where it should not have been checking for an ACK which our hardware
was sending.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.26-rc4-quilt1/drivers/i2c/busses/i2c-s3c2410.c
===================================================================
--- linux-2.6.26-rc4-quilt1.orig/drivers/i2c/busses/i2c-s3c2410.c	2008-05-28 11:49:18.000000000 +0100
+++ linux-2.6.26-rc4-quilt1/drivers/i2c/busses/i2c-s3c2410.c	2008-05-28 11:56:14.000000000 +0100
@@ -324,6 +324,15 @@ static int i2s_s3c_irq_nextbyte(struct s
 		 */
 
 	retry_write:
+		if (!(i2c->msg->flags & I2C_M_IGNORE_NAK)) {
+			if (iicstat & S3C2410_IICSTAT_LASTBIT) {
+				dev_dbg(i2c->dev, "WRITE: No Ack\n");
+
+				s3c24xx_i2c_stop(i2c, -ECONNREFUSED);
+				goto out_ack;
+			}
+		}
+
 		if (!is_msgend(i2c)) {
 			byte = i2c->msg->buf[i2c->msg_ptr++];
 			writeb(byte, i2c->regs + S3C2410_IICDS);
@@ -377,17 +386,6 @@ static int i2s_s3c_irq_nextbyte(struct s
 		 * going to do any more read/write
 		 */
 
-		if (!(i2c->msg->flags & I2C_M_IGNORE_NAK) &&
-		    !(is_msglast(i2c) && is_lastmsg(i2c))) {
-
-			if (iicstat & S3C2410_IICSTAT_LASTBIT) {
-				dev_dbg(i2c->dev, "READ: No Ack\n");
-
-				s3c24xx_i2c_stop(i2c, -ECONNREFUSED);
-				goto out_ack;
-			}
-		}
-
 		byte = readb(i2c->regs + S3C2410_IICDS);
 		i2c->msg->buf[i2c->msg_ptr++] = byte;
 

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
