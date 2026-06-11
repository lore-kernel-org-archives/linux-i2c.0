Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B5D29D27A
	for <linux-i2c@vger.kernel.org>; Thu, 11 Jun 2026 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781180831; cv=none; b=MAuPEMeNYI65fC96E4F/Oh9+uKWeiXNj3TqyfSmoB72+IbhqSTJOAW/nuAoA2Zz1FdGU4me5GKKzs9um87f6U5XD8RSioxFy23Jc3ff9Qc0vc4vUtlDE37fUNlhHMnO4oLIvYnAX99+YCaa353vrD0NezrY78R5BO3JXTPREFB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781180831; c=relaxed/simple;
	bh=07XhFOZIzFvouZx4+034ijG/oHYdilZ0gKzqtG233e8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XJ0r7UEdfG/0M3xF5A5YGrS3GHCQt2wZqFJI0ZSQrqlf7/YlGMz2WLFHwawKrlV9lQ9KLyckp9fljMc01jJ0YkewNVQ5Vk6Z7ADykviVWyk6+bTYpWxi+1nLAvzIojSUqklqKD4VtiuQY3eoCLUWeQltGc8tZmUB94MXylwGpAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=SRH1Iqmo; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="SRH1Iqmo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=pzCWhYTTaHarIV
	WSw9dJjxLQ5h4uRp5jhIoJCVn4y5Q=; b=SRH1IqmoDon1gNM50cL9B7fNXPfWgj
	RcT1fqj3DDhQC1KVVIrc2UB8alJqNgWPzXkw2IGsABQ0pNNvCAoI54D0l0qEWY3K
	xHMUsPkEPlL+spAvJ6xGt3yFA0yi4fRzxgdsdVSlygCpp5NUzy1nu5Rjp87zDVBz
	ELhL1bMq7QPZ5zRF+ojpvpdgP+7i5dkN7bEdTAoPIhGJFw6cH4m05Dn7yUE7F8Yn
	6zNcK4I711pBK/yUcyUciIug0LvdjZjQA0mNIFAKg/RLdYVycSBkNl0AbD8QbeF0
	B8BoH2LOSC/Xh3V9OLmNAIho2WdJvG3iuz64WcF281lPeRGHMRJ8mCjw==
Received: (qmail 2112875 invoked from network); 11 Jun 2026 14:27:07 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Jun 2026 14:27:07 +0200
X-UD-Smtp-Session: l3s3148p1@dxKCevlToKUujnvX
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Thierry Reding <treding@nvidia.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@lysator.liu.se>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: i2c: i2c-mux-pinctrl: change maintainer
Date: Thu, 11 Jun 2026 14:26:24 +0200
Message-ID: <20260611122704.7559-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The YAML conversion added me as maintainer but I can't recall being
asked nor do I want to maintain it. Thierry has created the YAML file
and works for the company which contributed the driver.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

@Thierry: are you okay with this change?

 Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.yaml b/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.yaml
index 2e3d555eb96c..f7502da71909 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Pinctrl-based I2C Bus Mux
 
 maintainers:
-  - Wolfram Sang <wsa@kernel.org>
+  - Thierry Reding <treding@nvidia.com>
 
 description: |
   This binding describes an I2C bus multiplexer that uses pin multiplexing to route the I2C
-- 
2.51.0

