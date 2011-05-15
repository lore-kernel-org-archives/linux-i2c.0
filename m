From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v2 1/2] i2c-i801: Check for vendor Fujitsu before probing
 for apanel
Date: Sun, 15 May 2011 22:10:58 +0200
Message-ID: <20110515221058.5dc22a1e@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: David Woodhouse <david.woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Scanning the BIOS memory for the apanel information is costly, so avoid
doing it on non-Fujitsu machines.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.39-rc7.orig/drivers/i2c/busses/i2c-i801.c	2011-05-15 21:13:06.000000000 +0200
+++ linux-2.6.39-rc7/drivers/i2c/busses/i2c-i801.c	2011-05-15 21:31:42.000000000 +0200
@@ -931,7 +931,8 @@ static struct pci_driver i801_driver = {
 
 static int __init i2c_i801_init(void)
 {
-	input_apanel_init();
+	if (dmi_name_in_vendors("FUJITSU"))
+		input_apanel_init();
 	return pci_register_driver(&i801_driver);
 }
 

-- 
Jean Delvare
