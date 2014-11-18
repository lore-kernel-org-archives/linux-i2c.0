From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH v2 4/4] mfd: dln2: a couple endian fixes
Date: Tue, 18 Nov 2014 14:58:00 +0200
Message-ID: <1416315480-2053-5-git-send-email-octavian.purdila@intel.com>
References: <1416315480-2053-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416315480-2053-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: wsa@the-dreams.de, julia.lawall@lip6.fr, dan.carpenter@oracle.com, johan@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

Sparse catches a couple endian bugs.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Octavian Purdila <octavian.purdila@intel.com>
---
 drivers/mfd/dln2.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index df2fda9..559e6cc 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -436,6 +436,7 @@ static int _dln2_transfer(struct dln2_dev *dln2, u16 handle, u16 cmd,
 	struct device *dev = &dln2->interface->dev;
 	const unsigned long timeout = DLN2_USB_TIMEOUT * HZ / 1000;
 	struct dln2_mod_rx_slots *rxs = &dln2->mod_rx_slots[handle];
+	int size;
 
 	spin_lock(&dln2->disconnect_lock);
 	if (!dln2->disconnect)
@@ -477,8 +478,9 @@ static int _dln2_transfer(struct dln2_dev *dln2, u16 handle, u16 cmd,
 
 	/* if we got here we know that the response header has been checked */
 	rsp = rxc->urb->transfer_buffer;
+	size = le16_to_cpu(rsp->hdr.size);
 
-	if (rsp->hdr.size < sizeof(*rsp)) {
+	if (size < sizeof(*rsp)) {
 		ret = -EPROTO;
 		goto out_free_rx_slot;
 	}
@@ -493,8 +495,8 @@ static int _dln2_transfer(struct dln2_dev *dln2, u16 handle, u16 cmd,
 	if (!ibuf)
 		goto out_free_rx_slot;
 
-	if (*ibuf_len > rsp->hdr.size - sizeof(*rsp))
-		*ibuf_len = rsp->hdr.size - sizeof(*rsp);
+	if (*ibuf_len > size - sizeof(*rsp))
+		*ibuf_len = size - sizeof(*rsp);
 
 	memcpy(ibuf, rsp + 1, *ibuf_len);
 
-- 
1.9.1
