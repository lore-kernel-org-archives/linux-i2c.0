From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] ARM: OMAP: Release i2c_adapter after use (Siemens SX1)
Date: Sun, 24 Feb 2008 09:37:25 +0100
Message-ID: <20080224093725.0e059dc0@hyperion.delvare>
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
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Vladimir Ananiev <vovan888-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Each call to i2c_get_adapter() must be followed by a call to
i2c_put_adapter() to release the grabbed reference. Otherwise the
reference count grows forever and the adapter can never be
unregistered.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Acked-by: Vladimir Ananiev <vovan888-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/mach-omap1/board-sx1.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.24-rc4.orig/arch/arm/mach-omap1/board-sx1.c	2007-10-24 09:59:18.000000000 +0200
+++ linux-2.6.24-rc4/arch/arm/mach-omap1/board-sx1.c	2007-12-07 11:56:22.000000000 +0100
@@ -61,6 +61,7 @@ int i2c_write_byte(u8 devaddr, u8 regoff
 	data[0] = regoffset;	/* register num */
 	data[1] = value;		/* register data */
 	err = i2c_transfer(adap, msg, 1);
+	i2c_put_adapter(adap);
 	if (err >= 0)
 		return 0;
 	return err;
@@ -91,6 +92,7 @@ int i2c_read_byte(u8 devaddr, u8 regoffs
 	msg->buf = data;
 	err = i2c_transfer(adap, msg, 1);
 	*value = data[0];
+	i2c_put_adapter(adap);
 
 	if (err >= 0)
 		return 0;


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
