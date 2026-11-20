Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795149138;
	b=pB1f4l8MMVVH/XDAoNlOTI+xiPdSM/HMzGtGKUg7bjfoC8cUCdctDNg/FCVbN698Yvge
	 AMX8Eca7DS6KrwswyKG5CcEH3Wokv/PkYGxKgOoLz3cTPPTARwrOPVeMO8mlpBqPplcfr
	 UUtnyxk2VmJ1yQdZK0yXHI0EV7AE0iO4efAoqBRP1+KgigkCdbXNXOCZP3HVuvhwerc1x
	 IL2TWEKgkCTywuOcHk0+JYT484sUU1zRi0WEhb3bNbbQ/qZIbykahnwMlRgDVC56u1q6S
	 PkduSxSVwWgdwBIq4E/X+2pSdiCEpuJPKfsYDwFtFmu1HsdQt2nRAxMcikjfgvD48wg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795149138;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YE+Nn6B8jHC2P8KjP0E3LMlH+kb23vUfciBlAjFL0Kw=;
	b=clwTX7jVzxncKIflVT7yaCDsLd4P+e3sOi4ilVJs6r3G/Z+1vIWUJrnrStwXOQZxXGlf
	 cZpvoF3DiFYQ7ghudZytFyzmhNP3Gv4Py7mg7qXfu04kVXYckbRbfE4z3L8JjO9ZIejI3
	 FEEX3Jz4Rj4GEBOBJZCFuHDd0+BbjlobbadtzGEvKSi68M77DoWlxp7MWTJQyPq3WhtBq
	 u3CVCpAYQOXwwE/QA2FzIC5f+QZJwYAHAKl/jRA5eZyxl82ssKgkReUbhfm0cTM7NL3Ww
	 s518X12wMZdNs3JZ6T+UrBhFnlFlS0EdXJQN0Zz16qh1fQlwCdkJNLcoxTq+grz73rg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UWH2/RMI";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D32606A326;
	Fri, 20 Nov 2026 04:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWH2/RMI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795149138;
	b=tSQjTna/ncm+li2rKNJcyg47SpXRNIq0px+ZCfhl4AabQS7i3VY3t25ukdfzxmrINyx9
	 b/JE9SbGjJn4xSFZH+QtBbJ6zy/Pglv8i0jsAj6gNz+qQG7SENZocMvQOj+MWQ1/WKClx
	 cVvyrw3Zhv79b+peWSMIzJA2i+8SZZCRapeoUXtSG/o1bnXSSWGc9sM8g6rDGnQ1y/Xix
	 lsOvXUMMT0tgoAjDTOfCoYENiDjWlomszn0EwBCMpzTxQeS/cJK+ulTJFOhNYYt6xaJc2
	 mfMC3BPTY5k1IVPd4tv5fIPk/YmXeiVvLZLL561SRi5WpHg9u2YBjphmlINtNKb6Bgg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795149138;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YE+Nn6B8jHC2P8KjP0E3LMlH+kb23vUfciBlAjFL0Kw=;
	b=ae8cOjCYddETXDn8edeKa60W0NL7b0OqS+7tACPOU1bgSDNnYda3nYsJwaq3wmb41lij
	 MJFWBQ5TZndFyhh960Xz+a+XHzZEYcGOT8Pu89lHbMe+1f430DtXjEP3tCeUrqp1zCtPA
	 nCo79i6rrNIiIgUOg/6ViBF+rbi8r/mcs9NqnkCdMtJ1FwXVw4+RuOoTk2lrQxxbs9d4f
	 qbPyIlpntHiOdPaHS2xB+nCIqLUaX65xtNG9/YHZwFTQW+RtpRRHZEJM2gHXR+eHVai3m
	 VgzmjTzADDbIZmo8lgfOmdsImPAekC2+080jC+C+/1MiQbHXXb73wOjX+pRJXKaSryA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A8A0F1F000D0;
	Fri, 20 Nov 2026 04:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795149138;
	bh=YE+Nn6B8jHC2P8KjP0E3LMlH+kb23vUfciBlAjFL0Kw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=UWH2/RMIO974qmV3aab76MNZPgvT2QEOI0s/zYA1LNTVCFJNTKgAsvVZnKGw4QLkj
	 A+nMZPjPHexkIO9csAG2WnoYaiBLfQP7Z5OJgG3IGGpGdw0o6H+3InTRaPS9cpAHS0
	 yIxI6YIshWaapUiK0etaan9+E81emIrnH/wdccKTUq3h+V181CFgoJkDNm3qlkL5cK
	 CCqQY1cddMAGz1ATZaV+cDQZuSGaVymzO0dCoI04qzqJdA9YnG+/id/xhwOS4CN+Zh
	 ncyBDaVKxZp6AegNNy3EzoonWOdSMmtzffopUDnM6ew1h/0a8UnM0zdD+hKMVhHfXg
	 7iSDwmunrQj1A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3A139495AB;
	Fri, 20 Nov 2026 04:32:17 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 20 Nov 2026 04:32:17 +0000
