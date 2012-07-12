From: "Datta, Shubhrajyoti" <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: OMAP: send i2c message ignoring NAK
Date: Thu, 12 Jul 2012 10:54:59 +0530
Message-ID: <CANQgH-YxYY7M6o4Hxw0kq9=GSwF8TSgiobXLJoPnGhj=c3w4KQ@mail.gmail.com>
References: <CAGm1_ktL96X7kF3tvKErtirwnL7FGU=zGe+EyhX4GcUkZUeSkQ@mail.gmail.com>
	<20120703103221.62fcb7ae@endymion.delvare>
	<CAGm1_kvBerv_Ot-NX2+ozZT3y+h4ECzwb-MM0-v=3M9aRRznzA@mail.gmail.com>
	<CAM=Q2cv2yCEaxjSL45PSpf8k8pgMuhr88TJ-RWc0OW1GL+n6Dg@mail.gmail.com>
	<CAGm1_kvLwj3iFz5M6zc+pitS_45OYPYw=aBU4bv8TdOhH600NA@mail.gmail.com>
	<4FFDAF5A.8070205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FFDAF5A.8070205-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jul 11, 2012 at 10:22 PM, Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org> wrote:
> On Wednesday 11 July 2012 09:53 PM, Yegor Yefremov wrote:
[...]
Yegor I have made a patch to ignore the NACK in the ISR let me know if
that helps you.


diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 9895fa7..e13061f 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -476,6 +476,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,

 	if (msg->len == 0)
 		return -EINVAL;
+	if (msg->flags & I2C_M_IGNORE_NAK)
+		dev->flags |= OMAP_I2C_FLAG_NO_NAK;

 	omap_i2c_write_reg(dev, OMAP_I2C_SA_REG, msg->addr);

@@ -776,18 +778,26 @@ complete:
 				~(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
 				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));

-		if (stat & OMAP_I2C_STAT_NACK)
+		if (stat & OMAP_I2C_STAT_NACK &&
+				!(dev->flags & OMAP_I2C_FLAG_NO_NAK)) {
 			err |= OMAP_I2C_STAT_NACK;
+			omap_i2c_ack_stat(dev, stat &
+				(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
+				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR |
+				OMAP_I2C_STAT_ARDY));
+			omap_i2c_complete_cmd(dev, err);
+			return IRQ_HANDLED;
+		}

 		if (stat & OMAP_I2C_STAT_AL) {
 			dev_err(dev->dev, "Arbitration lost\n");
 			err |= OMAP_I2C_STAT_AL;
 		}
+
 		/*
 		 * ProDB0017052: Clear ARDY bit twice
 		 */
-		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
-					OMAP_I2C_STAT_AL)) {
+		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_AL)) {
 			omap_i2c_ack_stat(dev, stat &
 				(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
 				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR |
diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index 92a0dc7..f386150 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -29,6 +29,7 @@
 #define OMAP_I2C_FLAG_BUS_SHIFT_1		BIT(7)
 #define OMAP_I2C_FLAG_BUS_SHIFT_2		BIT(8)
 #define OMAP_I2C_FLAG_BUS_SHIFT__SHIFT 7
+#define OMAP_I2C_FLAG_NO_NAK			BIT(9)

 struct omap_i2c_bus_platform_data {
 	u32		clkrate;
