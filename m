From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v2] i2c: Quilt tree has moved
Date: Mon, 26 Jan 2009 11:51:32 +0100
Message-ID: <20090126115132.019d4457@hyperion.delvare>
References: <20090114162849.66bc21d2@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090114162849.66bc21d2-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

My i2c quilt tree will now be hosted on kernel.org, because I can
conveniently use rsync there.

Also list the new i2c wiki.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 MAINTAINERS |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.29-rc2.orig/MAINTAINERS	2009-01-26 10:41:07.000000000 +0100
+++ linux-2.6.29-rc2/MAINTAINERS	2009-01-26 11:48:03.000000000 +0100
@@ -2102,7 +2102,8 @@ M:	khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
 P:	Ben Dooks (embedded platforms)
 M:	ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
 L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
-T:	quilt http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/
+W:	http://i2c.wiki.kernel.org/
+T:	quilt kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/
 S:	Maintained
 
 I2C-TINY-USB DRIVER

-- 
Jean Delvare
