Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F33D2882DE
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 20:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787689984; cv=none; b=VZrEAw7ZC/ltZrJsgSJ/5zh1DceQfvig/xLAMsKYxMhwkQu6lMPwg1QMo1vQKhINmx0fRh+bNRe4NniT76+9WoQXIxXO2//L5KPjAciBt8emHz4KoKXzWRdnz2nJ4Ez+YN3cLF0x7SIJciNxZgIdkIdpg+RBA03EPt6DWpZkKUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787689984; c=relaxed/simple;
	bh=2+n5rByLPZJJvQrAR6tKZTIPfRHJB0qPDAnpYW36WPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQWcRm91Y0jgoeN4kylEdNDwRXDFzW8P4qouzK1poaSXRMZsnCbpytqeQUkif9nm7+0xvNCOJhnPdFcFq4//HXZEJzYQgMX5QQXEOX2Wy9s8oE8xxPJur8i7xMO/oZ+9ab2DTo/wejjlGK+HLyLMjff6Uid53Ih5tNP6Vz0asGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=c5m0V8R1; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="c5m0V8R1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=YKxnigf+qbZrYT
	CeGNLtjiJe9/SGcxAtJhB47jC8gq8=; b=c5m0V8R1Ffp7nMNopk3Fdk5dA9F3Ay
	TpK4HJuKd5Tjys2od+IhSkpgvmYZlG5PYAf50tD4DBVdqc8iyvoyOKrCGP4HfKe2
	j313hfRGX0Yl9r6+yuT4mkSdPu51Z0mQ9qMxw64riYpPYPca+ZNkXKpxsIY4C1ga
	6P8Tcw1kXzira3WYiAzbRtA/9snCKotvz9qXad3Q06w6oGL+fGK6gKKff/S6WlTt
	wjRHf+z4mDdpxvNthweS26nbiJykV34wayyzDsqhCC7ok0iFVm7R2AtqbEwVRxoV
	+Dt5by9TZuwW//q0jjC9rpQLEehR+jUIEN2xVKIgLH+crQ9j/QzLgu2Q==
Received: (qmail 620471 invoked from network); 25 Aug 2026 22:32:57 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Aug 2026 22:32:57 +0200
X-UD-Smtp-Session: l3s3148p1@YiEKAuVZ/Koujnus
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
Subject: [PATCH] dt-bindings: i2c: renesas,rcar-i2c: allow 6 DMA channels
Date: Tue, 25 Aug 2026 22:31:28 +0200
Message-ID: <20260825203251.2118-2-wsa+renesas@sang-engineering.com>
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

Sorry that this has not been noticed when adding Gen5 support, but DMA
support on this platform has only been implemented incrementally, so
this went unnoticed up to now.

 Documentation/devicetree/bindings/i2c/renesas,rcar-i2c.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,rcar-i2c.yaml b/Documentation/devicetree/bindings/i2c/renesas,rcar-i2c.yaml
index f9ede03c3287..4148081e3d84 100644
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
-- 
2.47.3

