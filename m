Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD313D3D10;
	Mon, 11 May 2026 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516742; cv=none; b=D0W4Zh245mnhTsReG7JSzzFOt5t0IPaiG93CJfmhmqCM6Z7aJ1/wfYhnTS7z0RbZ7GY8yfyEjqtm562kxbT/0I4i9qYAwkFT8NcKTeS5mXCsnUF7P79LzSEWhxLE041JFl6WBTZm5SQkRYK9i6v+pj9qT94Hp4lP0wUF8FtmnHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516742; c=relaxed/simple;
	bh=6zVhcCmXAaRpPDMOMkSqrn7iVkJc6K80ulZiga1PAzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/y+x7cWiwiYRXEuCn0+uqV7P8sjXGp3La2gHFCkbM1CLRztkgtTaUqpp1h5kdNRAqvFNgYnFMg2gkhlLYNpHwxIjeTBGsZ33QmxdQX9DoB6LqzXQwv7GGSbttpk0As6pqinL3jRCjvonvYCs8bt/aC4BgMImacer8bExfvEE6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=lkY0+iY9; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="lkY0+iY9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1778516739; x=1779121539;
	i=markus.stockhausen@gmx.de;
	bh=5yJitR742OK+5j3KFoCDib2+9MoGOjRGcpRfh/YBKaY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lkY0+iY9nepvCE6Jge64LMsuYfJUiNo+NPcP8cd1sVMK+/af8/zOowQ0cTtDxKVv
	 0ZV+c7L3DLjOCxBeWfKz8klKiOitMHPvgxeBYFtD9DNTYEfNuU0xpw//5O3lnD1Qk
	 TVe7xOV1bTGINcKOrOH4JXVlas+gcgD6pH/sLZiMPL3JWLYtenTu76EwkyZ59J+CP
	 05ROp7u9PHYSM6wBPCoJs8Dxcv+EbE+/LvIL8Whtp3t7QJMwPuPVORhQU95zqpe4P
	 Eh/F1e9ivnrw4uYjRsPPppbWRmzJMHf2ZIMTmfWKSY0tHnAFM3OSTJAluAYOcUnmW
	 C2rjKVR1OeCNpxj57g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mk0Ne-1x6qte3Qoy-00cohG; Mon, 11
 May 2026 18:25:38 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: brgl@kernel.org,
	wsa+renesas@sang-engineering.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH v2 1/2] dt-bindings: i2c: Add i2c-shared-gpio
Date: Mon, 11 May 2026 18:25:27 +0200
Message-ID: <20260511162528.84508-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511162528.84508-1-markus.stockhausen@gmx.de>
References: <20260511162528.84508-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8FHSYY3et/dwiBrN7T0JiZT63A4WWnbuemE99lqUDMQpHpKUD6e
 0LK9L8ERW47nMZxoE0EDpsiPjxJ5ciuzh5uc/QpTmyp1f6zzHPyfChCl9R2rFNOuoEsjW/K
 JCvA6vVSefpQWvnoOtLFhpRyfKOUW1OvDQDSuoFC0e/iicWsc7HbMZO3JXYTrccDvOFhTWE
 EF/3GEq9c/ZASRQsYMs9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DYQGMWoORi0=;HLvSl8AfKcHb7uxLhaStyZtjqb6
 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
 DntoAQ==

Document the driver for bitbanged gpio I2C busses
with shared SCL lines.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 .../bindings/i2c/i2c-gpio-shared.yaml         | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-gpio-shared.=
yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-gpio-shared.yaml b/=
Documentation/devicetree/bindings/i2c/i2c-gpio-shared.yaml
new file mode 100644
index 000000000000..4a21638bd842
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-gpio-shared.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/i2c-gpio-shared.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Multiple GPIO bitbanged I2C buses with shared SCL
+
+maintainers:
+  - Markus Stockhausen <markus.stockhausen@gmx.de>
+
+description:
+  Bitbanging I2C bus driver that supports multiple independent I2C buses
+  sharing a single SCL line. Each child node represents one I2C bus with
+  its own SDA line. The index of each entry in the parent's sda-gpios
+  property must match the reg value of the corresponding child bus node.
+
+properties:
+  compatible:
+    const: i2c-gpio-shared
+
+  scl-gpios:
+    maxItems: 1
+    description:
+      GPIO used for the shared SCL signal. Must be configured as open-dra=
in.
+
+  sda-gpios:
+    minItems: 2
+    maxItems: 32
+    description:
+      GPIOs used for the SDA signals of the individual I2C buses. The ind=
ex
+      of the GPIO in this list corresponds to the 'reg' property of the
+      child bus nodes (e.g., the first GPIO is for the child with reg =3D=
 <0>).
+      Must be configured as open-drain.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+required:
+  - compatible
+  - scl-gpios
+  - sda-gpios
+  - "#address-cells"
+  - "#size-cells"
+
+patternProperties:
+  "^i2c@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/i2c/i2c-controller.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        items:
+          - minimum: 0
+            maximum: 31
+        description:
+          Index into the sda-gpios array used by this specific bus.
+
+      clock-frequency:
+        minimum: 1
+        maximum: 400000
+        default: 100000
+        description:
+          Desired I2C bus clock frequency in Hz.
+
+    required:
+      - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        compatible =3D "i2c-gpio-shared";
+        scl-gpios =3D <&gpio1 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+        sda-gpios =3D <&gpio1 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>,
+                    <&gpio1 7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        i2c@0 {
+            reg =3D <0>;
+            clock-frequency =3D <100000>;
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            eeprom@50 {
+                compatible =3D "atmel,24c02";
+                reg =3D <0x50>;
+            };
+        };
+
+        i2c@1 {
+            reg =3D <1>;
+            clock-frequency =3D <400000>;
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+        };
+    };
=2D-=20
2.54.0

