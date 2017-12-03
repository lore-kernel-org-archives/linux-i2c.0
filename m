From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <volker.ruemelin@googlemail.com>
Subject: [PATCH resend] i2c-i801: fix resume bug
Date: Sun, 3 Dec 2017 16:42:42 +0100
Message-ID: <a2fc5a6d-a3bf-eaf0-bb75-1521be346333@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38434 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbdLCPmp (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 3 Dec 2017 10:42:45 -0500
Received: by mail-wr0-f196.google.com with SMTP id o2so14661257wro.5
        for <linux-i2c@vger.kernel.org>; Sun, 03 Dec 2017 07:42:45 -0800 (PST)
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On suspend the original host configuration gets restored. The
resume routine has to undo this, otherwise the SMBus master
may be left in disabled state or in i2c mode.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---

I noticed this bug in a QEMU x86_64 q35 VM booted with OVMF. OVMF
doesn't intitialize the SMBus master. After 1s of SMBus inactivity
autosuspend disables the SMBus master. To reproduce please note QEMU's
ICH9 SMBus emulation does not handle interrupts and it's necessary
to pass the parameter disable_features=0x10 to the i2c_i801 driver.

 drivers/i2c/busses/i2c-i801.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 9e12a53..ebd81bc 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1489,6 +1489,13 @@ static void i801_acpi_remove(struct i801_priv *priv)
 static inline void i801_acpi_remove(struct i801_priv *priv) { }
 #endif
 
+static unsigned char i801_setup_hstcfg(unsigned char hstcfg)
+{
+	hstcfg &= ~SMBHSTCFG_I2C_EN;	/* SMBus timing */
+	hstcfg |= SMBHSTCFG_HST_EN;
+	return hstcfg;
+}
+
 static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	unsigned char temp;
@@ -1592,13 +1599,10 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return err;
 	}
 
-	pci_read_config_byte(priv->pci_dev, SMBHSTCFG, &temp);
-	priv->original_hstcfg = temp;
-	temp &= ~SMBHSTCFG_I2C_EN;	/* SMBus timing */
-	if (!(temp & SMBHSTCFG_HST_EN)) {
+	pci_read_config_byte(priv->pci_dev, SMBHSTCFG, &priv->original_hstcfg);
+	temp = i801_setup_hstcfg(priv->original_hstcfg);
+	if (~priv->original_hstcfg & temp & SMBHSTCFG_HST_EN)
 		dev_info(&dev->dev, "Enabling SMBus device\n");
-		temp |= SMBHSTCFG_HST_EN;
-	}
 	pci_write_config_byte(priv->pci_dev, SMBHSTCFG, temp);
 
 	if (temp & SMBHSTCFG_SMB_SMI_EN) {
@@ -1709,7 +1713,9 @@ static int i801_resume(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct i801_priv *priv = pci_get_drvdata(pci_dev);
+	unsigned char hstcfg = i801_setup_hstcfg(priv->original_hstcfg);
 
+	pci_write_config_byte(pci_dev, SMBHSTCFG, hstcfg);
 	i801_enable_host_notify(&priv->adapter);
 
 	return 0;
-- 
1.8.4.5
