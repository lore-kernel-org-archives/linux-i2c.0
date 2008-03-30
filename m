From: Till Harbaum / Lists <lists-RcHadlBFbzVAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH] New VID/PID pair for i2c-tiny-usb
Date: Sun, 30 Mar 2008 19:55:15 +0100
Message-ID: <200803302055.15948.lists@harbaum.org>
References: <200803241042.31263.lists@harbaum.org>
	<200803272047.21505.lists@harbaum.org>
	<20080330143107.1575e1bf@hyperion.delvare>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TI+7HJ7fi8uqZXw"
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080330143107.1575e1bf-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--Boundary-00=_TI+7HJ7fi8uqZXw
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Am Sonntag 30 M=E4rz 2008 schrieb Jean Delvare:
> > Does this make sense?
>
> Yes it does, thanks for clarifying. Please send an updated patch and
> I'll apply it.
Please find a new patch attached.

> Do you plan to phase out the old VID/PID pair? If so, I'll have to send
> you back my i2c-tiny-usb device for a firmware update.
Nothing will change for people using the old vid/pid pair as the driver sti=
ll=20
supports that and i don't think there's a reason to also remove
the old vid/pid pair from the driver. But since you don't have the latest=20
firmware, you might of course return your device anyway to get it updated.=
=20
It'll then be detected correctly if it's plugged in at boot time.

Till

So here we go:

This patch adds support for the EZPrototypes USB vid/pid pair used in later
i2c-tiny-usb firmware versions (avrusb v1.06 and up, usbtiny v2.06 and up).

Signed-off-by: Till Harbaum <Till-zicpKgigMvpAfugRpC6u6w@public.gmane.org>


--Boundary-00=_TI+7HJ7fi8uqZXw
Content-Type: text/x-diff; charset="iso-8859-1";
	name="i2c-tiny-usb-ezprototypes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="i2c-tiny-usb-ezprototypes.patch"

--- linux-2.6.24.3.orig/drivers/i2c/busses/i2c-tiny-usb.c	2008-02-26 01:20:20.000000000 +0100
+++ linux-2.6.24.3/drivers/i2c/busses/i2c-tiny-usb.c	2008-03-30 20:47:46.000000000 +0200
@@ -131,11 +131,15 @@
 
 /* ----- begin of usb layer ---------------------------------------------- */
 
-/* The usb i2c interface uses a vid/pid pair donated by */
-/* Future Technology Devices International Ltd. */
+/* 
+ * Initially the usb i2c interface uses a vid/pid pair donated by
+ * Future Technology Devices International Ltd., later a pair was
+ * bought from EZPrototypes 
+ */
 static struct usb_device_id i2c_tiny_usb_table [] = {
-	{ USB_DEVICE(0x0403, 0xc631) },
-	{ }			/* Terminating entry */
+	{ USB_DEVICE(0x0403, 0xc631) },   /* FTDI */
+	{ USB_DEVICE(0x1c40, 0x0534) },   /* EZPrototypes */
+	{ }                               /* Terminating entry */
 };
 
 MODULE_DEVICE_TABLE(usb, i2c_tiny_usb_table);

--Boundary-00=_TI+7HJ7fi8uqZXw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--Boundary-00=_TI+7HJ7fi8uqZXw--
