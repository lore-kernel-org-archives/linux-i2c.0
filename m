From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Let checkpatch shout on users of the legacy model
Date: Thu, 12 Mar 2009 16:15:51 +0100
Message-ID: <20090312161551.51ee067f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

As suggested by Mauro Carvalho Chehab.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
---
 Documentation/feature-removal-schedule.txt |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.29-rc7.orig/Documentation/feature-removal-schedule.txt	2009-03-12 08:48:06.000000000 +0100
+++ linux-2.6.29-rc7/Documentation/feature-removal-schedule.txt	2009-03-12 16:07:35.000000000 +0100
@@ -311,7 +311,8 @@ Who:  Krzysztof Piotr Oledzki <ole@ans.p
 ---------------------------
 
 What:	i2c_attach_client(), i2c_detach_client(), i2c_driver->detach_client()
-When:	2.6.29 (ideally) or 2.6.30 (more likely)
+When:	2.6.30
+Check:	i2c_attach_client i2c_detach_client
 Why:	Deprecated by the new (standard) device driver binding model. Use
 	i2c_driver->probe() and ->remove() instead.
 Who:	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>


-- 
Jean Delvare
