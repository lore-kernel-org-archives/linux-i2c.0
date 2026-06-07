Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB2930C15B
	for <linux-i2c@vger.kernel.org>; Sun,  7 Jun 2026 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780820464; cv=none; b=CZG+Gnjc7EmG/NAlmo5OCZfwQ9NoB0AmBJ6esWoZje62mJL06LUkmFghRdLh4QYzZQ+61qDKQ5DnWge5+cCrqWORL7zZCEjuBgC9fxmRtJZZutC8zXyoSOMcNk1H63wj8K9Qyy2mOrVjm5HbgyjZe0tP8nxaRWyDv0ZsQFZxYl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780820464; c=relaxed/simple;
	bh=XaIH/tdA/VTfND3mpkqGBSmm806lREpUi5+nvDjYaoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VOvOXP/sq7arsRmzUP/cLveaOBlfYyaNrnU50q5GuQ7PKKKKH3pb3+sNM2KNeRn9cw8nRLxmqfv27PhQpSooRm3qt/FlB6wqSgjW0RRgHfqaIHSJPUZGcN4OxcY8GqTVssRZBiGZWTpJW4S/zmACibQovnmgGZUbrOMxmjzoY6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=RcvraqHq; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="RcvraqHq"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1363e78746eso3464913c88.1
        for <linux-i2c@vger.kernel.org>; Sun, 07 Jun 2026 01:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1780820463; x=1781425263; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/xWxoztuolS/ZK9hptFI5IvqarIJl0DesoQ958DqkU=;
        b=RcvraqHqwhkrL/dhgGhClTpe1pmQJ4z7dABaE7b1qeBevAJEOZV65Z3kcIOFS5Kh/0
         063dtGANGx5n4aSg3IW7tDrmV4IRDXI3Ncw1OBhx7qQ5p/8K1JXirYvBTmwqCEtTnSZU
         zNZEMZQCC2MilV3TOa7KE5eYrU2dx8viXCdb/F3H71HnZlfjpdGqmH+a3rUwvZ+Mz7NU
         7mSX4Rg8/SucnqXRoAWfdNo2GNJsVXLIsl9IVptxPHj4K5q0hDLrfbIt2nJDam+xtI6d
         DEBa9SusGKFODlzR24w8FKPcPlyGYk0QItUqhACUrbGb6bte50zUvvNo0idFezJbjRFz
         TzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780820463; x=1781425263;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n/xWxoztuolS/ZK9hptFI5IvqarIJl0DesoQ958DqkU=;
        b=RS/ExgogSTkyYNvNGsZp2U6ptyrdjaB900K+oAyAQCgKkqgeTFCC67VQ3CQuLffgUs
         kdVBeguQSFaa3J1CqaU/dFg7FRkwo9GC3shHlhmQcKusmSZqUKD64pM3tym6H/juQ0yP
         1Rt2wokY1zGhszmaAar53/1bwNdJP2rC2X75q8VLr+xC72hQc/JI2jjJELU3HCusrlFS
         79NDVsGWbfgjKVCwuQcptHgB//5yb4RL2oYamhX+C+FIaA2Fv6vA25eUGHOHnTuUg7Z2
         2COGd+O6UvclWMWaSBJSLsoDdl39gN6AFoXCWx6I4g21wZSFHjfGE8zKD2gCcIDLVn58
         rDPQ==
X-Gm-Message-State: AOJu0YzGr77Qs73FjDDgmR9J0N7AKQ6kbqKy90uU2hKxGuecc4f2O9uT
	4s0P82VEYSAQQ4FCblSFUbgDaEV3Q97jsUsmDJAvS2nwRSJKohUT//Y73YkX/LKd1BY=
