Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201194;
	b=ajb3hEZSNjfB6mSVnNbJn9IW+yoNGSuwqN8ItlxiKcwTMd+VgVywSEUWdV2//hqbEJEb
	 F5Fxi5fbqnJhDOilY6oAmubpG4AgMIZthPpkTMvbbA2fE8OKi+L3tFzwrEHZsHKXiKl2R
	 /GBBZAb+lHrrSXiN/cgRJZq6oOZGI+B9dgetAnhWCyUSN1pRTWbbxsOzjsE06wEZF8Md9
	 5sShlfw+Dm9PAw8App0eltw4Aun3a2kNjYE5ZdO/5VDbKBylBAYg60r1C+dJsbtcuXBsY
	 9U/dFMe44sGDQCUSD8oLjFEiGdWyRNuqg4ybHzSs/24D5MOKm5BzTaG4YFj+CMyuJ6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jeNmj5ZEc17RCrEqMZFDITOByu/mJAzOv4t4PwqFZds=;
	b=w0YLtq/SvkQ9r1xZ5v8pYiXqHNyTWaNXR/fiOCPtqYE6kxUmIMK5nEelw88Ld4HXM86m
	 gGxhj5YOkfPMNGbz9VRqY9mUCokSt2zIXU37pt+16HbdyP4ljSU5e4aqU7vudCQnPBp1r
	 A39nw8m3dBiEwWwHT2D7/BQPVlwMRz1ReQfyZQEcMQqPYau+WVlov38K+NvFF0KQaVv3W
	 AdDN64HhlqvIJl2gvN8OresyKIE5tEg0SBWKTvl1ZMGzyn4bKwXPzbSCjnld+RFgwztiC
	 O3L0S2LcAUuj7SAeB8ufHRixofHP7KuuvmbVeffTJbjsHNEhqQUhi3arDeWTSecrAwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yxkcDXGO;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F66660A263A
	for <linux-i2c@vger.kernel.org>; Fri, 20 Nov 2026 18:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F66660A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yxkcDXGO
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c5118deebcfso196843566b.1
        for <linux-i2c@vger.kernel.org>; Fri, 20 Nov 2026 10:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795201188; x=1795805988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jeNmj5ZEc17RCrEqMZFDITOByu/mJAzOv4t4PwqFZds=;
        b=yxkcDXGOasir3Qy6rymbwZ/6dJ/Um58rGBpB81H1qg5RNFLOoQ6GK2AsCGxDtL2CJo
         oJ/y2p/fqn3K01f0Y9rTNMQrS/undGrlx1eJJQaLIFC0tLdFy7wohnRbz+aPQ/fuZ4eh
         zMsVRxYMA67xJ99I6j43TSyT5zA0divNQF2ntlSUYeOqyUUyrC1gYRE5wBok9kkLan97
         Guui3O+gNwH2afkBdz1Qp6BXLpm4AVL+qwhTyQ0PTn0XyfFCN7QBQhO3t7wR5Fi671BE
         JZE+WjePQDzRUmsKlH3DVNkATh8GE1JYn2baRismgDLTBTYftBADchLio99oNKSHZGq7
         QDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201188; x=1795805988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jeNmj5ZEc17RCrEqMZFDITOByu/mJAzOv4t4PwqFZds=;
        b=Om6aPEtfWJXcvq++nJgtasYQ8Gfrucf8Pge8BYOPW5D7NgObTLoBJKrI/kvyTf3fJH
         JsuZwcV0827lRrU5Vq/uOAjcG7/njURjIwGH7X7RlLxLwV8+NhWx4FHeiYz4cavuuepc
         tOHNm3RH+wQ00QLeSEKTMXJccIuwHZh93E6Lz1SOeX8MdY2DlLtD66k3gkxFhEwDIomO
         RDTrOfmdUEzZ+HrKqkba5wlCoATrY5HKOKLdafAnPtPCpmPNKjLtV+JJ7GWOtOmBOdoS
         TyTFA5ecloIYOorDsonh4Vmq/qKKlCmco/5fwiHsUk+o6X2XNV6NOhEyoz+eW6V+aM9G
         jcmQ==
