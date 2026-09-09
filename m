Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355B53D2FE6
	for <linux-i2c@vger.kernel.org>; Wed,  9 Sep 2026 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979332; cv=none; b=MAh/u+OWDBwVKB/63LTgh6l1H5pNRoMKe4peE2x/upk4ThNfQ04AsFRxxoeePTk/VhSRuUWvdIooCuQA+PV7/1qJi6sOOn+REgQIoF6Arbtl4fd/4M2X4gCJA3aUXVgYc9OoQuhvwz67m3D7xPiu3S23YFJ1JZN2A2Y//5U1SeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979332; c=relaxed/simple;
	bh=sbQeSkAq/3drilWc2nTiSI0YUQXlV//NckCEzgDM3Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SvswsUWBrGyniMC0lTXEc7VJ47N44yQJ8xhRbOKzG0yd5pFfvDO5HRIoF09OHsnRaafmIPjyoflqFuQwwiUR2HwcKDBFl5X9MSN65cFi31NbDTXPb7ROXV6eKXn0+R0kKMQke+VfyNvjyhudtDwXo2aj7EN/uU+e4r04BG01qMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Cez3K3sf; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Cez3K3sf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=WPhDwlHTCy1933
	sV/rX1r0YXdTYV4WYD8yT6RoXIJ0o=; b=Cez3K3sfUs/yUh5t5arR/4GCAgQ1AV
	vOcJI+UabAQacd7uGxWk1nU+Bl/rqoL8o7ELXohkhYURFu+JYgVDxqERyIXGdJsj
	XEid8zjYzPjc9Oop7UDdKOR1taucRYCsbkwaWmWJqotTMTGPL/adqK6em2xmn5C7
	LX9MK6SvU3U+6m09d7XLqlIi967H2PK8gYl3KGH44XZDr4Bfz9+M7OxTzXwST6Mp
	5eEwgeUcwofbYFAWebOqNpyGwwl/+fkp2Q7ajyagyUB9IRPChSxREw4X5tfe/Ini
	BkXYIFTHNpwl+uCuREGlCvj6Y2uAl8MeaY9n441zofIhCuSR0xfqA/RQ==
Received: (qmail 3228878 invoked from network); 9 Sep 2026 20:42:04 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Sep 2026 20:42:04 +0200
X-UD-Smtp-Session: l3s3148p1@ABwgNRFbzLUujnv0
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
Subject: [PATCH v3] dt-bindings: i2c: renesas,rcar-i2c: allow 6 DMA channels
Date: Wed,  9 Sep 2026 20:35:32 +0200
Message-ID: <20260909184200.3319-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.53.0
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

Changes since v2:

- dropped extra limits for Gen3/4 based on a discussion with Geert[1].
  I dropped Conor's ack because of this being a bigger change. If
  Sashiko complains again, we will ignore it

- not a a change, but after an internal discussion with Geert, we
  concluded that his suggestion of raising to 8 is not fully backed
  with current documentation and we keep it 6 (for now)

[1] https://lore.kernel.org/r/CAMuHMdXj04QoxituCF3wRcyzN7qZrVBn7-ukNkKDd0OfhB8zOQ@mail.gmail.com

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
2.53.0

