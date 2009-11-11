From: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH 4/4] i2c : Map I2C adapter number to platform ID number
Date: Thu, 12 Nov 2009 00:34:17 +0100
Message-ID: <083DF309106F364B939360100EC290F804F53CC644@eu1rdcrdc1wx030.exi.nxp.com>
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

Map I2C adapter number to platform ID number

Signed-off-by: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
---
i2c-pnx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- drivers/i2c/busses/i2c-pnx.c.orig	2009-11-11 14:54:30.000000000 -0800
+++ drivers/i2c/busses/i2c-pnx.c	2009-11-11 15:02:30.000000000 -0800
@@ -633,7 +633,8 @@ static int __devinit i2c_pnx_probe(struc
 
 	/* Register this adapter with the I2C subsystem */
 	i2c_pnx->adapter->dev.parent = &pdev->dev;
-	ret = i2c_add_adapter(i2c_pnx->adapter);
+	i2c_pnx->adapter->nr = pdev->id;
+	ret = i2c_add_numbered_adapter(i2c_pnx->adapter);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "I2C: Failed to add bus\n");
 		goto out_irq;
