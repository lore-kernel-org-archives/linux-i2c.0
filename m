From: Christian Fetzer <fetzer.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/4] i2c-piix4: Convert piix4_main_adapter to array
Date: Tue, 25 Aug 2015 13:05:03 +0200
Message-ID: <1440500705-2288-3-git-send-email-fetzer.ch@gmail.com>
References: <1440500705-2288-1-git-send-email-fetzer.ch@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1440500705-2288-1-git-send-email-fetzer.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tbrandonau-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, eddi-soWH+0lSOSbR7s880joybQ@public.gmane.org, galandilias-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Christian Fetzer <fetzer.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The SB800 chipset supports a multiplexed main SMBus controller with
four ports. Therefore the static variable piix4_main_adapter is
converted into a piix4_main_adapters array that can hold one
i2c_adapter for each multiplexed port.

The auxiliary adapter remains unchanged since it represents the second
(not multiplexed) SMBus controller on the SB800 chipset.

Signed-off-by: Christian Fetzer <fetzer.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-piix4.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 97d2165..8934a32 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -75,6 +75,9 @@
 #define PIIX4_WORD_DATA		0x0C
 #define PIIX4_BLOCK_DATA	0x14
 
+/* Multi-port constants */
+#define PIIX4_MAX_ADAPTERS 4
+
 /* insmod parameters */
 
 /* If force is set to anything different from 0, we forcibly enable the
@@ -561,7 +564,7 @@ static const struct pci_device_id piix4_ids[] = {
 
 MODULE_DEVICE_TABLE (pci, piix4_ids);
 
-static struct i2c_adapter *piix4_main_adapter;
+static struct i2c_adapter *piix4_main_adapters[PIIX4_MAX_ADAPTERS];
 static struct i2c_adapter *piix4_aux_adapter;
 
 static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
@@ -629,7 +632,7 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return retval;
 
 	/* Try to register main SMBus adapter, give up if we can't */
-	retval = piix4_add_adapter(dev, retval, &piix4_main_adapter);
+	retval = piix4_add_adapter(dev, retval, &piix4_main_adapters[0]);
 	if (retval < 0)
 		return retval;
 
@@ -675,9 +678,14 @@ static void piix4_adap_remove(struct i2c_adapter *adap, int free_smba)
 
 static void piix4_remove(struct pci_dev *dev)
 {
-	if (piix4_main_adapter) {
-		piix4_adap_remove(piix4_main_adapter, 1);
-		piix4_main_adapter = NULL;
+	int port;
+
+	for (port = 0; port < PIIX4_MAX_ADAPTERS; port++) {
+		if (piix4_main_adapters[port]) {
+			piix4_adap_remove(piix4_main_adapters[port],
+					  port == 0);
+			piix4_main_adapters[port] = NULL;
+		}
 	}
 
 	if (piix4_aux_adapter) {
-- 
1.9.1
