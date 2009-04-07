From: Enrik Berkhan <Enrik.Berkhan-JJi787mZWgc@public.gmane.org>
Subject: [PATCH] Let PCA9564 recover from unacked data byte (state 0x30)
Date: Tue, 7 Apr 2009 12:38:56 +0200
Message-ID: <20090407103847.GA13586@ngeserver2.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
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

Signed-off-by: Enrik Berkhan <Enrik.Berkhan-JJi787mZWgc@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-pca.c |    2 ++
 1 file changed, 2 insertions(+)

Index: drivers/i2c/algos/i2c-algo-pca.c
===================================================================
--- drivers/i2c/algos/i2c-algo-pca.c.orig	2009-04-07 11:23:08.000000000 +0200
+++ drivers/i2c/algos/i2c-algo-pca.c	2009-04-07 11:24:56.000000000 +0200
@@ -270,10 +270,12 @@ static int pca_xfer(struct i2c_adapter *
 
 		case 0x30: /* Data byte in I2CDAT has been transmitted; NOT ACK has been received */
 			DEB2("NOT ACK received after data byte\n");
+			pca_stop(adap);
 			goto out;
 
 		case 0x38: /* Arbitration lost during SLA+W, SLA+R or data bytes */
 			DEB2("Arbitration lost\n");
+			// XXX pca_start()? pca_reset()?
 			goto out;
 
 		case 0x58: /* Data byte has been received; NOT ACK has been returned */
