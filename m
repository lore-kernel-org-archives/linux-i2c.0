Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9384749C3
	for <linux-i2c@vger.kernel.org>; Mon, 12 Oct 2026 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799801; cv=none; b=DVhNHl2HpjK8nADTpn5jiFplpDJFUFYQ5PwPsMCh1Yhrv+vuHl+8MCp9+F08K1CkoBICooY9V6HYaIl0MtdZHb4A3tVoJ4DzI4+YoJcV6NUBj6Wm9ZwultHpGhQ8HEjvwX3PGvQnIxzfB2J++wr+6+xhn5P7Ed1Gx3zadEhfImU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799801; c=relaxed/simple;
	bh=rF6rQofzYRml/5wBil+Xn0JDP3ogfFhOy5WOAz38e3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nj6bKeQmFYh2uYMS+q+J7J5AnGestd66bCEAjiq5RLid+04qC1Kg+T9EcOdM2ZfJEll7jZI8u1IswHiM6NvuWO4aW8XweMAaq8ZbQ3sITh9dNe0EBEVF8phsX8JGqxZzdY6Gep3+TI7LW8DpIh6gYNt+BwymkrtWhIy7xaZBxHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+nvihru; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+nvihru"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49ff680331aso13043285e9.3
        for <linux-i2c@vger.kernel.org>; Mon, 12 Oct 2026 03:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791799781; x=1792404581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W/C9tWh0XAUTo7k5jKf93sgNA+uT1YvSZ7hoHgaGa7c=;
        b=f+nvihruUVejM7Uhc3/2JbQjBD21Nf0Hcrw93+oX3Lmmg24yvmklDr7m4mVNusixel
         ui2oNSb4XQ6Ze6W0qDFk2xaIHdZBD8jwa861PcRN+KVryLmrvVg+hP9rX5aybX5WNLaG
         3LXz1oPxo1aaxbG//YilwZ/EneGRt22rGnPrL8Vd6JkX2Q/cDCgCx4+wzTvdizce1f3l
         t66wqeeTXefceKRRZwYZv+FpIjdTHxXlMLwlAnnP97gOW5JGzTVXHnI5sGJK3y1zejML
         saFHkUafDBUGjWEy0a7c41mK0AlUpIKOyTEH7a4srtiedGevmF/66PMFPjEhKDhPsnPa
         ATbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791799781; x=1792404581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W/C9tWh0XAUTo7k5jKf93sgNA+uT1YvSZ7hoHgaGa7c=;
        b=tXpymaSP6NskAosE5GdvEQrycgsRdkW1rEOoB6yOvznCM0+80gBmAWukSl0g7ezg7R
         kN4rq6oo24bMmA3DgtKlXJsg/6dYfi+lu6jX3eVfrsVfeZYI9+uJUaESG/GxuShiDRDN
         LVJr9cqc+AQXlRdXHJPGnSO8ud48XevoyE2Q+GYtaSN9fm3zOL8U/uGSoQU+X4V5V5l8
         4K46ZlGqfeDkBVrXI2l5Dl0fGxcpMwnXxuvwCV5QiiDYYS+f/vOxymy8O1bCC6pLrpR8
         WQbwSK1EzZ+9dFQGsajEAXX9uNl3FwV5Y5ygiheJXSFV2xkP4gxO5rJ8YtsTjv3Pjr6Q
         shGg==
X-Forwarded-Encrypted: i=1; AKwUvByl01CmEWYCOY3gXuBgR5M/DU5GcLHkbihe/CAA8aVlixlyUPdpsx8thxUH/G3jprB7sWtIm3w2C/w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYERCXMtO8PP+GPtVMFJLEgYUSQyohcZC6yBQoUtMMCNwoIm1X
	Ef8yLp/HZHLU9r+iRbxyAnwkVz+6WQdzkNgJ7AoN5B70JDMaQx+vgBvv
X-Gm-Gg: AYBFou2Rg+dkxPo3Ie/Xm7kWosBRtSvbVIymo8rG10mNDtean0Gc1hJ8WhNuSXsDa3j
	mKdV+NsWL0dAwnQ+5toL2U8q7201KfaWkf5Y7eQKHuqBgNHtzHegNdkAWexDqSIVO0Lrl4kPELE
	7j/xCkbGrFbnCDxj9cWFoetcdGIf64aTbt54SPWLdq23xCYANPX9QkMnqo4uxUnhr0LMq1fVi2K
	Ger6AnNJRgPogZpv/7a7Mh2/mEQ4J5zdGXg1zejXSh2vcJCig4y61L+f+bJ92+a95dm5VVOH7a7
	03uKpGZMIPWzS6X7zYwF1KtKU186kWq9o2jJcf7AKXjpOQwjznTfEk+l79dPGd6LmQQ1BxuNqna
	8Kg1lV8ASJs6YlnvXjnIvkM9TBJoNmJYjZN8IU2DC1Vh3K2eyNi/alsb+Qa7fnzp9vrKmbF6CxG
	p3+4QdRi9/S/4J/Z7OaJPui4dKP1gZ5YLJYqo/mXAbwxNEyHivPdlvJpmvBcIk0w/49GNGQh/WD
	VNAcV9vAw3ns41AhAFBp/DodFZkQqnS
X-Received: by 2002:a05:600c:46d1:b0:4a1:7d56:663b with SMTP id 5b1f17b1804b1-4a18e4a7844mr180897045e9.24.1791799780438;
        Mon, 12 Oct 2026 03:09:40 -0700 (PDT)
Received: from debian (ip-78-137-176-146.broadband.digiweb.ie. [78.137.176.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a192d3efb6sm166229885e9.1.2026.10.12.03.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 03:09:39 -0700 (PDT)
From: Pablo Mazzini <pmazzini@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Pablo Mazzini <pmazzini@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Andre Przywara <andre.przywara@arm.com>,
	devicetree@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/11] dt-bindings: i2c: mv64xxx: add Allwinner B288
Date: Mon, 12 Oct 2026 11:08:12 +0100
Message-ID: <20261012100816.331033-8-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012100816.331033-1-pmazzini@gmail.com>
References: <20261012100816.331033-1-pmazzini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The B288 controller follows the existing Allwinner variant.

Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
Acked-by: Andi Shyti <andi.shyti@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml b/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
index c4efcef59133..d3b6f7668621 100644
--- a/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
@@ -21,6 +21,7 @@ properties:
           - enum:
               - allwinner,suniv-f1c100s-i2c
               - allwinner,sun8i-a23-i2c
+              - allwinner,sun8i-b288-i2c
               - allwinner,sun8i-a83t-i2c
               - allwinner,sun8i-v536-i2c
               - allwinner,sun50i-a64-i2c
-- 
2.52.0

