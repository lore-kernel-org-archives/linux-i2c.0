Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D2326942;
	Thu,  7 May 2026 18:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778177845; cv=none; b=ALTQy1iQf0LtDwvoKhrRbM+tRPnePFsEP2vfWhJyM7anBzAf8HtlsM6holCYZKun36ttDIQScef7Y8bNYEZYEHvT54NV7b1+ueAaL1d3uFdlGaeqyBU+ODBCXLGdgV8O4rjKleTVVHftibSt1ImVh5x81Yh/TO4tbEjUeDuUGNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778177845; c=relaxed/simple;
	bh=W0N01yi8be5fwAeE5sd5zA7qxNMhj2cF/hjGAlnlSFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrZI3vvGq2DUtQNkwJ+nHLt9yHHnhqRYbYVlziVu5tTyUkT5Au8L9rdFPX4yzM0douoYJV6UDOQsQ5GSnObLcxEGm56iIxwZHwuywlgh75UFFder98ua/f7SwiEOapWMM0Tk2p0CduYM9e4IM0kW/hmIyUdRn5QfgJK7pw5Z558=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=PJxNh/bP; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="PJxNh/bP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1778177841; x=1778782641;
	i=markus.stockhausen@gmx.de;
	bh=a9XZMS6GvP7V/Kz5PgYwmDlJpUNwJ6QkRHrHueiddRo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PJxNh/bP5UqKEVvGMWMqXP2oK1Z5NhxNbO61mnF+3XVhQswx0pfFwo2o5eAc9Zkl
	 q+ZduQym64O2yxlmKoduP1+i5VQqnErcQ0bfotL3S/Hnsh7/7wQj8gv8WwlEEyewk
	 bS7N6DQsaMFJtQc8J6Lipp1kZ+R+xqOfx01hw43v+KIPYkEWXnLVydms+mA+g7MLR
	 O5kgWccx4QDZT3jLc5vxnNH3xqRfJr/jZubuCRS7Rpwg3r7sasmDwJf7jLfSYYL20
	 KDWeHO62S57ErEfrIpju/Vi9r4DwYHIm1bl/6FATl9emIzrceZqgjPicPY4JSJ/Ln
	 I3HlebTEUgJmmLDxww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAfUo-1wA5zF2IjA-002NTB; Thu, 07
 May 2026 20:17:21 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH 1/2] dt-bindings: i2c: Add i2c-shared-gpio
Date: Thu,  7 May 2026 20:17:10 +0200
Message-ID: <20260507181711.2696783-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507181711.2696783-1-markus.stockhausen@gmx.de>
References: <20260507181711.2696783-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qpsFQ9vJhnnaW5xvEHiYW92BHD4vD9xW2z8jZV/zxCBR4V1fMGH
 /ufE7vYrBRt+hN3RFVpocN+dD+Fb/I6iLpAA56fxEFiDEzEEK3ld2KXM1e5T22WjpjAFcFS
 7AlxqmNczajSyAv1lxAFnCjlQvYR5UmasDJyRxGgV53Uw1IHbP5Ex4D7n6NtLyv0LXpV0qP
 s4ai9gjH68iGJ5G5VmY3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E9zDVTVNgzE=;eGnOTgvfxIo4ck2DtYoc/ZlbLj7
 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
 AQauJA==

Document the driver for bitbanged gpio I2C busses
with shared SCL lines.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 .../bindings/i2c/i2c-gpio-shared.yaml         | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-gpio-shared.=
yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-gpio-shared.yaml b/=
Documentation/devicetree/bindings/i2c/i2c-gpio-shared.yaml
new file mode 100644
index 000000000000..7db344821e2f
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-gpio-shared.yaml
@@ -0,0 +1,115 @@
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
+  its own SDA line. The shared SCL line is driven by the parent node.
+  A mutex serializes access so that only one bus transfers at a time.
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: i2c-gpio-shared
+  required:
+    - compatible
+
+properties:
+  compatible:
+    const: i2c-gpio-shared
+
+  scl-gpios:
+    maxItems: 1
+    description:
+      GPIO used for the shared SCL signal. Must be configured as
+      open-drain. All child buses share this single clock line.
+
+  i2c-gpio-shared,scl-output-only:
+    type: boolean
+    description:
+      If present, SCL is treated as output only and clock stretching
+      by devices is not supported.
+
+  i2c-gpio-shared,timeout-ms:
+    description:
+      Bus timeout in milliseconds. If not specified, defaults to 100 ms.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^i2c@[0-9a-f]+$":
+    $ref: /schemas/i2c/i2c-controller.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        maxItems: 1
+        description:
+          Bus index used to identify this child bus. Must be unique among
+          siblings and match the node unit address.
+
+      sda-gpios:
+        maxItems: 1
+        description:
+          GPIO used for the SDA signal of this I2C bus. Must be
+          configured as open-drain.
+
+      i2c-gpio-shared,delay-us:
+        default: 5
+        description:
+          Delay in microseconds between signal transitions for this bus.
+          Controls the I2C clock frequency. Defaults to 5 us (~100 kHz).
+
+      i2c-gpio-shared,sda-output-only:
+        type: boolean
+        description:
+          If present, SDA is treated as output only. No acknowledgment
+          or read data from devices can be received on this bus.
+
+    required:
+      - reg
+      - sda-gpios
+
+required:
+  - compatible
+  - scl-gpios
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c-gpio-shared {
+        compatible =3D "i2c-gpio-shared";
+        scl-gpios =3D <&gpio1 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        i2c@0 {
+            reg =3D <0>;
+            sda-gpios =3D <&gpio1 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>=
;
+            i2c-gpio-shared,delay-us =3D <2>;
+        };
+
+        i2c@1 {
+            reg =3D <1>;
+            sda-gpios =3D <&gpio1 7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>=
;
+            i2c-gpio-shared,delay-us =3D <2>;
+        };
+    };
=2D-=20
2.54.0

