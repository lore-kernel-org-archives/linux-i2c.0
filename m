Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1F537B00C
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786544244; cv=none; b=QmzP6ZJrFSqaLbMh8tJDC25oZ0XX3B9kktQ92wzwQdD/i1wAHairVJ3kLma7LVO9ryM4I+bMQZsrZuYmgVwzFQNEKe4AUjIB1zKpjG6PlnUiN3B6Hf30ol9UbVuSpREdLrVQVOGMzVGPPhoOugsJSC3J9oAxeQteLjlWX8v7wwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786544244; c=relaxed/simple;
	bh=w4D3Tw/qGODOSquheRTqS2zaE5vY/ibskA7/ntNW+8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGC/tga2Cso2NTQe6YtB5tXkzYzMalERBbR1EUGm57+EEPm4gyntqvV/8ylQ1AKJz+GL+0ETxU4PUTAe8I0GllGv1Uzjr6WVhmgFV/uzWtHa9HCSu8AsWUH1o+mSQBzg5dHNiOky5M/WjWj7lNxx5YbEljaLu4Z1l+5Q0Ro4mi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnAAKYOt; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnAAKYOt"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so1271845a91.0
        for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786544242; x=1787149042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c7gjSQ0r/UdoBWSwg7nk7c7n8PtdywkD8czofZ+H0lU=;
        b=PnAAKYOtz7Mz1ciZOlBRlxFv384+MX9DHgmiJsWBiy17KK0V4LTJJ+eXDA9q+HNtqt
         bRJDuY5g26goQ02awKjr8yXOdU0qkV253pSuPQzYQ4zng0UPySTqmYH/fuFhDSveezIO
         ZmajdNNSzOcQv5jqulaN4TkWYuUWuxvj3blGom1xNFY19ZtRAJhTX2+eMp9tRgqbm23/
         nN7kdzSZhhK/cKc/KvxPS3dp8AMIJmyV7pzt9xXomg2rIIX4NC+4YaXmtfVCoMLqJ1Tp
         +M+13rupziVn2HoC0EhCkF9ngbrH8qqRTG4VOMbQbhhuFwVs5gycgbjijdNgP+Y29v5q
         c4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786544242; x=1787149042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c7gjSQ0r/UdoBWSwg7nk7c7n8PtdywkD8czofZ+H0lU=;
        b=aks6Dc+6XBTIlO6Sa7b6EP0jZaBk3p8pscoJX2aHIw816bfTjZeunstMztDJakBSDk
         k3+ENKEQ/xhpjIKX1qZmyTRsVxLYNWM2xo63ZweX317lggKmHNzSoJ56Z7CNwtGkYEo3
         UpwqQ+FzX0kFPxKkQxLgI/Tj+pYbuWPBmjiqbUJe8E48Bc2aJivumSavehavcY1p+2M2
         25LoM5IdP/buG71SkozrddH1m4MIrG5ZWKlWMuIFrsfsGUCM8knC7tkK9In+Z/Qxd21T
         U8kOCBjAkI186CFBMkSwq+JpvPEypVPedI/ZJ0/KFj0e91m+kUjy01McDDaqClpRZ/MJ
         YygA==
X-Forwarded-Encrypted: i=1; AHgh+RoYfMl9xsyeioWjCNbssQzFA4V7lnZ/7zDR9ZYTwf8QdMFCnFGXGHTmksKnwpDQ6ELQEc63QicGoLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgxj9x7tvPBglxjHRbvOJWzjj9qFx+55DlPl8OVKNXmL1B3/7+
	LwU8+FcgL/7+JPcvBS6bkpuxjMBXMKl8K5GMwqK1BXxQn6HmT+P/ZbqN
