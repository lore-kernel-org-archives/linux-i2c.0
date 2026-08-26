Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D9538B7DB
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 08:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787733333; cv=none; b=SZLSLTDuC1NITiNB3TE30dvh6topr1W8kiqZ4ttuHtJfwfR7NVSijQYUUVcXls1AJk00AIgXyx0ZKKG/mlUhDYxyPeSrcZFWgmZw20Bw6b9TU2sVUBeUC87ONPgDQcR4fPxrQLu5sDNjSupF3+ysC/zC9FA3dYa+lIbxGuVlgaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787733333; c=relaxed/simple;
	bh=8UkJs7+Yd83Q9YwRtqpurP1qoy033P6wwjcxhPZj8ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q+8x5/Ef6aJD5qszOfMpO+0vWwD4l+Na8Iwgz2kl5gSLxgDf35hpLVgpd377CdMDzcF3yvd8QHt6hg0u68FB/hAWJ0A2/Tv2sfJiXVl1RZC1IHFsXFdqQQpnymdtPSTqLYy9k+Fl5TRh8iC7mJ9BcKhqYF1FcXkQToOINiJPAaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=F7nYnkRP; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="F7nYnkRP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=vmwm2m/Tv9tEIQ
	bYfD+UllBk4kUwIEKqx5biQMcjaRY=; b=F7nYnkRPA7keDGmNekZsWZeeePQZcu
	fYQRpPYZnOZssShs6wmtE01ZFN9Qo3A29kTiaMLMdm9J/hvAFPhu8EHzJ3IcXtW0
	/cBBUwdZsZi9VBFF4QNODa0rKuKBH2ATnatQx6EoTffFxC8bigb6a6EVEZa5Xo7y
	DDXenFwHtWjkYrzR+ch8ZgJbFUHl3X+84TOuwkKqpKwtApno94JmG+WY9iT/pzVc
	DO+8XkmHgVtQUMinlFLviUG1hPpqGMtlOycBeqvlR0Ee2wm7FWDnV6LismWJv8SJ
	qsglpdsZnTGbJdwrqELAk8I+x9dS084HcCBjPSwoS4DCmV2FCEsYJCuA==
Received: (qmail 788513 invoked from network); 26 Aug 2026 10:35:28 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 Aug 2026 10:35:28 +0200
X-UD-Smtp-Session: l3s3148p1@EPz+Ge9ZHOMujnsh
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2] dt-bindings: i2c: renesas,rcar-i2c: allow 6 DMA channels
Date: Wed, 26 Aug 2026 10:34:23 +0200
Message-ID: <20260826083524.6056-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

R-Car Gen5 can make use of it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since v1: add check for limit on Gen3/4.

 .../bindings/i2c/renesas,rcar-i2c.yaml         | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,rcar-i2c.yaml b/Documentation/devicetree/bindings/i2c/renesas,rcar-i2c.yaml
index f9ede03c3287..bfd486be0109 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,rcar-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/renesas,rcar-i2c.yaml
@@ -83,14 +83,14 @@ properties:
 
   dmas:
     minItems: 2
-    maxItems: 4
+    maxItems: 6
     description:
       Must contain a list of pairs of references to DMA specifiers, one for
       transmission, and one for reception.
 
   dma-names:
     minItems: 2
-    maxItems: 4
+    maxItems: 6
     items:
       enum:
         - tx
@@ -137,6 +137,20 @@ allOf:
         dmas: false
         dma-names: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rcar-gen3-i2c
+              - renesas,rcar-gen4-i2c
+    then:
+      properties:
+        dmas:
+          maxItems: 4
+        dma-names:
+          maxItems: 4
+
   - if:
       properties:
         compatible:
-- 
2.47.3

