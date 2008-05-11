From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH] I2C: SiByte: Correct a comment about frequency
Date: Sun, 11 May 2008 03:10:29 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0805110302400.18978@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756573AbYEKCMW@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

 The frequency may have been once hardcoded to 100kHz, but currently it is
passed as an argument to i2c_sibyte_add_bus(), so update the comment to
match code.  While at it, reformat a nearby comment for consistency.  No
functional changes.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 It should be obvious.  Please apply.

  Maciej

patch-2.6.26-rc1-20080505-sibyte-i2c-add-bus-16
diff -up --recursive --new-file linux-2.6.26-rc1-20080505.macro/drivers/i2c/busses/i2c-sibyte.c linux-2.6.26-rc1-20080505/drivers/i2c/busses/i2c-sibyte.c
--- linux-2.6.26-rc1-20080505.macro/drivers/i2c/busses/i2c-sibyte.c	2008-05-05 02:55:25.000000000 +0000
+++ linux-2.6.26-rc1-20080505/drivers/i2c/busses/i2c-sibyte.c	2008-05-11 01:14:30.000000000 +0000
@@ -136,10 +136,10 @@ int __init i2c_sibyte_add_bus(struct i2c
 {
 	struct i2c_algo_sibyte_data *adap = i2c_adap->algo_data;
 
-	/* register new adapter to i2c module... */
+	/* Register new adapter to i2c module... */
 	i2c_adap->algo = &i2c_sibyte_algo;
 
-	/* Set the frequency to 100 kHz */
+	/* Set the requested frequency. */
 	csr_out32(speed, SMB_CSR(adap,R_SMB_FREQ));
 	csr_out32(0, SMB_CSR(adap,R_SMB_CONTROL));
 
