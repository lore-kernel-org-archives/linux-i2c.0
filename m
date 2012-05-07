From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V1 2/2] i2c: tegra: notify transfer-complete after clearing status.
Date: Mon,  7 May 2012 12:14:07 +0530
Message-ID: <1336373047-12654-3-git-send-email-ldewangan@nvidia.com>
References: <1336373047-12654-1-git-send-email-ldewangan@nvidia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336373047-12654-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The notification of the transfer complete by calling complete()
should be done after clearing all interrupt status.
This may avoid the race condition of misconfigure the i2c controller
in multi-core environment.

Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-tegra.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 390d379..16820a5 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -399,8 +399,6 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 			disable_irq_nosync(i2c_dev->irq);
 			i2c_dev->irq_disabled = 1;
 		}
-
-		complete(&i2c_dev->msg_complete);
 		goto err;
 	}
 
@@ -409,7 +407,6 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 			i2c_dev->msg_err |= I2C_ERR_NO_ACK;
 		if (status & I2C_INT_ARBITRATION_LOST)
 			i2c_dev->msg_err |= I2C_ERR_ARBITRATION_LOST;
-		complete(&i2c_dev->msg_complete);
 		goto err;
 	}
 
@@ -427,14 +424,14 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 			tegra_i2c_mask_irq(i2c_dev, I2C_INT_TX_FIFO_DATA_REQ);
 	}
 
+	i2c_writel(i2c_dev, status, I2C_INT_STATUS);
+	if (i2c_dev->is_dvc)
+		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
+
 	if (status & I2C_INT_PACKET_XFER_COMPLETE) {
 		BUG_ON(i2c_dev->msg_buf_remaining);
 		complete(&i2c_dev->msg_complete);
 	}
-
-	i2c_writel(i2c_dev, status, I2C_INT_STATUS);
-	if (i2c_dev->is_dvc)
-		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
 	return IRQ_HANDLED;
 err:
 	/* An error occurred, mask all interrupts */
@@ -444,6 +441,8 @@ err:
 	i2c_writel(i2c_dev, status, I2C_INT_STATUS);
 	if (i2c_dev->is_dvc)
 		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
+
+	complete(&i2c_dev->msg_complete);
 	return IRQ_HANDLED;
 }
 
-- 
1.7.1.1
