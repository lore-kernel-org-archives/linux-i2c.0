From: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: strncpy does not null terminate string
Date: Fri, 17 Jul 2009 15:24:00 +0200
Message-ID: <4A607B70.8080901@gmail.com>
References: <4A60769C.9010707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A60769C.9010707-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

strlcpy() will always null terminate the string.

Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index fdd8327..f2b82ee 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -879,7 +879,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
 	adap->class = I2C_CLASS_HWMON;
-	strncpy(adap->name, "OMAP I2C adapter", sizeof(adap->name));
+	strlcpy(adap->name, "OMAP I2C adapter", sizeof(adap->name));
 	adap->algo = &omap_i2c_algo;
 	adap->dev.parent = &pdev->dev;
 