X-Gm-Gg: AR+sD10wd54QnM3h9jFyXL7kLX65crvUgWE1glY1Wwzk8v0Imw9TCcwu7ghT4k2dHV6
	PvuO/oG8m5SuJ9zQjQI0fCo8YJIJZZymRm6Lrzx+vL4Hf+9NJANNtzJO8iTfTRs/YEiMHW2j77r
	R6OLdR6XNXRSKODEaWQ6jJTeHQv9zcNlJbJRaKKLe2jvzdnql7wu0bXGB5a00ZUVNyDwFrajudN
	5tv7h7EKKhTn6WOPyW45/YpFsUPI+iiq1bUgeqgdZh3wGlS8Wm804eARO07Xc9LYm9D19iplAqP
	EGxm02F7RmPqPGSes/3WSFGNUL0VWk3IY/5ppGi7bQ4/2WztznokuOYKexmh2RqrC0cyQjgotw0
	gmqPzM6eaH9jO4AuVDeWK+3PBdiHUBl3ZTD115mAINHGEzLsacaEFMA7z6RMuQkiRPVvGE1cuKw
	+8cxVWJQz9O9MvxasR4ZHgRwqo3qa4bCNncx33FYVLZY2mvOVOMSQqtQKGLrg5jXj805Tn50Ro/
	I+H0K0upke0BfIcTLezzFJt6Yy4N+bgmIj0g5I6gwng0n579Os7ucuGKthl
X-Received: by 2002:a17:90b:254c:b0:380:83fc:4315 with SMTP id 98e67ed59e1d1-393014a8c62mr6658843a91.21.1786544241876;
        Wed, 12 Aug 2026 07:17:21 -0700 (PDT)
Received: from Mac.localdomain (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf361d57asm11963071eec.6.2026.08.12.07.17.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Aug 2026 07:17:20 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nam Tran <trannamatk@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Andi Shyti <andi.shyti@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH net-next v4 1/5] dt-bindings: leds: Add IS32FL3207 controller
Date: Wed, 12 Aug 2026 07:17:11 -0700
Message-ID: <361f85124583adba9aae710179af910c328a747b.1786543681.git.ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1786543681.git.ahmadexp@gmail.com>
References: <cover.1786543681.git.ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IS32FL3207 is an 18-channel constant-current LED controller
with per-output PWM and current scaling.

Describe I2C addressing, power and shutdown controls, RISET, and
individual or multicolor output groupings. Require board current limits
for each output.

Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/leds/issi,is32fl3207.yaml        | 251 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 257 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/issi,is32fl3207.yaml

