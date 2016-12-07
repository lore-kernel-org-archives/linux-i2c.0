From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH v4 5/5] i2c: designware: Cleaning comments and formatation
Date: Wed,  7 Dec 2016 17:55:52 +0000
Message-ID: <02856fdb6ce3230a4ac1ba0958938ad51e763205.1481131072.git.lolivei@synopsys.com>
References: <cover.1481131072.git.lolivei@synopsys.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:43561 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753271AbcLGR6T (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 7 Dec 2016 12:58:19 -0500
In-Reply-To: <cover.1481131072.git.lolivei@synopsys.com>
In-Reply-To: <cover.1481131072.git.lolivei@synopsys.com>
References: <cover.1481131072.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Luis.Oliveira@synopsys.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

- Missspelling, comment formatation and fix a string of
  the existing code

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
---
Changes V3->V4: (Andy Shevchenko)
- created a commit message

 drivers/i2c/busses/i2c-designware-common.c |  2 +-
 drivers/i2c/busses/i2c-designware-slave.c  | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 41b38d8b8732..838ef662d2c8 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -42,7 +42,7 @@ static char *abort_sources[] = {
 	[ABRT_TXDATA_NOACK] =
 		"data not acknowledged",
 	[ABRT_GCALL_NOACK] =
-		"no acknowledgement for a general call",
+		"no acknowledgment for a general call",
 	[ABRT_GCALL_READ] =
 		"read after general call",
 	[ABRT_SBYTE_ACKDET] =
diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index 1c7f82bb2513..442bc5ce6d47 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -70,8 +70,8 @@ int i2c_dw_init_slave(struct dw_i2c_dev *dev)
 		/* Configure register access mode 16bit */
 		dev->accessor_flags |= ACCESS_16BIT;
 	} else if (reg != DW_IC_COMP_TYPE_VALUE) {
-		dev_err(dev->dev, "Unknown Synopsys component type: "
-			"0x%08x\n", reg);
+		dev_err(dev->dev,
+		 "Unknown Synopsys component type: 0x%08x\n", reg);
 		i2c_dw_release_lock(dev);
 		return -ENODEV;
 	}
@@ -181,8 +181,10 @@ int i2c_dw_reg_slave(struct i2c_client *slave)
 		return -EBUSY;
 	if (slave->flags & I2C_CLIENT_TEN)
 		return -EAFNOSUPPORT;
-		/* set slave address in the IC_SAR register,
-		* the address to which the DW_apb_i2c responds */
+		/*
+		 * set slave address in the IC_SAR register,
+		 * the address to which the DW_apb_i2c responds
+		 */
 
 	__i2c_dw_enable(dev, false);
 	dw_writel(dev, slave->addr, DW_IC_SAR);
-- 
2.11.0
