From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] i2c: i801: Fix Failed to allocate irq -2147483648 error
Date: Wed, 22 Nov 2017 12:28:17 +0100
Message-ID: <20171122112817.9554-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752011AbdKVL2U (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 22 Nov 2017 06:28:20 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org, stable@vger.kernel.org

On Apollo Lake devices the BIOS does not set up IRQ routing for the i801
SMBUS controller IRQ, so we end up with dev->irq set to IRQ_NOTCONNECTED.

Detect this and do not try to use the irq in this case silencing:
i801_smbus 0000:00:1f.1: Failed to allocate irq -2147483648: -107

Cc: stable@vger.kernel.org
BugLink: https://communities.intel.com/thread/114759
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/busses/i2c-i801.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 9e12a53ef7b8..8eac00efadc1 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1617,6 +1617,9 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	/* Default timeout in interrupt mode: 200 ms */
 	priv->adapter.timeout = HZ / 5;
 
+	if (dev->irq == IRQ_NOTCONNECTED)
+		priv->features &= ~FEATURE_IRQ;
+
 	if (priv->features & FEATURE_IRQ) {
 		u16 pcictl, pcists;
 
-- 
2.14.3
