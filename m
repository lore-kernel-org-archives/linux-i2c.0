Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BCF33F8C1;
	Wed, 28 Jan 2026 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603148; cv=none; b=QuruPX339dCFXrXdeqi8uIxcp6Yb5pBk7549TOnDMIcWZDT7638QQGQqYH8mZGKQaaq95kflhN7PXjW89CaZsua71ETMVNWq7S/smGsOJEn7a4s8mGUQOm+Nw1ASixcydkrTxYRr8i1QLopE9O2zxYUh/qbXSVWFh5r9PxoI1S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603148; c=relaxed/simple;
	bh=I6SFiFiNnzvjnHZJQs1yZdEPLEEph5L365SmIUtly8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KJuphQL11VUVwQ/KfEbcgTInSyHzzbRPv7MvxrCGLTKsFvRQEs2il5y7rzyua6KBYp7z/BrXtXd6vAo7R+SamxEc7qilkPOTN72op05OSl64Ixew8/DP1R/T3PpXsFUIdG1OO4x7XCHmmtwXrL4vKA9/bE0kgoPh6jTfoS3uQrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OU2o3bBx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OU2o3bBx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5FABC16AAE;
	Wed, 28 Jan 2026 12:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769603147;
	bh=I6SFiFiNnzvjnHZJQs1yZdEPLEEph5L365SmIUtly8I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OU2o3bBxSM5A1rMHXtUw9xEqtmgkmj6cXbmCxGqS6X0EtidnKkPBYjT6krRGOojqI
	 mpDR7Kd6Uh2BjIfIV8dXhTyZwRJxiyT5fEidmjHEKf7HlSB48E5zsoY2NyfxyQ4012
	 Wjao+LvJjsDC9V3ZEpb7vW/N+IEr7WfSMbUYHvLY/boEqcGMKSx6JKOR1O7DwUBoOB
	 UkiOFBtB1zzKqmtiQqMpls34ECv54pQxXHdPvHDyJuZkU78hTswdVlp6rtSrFjkdhN
	 sk6h2XK0zdTlVh+ZlQqmDGITUOuFUMgBLS7YZjM3UEJasM2x/8/5ns/56fK6QJuv7F
	 EriuEYMdCmx6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A886ED25B4C;
	Wed, 28 Jan 2026 12:25:47 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Date: Wed, 28 Jan 2026 20:25:44 +0800
Subject: [PATCH v3 1/4] dt-bindings: i2c: add support for AE350 I2C
 controller
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-atciic100-v3-1-8c002fcc2bb4@andestech.com>
References: <20260128-atciic100-v3-0-8c002fcc2bb4@andestech.com>
In-Reply-To: <20260128-atciic100-v3-0-8c002fcc2bb4@andestech.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Ben Zong-You Xie <ben717@andestech.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769603146; l=2094;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=NMbc3VIfpHJETsANLk21QTpskUGQ9uYRp5oUEqlzxCU=;
 b=5BwaIZCAGLFCyGw3oyx8lje/xt4KUylEHsKwfH29eFwHiK8DsNZLbEUPtNEOvRXUFkgOlQEUP
 cPrJK8pSVBNCXgEwlVdGvD0GBSAuyrI39JRoINgSgovvIEbyrAEo22t
X-Developer-Key: i=ben717@andestech.com; a=ed25519;
 pk=nb8L7zQKGJpYk0yvrYKjViOZ34A36g1ZIsCmCsP518s=
X-Endpoint-Received: by B4 Relay for ben717@andestech.com/20260120 with
 auth_id=610
X-Original-From: Ben Zong-You Xie <ben717@andestech.com>
Reply-To: ben717@andestech.com

From: Ben Zong-You Xie <ben717@andestech.com>

Document device tree bindings for the I2C controller on Andes AE350
platform.

The ATCIIC100 is a dedicated I2C controller IP developed by
Andes Technology. This IP block is a core component of the Andes
AE350 platform, which serves as a reference architecture for SoC
designs. The QiLai SoC also integrates this I2C controller.

The binding introduces the following compatible strings:
- "andestech,qilai-i2c": For the implementation integrated into the
  Andes QiLai SoC.
- "andestech,ae350-i2c": As a fallback compatible string representing
  the base IP design used across the AE350 platform architecture.

Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
 .../bindings/i2c/andestech,ae350-i2c.yaml          | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/andestech,ae350-i2c.yaml b/Documentation/devicetree/bindings/i2c/andestech,ae350-i2c.yaml
new file mode 100644
index 000000000000..59a521fb249b
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/andestech,ae350-i2c.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/andestech,ae350-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Andes I2C controller on AE350 platform
+
+maintainers:
+  - Ben Zong-You Xie <ben717@andestech.com>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - andestech,qilai-i2c
+          - const: andestech,ae350-i2c
+      - const: andestech,ae350-i2c
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c@f0a00000 {
+        compatible = "andestech,ae350-i2c";
+        reg = <0xf0a00000 0x100000>;
+        interrupts = <6 IRQ_TYPE_LEVEL_HIGH>;
+    };

-- 
2.34.1


