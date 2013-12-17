From: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] dt: Update I2C trivial devices list
Date: Mon, 16 Dec 2013 19:12:31 -0500
Message-ID: <1387239151-19226-1-git-send-email-bgamari.foss@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index b1cb341..0e68085 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -1,6 +1,9 @@
 This is a list of trivial i2c devices that have simple device tree
 bindings, consisting only of a compatible field, an address and
-possibly an interrupt line.
+possibly an interrupt line. The compatible field is used to lookup the
+modalias of the driver which will handle the device. The compatible
+string may begin with a manufacturer prefix (separated from the
+modalias by a comma) which will be stripped off during lookup.
 
 If a device needs more specific bindings, such as properties to
 describe some aspect of it, there needs to be a specific binding
@@ -9,10 +12,10 @@ document for it just like any other devices.
 
 Compatible		Vendor / Chip
 ==========		=============
+ad,adt7411		I2C Digital 8-channel 10-bit ADC and temperature sensor
 ad,ad7414		SMBus/I2C Digital Temperature Sensor in 6-Pin SOT with SMBus Alert and Over Temperature Pin
 ad,adm9240		ADM9240:  Complete System Hardware Monitor for uProcessor-Based Systems
-adi,adt7461		+/-1C TDM Extended Temp Range I.C
-adt7461			+/-1C TDM Extended Temp Range I.C
+adi,adt7461		+/-1C SMBus digital thermometer
 at,24c08		i2c serial eeprom  (24cxx)
 atmel,24c02		i2c serial eeprom  (24cxx)
 atmel,at97sc3204t	i2c trusted platform module (TPM)
-- 
1.8.3.2
