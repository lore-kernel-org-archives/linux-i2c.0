Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30173139D;
	Tue, 27 Jan 2026 02:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769482104; cv=none; b=fR23QW69w5YNzGaqrTZs3MZLiI7maOpdQsvMkxPPl0e0QX7Lp5qNSHg5TWUJMIU9qA2HSKVPxB/4Yg6VtiSkHS8dHi+vdwFzn8vPNnlgK4Tx5zeXI9SxZ40nH8jqyrEwckiY6utAl8ZR/8EAgSfgtGrIkKCR1hDAgan1/SkuZ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769482104; c=relaxed/simple;
	bh=4yQQFdO+BmzOQwKmp//pjMtarcuNliXPQ5tUWpcZNXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujwZWc6/x2f2FEtp9iQ1IS0S4Tswc5ekuPbB2yPauKD6i0FqxGOre4gtq/IN9bM+kcazK+1h4YO70vXiQmracJ7S5YWVrzcFRh4k5LFzGk/tsFohQO7iDQLTKiRUiiymIdVvMSEV2+RST7w3P8xhosOwh46SDj9TlxW4N4F48/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.42])
	by gateway (Coremail) with SMTP id _____8BxmsJtJ3hpbPsMAA--.42383S3;
	Tue, 27 Jan 2026 10:48:13 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.42])
	by front1 (Coremail) with SMTP id qMiowJCxWeBnJ3hpPJEzAA--.36583S3;
	Tue, 27 Jan 2026 10:48:12 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-i2c@vger.kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: i2c: loongson,ls2x: Add ls2k0300-i2c compatible
Date: Tue, 27 Jan 2026 10:47:56 +0800
Message-ID: <8ba86d2daf43527ee41795b86ea0411a3ea19b2f.1769476820.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1769476820.git.zhoubinbin@loongson.cn>
References: <cover.1769476820.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxWeBnJ3hpPJEzAA--.36583S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEACGl3Ah0TuAAAsh
X-Coremail-Antispam: 1Uk129KBj93XoWrtFWkCrW3Gr48uF1xXr18Zwc_yoW8JrWrpF
	nxC3s8Gr10qF13W398ta48Cw1Yvr9Yy3ZrGFs7tr17KF4DJw4UXw13Krn8Xw45uryvvFW3
	XrZ7Kr4UCas7ZrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4ZqXDUUUU

Add "loongson,ls2k0300-i2c" dedicated compatible for representing I2C of
Loongson-2K0300 chip, because its HW integration is quiet different from
others.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 .../bindings/i2c/loongson,ls2x-i2c.yaml           | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml b/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
index 67882ec6e06a..4c381559f7f0 100644
--- a/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     enum:
       - loongson,ls2k-i2c
+      - loongson,ls2k0300-i2c
       - loongson,ls7a-i2c
 
   reg:
@@ -24,6 +25,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -31,6 +35,17 @@ required:
 
 unevaluatedProperties: false
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - loongson,ls2k0300-i2c
+
+then:
+  required:
+    - clocks
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
-- 
2.47.3