X-Forwarded-Encrypted: i=1; AL+hErFuWeBxmjpamYcBvVZpDmXvyGWoEY/NKDMprPLQoi0L6VAqAhxtJjWItDf45RFKNKzBp9QI699Jml0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tJ87K5uSjMfdz81iu3wmp9fYlrGDdoSJBiW1RlCOG8dgpbvKg
	/HP3P5+AMdZGNy9ij1uApmB07H9IPGdksO2mfizFb87UBbReiw0OH7Xy
X-Gm-Gg: AZFdTZdNv28LsbV9rCOYYWWS3OyjBSqwNdFGueFzmosA8SXJ63wei3N6MK5fpaY+gwK
	mP2ypQm+Ye3Cm3VrdAOU4rjkgjy6zhSD6b4aqbsGAq8rbS5fKbaBIy56nukFKnjceNHqSqsct0p
	xp5OQrIufLeg21VBkLe70HJKKPWdyK/1S4Tc8lBiX7dyaOv7kx5JFKloLFzXVUCRTbx2VcKYYG+
	urXEVSbePAFuAdyHbl0i7ukDcZvrjy+HWVMBXvdpHErFKJQpGxfHG4BaFCvCAsYhwEr184e4d9+
	5L9QiYyvOa2cpYZN6beJr8jYnls9YX0twyxpV4VZQ3tAEJq0nyw1kgZJxCLyLx2oum/YOYZJCDz
	+QsiJU9/GWdc6kw0tP1OrgIGuk8vGLI8kvUIdEn443L4qxPe8FhQqhD9/7+T7XJBHuKMcMT7wVK
	mTmixZMv624kGv/Qqvss0OfdqGr7lltKkBnc9cSy016pptn4wLiU2o8ds5SXea1cDvRWekn37OE
	4+8hrF0DtA5wy/j4wTqfKiwU5vcWR9UH+PJDIcSaYiZUAp/FBY8gn8Ynyif+fNTnoZkiIF+ZYYv
	h7+ECqmkE1SYoRCVUNSj0cgd/AjvCBlARjTug23pSM59/8izbEPVbpw2++x9lw==
X-Received: by 2002:a17:907:a890:b0:c2d:c739:30e1 with SMTP id a640c23a62f3a-c513ab14a58mr450503366b.32.1795201187683;
        Fri, 20 Nov 2026 10:59:47 -0800 (PST)
Received: from antoniarch (84-40-238-230.cgnat.inetia.pl. [84.40.238.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513b02de1dsm125205266b.85.2026.11.20.10.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:59:47 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: vigneshr@ti.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	jmkrzyszt@gmail.com,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	phasta@kernel.org
Cc: linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v3 1/3] dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
Date: Fri, 20 Nov 2026 19:59:11 +0100
Message-ID: <20261120185915.150228-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120185915.150228-1-apokusinski01@gmail.com>
References: <20261120185915.150228-1-apokusinski01@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the TX and RX DMA request channels featured
by the OMAP I2C controller.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 .../devicetree/bindings/i2c/ti,omap4-i2c.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml b/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
index 58d32ceeacfc..ff946fdfaad3 100644
--- a/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
@@ -37,6 +37,16 @@ properties:
   clock-names:
     const: fck
 
+  dmas:
+    items:
+      - description: TX DMA channel phandle
+      - description: RX DMA channel phandle
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
   power-domains: true
 
   ti,hwmods:
@@ -93,4 +103,6 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
         mux-states = <&i2c_mux 1>;
+        dmas = <&edma 58 0>, <&edma 59 0>;
+        dma-names = "tx", "rx";
     };
-- 
2.56.1

