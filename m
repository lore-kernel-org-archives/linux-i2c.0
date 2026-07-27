Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A224071E5
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155162; cv=none; b=Z29DtOVwfS2YbV4LaBSA1Zb6d3UOrFp9v7D3I3lg3n6p/6J3/5czEaOei/nEFTGd6a64g4RnpLrLDN0VdCPmG0OPaqJfR1JE+sz6IXiFHvHqHkw57hritPeKleQPH2lPlj/z5NdznfkESNUAsGlE9eSXS/cfml98H3TEqA/A/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155162; c=relaxed/simple;
	bh=kVPck4OpThiIm4TGXSks/fMT2CxHuk9QTbuoRPty0D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c66YuIDBU7w2QH1+VZK8dGhcygiAmQgnxZx3kW4Dx+2xmxcMqR7cuwaxD2z3ZDCXrfF45XTtqRLQZGzOI8tNHYlV2xeTjXO4zB6SN6hg1iyrGlUvxlDsAJmWl9QPY+uRGPKVl53zzJjKiwfRcP8Mwpjn7RGKEusjsLKYEw1iI9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=fpF6M2dg; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="fpF6M2dg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=ffXL2Lq+be6SgvKRnD1tUATuHMpwf3JbD2cIW9JQtY8=; b=fpF6M2
	dgCul8EapeDSIB/A4RRHhnt8nMlpc1rHHvsTJJjrwbHw0/HzoFjeaL9rX4j9KnfZ
	2zSOgeBSrNjullBgaKU5P324jsX195qDElnwH+w7uYzVWvoEBUoo7KxVT2rgFryk
	aypcHAtEqGnxHXHxCHdXI+WZYX9V8NJze/+VT9SsOqQMLYUXebgpRr/YtRudtrxG
	LvG7OmY6YBfazkvANE4WN5dppFTJfkMO91U8TyVh0oqLKGYvgOfLh7gUyWVEMZSQ
	hChIPofFbar9+AYHNoOdi/G3b5CrUUAUWxndvoMzsvg01EssclVuW4bm38JtNXEh
	qH0/TtuLArNxcqhA==
Received: (qmail 602537 invoked from network); 27 Jul 2026 14:25:58 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 Jul 2026 14:25:58 +0200
X-UD-Smtp-Session: l3s3148p1@G/gR05ZXKL0ujnuy
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Minh Le <minh.le.aj@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: i2c: rcar-i2c: Document R-Car X5H support
Date: Mon, 27 Jul 2026 14:25:47 +0200
Message-ID: <20260727122546.4232-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727122546.4232-4-wsa+renesas@sang-engineering.com>
References: <20260727122546.4232-4-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Minh Le <minh.le.aj@renesas.com>

Document support for rcar-i2c on R8A78000 (X5H) SoCs.

Signed-off-by: Minh Le <minh.le.aj@renesas.com>
[wsa: fixed white space issues, added reset requirement]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Change since v1: * require resets, too

 Documentation/devicetree/bindings/i2c/renesas,rcar-i2c.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,rcar-i2c.yaml b/Documentation/devicetree/bindings/i2c/renesas,rcar-i2c.yaml
index 6cc60c3f61cd..f9ede03c3287 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,rcar-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/renesas,rcar-i2c.yaml
@@ -56,6 +56,11 @@ properties:
               - renesas,i2c-r8a779h0     # R-Car V4M
           - const: renesas,rcar-gen4-i2c # R-Car Gen4
 
+      - items:
+          - enum:
+              - renesas,i2c-r8a78000     # R-Car X5H
+          - const: renesas,rcar-gen5-i2c # R-Car Gen5
+
   reg:
     maxItems: 1
 
@@ -140,6 +145,7 @@ allOf:
               - renesas,rcar-gen2-i2c
               - renesas,rcar-gen3-i2c
               - renesas,rcar-gen4-i2c
+              - renesas,rcar-gen5-i2c
     then:
       required:
         - resets
-- 
2.47.3

