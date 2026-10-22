Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792661175;
	b=S87p2szblnD1rBBsnL0MWh5fZRGIYO7sPUgN6L/g0ye0cmu9O2+v1OIg/BEBq2lHDGs9
	 JdeGbREYD0kT7SfzGL3ks6lL1Dt8fc9Ub5hdUib0UhKcxIjao66waDPsy5/bjygesk637
	 QJlWrYGx6+esKrp7kvzcMTxMZT5GUm0iiuBnWP4gDUKZfvK+Op6st+dnhG0p88ubazsT0
	 Bf+ysxOVh36qa4qnLxbWLzITAvyTQutaKWI2VI94A0F8HsdZ/PDx4KVPRdvVwVPeTyhW9
	 nE+izu70DIBzluXtRbk9ng54zcldoWMCaGMKQIrkqEY2R5IOruyfAMVBZUfD18Pm8xQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661175;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wfbg6tsOH+5dCqR6eRG5y+pRRouozsxb6eB2ua5FAlU=;
	b=1tpDdh++jXEo10asRcQeSnMMQNUYPtBKmNDBzOI8jpLxLdWMLNVt5agNORW+o4Gr6uKq
	 kT/hJWVg1/ne/+jxsz8Twwv6DNFGb3tSWnYFURsCwsVyLoT0+J0lKseTLKT1hgngsvO9g
	 tWdYC3/g7Exmlrm6swYC5mKz/g3VklRZak9nOvOiYUHo8oTPnXTvW9GbreQ8FD83uV2it
	 nwwQhOsLJWr8oeq4oG17WJqF/z/WvdXgcfTJYNZjvBOcJqQfoUdCD2zkTVrs6yMixUpmf
	 tQFE7171iIL4d1M1ZIuk4hKs0wMKngsifSkC9oiI2NGLwhF7/Tix8BaJ5mlQnlixYXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WGkG1Xfn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F8A606A31A;
	Thu, 22 Oct 2026 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WGkG1Xfn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792661175;
	b=2x/A9+kHehPwnBWi5Bzz+UwX2G1UwxrSYpBGTtkdGYV+6ldVROFJgbMcGlO8ovFQN4hN
	 24sxusthLsnG0eodhzh5axnV/LUD/6CDGbv3DI+ZLbFoSWfij2GC1ZGjRxQWkknRm4gil
	 gf1wLxBsd9S9TKv7YWMIFXaP2/MuWxQARS8dsve9ePcNQ2v3UF9kyw9cItpsGgNGpUbNK
	 j2r8/9dysC6/DGL7hqX0GSYFJ0bEEB/qmb0rZ8rjk7CsxgmCgIx45c4t351BDdnE8fgBI
	 PkXrvOR5uabUei3OGueXMZHkEwCJ5taYMRngYthsdhOvBhHvOwhzCEBKHke8eQCD1nQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792661175;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wfbg6tsOH+5dCqR6eRG5y+pRRouozsxb6eB2ua5FAlU=;
	b=c2E6ShFWfCSkJizJ8e7woHywVF0tlS12C35j0JFXUGyA9MlGFDmBNg2xPm6RExGMQLhn
	 HyGncRfHp/GOczJA1elhD1qXtJdi0EukVVzL0nxtUv3xjeTNfHQVWhbnLe3yh9fe8y0no
	 TIqdWMI9G7UkNeH9/1p+5ZTbCfF4vMLEoL2mqvVyuoGysGFTdGBW1j8EG34dWizng22jH
	 KvsG72bxnROeAaDAOD2SH+C3F0M4/bn0BFhERfqXtpVxqu68/N4lAR7Erd4MNodZYQIOF
	 BEkJxAN3ozheALihk4Oc/7El1rQXdPTYlH5LpentvP6zpNLHVpp1pS65kGRGy5X4okQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5A1ED1F000C3;
	Thu, 22 Oct 2026 09:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792661175;
	bh=wfbg6tsOH+5dCqR6eRG5y+pRRouozsxb6eB2ua5FAlU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WGkG1XfnsHj41WZbddQd7Yzx08OpDlMTBDeUidC48mkGhxcCD1vuXagyCC2JoRdjp
	 THU6dkWbXr6bn6jtMwhz9vq9/ynQx32cWKXQPbE7N+qYmTElJujcDntIJwDZBuX82x
	 jPadxivL91niOYUp2zXBesn3FT6qaxBF9F0/+RzMoaBSk2v8gxwaK27X0nJ61u/4ph
	 i9+/WqqKA/7TRnmitfLPnUWerJ1lbci5uYE/YtqYJDlBagd8qlr7dKHkt3s04k39rw
	 EDs+PJ8cdYQ2uKY0v4wGidSjFhWY53QI/hl8o17f32aTCMg05xDGp8ND7M4QGav+Fk
	 ZnZLkpAY8VDtA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B7C5A4352F;
	Thu, 22 Oct 2026 09:26:13 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 22 Oct 2026 09:26:09 +0000
Subject: [PATCH v2 1/2] dt-bindings: i2c: add Amlogic A9 I2C controller
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
Message-Id: <20261022-a9-i2c-v2-1-45e3cef175bf@amlogic.com>
References: <20261022-a9-i2c-v2-0-45e3cef175bf@amlogic.com>
In-Reply-To: <20261022-a9-i2c-v2-0-45e3cef175bf@amlogic.com>
To: Junyi Zhao <junyi.zhao@amlogic.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Xianwei Zhao <xianwei.zhaol@amlogic.com>
Cc: Junyi Zhao <junyi.zhaol@amlogic.com>, linux-i2c@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792661171; l=1719;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=/oijmKmiPfKgJUJzYs/dQncbUdJ0Rw2jHh3oFq2y0wk=;
 b=ebjO1TsqDS8xEYXSCiVbo1r6Pb2VkTgwhQv6vwAVaGTVcTXnFLAAR9xv9KN/So9DlyDpV/Iju
 2GZaupdC4iVC3Z1LSXZXqy5VuailzKhgqEtrrG1sfWE0evHimY0gT8A
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com
Content-Transfer-Encoding: 7bit

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add a Device Tree binding for the I2C controller found on the
Amlogic A9 SoC.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../devicetree/bindings/i2c/amlogic,a9-i2c.yaml    | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/amlogic,a9-i2c.yaml b/Documentation/devicetree/bindings/i2c/amlogic,a9-i2c.yaml
new file mode 100644
index 000000000000..31ddc6d23732
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/amlogic,a9-i2c.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/amlogic,a9-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic A9 I2C Controller
+
+maintainers:
+  - Xianwei Zhao <xianwei.zhao@amlogic.com>
+  - Junyi Zhao <junyi.zhao@amlogic.com>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    const: amlogic,a9-i2c
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  dmas:
+    items:
+      - description: DMA controller phandle and request line for RX
+      - description: DMA controller phandle and request line for TX
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c@3a4400 {
+        compatible = "amlogic,a9-i2c";
+        reg = <0x3a4400 0x3c>;
+        interrupts = <0 164 1>;
+        clocks = <&clkc_periphs 11>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };

-- 
2.52.0


