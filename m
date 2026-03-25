Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19C523EA89;
	Wed, 25 Mar 2026 01:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774401552; cv=none; b=rbJjIHd0/Yc6vj3NyCi5/6pYDP7bJA3CyO3GHCwy8zimbIFRG6WZw7+E5aC1E3lbmUa0lxTmI8mynrfEo0JEYUiKFa6L5kpv9UY43e7JlEfrr9p1XJnNb3aWRaQueuknhGKKcDW1bg789wjNanEr6arnI0sF30usKDL4z0rdkWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774401552; c=relaxed/simple;
	bh=0ce4h4raJMXdBDrwlxeI4i3hpaF6fdyWu1cKpZ7GTNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FREROpbNdsbcjWhmxyvmLPY6+g0oAx1bJ99hr4wnxvlePFlwIe76u/ofl7FF6Q6zL7E48xaZVzmC+EXo2s7Wii+C9hS/pMPR8CGu+PBwgj01lPm4F9OMB3LeZI4kRajy2Q0iHF8ewcuXjhXhd4svzeY4dOky5i4WssdG/g1w2ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8Cx48ALOMNpvmkeAA--.27688S3;
	Wed, 25 Mar 2026 09:19:07 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJBxLMIIOMNpi6xcAA--.44576S3;
	Wed, 25 Mar 2026 09:19:07 +0800 (CST)
From: Hongliang Wang <wanghongliang@loongson.cn>
To: Binbin Zhou <zhoubinbin@loongson.cn>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hongliang Wang <wanghongliang@loongson.cn>
Cc: linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH v1 1/2] dt-bindings: i2c: ls2x-i2c: Add clock- related properties
Date: Wed, 25 Mar 2026 09:18:51 +0800
Message-Id: <20260325011852.19079-2-wanghongliang@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260325011852.19079-1-wanghongliang@loongson.cn>
References: <20260325011852.19079-1-wanghongliang@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxLMIIOMNpi6xcAA--.44576S3
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw48ZrW3XrW7tF4DKFWUZFc_yoW8XrWrpa
	sIk3ZrGr409F17uw4Yg348Gr15XFn5Ars7Kr9rZF17KF43Zw40qFWakrn8u34UGrZ7Za9r
	WrZFka10kasrAwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI
	0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jebyAU
	UUUU=

From: wanghongliang <wanghongliang@loongson.cn>

Add clock-input and clock-div properties.

clock-input describes the input clock of i2c controller.
clock-div describes the clock divisor of the input clock
of i2c controller.

Prcescale = (clock-input * 10) / (clock-div * t->bus_freq_hz) - 1

Signed-off-by: wanghongliang <wanghongliang@loongson.cn>
---
 .../devicetree/bindings/i2c/loongson,ls2x-i2c.yaml  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml b/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
index 67882ec6e06a..4659d7012bce 100644
--- a/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
@@ -24,6 +24,16 @@ properties:
   interrupts:
     maxItems: 1
 
+  clock-input:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Describes the input clock of i2c controller in HZ.
+
+  clock-div:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Describes the divisor of the input clock of i2c controller.
+
 required:
   - compatible
   - reg
@@ -40,6 +50,9 @@ examples:
         reg = <0x1fe21000 0x8>;
         interrupt-parent = <&extioiic>;
         interrupts = <22 IRQ_TYPE_LEVEL_LOW>;
+        clock-frequency = <100000>;
+        clock-input = <100000000>;
+        clock-div = <40>;
         #address-cells = <1>;
         #size-cells = <0>;
 
-- 
2.47.2

