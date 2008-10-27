From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: The i2c mailing list is moving
Date: Mon, 27 Oct 2008 18:48:22 +0100
Message-ID: <20081027184822.23a4577a@hyperion.delvare>
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

Replace all references to the old i2c mailing list.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 Documentation/i2c/busses/i2c-sis96x |    2 +-
 MAINTAINERS                         |   20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

--- linux-2.6.28-rc2.orig/Documentation/i2c/busses/i2c-sis96x	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.28-rc2/Documentation/i2c/busses/i2c-sis96x	2008-10-27 18:42:21.000000000 +0100
@@ -42,7 +42,7 @@ I suspect that this driver could be made
 chipsets as well: 635, and 635T. If anyone owns a board with those chips
 AND is willing to risk crashing & burning an otherwise well-behaved kernel
 in the name of progress... please contact me at <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org> or
-via the project's mailing list: <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>.  Please send bug
+via the linux-i2c mailing list: <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>.  Please send bug
 reports and/or success stories as well.
 
 
--- linux-2.6.28-rc2.orig/MAINTAINERS	2008-10-24 09:27:31.000000000 +0200
+++ linux-2.6.28-rc2/MAINTAINERS	2008-10-27 18:41:53.000000000 +0100
@@ -347,7 +347,7 @@ S:	Maintained
 ALI1563 I2C DRIVER
 P:	Rudolf Marek
 M:	r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org
-L:	i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
+L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 S:	Maintained
 
 ALPHA PORT
@@ -1749,7 +1749,7 @@ FREESCALE I2C CPM DRIVER
 P:	Jochen Friedrich
 M:	jochen-NIgtFMG+Po8@public.gmane.org
 L:	linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
-L:	i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
+L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 S:	Maintained
 
 FREESCALE SOC FS_ENET DRIVER
@@ -2022,7 +2022,7 @@ S:	Maintained
 I2C/SMBUS STUB DRIVER
 P:	Mark M. Hoffman
 M:	mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org
-L:	i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
+L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 S:	Maintained
 
 I2C SUBSYSTEM
@@ -2030,14 +2030,14 @@ P:	Jean Delvare (PC drivers, core)
 M:	khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
 P:	Ben Dooks (embedded platforms)
 M:	ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
-L:	i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
+L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 T:	quilt http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/
 S:	Maintained
 
 I2C-TINY-USB DRIVER
 P:	Till Harbaum
 M:	till-RcHadlBFbzVAfugRpC6u6w@public.gmane.org
-L:	i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
+L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 T:	http://www.harbaum.org/till/i2c_tiny_usb
 S:	Maintained
 
@@ -3143,7 +3143,7 @@ S:	Maintained
 OPENCORES I2C BUS DRIVER
 P:	Peter Korsgaard
 M:	jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org
-L:	i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
+L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 S:	Maintained
 
 OPROFILE
@@ -3190,7 +3190,7 @@ S:	Maintained
 PA SEMI SMBUS DRIVER
 P:	Olof Johansson
 M:	olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org
-L:	i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
+L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 S:	Maintained
 
 PANASONIC LAPTOP ACPI EXTRAS DRIVER
@@ -3335,7 +3335,7 @@ S:	Maintained
 PNXxxxx I2C DRIVER
 P:	Vitaly Wool
 M:	vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
-L:	i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
+L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 S:	Maintained
 
 PPP PROTOCOL DRIVERS AND COMPRESSORS
@@ -3799,7 +3799,7 @@ S:	Maintained
 SIS 96X I2C/SMBUS DRIVER
 P:	Mark M. Hoffman
 M:	mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org
-L:	i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
+L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 S:	Maintained
 
 SIS FRAMEBUFFER DRIVER
@@ -4546,7 +4546,7 @@ S:	Maintained
 VIAPRO SMBUS DRIVER
 P:	Jean Delvare
 M:	khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
-L:	i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
+L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 S:	Maintained
 
 VIA UNICHROME(PRO)/CHROME9 FRAMEBUFFER DRIVER


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
