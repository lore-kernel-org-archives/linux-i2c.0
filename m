From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: [PATCH] i2c_intel_mid: Fix slash in sysfs name
Date: Tue, 14 Dec 2010 15:29:08 +0000
Message-ID: <20101214152849.7265.93628.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

This gets caught by the new sanity check code. Instead of the slash use a
different symbol. This was originally found by Major Lee who proposed a
rather more complex patch which changed the name according to the chip
type.

On the basis that we are in a late -rc and making Linus grumpy isn't always
a good idea (however fun) this is a simple alternative.

Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---

 drivers/i2c/busses/i2c-intel-mid.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/i2c/busses/i2c-intel-mid.c b/drivers/i2c/busses/i2c-intel-mid.c
index 657f314..da4bbdd 100644
--- a/drivers/i2c/busses/i2c-intel-mid.c
+++ b/drivers/i2c/busses/i2c-intel-mid.c
@@ -1035,7 +1035,7 @@ static int __devinit intel_mid_i2c_probe(struct pci_dev *dev,
 
 	/* Initialize struct members */
 	snprintf(mrst->adap.name, sizeof(mrst->adap.name),
-		"MRST/Medfield I2C at %lx", start);
+		"Intel MID I2C at %lx", start);
 	mrst->adap.owner = THIS_MODULE;
 	mrst->adap.algo = &intel_mid_i2c_algorithm;
 	mrst->adap.dev.parent = &dev->dev;