Subject: [PATCH v2 1/2] dt-bindings: i2c: Add the slave EEPROM backend
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-i2c-slave-eeprom-of-match-v2-1-0444790a0b76@gmail.com>
References: <20261120-i2c-slave-eeprom-of-match-v2-0-0444790a0b76@gmail.com>
In-Reply-To: <20261120-i2c-slave-eeprom-of-match-v2-0-0444790a0b76@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 =?utf-8?q?Bj=C3=B6rn_Ard=C3=B6?= <bjorn.ardo@axis.com>, 
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795149136; l=2337;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=7TThpKM3y4oAcfYvPrtWKqq71G20/x2Yu5tN6fE5i94=;
 b=SXO3Q2HU0xgiVbOLTq31+B7KOpMHsyp0zTrka1rKDGNntY27IxHKG0Ng+T2sJKPOe56EB925y
 a9JPwhasTMDBqYFNrgUJLNc7FvbmEnrKRHFuIwporo61oD+n0e0deJv
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

A node with one of the i2c-slave-eeprom names as compatible and
I2C_OWN_SLAVE_ADDRESS in reg already binds to the backend, because the
I2C core names the client after the compatible and matches the I2C id.
The driver also reads firmware-name. None of this is documented.

Document the names without a vendor prefix, as the driver and
Documentation/i2c spell them (ipmb-dev and mctp-i2c-controller are
unprefixed too).

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 .../devicetree/bindings/i2c/slave-eeprom.yaml      | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/slave-eeprom.yaml b/Documentation/devicetree/bindings/i2c/slave-eeprom.yaml
new file mode 100644
index 000000000000..b7a6e6653a64
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/slave-eeprom.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/slave-eeprom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: I2C target EEPROM backend
+
+maintainers:
+  - Arun Iyengar <aiyengar1990@gmail.com>
+
+description:
+  The I2C controller answers on its own address as a target and behaves
+  like a 24Cxx EEPROM towards the other controllers on the bus. The
+  compatible selects the EEPROM type that is simulated. The "ro" variants
+  ignore writes from the bus.
+
+properties:
+  compatible:
+    enum:
+      - slave-24c02
+      - slave-24c02ro
+      - slave-24c32
+      - slave-24c32ro
+      - slave-24c64
+      - slave-24c64ro
+      - slave-24c512
+      - slave-24c512ro
+
+  reg:
+    maxItems: 1
+    description:
+      Own address of the controller on the bus. The I2C_OWN_SLAVE_ADDRESS
+      flag must be set.
+
+  firmware-name:
+    maxItems: 1
+    description:
+      File with the initial content. Without it all bytes start as 0xff.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/i2c/i2c.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        eeprom@64 {
+            compatible = "slave-24c02";
+            reg = <(0x64 | I2C_OWN_SLAVE_ADDRESS)>;
+        };
+    };

-- 
2.55.0


