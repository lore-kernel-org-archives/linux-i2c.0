From: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Subject: [PATCH, fix 2/2] Add include to i2c-xii.c to fix build error
Date: Sun, 14 Mar 2010 23:07:47 +1100
Message-ID: <20100314230747.1a118846.sfr@canb.auug.org.au>
References: <4B94C951.6050703@pelagicore.com>
	<20100308150121.GW10014@trinity.fluff.org>
	<4B956F9E.8020304@oracle.com>
	<4B960420.8040804@pelagicore.com>
	<20100314230525.352410e5.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100314230525.352410e5.sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: =?UTF-8?B?IlJpY2hhcmQgUsO2amZvcnMi?= <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>, Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, xtfeng-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=46rom: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Date: Thu, 04 Feb 2010 12:11:09 -0800

drivers/i2c/busses/i2c-xiic.c:493: error: implicit declaration of funct=
ion 'mdelay'

Signed-off-by: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: "Richard R=C3=B6jfors" <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Cc: "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
---
 drivers/i2c/busses/i2c-xiic.c |    1 +
 1 file changed, 1 insertion(+)

Hi Linus,

This patch has been in linux-next for a while as well.  Please apply.

--- linux-next-20100204.orig/drivers/i2c/busses/i2c-xiic.c
+++ linux-next-20100204/drivers/i2c/busses/i2c-xiic.c
@@ -31,6 +31,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/errno.h>
+#include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>

--=20
Cheers,
Stephen Rothwell                    sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org
http://www.canb.auug.org.au/~sfr/
