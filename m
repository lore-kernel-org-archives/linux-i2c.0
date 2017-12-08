From: Sven Van Asbroeck <svendev-fuHqz3Nb1YI@public.gmane.org>
Subject: [PATCH RESEND v6 2/2] dt-bindings: add eeprom "no-read-rollover" property
Date: Fri, 8 Dec 2017 10:37:25 -0500
Message-ID: <1512747445-5817-3-git-send-email-svendev@arcx.com>
References: <1512747445-5817-1-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512747445-5817-1-git-send-email-svendev-fuHqz3Nb1YI@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: svendev-fuHqz3Nb1YI@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, brgl-ARrdPY/1zhM@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Adds an optional property for at24 eeproms.
This parameterless property indicates that the multi-address eeprom
does not automatically roll over reads to the next slave address.

Signed-off-by: Sven Van Asbroeck <svendev-fuHqz3Nb1YI@public.gmane.org>
Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/eeprom/eeprom.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
index 27f2bc1..5bfc0ac 100644
--- a/Documentation/devicetree/bindings/eeprom/eeprom.txt
+++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
@@ -38,6 +38,11 @@ Optional properties:
 
   - size: total eeprom size in bytes
 
+  - no-read-rollover:
+			This parameterless property indicates that the multi-address
+			eeprom does not automatically roll over reads to the next
+			slave address. Please consult the manual of your device.
+
 Example:
 
 eeprom@52 {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