X-Gm-Gg: Acq92OFJhniXMIzTY0Us2pXxOqrqng8WIWieK1wwHpdb1qQay+k9gLYXFxetZsrOWqh
	T4uyTl9PgTE3YJlZNGed/iFEEpY61r0Y6+4T7c4M2jtEWNhEiYbHHWlho3FoWm1zSz1KSjxGAqy
	vPIK5pHxdKyJw6m1QRMnptyXfm+FiOf7RL/+Znl52T5vtgf+6CYMTu9zYDlBi83c8cIb86fvRZT
	Tc/2JlB/qAyFOBf3KCbDerEYDHHx6OHtVNjxuQvzj9j7nHpxK4dolixduhiOmN/LmhIqHchxOJu
	J5bmpONqwllk1KdV1zlDUFLL+BRdY4oUeojB+F2P5S88OfG/DxJitPd6QEOF+uwtZ8Zmm9JqaRi
	Q2m+eOfft6Xk4/0djeOv3vFO/5ZqDk77DOe9B3K/sdSrWOFKeQGUj2Ar9axNvzsGSoYHyrOCEZJ
	ygzsb7TaL/EL2cBOdKxySi+AK37Hh55mtEMj5Sf03atv+0Kp0=
X-Received: by 2002:a05:7022:6ba1:b0:136:d237:b42f with SMTP id a92af1059eb24-1380671e4f7mr5539508c88.32.1780820462533;
        Sun, 07 Jun 2026 01:21:02 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5489d17sm9439232c88.1.2026.06.07.01.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 01:21:01 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Sun, 07 Jun 2026 01:20:55 -0700
Subject: [PATCH 1/2] dt-bindings: i2c: convert i2c-mux-reg to DT schema
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-i2c-mux-reg-base-bus-num-v1-1-f193b5a8fedc@nexthop.ai>
References: <20260607-i2c-mux-reg-base-bus-num-v1-0-f193b5a8fedc@nexthop.ai>
In-Reply-To: <20260607-i2c-mux-reg-base-bus-num-v1-0-f193b5a8fedc@nexthop.ai>
To: Peter Rosin <peda@lysator.liu.se>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780820459; l=7006;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=XaIH/tdA/VTfND3mpkqGBSmm806lREpUi5+nvDjYaoo=;
 b=C+ibZQ+gsmsrAvsymoBk+kltJIaMIG2c48b1dcSIFmRXC4kaNlSUsBa0652Tuh3i3hW16XpDB
 Hvz0eR4j8g+DurUyhYeszzYQ+sC0B5KJX/DIQH6ziBr1OxW04Lb7Ixx
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

Convert Documentation/devicetree/bindings/i2c/i2c-mux-reg.txt to
the YAML schema so the i2c-mux-reg binding is validated by
dt_binding_check.

Also document a new optional "base-bus-num" property: when
present, child adapter N is registered as Linux i2c bus number
(base-bus-num + reg), so static references such as sensors.conf
stanzas remain stable across boots. The matching driver support is
added in the following patch.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 .../devicetree/bindings/i2c/i2c-mux-reg.txt        |  74 --------------
 .../devicetree/bindings/i2c/i2c-mux-reg.yaml       | 110 +++++++++++++++++++++
 2 files changed, 110 insertions(+), 74 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-reg.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-reg.txt
