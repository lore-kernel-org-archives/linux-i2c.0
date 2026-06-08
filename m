Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7593636CDFE
	for <linux-i2c@vger.kernel.org>; Mon,  8 Jun 2026 19:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780946283; cv=none; b=HwffP/47yADJFTEbJ5eiwschMxRY8jsrO4KoIyB7mOO/jNtS6H85vL5MKD/vKrWCWdai9nH1n3hgmnIEJmuQWlGhIHGgVC21i4F4fsdSuxmLXw1TgYmyWgnr5txf4ux2nUzRYya7emf1xpuaVxUELcHqzZanHdg52ppZQDIrPGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780946283; c=relaxed/simple;
	bh=j50omREjNPnkIZ2Q/S1IZiVP0CjCo0xozY68eQEpOZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p2bgB8XsPf8equmnbG06JdcO8SezYYsIje+4ywZm6OtixjOD/WXBhLNUGOMwhgBkLHFxelAsqemMx2Q/0B+f50P9i6ypkzOij9eomzLo1Iyep9mpStWvx09Vp6DO2WNuBt6fdgaZiqmXJOBrf/Vi7ssxV5A2RPDjkkyNo4XP+1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=VO5+a/X/; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="VO5+a/X/"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-137335bc3caso5737731c88.0
        for <linux-i2c@vger.kernel.org>; Mon, 08 Jun 2026 12:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1780946281; x=1781551081; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2SpBt+3akFBCUF5Ott3wYRAj9ArzdqAatXrQaEYGn4U=;
        b=VO5+a/X/hD04380qkcdBUp4cGA5iX4tBZcCqqFR9DfF4MhfCyCBAfXTRNwxsOVx6O5
         tIc7wQFHFNORGQmWHYi8gCmi8o/TnW4EaBwTq5DroSlTK+a4YW1pTCcDaST/xfoxVv5W
         A+RVIbQt5CS4B5oAGQvF9n1YLAfP8tLEv1fMOAx/z8gqnWnqpuLB/D898jrRGlqfoUu4
         VQKML6rYbGgt3gFtqpd7HUGGPG6t+dxKRinU85WAV57Z+53oZBFviICK8o7D4JNR59g5
         VlMWhpYMrTe9NHNKcABrAebXaYYe5UGYdRXxanw1jtJ/Of2/O5nNTHxAxp7jVDMrd2jB
         sUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780946281; x=1781551081;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SpBt+3akFBCUF5Ott3wYRAj9ArzdqAatXrQaEYGn4U=;
        b=Qj2YTn6kTHx7C264YtiPBD2ETlBBFOAxjyizJpqMa3OYRmxbv/QpqB0RWbgXyxzeTV
         hrQyzvEzcj96/XovWIagXUi9RXcFixCThxQYOnC8VlV2kjdHU10Lu9VIyQHmQ18rjIr1
         IetD0aMzGFiw+RsfZxAplsH99UhysWtSPLBuiGsqaLBb+mvut4PS6nKho3vIpwWuRNFF
         Tc6q8ZYKm9CEVYWjb5/WI+n3FU5y4Su5D4JwgdQx0yhrPvLnWEprrae+xWWOYsiQi4qw
         bPjgj8LPnqybi8va4nXjzwFMmsVlnbwXzwpyAPr+0muxbKdKMdtHcz7F7E7rFPt7ygBw
         EYNw==
X-Gm-Message-State: AOJu0Yzl1YLN3g0bigJb2mqQmaRaNOJw8d3lqJ+oniXFY+97h/LnJQYO
	XLhITJfs0RqCpgaCFOPHNzt8uyLAQ5AheGm31Dzl9ofXuLXNyzzWtnlXiNDbVJKMms4=
