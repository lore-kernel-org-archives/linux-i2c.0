From: Alban Browaeys <alban.browaeys@gmail.com>
Subject: [PATCH] i2c: i801: Fix SMBus ENXIO on resume from suspend.
Date: Wed, 15 Nov 2017 18:01:56 +0100
Message-ID: <20171115170156.21532-1-alban.browaeys@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39029 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932406AbdKORCR (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 15 Nov 2017 12:02:17 -0500
Received: by mail-wm0-f65.google.com with SMTP id l8so4313145wmg.4
        for <linux-i2c@vger.kernel.org>; Wed, 15 Nov 2017 09:02:16 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Alban Browaeys <alban.browaeys@gmail.com>

Disabling I2C_EN on resume as it was restored in
suspend when we set pci config to its original value.

ENXIO landing in rmi_smb_get_version,  i2c-i802 debug
pointing at i801_check_post and guesswork from reading
probe which has this tweak.

i801_smbus 0000:00:1f.3: No response
rmi4_smbus 0-002c: failed to get SMBus version number!
i801_smbus 0000:00:1f.3: No response
rmi4_physical rmi4-00: rmi_driver_reset_handler: Failed to read current IRQ mask.
i801_smbus 0000:00:1f.3: No response
rmi4_f01 rmi4-00.fn01: Failed to restore normal operation: -6.
rmi4_f01 rmi4-00.fn01: Resume failed with code -6.
rmi4_physical rmi4-00: Failed to suspend functions: -6
rmi4_smbus 0-002c: Failed to resume device: -6
rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to write to F03 TX register (-6).
i801_smbus 0000:00:1f.3: No response
rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to write to F03 TX register (-6).

Signed-off-by: Alban Browaeys <alban.browaeys@gmail.com>
---
 drivers/i2c/busses/i2c-i801.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 9e12a53ef7b8..b7b6c8ee2176 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1707,9 +1707,14 @@ static int i801_suspend(struct device *dev)
 
 static int i801_resume(struct device *dev)
 {
+	unsigned char temp;
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct i801_priv *priv = pci_get_drvdata(pci_dev);
 
+	pci_read_config_byte(pci_dev, SMBHSTCFG, &temp);
+	temp &= ~SMBHSTCFG_I2C_EN;	/* SMBus timing */
+	pci_write_config_byte(pci_dev, SMBHSTCFG, temp);
+
 	i801_enable_host_notify(&priv->adapter);
 
 	return 0;
-- 
2.15.0
