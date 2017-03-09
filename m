From: Julia Cartwright <julia@ni.com>
Subject: [PATCH 12/19] i2c: mux: pca954x: make use of raw_spinlock variants
Date: Thu, 9 Mar 2017 10:21:59 -0600
Message-ID: <a5015f6a7ecc2f84e9026c309ca2753c0cb3a1fa.1489015238.git.julia@ni.com>
References: <cover.1489015238.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1489015238.git.julia@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The pca954x i2c mux driver currently implements an irq_chip for handling
interrupts; due to how irq_chip handling is done, it's necessary for the
irq_chip methods to be invoked from hardirq context, even on a a
real-time kernel.  Because the spinlock_t type becomes a "sleeping"
spinlock w/ RT kernels, it is not suitable to be used with irq_chips.

A quick audit of the operations under the lock reveal that they do only
minimal, bounded work, and are therefore safe to do under a raw spinlock.

Signed-off-by: Julia Cartwright <julia@ni.com>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index dfc1c0e37c40..15dfc1648716 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -85,7 +85,7 @@ struct pca954x {
 
 	struct irq_domain *irq;
 	unsigned int irq_mask;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 };
 
 /* Provide specs for the PCA954x types we know about */
@@ -264,13 +264,13 @@ static void pca954x_irq_mask(struct irq_data *idata)
 	unsigned int pos = idata->hwirq;
 	unsigned long flags;
 
-	spin_lock_irqsave(&data->lock, flags);
+	raw_spin_lock_irqsave(&data->lock, flags);
 
 	data->irq_mask &= ~BIT(pos);
 	if (!data->irq_mask)
 		disable_irq(data->client->irq);
 
-	spin_unlock_irqrestore(&data->lock, flags);
+	raw_spin_unlock_irqrestore(&data->lock, flags);
 }
 
 static void pca954x_irq_unmask(struct irq_data *idata)
@@ -279,13 +279,13 @@ static void pca954x_irq_unmask(struct irq_data *idata)
 	unsigned int pos = idata->hwirq;
 	unsigned long flags;
 
-	spin_lock_irqsave(&data->lock, flags);
+	raw_spin_lock_irqsave(&data->lock, flags);
 
 	if (!data->irq_mask)
 		enable_irq(data->client->irq);
 	data->irq_mask |= BIT(pos);
 
-	spin_unlock_irqrestore(&data->lock, flags);
+	raw_spin_unlock_irqrestore(&data->lock, flags);
 }
 
 static int pca954x_irq_set_type(struct irq_data *idata, unsigned int type)
@@ -311,7 +311,7 @@ static int pca954x_irq_setup(struct i2c_mux_core *muxc)
 	if (!data->chip->has_irq || client->irq <= 0)
 		return 0;
 
-	spin_lock_init(&data->lock);
+	raw_spin_lock_init(&data->lock);
 
 	data->irq = irq_domain_add_linear(client->dev.of_node,
 					  data->chip->nchans,
-- 
2.11.1
