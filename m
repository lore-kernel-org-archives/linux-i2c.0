From: Joe Perches <joe@perches.com>
Subject: [PATCH 01/11] drivers/i2c/busses/i2c-nforce2.c: Remove unnecessary casts of pci_get_drvdata
Date: Mon, 15 Nov 2010 12:13:52 -0800
Message-ID: <8202cea15da761f594353ae6906e1414b1f1f152.1289851770.git.joe@perches.com>
References: <cover.1289851770.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1289851770.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <trivial@kernel.org>
Cc: "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/i2c/busses/i2c-nforce2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
index a605a50..ff1e127 100644
--- a/drivers/i2c/busses/i2c-nforce2.c
+++ b/drivers/i2c/busses/i2c-nforce2.c
@@ -432,7 +432,7 @@ static int __devinit nforce2_probe(struct pci_dev *dev, const struct pci_device_
 
 static void __devexit nforce2_remove(struct pci_dev *dev)
 {
-	struct nforce2_smbus *smbuses = (void*) pci_get_drvdata(dev);
+	struct nforce2_smbus *smbuses = pci_get_drvdata(dev);
 
 	nforce2_set_reference(NULL);
 	if (smbuses[0].base) {
-- 
1.7.3.1.g432b3.dirty
