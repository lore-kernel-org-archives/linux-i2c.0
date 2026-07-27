Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6A8392836
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785152113; cv=none; b=rS5/s03auSKBv7OKmsPZZTKf+bsRVGtg/cKVbQa0KIQ7GV6QjnHz0/QD0y8/PYgYH4l4lcrPmT5VAttfl6Lgb3NryqPJezYbPzIt0vMaUjcK+rjdNlCWcog3ilAh26vnDXagQlpZY6s3kRHTJXlnNwQ6nUjrYrIZIwcGB/4fWm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785152113; c=relaxed/simple;
	bh=TzINDbs+VbgzH2YheSF3cDlUZ7+ZuUFX1umEZ5dY+kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRirHZV8cSb0nxcx6PleqBurhGCO1J7fbK3yEOtZiu+IHn5pcgLzbuiBiLGoN6lJbeH0SEqXLNx2QEeD3t/BUk+Aim5cayVkUM6eebrEiau9GFQrX8vetwX063BV/QP//r6hrYKTzv7TWED+FpTGzc/yQ3rENIqyr5Tghy2qRao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=IJ0bCOHG; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="IJ0bCOHG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=IhASfEUPTeqfb8JyVjNSBH9Y4Frmem9Jz52g3v5FJKY=; b=IJ0bCO
	HGgAXsDn7ehwFEzx62QNV+rb/7ZLlbzB3Ax1esufL1ncIV+Fdyuhowm+36b43Msz
	FL74unL88HsyedZj6d2b2sygn1Vo6QiVsIYZkVgPzmXN6UttLIx6OOYI1UHgNrvP
	c5NonqNjuHw/85HCoO24cnaeUpqYMcG1KNMz5BF70urD0/vgxwL+7Qc4rKEVxCop
	c2nuqK+HZmnS/tNV70yvaEAyQzO+Zkr5QkV+suRi+dXo50ctZ/JnirCQ6U87/iKD
	cHeQRi3q9LWz5/HUsSPza0ajOPO0Pu1++Glp7oYbHNQNaUEZH5HDzoNuSHHgUeN6
	ga5bIXGvJa9fkklQ==
Received: (qmail 589300 invoked from network); 27 Jul 2026 13:35:04 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 Jul 2026 13:35:04 +0200
X-UD-Smtp-Session: l3s3148p1@cOISHZZXOs8ujnuy
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
Subject: [PATCH 1/2] dt-bindings: i2c: rcar-i2c: Document R-Car X5H support
Date: Mon, 27 Jul 2026 13:34:42 +0200
Message-ID: <20260727113441.11193-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727113441.11193-4-wsa+renesas@sang-engineering.com>
References: <20260727113441.11193-4-wsa+renesas@sang-engineering.com>
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
[wsa: fixed white space issues]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/i2c/renesas,rcar-i2c.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,rcar-i2c.yaml b/Documentation/devicetree/bindings/i2c/renesas,rcar-i2c.yaml
index 6cc60c3f61cd..46b4bd16c593 100644
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
 
-- 
2.47.3

