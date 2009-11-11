From: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH 2/4] i2c : Added missing mach/i2c.h and linux/io.h header
 file includes
Date: Thu, 12 Nov 2009 00:25:52 +0100
Message-ID: <083DF309106F364B939360100EC290F804F53CC642@eu1rdcrdc1wx030.exi.nxp.com>
References: <083DF309106F364B939360100EC290F804F5343706@eu1rdcrdc1wx030.exi.nxp.com>
 <20091111212152.GK13398@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091111212152.GK13398-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: "vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Added missing mach/i2c.h and linux/io.h header file includes

Signed-off-by: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
---
i2c-pnx.c |    2 ++
 1 file changed, 2 insertions(+)

--- drivers/i2c/busses/i2c-pnx.c.orig	2009-11-11 14:54:30.000000000 -0800
+++ drivers/i2c/busses/i2c-pnx.c	2009-11-11 14:55:14.000000000 -0800
@@ -19,7 +19,9 @@
 #include <linux/completion.h>
 #include <linux/platform_device.h>
 #include <linux/i2c-pnx.h>
+#include <linux/io.h>
 #include <mach/hardware.h>
+#include <mach/i2c.h>
 #include <asm/irq.h>
 #include <asm/uaccess.h>
