From: Till Harbaum / Lists <lists-RcHadlBFbzVAfugRpC6u6w@public.gmane.org>
Subject: [PATCH] New VID/PID pair for i2c-tiny-usb
Date: Mon, 24 Mar 2008 10:42:30 +0100
Message-ID: <200803241042.31263.lists@harbaum.org>
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
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I have recently bought some USB PIDs from EZPrototypes for my USB projects
and one will be for the i2c-tiny-usb. I have not yet started to use the new 
one in the official i2c-tiny-usb firmware since i think it makes sense to get 
the change into the kernel before releasing a modified firmware.

This patch adds support for the EZPrototypes USB vid/pid pair used in later
i2c-tiny-usb firmware versions (avrusb v1.06 and up, usbtiny v2.06 and up).

Signed-off-by: Till Harbaum <Till-zicpKgigMvpAfugRpC6u6w@public.gmane.org>

--- linux-2.6.24.3.orig/drivers/i2c/busses/i2c-tiny-usb.c	2008-02-26 
01:20:20.000000000 +0100
+++ linux-2.6.24.3/drivers/i2c/busses/i2c-tiny-usb.c	2008-03-24 
10:27:13.000000000 +0100
@@ -131,11 +131,13 @@
 
 /* ----- begin of usb layer ---------------------------------------------- */
 
-/* The usb i2c interface uses a vid/pid pair donated by */
-/* Future Technology Devices International Ltd. */
+/* Initially the usb i2c interface used a vid/pid pair donated by */
+/* Future Technology Devices International Ltd., later a pair was */
+/* bought from EZPrototypes */
 static struct usb_device_id i2c_tiny_usb_table [] = {
-	{ USB_DEVICE(0x0403, 0xc631) },
-	{ }			/* Terminating entry */
+	{ USB_DEVICE(0x0403, 0xc631) },   /* FTDI */
+	{ USB_DEVICE(0x1c40, 0x0534) },   /* EZPrototypes */
+	{ } /* Terminating entry */
 };
 
 MODULE_DEVICE_TABLE(usb, i2c_tiny_usb_table);

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
