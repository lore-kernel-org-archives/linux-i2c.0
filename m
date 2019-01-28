From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 39/80] i2c-axxia: check for error conditions first
Date: Mon, 28 Jan 2019 11:23:20 -0500
Message-ID: <20190128162401.58841-39-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: "Adamski, Krzysztof (Nokia - PL/Wroclaw)" <krzysztof.adamski@nokia.com>, Wolfram Sang <wsa@the-dreams.de>, Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: "Adamski, Krzysztof (Nokia - PL/Wroclaw)" <krzysztof.adamski@nokia.com>

[ Upstream commit 4f5c85fe3a60ace555d09898166af372547f97fc ]

It was observed that when using seqentional mode contrary to the
documentation, the SS bit (which is supposed to only be set if
automatic/sequence command completed normally), is sometimes set
together with NA (NAK in address phase) causing transfer to falsely be
considered successful.

My assumption is that this does not happen during manual mode since the
controller is stopping its work the moment it sets NA/ND bit in status
register. This is not the case in Automatic/Sequentional mode where it
is still working to send STOP condition and the actual status we get
depends on the time when the ISR is run.

This patch changes the order of checking status bits in ISR - error
conditions are checked first and only if none of them occurred, the
transfer may be considered successful. This is required to introduce
using of sequentional mode in next patch.

Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-axxia.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
index 9c9fd2e87a4b..1c68b05c8649 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -296,22 +296,7 @@ static irqreturn_t axxia_i2c_isr(int irq, void *_dev)
 			i2c_int_disable(idev, MST_STATUS_TFL);
 	}
 
-	if (status & MST_STATUS_SCC) {
-		/* Stop completed */
-		i2c_int_disable(idev, ~MST_STATUS_TSS);
-		complete(&idev->msg_complete);
-	} else if (status & MST_STATUS_SNS) {
-		/* Transfer done */
-		i2c_int_disable(idev, ~MST_STATUS_TSS);
-		if (i2c_m_rd(idev->msg) && idev->msg_xfrd < idev->msg->len)
-			axxia_i2c_empty_rx_fifo(idev);
-		complete(&idev->msg_complete);
-	} else if (status & MST_STATUS_TSS) {
-		/* Transfer timeout */
-		idev->msg_err = -ETIMEDOUT;
-		i2c_int_disable(idev, ~MST_STATUS_TSS);
-		complete(&idev->msg_complete);
-	} else if (unlikely(status & MST_STATUS_ERR)) {
+	if (unlikely(status & MST_STATUS_ERR)) {
 		/* Transfer error */
 		i2c_int_disable(idev, ~0);
 		if (status & MST_STATUS_AL)
@@ -328,6 +313,21 @@ static irqreturn_t axxia_i2c_isr(int irq, void *_dev)
 			readl(idev->base + MST_TX_BYTES_XFRD),
 			readl(idev->base + MST_TX_XFER));
 		complete(&idev->msg_complete);
+	} else if (status & MST_STATUS_SCC) {
+		/* Stop completed */
+		i2c_int_disable(idev, ~MST_STATUS_TSS);
+		complete(&idev->msg_complete);
+	} else if (status & MST_STATUS_SNS) {
+		/* Transfer done */
+		i2c_int_disable(idev, ~MST_STATUS_TSS);
+		if (i2c_m_rd(idev->msg) && idev->msg_xfrd < idev->msg->len)
+			axxia_i2c_empty_rx_fifo(idev);
+		complete(&idev->msg_complete);
+	} else if (status & MST_STATUS_TSS) {
+		/* Transfer timeout */
+		idev->msg_err = -ETIMEDOUT;
+		i2c_int_disable(idev, ~MST_STATUS_TSS);
+		complete(&idev->msg_complete);
 	}
 
 out:
-- 
2.19.1
