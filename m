From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH 2/2] i2c-eg20t: use i2c_add_numbered_adapter to get a fixed bus number
Date: Tue, 29 Nov 2011 15:19:11 +0800
Message-ID: <1322551151-28580-2-git-send-email-feng.tang@intel.com>
References: <1322551151-28580-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1322551151-28580-1-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ben-linux@fluff.org, khali@linux-fr.org, tomoya-linux@dsn.lapis-semi.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: joel.clark@intel.com, Feng Tang <feng.tang@intel.com>
List-Id: linux-i2c@vger.kernel.org

For EG20T and ML7213 IOH, the i2c controller numbers are fixed, using
fixed bus number will make it much easier for platform code to use
i2c_register_board_info() to register i2c devices.

Signed-off-by: Feng Tang <feng.tang@intel.com>
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
