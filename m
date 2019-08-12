From: lingyxu <lingyan.xu@nokia-sbell.com>
Subject: [PATCH] i801_smbus: clear SMBALERT status bit and disable SMBALERT interrupt
Date: Mon, 12 Aug 2019 10:40:34 +0800
Message-ID: <1565577634-18264-1-git-send-email-lingyan.xu@nokia-sbell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Wladislav Wiebe <wladislav.wiebe@nokia.com>, Krzysztof Adamski <krzysztof.adamski@nokia.com>, Lingyan Xu <lingyan.xu@nokia-sbell.com>
List-Id: linux-i2c@vger.kernel.org

From: Lingyan Xu <lingyan.xu@nokia-sbell.com>

In current i801 driver, SMBALERT interrupt is allowed
(Slave Command Register bit2 is 0).
But these is no handler for SMBALERT interrupt in i801_isr,
if there is SMBALERT interrupt asserted and deasserted,
i801 will have an irq flood for the related status bit is setted.

So SMBALERT interrupt handler is needed, and also, SMBALERT interrupt
will be generated from time to time if slave chip have some fault.
So disable SMBALERT interrupt is also needed.

About the solution,
please see http://www.farnell.com/datasheets/1581967.pdf
Page632 P640 for more.

Signed-off-by: Lingyan Xu <lingyan.xu@nokia-sbell.com>
---
 drivers/i2c/busses/i2c-i801.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index f295693..033bafe 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -661,9 +661,11 @@ static irqreturn_t i801_isr(int irq, void *dev_id)
 	 * Clear irq sources and report transaction result.
 	 * ->status must be cleared before the next transaction is started.
 	 */
+
+	outb_p(status, SMBHSTSTS(priv));
+
 	status &= SMBHSTSTS_INTR | STATUS_ERROR_FLAGS;
 	if (status) {
-		outb_p(status, SMBHSTSTS(priv));
 		priv->status = status;
 		wake_up(&priv->waitq);
 	}
@@ -1810,6 +1812,9 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	/* Default timeout in interrupt mode: 200 ms */
 	priv->adapter.timeout = HZ / 5;
 
+	/* Disable SMBALERT interrupt */
+	outb_p(inb_p(SMBSLVCMD(priv)) | BIT(2), SMBSLVCMD(priv));
+
 	if (dev->irq == IRQ_NOTCONNECTED)
 		priv->features &= ~FEATURE_IRQ;
 
-- 
1.7.1