diff --git a/Documentation/devicetree/bindings/leds/issi,is32fl3207.yaml b/Documentation/devicetree/bindings/leds/issi,is32fl3207.yaml
new file mode 100644
index 000000000000..4ee9db964ecc
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/issi,is32fl3207.yaml
@@ -0,0 +1,251 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/issi,is32fl3207.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lumissil IS32FL3207 18-channel LED controller
+
+maintainers:
+  - Ahmad Byagowi <ahmadexp@gmail.com>
+
+description: |
+  The IS32FL3207 is an I2C LED controller with 18 individually controlled
+  constant-current outputs. Each output has 8-bit current scaling. PWM
+  brightness control uses the controller's default 8-bit, 62 kHz mode.
+  Outputs may be exposed as individual LEDs or grouped as multicolor LEDs.
+
+  The data sheet is available at:
+    https://www.lumissil.com/assets/pdf/core/IS32FL3207_DS.pdf
+
+properties:
+  compatible:
+    const: issi,is32fl3207
+
+  reg:
+    enum: [0x34, 0x35, 0x36, 0x37]
+
+  vcc-supply:
+    description: Regulator providing power to the VCC pin.
+
+  enable-gpios:
+    maxItems: 1
+    description: GPIO connected to SDB, asserted to enable the controller.
+
+  issi,riset-ohms:
+    minimum: 2000
+    maximum: 76500000
+    description: |
+      Resistance in ohms of the external RISET resistor. The resistor sets the
+      maximum output current according to IOUT(MAX) = 76.5 / RISET amperes.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^led@[0-9a-f]+$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 17
+        description: |
+          Zero-based LED output number. Values 0 through 17 correspond to
+          OUT1 through OUT18.
+
+      led-max-microamp:
+        minimum: 1
+        maximum: 38250
+
+      color:
+        oneOf:
+          - minimum: 0
+            maximum: 7
+          - minimum: 10
+            maximum: 14
+
+      max-brightness:
+        minimum: 1
+        maximum: 255
+
+      default-state:
+        description:
+          The controller is reset during initialization, so an existing state
+          cannot be preserved.
+        enum: ["on", "off"]
+
+      default-brightness:
+        maximum: 255
+        description: |
+          Brightness used when default-state is "on". This value must not
+          exceed max-brightness when max-brightness is specified.
+
+    anyOf:
+      - required:
+          - function
+      - required:
+          - color
+
+    required:
+      - reg
+      - led-max-microamp
+
+  "^multi-led@[0-9a-f]$":
+    type: object
+    $ref: leds-class-multicolor.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 15
+        description: |
+          Zero-based lowest-numbered LED output used by the group. Values 0
+          through 15 correspond to OUT1 through OUT16. A group based at
+          channel 15 (OUT16) may include channels 16 and 17 (OUT17 and OUT18).
+
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+      max-brightness:
+        minimum: 1
+        maximum: 255
+
+      default-state:
+        description:
+          The controller is reset during initialization, so an existing state
+          cannot be preserved.
+        enum: ["on", "off"]
+
+      default-brightness:
+        maximum: 255
+        description: |
+          Brightness used when default-state is "on". This value must not
+          exceed max-brightness when max-brightness is specified.
+
+    patternProperties:
+      "^led@[0-9a-f]+$":
+        type: object
+        $ref: common.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            minimum: 0
+            maximum: 17
+            description: |
+              Zero-based LED output number. Values 0 through 17 correspond to
+              OUT1 through OUT18.
+
+          led-max-microamp:
+            minimum: 1
+            maximum: 38250
+
+          color:
+            oneOf:
+              - minimum: 0
+                maximum: 7
+              - minimum: 10
+                maximum: 14
+
+          max-brightness: false
+
+          default-state: false
+
+          default-brightness: false
+
+          retain-state-shutdown: false
+
+        required:
+          - reg
+          - color
+          - led-max-microamp
+
+    anyOf:
+      - required: [led@0]
+      - required: [led@1]
+      - required: [led@2]
+      - required: [led@3]
+      - required: [led@4]
+      - required: [led@5]
+      - required: [led@6]
+      - required: [led@7]
+      - required: [led@8]
+      - required: [led@9]
+      - required: [led@a]
+      - required: [led@b]
+      - required: [led@c]
+      - required: [led@d]
+      - required: [led@e]
+      - required: [led@f]
+
+    required:
+      - reg
+      - "#address-cells"
+      - "#size-cells"
+
+required:
+  - compatible
+  - reg
+  - issi,riset-ohms
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@34 {
+            compatible = "issi,is32fl3207";
+            reg = <0x34>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            vcc-supply = <&led_3v3>;
+            enable-gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
+            issi,riset-ohms = <4700>;
+
+            multi-led@0 {
+                reg = <0>;
+                color = <LED_COLOR_ID_RGB>;
+                function = LED_FUNCTION_STATUS;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                    reg = <0>;
+                    color = <LED_COLOR_ID_RED>;
+                    led-max-microamp = <8100>;
+                };
+
+                led@1 {
+                    reg = <1>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    led-max-microamp = <8100>;
+                };
+
+                led@2 {
+                    reg = <2>;
+                    color = <LED_COLOR_ID_BLUE>;
+                    led-max-microamp = <8100>;
+                };
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index e0e7fae5b92f..af4b63b9f1ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13822,6 +13822,12 @@ S:	Maintained
 F:	Documentation/filesystems/isofs.rst
 F:	fs/isofs/
 
+ISSI IS32FL3207 LED DRIVER
+M:	Ahmad Byagowi <ahmadexp@gmail.com>
+L:	linux-leds@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/leds/issi,is32fl3207.yaml
+
 IT87 HARDWARE MONITORING DRIVER
 M:	Jean Delvare <jdelvare@suse.com>
 L:	linux-hwmon@vger.kernel.org
-- 
2.50.1 (Apple Git-155)

