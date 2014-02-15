From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] Documentation: i2c: mention ACPI method for instantiating devices
Date: Sat, 15 Feb 2014 15:58:35 +0100
Message-ID: <1392476315-13396-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---

Very basic, but probably should do for now?

 Documentation/i2c/instantiating-devices | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/i2c/instantiating-devices b/Documentation/i2c/instantiating-devices
index 6df095a..0d85ac19 100644
--- a/Documentation/i2c/instantiating-devices
+++ b/Documentation/i2c/instantiating-devices
@@ -81,6 +81,13 @@ additional properties which might be needed to set up the device, please refer
 to its devicetree documentation in Documentation/devicetree/bindings/.
 
 
+Method 1c: Declare the I2C devices via ACPI
+-------------------------------------------
+
+ACPI can also describe I2C devices. There is special documentation for this
+which is currently located at Documentation/acpi/enumeration.txt.
+
+
 Method 2: Instantiate the devices explicitly
 --------------------------------------------
 
-- 
1.8.5.1
