Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009593;
	b=wo/x5qaz59tg8cHRQKd3EGsellTMI6PNEI8TKMWihQrkUQ4fxnshBIeXdQ54RCsD+TLO
	 6JqHxq5ACeVkBGAv53sAP73tsMibchLyEQU1TqEXpgjKIgLpgwTHttISbNEiLLZe5F1qU
	 JXz94xBBvCLBfTOBbh2VNgLmRRg8cnkDmnU0t1Mdd/jN8Tg/A+lQEkeUbgOOY0LwONwZH
	 hlwfuB3pxGhBrTTJNpGm5qHIsCkLSbzJkcE0UBpYx9lzaeEg4cr28eaBgpTx2iZMHg2nT
	 bgASPvSGAomfArwZLTHw6rSr69dvhDM4CS41ZE1g2w2zeJXY87BcMCT0zROl44NVpUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=JxCBlWe9xidf5BljIoViI2yy2fuy4UwH/MuESKWLU9M=;
	b=bCGZkfMzdvm9jlv8XuOfJRo17BA+i3RutzjRfAShh/VUkxgWMxO3XMXy0gZ7VohaZM1l
	 ztHI2ol560Q9oYTG8mqSFSb+cZLW+Uvot24Y1wDKqMwYbaWhVXKTPD6wtvIAwjPDkW2TS
	 tV5U4KjwEG1rahKhvE83xrEJOMWYPeKodhejrEXwjmRbf2BNpzkYo2CEUbVAsR24kGrV7
	 KS+LrX68v8DwrZD20mjd6zF5uiuMv8L6ykn7YiqVU2AMIqgcxBUS7617qQtSA63R6ysyg
	 i17ju3F0ZHF1Y6SVzDXugfb4T0B6EiMWV1p3wOSdStRjrp8gGbc1sHYgPwEEXHQB1cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="CI3T//Am";
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CEC606A33E
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 13:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9CEC606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CI3T//Am
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4d28f75d62so155029066b.0
        for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 05:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795009591; x=1795614391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JxCBlWe9xidf5BljIoViI2yy2fuy4UwH/MuESKWLU9M=;
        b=CI3T//AmB4WgxqmDLK9GofxG/Bymhupg2aUet9eCacSlxYrNgnwA37/u0VMT3FY8qZ
         u+AWDjn3gxLMDWCmuFKzKVxFOhm2K53C1Uzz4XoQ3HsPzNdvX9do+DWmoQ/F4W49APX4
         CYrg01bmy/hHY448naEYetdYQ3lTB9PZxcwDofbxZnj6HXGI4uEL9H2PguSqPZjR5+Gp
         IJ4cpdvM85isaIERTBArshTyzXpGxN46ZPlFNUigJceRK6Wdm6N+QE6P10GQVZMeF83/
         ZKYjMKH39oQwKAJ99GhWgrQ+D2wuyQMQ9WafweZR0tM2yd3RPXVXW/yz5qLsAMiEgKm/
         89xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795009591; x=1795614391;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JxCBlWe9xidf5BljIoViI2yy2fuy4UwH/MuESKWLU9M=;
        b=pKDG/f/+0CYwUUp7eS+eFEvAxLhhCg5uivNUVfft98tZLzguiuwgaGg4K/jfohH932
         UPlV36qbZrnig/aBzFxW1+jBUn3gKtV9ntdzG2DC78ZmHk/nvVq2ZZYX91Q2cgWNyfaZ
         q9LLeuOVcwPH6B7zrfrVN1nhseX0DuS9qxKU9gZFMGW/xI1QyhvzjYggf7qQgzsW+7ho
         lmN0wox97dVwgk4/NUNWN79cid77B9cDeOvaiYxPIiqaVWHg/c2p/9NslNDpK0kwosnA
         zYTco1iCZE1fX2EysPw1uzuGCTDrpAhmUzqEwtOQp7jHvWfl3bl4cw9rs/9sJvgd0akw
         /zIg==
