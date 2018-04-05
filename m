From: Jason Andryuk <jandryuk@gmail.com>
Subject: [PATCH v3] i2c: i801: blacklist Host Notify on HP EliteBook G3 850
Date: Thu,  5 Apr 2018 14:38:24 -0400
Message-ID: <20180405183824.13333-1-jandryuk@gmail.com>
References: <20180404225643.6b40782f@endymion>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180404225643.6b40782f@endymion>
Sender: stable-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: benjamin.tissoires@redhat.com, andyrtr@archlinux.org, aduggan@synaptics.com, Jason Andryuk <jandryuk@gmail.com>, stable@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The HP EliteBook G3 850 has a weird bug where a subsequent cold boot
hangs while plugged in if Linux enables the Host Notify features of
i2c-i801.  The cold boot hang depends on how the system boots.  It does
not hang on UEFI Grub text boot or legacy Grub text boot.  But it does
hang on legacy Grub graphical boot and Intel Boot Agent PXE text boot.
Booting unplugged is not affected.

Disabling the Host Notify feature with disable_feature=0x20 works around
the bug, so automatically do so based on DMI information.

More information can be found here:
https://www.spinics.net/lists/linux-i2c/msg33938.html

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Cc: stable@vger.kernel.org
---
v3: Switch to DMI_EXACT_MATCH and add empty element to array

 drivers/i2c/busses/i2c-i801.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 692b34125866..11149ddae745 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1042,6 +1042,27 @@ static const struct pci_device_id i801_ids[] = {
 MODULE_DEVICE_TABLE(pci, i801_ids);
 
 #if defined CONFIG_X86 && defined CONFIG_DMI
+static const struct dmi_system_id host_notify_dmi_blacklist[] = {
+	{
+		.ident = "HP EliteBook G3 850",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME,
+					"HP EliteBook 850 G3"),
+		},
+	},
+	{}
+};
+
+static void blacklist_features(struct i801_priv *priv)
+{
+	if (dmi_check_system(host_notify_dmi_blacklist)) {
+		dev_warn(&priv->pci_dev->dev,
+			 "SMBus Host Notify disabled on this system");
+		priv->features &= ~FEATURE_HOST_NOTIFY;
+	}
+}
+
 static unsigned char apanel_addr;
 
 /* Scan the system ROM for the signature "FJKEYINF" */
@@ -1159,6 +1180,7 @@ static void i801_probe_optional_slaves(struct i801_priv *priv)
 #else
 static void __init input_apanel_init(void) {}
 static void i801_probe_optional_slaves(struct i801_priv *priv) {}
+static void blacklist_features(struct i801_priv *priv) {}
 #endif	/* CONFIG_X86 && CONFIG_DMI */
 
 #if IS_ENABLED(CONFIG_I2C_MUX_GPIO) && defined CONFIG_DMI
@@ -1562,6 +1584,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 				   i801_feature_names[i]);
 	}
 	priv->features &= ~disable_features;
+	blacklist_features(priv);
 
 	err = pcim_enable_device(dev);
 	if (err) {
-- 
2.14.3