X-Gm-Gg: Acq92OFM6egTsCj9Q9ixLEs7qtOx246UBWB0EXmtQi4cX5cmUzzpYJ9YDLGMeXtoyTN
	DcfOG24puzluSVAwWyq3rjYTK1Dc4uMeIWs7yriBh61QrgwenYtg08DZQSMquveAZ7IwE74QhVM
	e0ISJEsITubi2lDlG6cxuOOA+73oJfy1eSxie8mcy9z/szO7e6RNahwnJ2pcn0eRYWOlE0We+bT
	Lo7PY7CT7qnGsdd8y80nsyEpleE7KYjN7+0WrcmWI2DSQ+o4A2SCD3AWdOpZstZOi0G2e336R7R
	0i1FyB8pe4LYR+tFEkZf1cAUck71Foogpp1HVFV1qacDv9JMlTZWqrqgeJ2UOB4fighpAlZyRk+
	MukC6AO8+BiFgNvUzrXmstDL4RI+/jiyJI+Q1OHvWhdXrW2pviScZFWDuybsGW6Ek1C7IqjHdZc
	FQqqtg2npLyBeb78mCR4moKodZ8VvXIzPs8s4n
X-Received: by 2002:a05:693c:2d82:b0:2d9:f0b3:1d98 with SMTP id 5a478bee46e88-3077b25d0c5mr8589540eec.7.1780946281278;
        Mon, 08 Jun 2026 12:18:01 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db528dcsm21588602eec.3.2026.06.08.12.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 12:18:00 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Mon, 08 Jun 2026 12:17:39 -0700
Subject: [PATCH v2] dt-bindings: i2c: convert i2c-mux-reg to DT schema
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-i2c-mux-reg-base-bus-num-v2-1-776e313f213a@nexthop.ai>
X-B4-Tracking: v=1; b=H4sIAFIVJ2oC/42NTQqDMBBGryKz7pQY8a+r3qO4SOKoUzBKYsQi3
 r3GXqDLB+973w6eHJOHR7KDo5U9T/YEeUvADMr2hNyeDFLIQhSiRJYGx7Chox618oQ6eLRhxDK
 rKG91SXVt4JzPjjrervSr+bEP+k1mib1oDOyXyX2u7zWN3h83a4oCu7TOdK6qjlrztLQtwzTfF
 UNzHMcXpRIUF9MAAAA=
X-Change-ID: 20260607-i2c-mux-reg-base-bus-num-738e5db7e99c
To: Peter Rosin <peda@lysator.liu.se>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780946280; l=7015;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=j50omREjNPnkIZ2Q/S1IZiVP0CjCo0xozY68eQEpOZ8=;
 b=A6RZ522Dk4OYtp+A+tOPkBRwynLuRbuPcBT0xPmi5dR+6dfJqz7UhVzqayJNzEB473JC5UYEF
 57RoHu5KQZLAzR947KxfjZbFMigRGIy210apDzdoNi5a8G79V9+fgbX
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

Convert Documentation/devicetree/bindings/i2c/i2c-mux-reg.txt to
the YAML schema so the i2c-mux-reg binding is validated by
dt_binding_check.  Faithful port of the existing properties; no
semantic change.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
Changes in v2:
- Drop the new "base-bus-num" property and the matching driver
  patch.  The motivating use case (stable Linux bus numbers for
  DT i2c-mux children) is already covered by the i2c-core's
  of_alias_get_id() lookup; an aliases { i2cN = &mux_child; };
  entry in the platform DTS pins the same numbers without any
  new binding.  Thanks Conor for the hint.
- Drop the silabs,si5338 chip from the example, which has no
  schema and tripped dt_binding_check on v1.  The mux structure
  is the point of the example anyway.
- Link to v1: https://patch.msgid.link/20260607-i2c-mux-reg-base-bus-num-v1-0-f193b5a8fedc@nexthop.ai
---
 .../devicetree/bindings/i2c/i2c-mux-reg.txt        | 74 -----------------
 .../devicetree/bindings/i2c/i2c-mux-reg.yaml       | 92 ++++++++++++++++++++++
 2 files changed, 92 insertions(+), 74 deletions(-)

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
index 000000000000..01ade0771c60
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-reg.yaml
@@ -0,0 +1,92 @@
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
+
+        i2c@0 {
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+        };
+
+        i2c@1 {
+            reg = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+        };
+    };
+...

---
base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
change-id: 20260607-i2c-mux-reg-base-bus-num-738e5db7e99c

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>

