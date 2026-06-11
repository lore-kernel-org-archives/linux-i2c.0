Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336AB3BB13A
	for <linux-i2c@vger.kernel.org>; Thu, 11 Jun 2026 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781180475; cv=none; b=qVZzC29Er5SzzFUYhz6J/KE3bt9ppc2lJP+2hTr42GxuUGK8Fex513CMe4f/5putEGLNyoE1nGETQVLWXrDcZ8sC9kZ2TEUsvAxf22P5kOWkgWpwRixwoymZZpYiqqaTSHO2Ww1/6Xh1IrOS4MC08vK8Cw3ZQ2GFCjP6FwT/xZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781180475; c=relaxed/simple;
	bh=OK6xEQe/D6eLI98p+VF3Sn8Dln++Z6is7QGztVPEovA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ln4F6QletYKT8nOdPaPYX7LN7xAF42JQKq7frQ+2k4y9PsqEx1Zw5PFdhJZvWya5cs1UPRStRoSSvv1/D/atwy+6y8OmpJ7Zpz2/F+ufS4CEqFQ3VV93NNLWDjd/s5dm1Neg4dAR6VR67/+dA/phzI9Wr1cAWCgTp16yP53DJnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=FceBgems; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="FceBgems"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=WT27qRO1N0+Qtu
	aUvRdOfGsxrSfSk0U/C5+BYr3RpHY=; b=FceBgemsyUtWMFTYXxbunHnFigmNKn
	9gZQd41+FAl6zyWMWDPhCNKVvaXlc16ERrHLbQpSS7eWi4HDB6FYDv0KconrPT5f
	94595ZsTg/vTry6VMjz/1eTf0QBYUpeECzIxK/dxQ0Rs3fCBFO8JWsAHz91rI9IW
	JI1qp847K0KdyD+GgzLjLn0jwg07cUfq7Ak2+mLBdX1rE01wssnZ90hYNqDV7/6y
	2jy/aFTc2Gatqz/x3mb1eDyE230k6/dCf4iaXQrL9IO/MOOsBZnSZmgY6KIO2cA3
	kQXjDvnz/rw4p78hJ2Agmf4eqb4DnQLt6IGb7zmclnD7mstAonza5rQA==
Received: (qmail 2110904 invoked from network); 11 Jun 2026 14:21:07 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Jun 2026 14:21:07 +0200
X-UD-Smtp-Session: l3s3148p1@eR8AZflThroujnvX
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Peter Korsgaard <peter.korsgaard@barco.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@lysator.liu.se>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: i2c: mux-gpio: name correct maintainer
Date: Thu, 11 Jun 2026 14:20:53 +0200
Message-ID: <20260611122053.7306-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The YAML conversion added me as maintainer but I can't recall being
asked nor do I want to maintain it. Add Peter as maintainer for the
binding as he is maintainer of the driver.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mux-gpio.yaml | 2 +-
 MAINTAINERS                                             | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.yaml b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.yaml
index 4a93d1f78f93..6e44510aaef6 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: GPIO-based I2C Bus Mux
 
 maintainers:
-  - Wolfram Sang <wsa@kernel.org>
+  - Peter Korsgaard <peter.korsgaard@barco.com>
 
 description: |
   This binding describes an I2C bus multiplexer that uses GPIOs to route the I2C signals.
diff --git a/MAINTAINERS b/MAINTAINERS
index e035a3be797c..a616abfce644 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10772,6 +10772,7 @@ GENERIC GPIO I2C MULTIPLEXER DRIVER
 M:	Peter Korsgaard <peter.korsgaard@barco.com>
 L:	linux-i2c@vger.kernel.org
 S:	Supported
+F:	Documentation/devicetree/bindings/i2c/i2c-mux-gpio.yaml
 F:	Documentation/i2c/muxes/i2c-mux-gpio.rst
 F:	drivers/i2c/muxes/i2c-mux-gpio.c
 F:	include/linux/platform_data/i2c-mux-gpio.h
-- 
2.51.0

