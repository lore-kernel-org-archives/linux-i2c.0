From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] i2c: i801: mark PM functions as __maybe_unused
Date: Tue,  8 May 2018 09:38:52 +0200
Message-ID: <20180508073852.16840-1-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jdelvare@suse.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>
List-Id: linux-i2c@vger.kernel.org

With CONFIG_PM, we get a harmless build warning:
drivers/i2c/busses/i2c-i801.c:1723:12: warning: ‘i801_resume’ defined but not used [-Wunused-function]
 static int i801_resume(struct device *dev)
            ^~~~~~~~~~~
drivers/i2c/busses/i2c-i801.c:1714:12: warning: ‘i801_suspend’ defined but not used [-Wunused-function]
 static int i801_suspend(struct device *dev)
            ^~~~~~~~~~~~

This marks the affected functions as __maybe_unused.

Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/i2c/busses/i2c-i801.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index ed07f9002710..ff18c6ed2bec 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1711,7 +1711,7 @@ static void i801_shutdown(struct pci_dev *dev)
 }
 
 #ifdef CONFIG_PM
-static int i801_suspend(struct device *dev)
+static int __maybe_unused i801_suspend(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct i801_priv *priv = pci_get_drvdata(pci_dev);
@@ -1720,7 +1720,7 @@ static int i801_suspend(struct device *dev)
 	return 0;
 }
 
-static int i801_resume(struct device *dev)
+static int __maybe_unused i801_resume(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct i801_priv *priv = pci_get_drvdata(pci_dev);
-- 
2.17.0
