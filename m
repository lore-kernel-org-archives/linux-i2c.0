From: Enrik Berkhan <Enrik.Berkhan-JJi787mZWgc@public.gmane.org>
Subject: [PATCH, v2] Let PCA9564 recover from unacked data byte (state 0x30)
Date: Thu, 9 Apr 2009 11:38:55 +0200
Message-ID: <20090409093855.GB539@ngeserver2.localdomain>
References: <20090407103847.GA13586@ngeserver2.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090407103847.GA13586-wEgbaqU1+uOv+36yZLenwA0JkcsJGQge@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ian Campbell <icampbell-2sJRl1BP9u0AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Currently, the i2c-algo-pca driver does nothing if the chip enters state
0x30 (Data byte in I2CDAT has been transmitted; NOT ACK has been
received).  Thus, the i2c bus connected to the controller gets stuck
afterwards.

I have seen this kind of error on a custom board in certain load
situations most probably caused by interference or noise.

A possible reaction is to let the controller generate a STOP condition.
This is documented in the controller data sheet and the same is done for
other NACK states as well.

Further, state 0x38 isn't handled completely, either. Try to do another
START in this case like the manual says. As this couldn't be tested,
I've added a comment to try to reset the chip if the START doesn't help
as suggested by Wolfram Sang.

Signed-off-by: Enrik Berkhan <Enrik.Berkhan-JJi787mZWgc@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-pca.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: drivers/i2c/algos/i2c-algo-pca.c
===================================================================
--- drivers/i2c/algos/i2c-algo-pca.c.orig	2009-04-07 11:23:08.000000000 +0200
+++ drivers/i2c/algos/i2c-algo-pca.c	2009-04-09 11:10:11.000000000 +0200
@@ -270,10 +270,17 @@ static int pca_xfer(struct i2c_adapter *
 
 		case 0x30: /* Data byte in I2CDAT has been transmitted; NOT ACK has been received */
 			DEB2("NOT ACK received after data byte\n");
+			pca_stop(adap);
 			goto out;
 
 		case 0x38: /* Arbitration lost during SLA+W, SLA+R or data bytes */
 			DEB2("Arbitration lost\n");
+			/*
+			 * The manual says to send another start
+			 * condition in this case. If this won't be
+			 * sufficient, try pca_reset() instead.
+			 */
+			pca_start(adap);
 			goto out;
 
 		case 0x58: /* Data byte has been received; NOT ACK has been returned */
