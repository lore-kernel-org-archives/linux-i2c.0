From: Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] i2c: ismt: Add missed pci_release_region
Date: Sat,  9 Nov 2019 15:54:35 +0800
Message-ID: <20191109075435.29871-1-hslester96@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
List-Id: linux-i2c@vger.kernel.org

ismt_remove forgets to call pci_release_region when remove.
Add the call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/i2c/busses/i2c-ismt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index 2f95e25a10f7..c393e629cac3 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -943,6 +943,8 @@ static void ismt_remove(struct pci_dev *pdev)
 	struct ismt_priv *priv = pci_get_drvdata(pdev);
 
 	i2c_del_adapter(&priv->adapter);
+
+	pci_release_region(pdev, SMBBAR);
 }
 
 static struct pci_driver ismt_driver = {
-- 
2.23.0
