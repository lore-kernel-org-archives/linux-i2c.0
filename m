From: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: strncpy does not null terminate string
Date: Fri, 17 Jul 2009 15:03:24 +0200
Message-ID: <4A60769C.9010707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

With `sizeof(string) - 1` strncpy() will null terminate the string.

Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
To test this:

#include <stdio.h>
#include <string.h>

char a[10];
char b[10];

int main()
{
        const char* str = "0123456789012";
        strncpy(a, str, sizeof(a));
        strncpy(b, str, sizeof(b) - 1);
        printf("String a was %s, b was %s\n", a, b);

        return 0;
}

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index fdd8327..bede75d 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -879,7 +879,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
 	adap->class = I2C_CLASS_HWMON;
-	strncpy(adap->name, "OMAP I2C adapter", sizeof(adap->name));
+	strncpy(adap->name, "OMAP I2C adapter", sizeof(adap->name) - 1);
 	adap->algo = &omap_i2c_algo;
 	adap->dev.parent = &pdev->dev;
 
