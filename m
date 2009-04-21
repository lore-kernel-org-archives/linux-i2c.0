From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: [PATCH] drivers: move media after i2c
Date: Tue, 21 Apr 2009 09:22:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0904210908360.6551@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux Media Mailing List <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Currently drivers/media drivers are linked very early - directly after 
base, block, misc, and mfd and before ata, scsi, ide, input, firewire, 
usb, and i2c. This breaks static build of video4linux drivers, that use 
generic CPU i2c adapter drivers and the v4l2-subdev subsystem, because 
during video4linux probing the v4l2-subdev core requires a struct 
i2c_adapter context, which cannot be satisfied before the i2c subsystem is 
initialised. Moving drivers/media after drivers/i2c fixes this problem.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
---

The best way to trigger action is by submitting a patch:-) So, let's see 
what comes out of it - on the one hand I don't see any reason why media 
has to be linked this early, and nobody was able to give me one yesterday 
as this problem has been discussed on linux-media, OTOH, maybe indeed it 
would be better to move i2c the whole way up above media, but that'd be 
much bigger of a change, I think.

diff --git a/drivers/Makefile b/drivers/Makefile
index 2618a61..1266ead 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -36,7 +36,7 @@ obj-$(CONFIG_FB_INTEL)          += video/intelfb/
 
 obj-y				+= serial/
 obj-$(CONFIG_PARPORT)		+= parport/
-obj-y				+= base/ block/ misc/ mfd/ media/
+obj-y				+= base/ block/ misc/ mfd/
 obj-$(CONFIG_NUBUS)		+= nubus/
 obj-y				+= macintosh/
 obj-$(CONFIG_IDE)		+= ide/
@@ -71,7 +71,7 @@ obj-$(CONFIG_GAMEPORT)		+= input/gameport/
 obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_I2O)		+= message/
 obj-$(CONFIG_RTC_LIB)		+= rtc/
-obj-y				+= i2c/
+obj-y				+= i2c/ media/
 obj-$(CONFIG_W1)		+= w1/
 obj-$(CONFIG_POWER_SUPPLY)	+= power/
 obj-$(CONFIG_HWMON)		+= hwmon/
