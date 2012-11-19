From: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Subject: [PATCH 306/493] i2c: remove use of __devinitdata
Date: Mon, 19 Nov 2012 13:24:15 -0500
Message-ID: <1353349642-3677-306-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks  <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinitdata is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> 
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> 
Cc: "Ben Dooks " <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> 
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> 
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org> 
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org 
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org 
---
 drivers/i2c/busses/i2c-i801.c    |  4 ++--
 drivers/i2c/busses/i2c-mpc.c     | 10 +++++-----
 drivers/i2c/busses/i2c-mv64xxx.c |  2 +-
 drivers/i2c/busses/i2c-nforce2.c |  2 +-
 drivers/i2c/busses/i2c-piix4.c   |  4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index d362004..5971441 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -841,7 +841,7 @@ struct dmi_onboard_device_info {
 	const char *i2c_type;
 };
 
-static struct dmi_onboard_device_info __devinitdata dmi_devices[] = {
+static struct dmi_onboard_device_info dmi_devices[] = {
 	{ "Syleus", DMI_DEV_TYPE_OTHER, 0x73, "fscsyl" },
 	{ "Hermes", DMI_DEV_TYPE_OTHER, 0x73, "fscher" },
 	{ "Hades",  DMI_DEV_TYPE_OTHER, 0x73, "fschds" },
@@ -944,7 +944,7 @@ static struct i801_mux_config i801_mux_config_asus_z8_d18 = {
 	.n_gpios = 2,
 };
 
-static struct dmi_system_id __devinitdata mux_dmi_table[] = {
+static struct dmi_system_id mux_dmi_table[] = {
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index caede3c..c26095d 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -746,24 +746,24 @@ static int mpc_i2c_resume(struct device *dev)
 SIMPLE_DEV_PM_OPS(mpc_i2c_pm_ops, mpc_i2c_suspend, mpc_i2c_resume);
 #endif
 
-static const struct mpc_i2c_data mpc_i2c_data_512x __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_512x = {
 	.setup = mpc_i2c_setup_512x,
 };
 
-static const struct mpc_i2c_data mpc_i2c_data_52xx __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_52xx = {
 	.setup = mpc_i2c_setup_52xx,
 };
 
-static const struct mpc_i2c_data mpc_i2c_data_8313 __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_8313 = {
 	.setup = mpc_i2c_setup_8xxx,
 };
 
-static const struct mpc_i2c_data mpc_i2c_data_8543 __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_8543 = {
 	.setup = mpc_i2c_setup_8xxx,
 	.prescaler = 2,
 };
 
-static const struct mpc_i2c_data mpc_i2c_data_8544 __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_8544 = {
 	.setup = mpc_i2c_setup_8xxx,
 	.prescaler = 3,
 };
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 06dd6aa..39a0a78 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -718,7 +718,7 @@ mv64xxx_i2c_remove(struct platform_device *dev)
 	return rc;
 }
 
-static const struct of_device_id mv64xxx_i2c_of_match_table[] __devinitdata = {
+static const struct of_device_id mv64xxx_i2c_of_match_table[] = {
 	{ .compatible = "marvell,mv64xxx-i2c", },
 	{}
 };
diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
index d820a93..1012183 100644
--- a/drivers/i2c/busses/i2c-nforce2.c
+++ b/drivers/i2c/busses/i2c-nforce2.c
@@ -117,7 +117,7 @@ struct nforce2_smbus {
 #define MAX_TIMEOUT	100
 
 /* We disable the second SMBus channel on these boards */
-static struct dmi_system_id __devinitdata nforce2_dmi_blacklist2[] = {
+static struct dmi_system_id nforce2_dmi_blacklist2[] = {
 	{
 		.ident = "DFI Lanparty NF4 Expert",
 		.matches = {
diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 891f2b5..1cce916 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -99,7 +99,7 @@ MODULE_PARM_DESC(force_addr,
 static int srvrworks_csb5_delay;
 static struct pci_driver piix4_driver;
 
-static struct dmi_system_id __devinitdata piix4_dmi_blacklist[] = {
+static struct dmi_system_id piix4_dmi_blacklist[] = {
 	{
 		.ident = "Sapphire AM2RD790",
 		.matches = {
@@ -119,7 +119,7 @@ static struct dmi_system_id __devinitdata piix4_dmi_blacklist[] = {
 
 /* The IBM entry is in a separate table because we only check it
    on Intel-based systems */
-static struct dmi_system_id __devinitdata piix4_dmi_ibm[] = {
+static struct dmi_system_id piix4_dmi_ibm[] = {
 	{
 		.ident = "IBM",
 		.matches = { DMI_MATCH(DMI_SYS_VENDOR, "IBM"), },
-- 
1.8.0
