From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH RESEND 3/3] i2c/ibm-iic: drop NO_IRQ
Date: Fri,  2 Apr 2010 02:17:01 +0200
Message-ID: <1270167421-5205-4-git-send-email-w.sang@pengutronix.de>
References: <1270167421-5205-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1270167421-5205-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sean MacLennan <smaclennan-Qtffpm9i2AVWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Drop NO_IRQ as 0 is the preferred way to describe 'no irq'
(http://lkml.org/lkml/2005/11/21/221). This change is safe, as the driver is
only used on powerpc, where NO_IRQ is 0 anyhow.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Sean MacLennan <smaclennan-Qtffpm9i2AVWk0Htik3J/w@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
---
 drivers/i2c/busses/i2c-ibm_iic.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index b1bc6e2..2bef534 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -668,12 +668,12 @@ static int __devinit iic_request_irq(struct of_device *ofdev,
 	int irq;
 
 	if (iic_force_poll)
-		return NO_IRQ;
+		return 0;
 
 	irq = irq_of_parse_and_map(np, 0);
-	if (irq == NO_IRQ) {
+	if (!irq) {
 		dev_err(&ofdev->dev, "irq_of_parse_and_map failed\n");
-		return NO_IRQ;
+		return 0;
 	}
 
 	/* Disable interrupts until we finish initialization, assumes
@@ -683,7 +683,7 @@ static int __devinit iic_request_irq(struct of_device *ofdev,
 	if (request_irq(irq, iic_handler, 0, "IBM IIC", dev)) {
 		dev_err(&ofdev->dev, "request_irq %d failed\n", irq);
 		/* Fallback to the polling mode */
-		return NO_IRQ;
+		return 0;
 	}
 
 	return irq;
@@ -719,7 +719,7 @@ static int __devinit iic_probe(struct of_device *ofdev,
 	init_waitqueue_head(&dev->wq);
 
 	dev->irq = iic_request_irq(ofdev, dev);
-	if (dev->irq == NO_IRQ)
+	if (!dev->irq)
 		dev_warn(&ofdev->dev, "using polling mode\n");
 
 	/* Board specific settings */
@@ -766,7 +766,7 @@ static int __devinit iic_probe(struct of_device *ofdev,
 	return 0;
 
 error_cleanup:
-	if (dev->irq != NO_IRQ) {
+	if (dev->irq) {
 		iic_interrupt_mode(dev, 0);
 		free_irq(dev->irq, dev);
 	}
@@ -790,7 +790,7 @@ static int __devexit iic_remove(struct of_device *ofdev)
 
 	i2c_del_adapter(&dev->adap);
 
-	if (dev->irq != NO_IRQ) {
+	if (dev->irq) {
 		iic_interrupt_mode(dev, 0);
 		free_irq(dev->irq, dev);
 	}
-- 
1.7.0