deleted file mode 100644
index b9d9755e4172..000000000000
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-reg.txt
+++ /dev/null
@@ -1,74 +0,0 @@
-Register-based I2C Bus Mux
-
-This binding describes an I2C bus multiplexer that uses a single register
-to route the I2C signals.
-
-Required properties:
-- compatible: i2c-mux-reg
-- i2c-parent: The phandle of the I2C bus that this multiplexer's master-side
-  port is connected to.
-* Standard I2C mux properties. See i2c-mux.yaml in this directory.
-* I2C child bus nodes. See i2c-mux.yaml in this directory.
-
-Optional properties:
-- reg: this pair of <offset size> specifies the register to control the mux.
-  The <offset size> depends on its parent node. It can be any memory-mapped
-  address. The size must be either 1, 2, or 4 bytes. If reg is omitted, the
-  resource of this device will be used.
-- little-endian: The existence indicates the register is in little endian.
-- big-endian: The existence indicates the register is in big endian.
-  If both little-endian and big-endian are omitted, the endianness of the
-  CPU will be used.
-- write-only: The existence indicates the register is write-only.
-- idle-state: value to set the muxer to when idle. When no value is
-  given, it defaults to the last value used.
-
-Whenever an access is made to a device on a child bus, the value set
-in the relevant node's reg property will be output to the register.
-
-If an idle state is defined, using the idle-state (optional) property,
-whenever an access is not being made to a device on a child bus, the
-register will be set according to the idle value.
-
-If an idle state is not defined, the most recently used value will be
-left programmed into the register.
-
-Example of a mux on PCIe card, the host is a powerpc SoC (big endian):
-
-	i2c-mux {
-		/* the <offset size> depends on the address translation
-		 * of the parent device. If omitted, device resource
-		 * will be used instead. The size is to determine
-		 * whether iowrite32, iowrite16, or iowrite8 will be used.
-		 */
-		reg = <0x6028 0x4>;
-		little-endian;		/* little endian register on PCIe */
-		compatible = "i2c-mux-reg";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		i2c-parent = <&i2c1>;
-		i2c@0 {
-			reg = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			si5338: clock-generator@70 {
-				compatible = "silabs,si5338";
-				reg = <0x70>;
-				/* other stuff */
-			};
-		};
-
-		i2c@1 {
-			/* data is written using iowrite32 */
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			si5338: clock-generator@70 {
-				compatible = "silabs,si5338";
-				reg = <0x70>;
-				/* other stuff */
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-reg.yaml b/Documentation/devicetree/bindings/i2c/i2c-mux-reg.yaml
new file mode 100644
index 000000000000..7fadedabde70
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-reg.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/i2c-mux-reg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Register-based I2C Bus Mux
+
+maintainers:
+  - Peter Rosin <peda@axentia.se>
+
+description: |
+  This binding describes an I2C bus multiplexer that uses a single
+  memory-mapped register to route the I2C signals.
+
+  Whenever an access is made to a device on a child bus, the value
+  set in the relevant node's reg property is output to the register.
+
+  If an idle state is defined via the idle-state property, the
+  register is set to that value whenever no access is being made.
+  Otherwise the most recently used value is left programmed.
+
+allOf:
+  - $ref: /schemas/i2c/i2c-mux.yaml#
+
+properties:
+  compatible:
+    const: i2c-mux-reg
+
+  reg:
+    maxItems: 1
+    description: |
+      Offset and size of the register that selects the active child
+      bus, relative to the parent node's address space. The size
+      determines the access width and must be 1, 2, or 4 bytes. If
+      omitted, the platform device's own memory resource is used
+      instead.
+
+  i2c-parent:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle of the I2C bus that this multiplexer's master-side port
+      is connected to.
+
+  little-endian:
+    type: boolean
+    description: Register is accessed in little-endian byte order.
+
+  big-endian:
+    type: boolean
+    description: Register is accessed in big-endian byte order.
+
+  write-only:
+    type: boolean
+    description:
+      Register is write-only; the driver must not read back the
+      current selection.
+
+  idle-state:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Value to write to the register when no child bus is selected.
+
+  base-bus-num:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Base Linux i2c-adapter number for the child buses. Child N is
+      registered as bus (base-bus-num + reg). When unset, child
+      adapters are allocated dynamically by the i2c core.
+
+required:
+  - compatible
+  - i2c-parent
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c-mux@6028 {
+        compatible = "i2c-mux-reg";
+        reg = <0x6028 0x4>;
+        little-endian;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        i2c-parent = <&i2c1>;
+        base-bus-num = <16>;
+
+        i2c@0 {
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            clock-generator@70 {
+                compatible = "silabs,si5338";
+                reg = <0x70>;
+            };
+        };
+
+        i2c@1 {
+            reg = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            clock-generator@70 {
+                compatible = "silabs,si5338";
+                reg = <0x70>;
+            };
+        };
+    };
+...

-- 
2.54.0

