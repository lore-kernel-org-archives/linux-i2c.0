From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c-eg20t: use i2c_add_numbered_adapter to get a fixed bus number
Date: Thu, 12 Jan 2012 15:38:02 +0800
Message-ID: <1326353882-3158-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

For EG20T and ML7213 IOH, the i2c controller numbers are fixed, using
fixed bus number will make it much easier for platform code to use
i2c_register_board_info() to register i2c devices.

Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-eg20t.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 18936ac..079435b 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -918,7 +918,9 @@ static int __devinit pch_i2c_probe(struct pci_dev *pdev,
 		pch_adap->dev.parent = &pdev->dev;
 
 		pch_i2c_init(&adap_info->pch_data[i]);
-		ret = i2c_add_adapter(pch_adap);
+
+		pch_adap->nr = i;
+		ret = i2c_add_numbered_adapter(pch_adap);
 		if (ret) {
 			pch_pci_err(pdev, "i2c_add_adapter[ch:%d] FAILED\n", i);
 			goto err_add_adapter;
-- 
1.7.1
