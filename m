From: "Daniel M. Weeks" <dan-ZKupHW+dzKzk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH] i2c: piix4: Continue probing for auxiliary SMBus without main
Date: Fri, 11 Jul 2014 20:06:15 -0400
Message-ID: <20140712000607.GA25787@turkey.danweeks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Some BIOS may only allow access to the AMD auxiliary SMBus - reserving
the main SMBus for system functions only. Probing should continue even
if the main bus is not available so at least the auxiliary can be added.

Signed-off-by: Daniel M. Weeks <dan-ZKupHW+dzKzk1uMJSBkQmQ@public.gmane.org>
---
This patch may warrant some discussion. I ran across this problem on an
AMD Hudson board where the main SMBus is hard-wired for debugging but
the auxiliary bus is exposed for expansion. Either purposefully or
because the BIOS is a little broken, loading this module used to result
in an ACPI conflict for the main bus and neither was usable. With the
patch I'm able to use the auxiliary bus regardless of the conflict on
the main bus. I'm not 100% convinced it's the correct fix - someone with
more ACPI experience than me is going to need to review this.

drivers/i2c/busses/i2c-piix4.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index a6f54ba..d4bac64 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -628,14 +628,16 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	else
 		retval = piix4_setup(dev, id);
 
-	/* If no main SMBus found, give up */
-	if (retval < 0)
-		return retval;
-
-	/* Try to register main SMBus adapter, give up if we can't */
-	retval = piix4_add_adapter(dev, retval, &piix4_main_adapter);
-	if (retval < 0)
-		return retval;
+	/* If no main SMBus found, do not give up
+	 * some BIOS purposely only expose aux bus */
+	if (retval < 0) {
+		dev_info(&dev->dev, "No main SMBus; checking auxiliary\n");
+	} else {
+		/* Try to register main SMBus adapter, give up if we can't */
+		retval = piix4_add_adapter(dev, retval, &piix4_main_adapter);
+		if (retval < 0)
+			return retval;
+	}
 
 	/* Check for auxiliary SMBus on some AMD chipsets */
 	retval = -ENODEV;
-- 
Daniel M. Weeks