X-Gm-Message-State: APuU4Z8J9yz7JyC5LBfG7FnP8/qT+5UcH+fC7jPuLB44KV2MWNxkzwB9
	t9zFq88ECKYsbtJQ1gIms4zEgJ+v2HaN37tkeC67TxQ9dLCV0Wpr0rEe
X-Gm-Gg: AYBFou1u5zJDt1G9bH464uiNBHXp0xpjmNVkRmC0bWtq7FP7wwm2OFbIoe4mxbXaHbx
	oOfWEDg1Owb3nas81uCeSwZtoKs9zxriFq+aus8WA8ZMIsW2HAG2BnAAkQgbJmtGttI0P7ahGGq
	hBMUNV4VWDMREkXJAAtZLJP5vLVGKveIyFg8zXAiLvXqY2D1Czp6ufxoqT97RUgjXY0NWHK20a2
	APSMHEL2yy54Xo7i4CWLlBKYmCh61ZLB/RwOHlqEs8nITdai7d0qJm3WeiYZkahUC8dHfGhvAIW
	wLYoPqhLGbVjjYVF6iXmJiVR+jpapILVut9e+wfngxAw93AAkBg9jMy+UQWqcP67IVXXOLPZO7D
	E4Fst2we7cOUzp6LhelQFzkSVqsDxr26TyX5MqUVX+Q3Wj8nouK3z5crIsXzkjKpw00n7koRgVD
	iDLS8RfxodWd5vvDu4pGflJd5WYhN0KQLKE2/yyKE7+iUjmn6Ys2k4yxE8uGfp/A9CbDWLj9vJ/
	C4bLxPf9s0317YngtChJW6WA4/b9f7jtuGhe5L5/W4DCHa2p7MUexynt0YIt+n4JwicRjLjXH7o
	7IQNcBP+4tgXJGppN6W8odreKMdWLyyQ6sutKLgJ15ME+uUSV2XJ1wLbLrbTVOOsssRxkbUXXOl
	lA9mqHYMrDA==
X-Received: by 2002:a17:907:3e0c:b0:c41:1e13:4ba9 with SMTP id a640c23a62f3a-c510df534a3mr224094366b.6.1795009590871;
        Wed, 18 Nov 2026 05:46:30 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510cab33aasm95461766b.52.2026.11.18.05.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 05:46:29 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Hans de Goede <hansg@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: i2c: Document ASUS Transformer's Dock
Date: Wed, 18 Nov 2026 15:45:46 +0200
Message-ID: <20261118134555.195479-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118134555.195479-1-clamor95@gmail.com>
References: <20261118134555.195479-1-clamor95@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document a hardware configuration that uses a GPIO signal to determine the
presence and state of devices on the bus, allowing the system to
dynamically configure a predetermined set of I2C devices as they are
plugged in or removed used in Tegra based ASUS Transformers.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/i2c/asus,transformer-dock.yaml   | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/asus,transformer-dock.yaml

diff --git a/Documentation/devicetree/bindings/i2c/asus,transformer-dock.yaml b/Documentation/devicetree/bindings/i2c/asus,transformer-dock.yaml
new file mode 100644
index 0000000000000..5f4a40539c2b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/asus,transformer-dock.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/asus,transformer-dock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASUS Transformer's Dock for Tegra based devices
+
+maintainers:
+  - Michał Mirosław <mirq-linux@rere.qmqm.pl>
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description: An I2C bus extension found in the ASUS Transformers, where
+  certain devices are hot-pluggable, with their presence indicated by a
+  GPIO line. The set of potential hot-pluggable devices must be predefined
+  and fixed.
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml
+
+properties:
+  compatible:
+    const: asus,transformer-dock
+
+  detect-gpios:
+    description:
+      A pin whose active state indicates that detachable devices are plugged in.
+    maxItems: 1
+
+  i2c-parent:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The phandle of the I2C bus that this multiplexer's master-side port is
+      connected to.
+
+required:
+  - compatible
+  - detect-gpios
+  - i2c-parent
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c-dock {
+        compatible = "asus,transformer-dock";
+
+        detect-gpios = <&gpio 164 GPIO_ACTIVE_LOW>;
+        i2c-parent = <&gen2_i2c>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
+...
-- 
2.53.0

