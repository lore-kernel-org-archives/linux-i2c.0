From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5 1/6] i2c: designware: Rename accessor_flags to flags
Date: Sun,  1 Jan 2017 21:15:16 +0100
Message-ID: <20170101201521.12364-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932229AbdAAUPZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 1 Jan 2017 15:15:25 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, Hans de Goede <hdegoede@redhat.com>

Rename accessor_flags to flags, so that we can use the field for
other flags too. This is a preparation patch for adding cherrytrail
support to the punit semaphore code.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/i2c/busses/i2c-designware-core.c    | 14 +++++++-------
 drivers/i2c/busses/i2c-designware-core.h    |  2 +-
 drivers/i2c/busses/i2c-designware-platdrv.c |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index b403fa5..b6a7989 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -177,13 +177,13 @@ static u32 dw_readl(struct dw_i2c_dev *dev, int offset)
 {
 	u32 value;
 
-	if (dev->accessor_flags & ACCESS_16BIT)
+	if (dev->flags & ACCESS_16BIT)
 		value = readw_relaxed(dev->base + offset) |
 			(readw_relaxed(dev->base + offset + 2) << 16);
 	else
 		value = readl_relaxed(dev->base + offset);
 
-	if (dev->accessor_flags & ACCESS_SWAP)
+	if (dev->flags & ACCESS_SWAP)
 		return swab32(value);
 	else
 		return value;
@@ -191,10 +191,10 @@ static u32 dw_readl(struct dw_i2c_dev *dev, int offset)
 
 static void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset)
 {
-	if (dev->accessor_flags & ACCESS_SWAP)
+	if (dev->flags & ACCESS_SWAP)
 		b = swab32(b);
 
-	if (dev->accessor_flags & ACCESS_16BIT) {
+	if (dev->flags & ACCESS_16BIT) {
 		writew_relaxed((u16)b, dev->base + offset);
 		writew_relaxed((u16)(b >> 16), dev->base + offset + 2);
 	} else {
@@ -339,10 +339,10 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	reg = dw_readl(dev, DW_IC_COMP_TYPE);
 	if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
 		/* Configure register endianess access */
-		dev->accessor_flags |= ACCESS_SWAP;
+		dev->flags |= ACCESS_SWAP;
 	} else if (reg == (DW_IC_COMP_TYPE_VALUE & 0x0000ffff)) {
 		/* Configure register access mode 16bit */
-		dev->accessor_flags |= ACCESS_16BIT;
+		dev->flags |= ACCESS_16BIT;
 	} else if (reg != DW_IC_COMP_TYPE_VALUE) {
 		dev_err(dev->dev, "Unknown Synopsys component type: "
 			"0x%08x\n", reg);
@@ -886,7 +886,7 @@ static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 tx_aborted:
 	if ((stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET)) || dev->msg_err)
 		complete(&dev->cmd_complete);
-	else if (unlikely(dev->accessor_flags & ACCESS_INTR_MASK)) {
+	else if (unlikely(dev->flags & ACCESS_INTR_MASK)) {
 		/* workaround to trigger pending interrupt */
 		stat = dw_readl(dev, DW_IC_INTR_MASK);
 		i2c_dw_disable_int(dev);
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 0d44d2a..fb143f5 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -95,7 +95,7 @@ struct dw_i2c_dev {
 	unsigned int		status;
 	u32			abort_source;
 	int			irq;
-	u32			accessor_flags;
+	u32			flags;
 	struct i2c_adapter	adapter;
 	u32			functionality;
 	u32			master_cfg;
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 0b42a12..97a2ca1 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -112,7 +112,7 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 
 	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
 	if (id && id->driver_data)
-		dev->accessor_flags |= (u32)id->driver_data;
+		dev->flags |= (u32)id->driver_data;
 
 	return 0;
 }
-- 
2.9.3
