From: Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
Subject: [PATCH v2 4/5] dt-bindings: at24: extend the list of supported chips
Date: Thu, 21 Dec 2017 14:48:41 +0100
Message-ID: <20171221134842.31287-5-brgl@bgdev.pl>
References: <20171221134842.31287-1-brgl@bgdev.pl>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171221134842.31287-1-brgl-ARrdPY/1zhM@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add other variants of at24 EEPROMs we support in the driver to the
list of allowed compatible strings.

Signed-off-by: Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
Reviewed-by: Javier Martinez Canillas <javierm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 Documentation/devicetree/bindings/eeprom/at24.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
index 1068b4309fed..ea2707f769d0 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.txt
+++ b/Documentation/devicetree/bindings/eeprom/at24.txt
@@ -6,13 +6,22 @@ Required properties:
 
         "atmel,24c00",
         "atmel,24c01",
+        "atmel,24cs01",
         "atmel,24c02",
+        "atmel,24cs02",
+        "atmel,24mac402",
+        "atmel,24mac602",
         "atmel,spd",
         "atmel,24c04",
+        "atmel,24cs04",
         "atmel,24c08",
+        "atmel,24cs08",
         "atmel,24c16",
+        "atmel,24cs16",
         "atmel,24c32",
+        "atmel,24cs32",
         "atmel,24c64",
+        "atmel,24cs64",
         "atmel,24c128",
         "atmel,24c256",
         "atmel,24c512",
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
