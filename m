Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DC13CF67F
	for <linux-i2c@vger.kernel.org>; Tue, 16 Jun 2026 06:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590160; cv=none; b=k/fiBYG9PlQ1VgDJqGMkpEI28WBXpwZ/jCfaiZjKe9r328qd+8eXC3YiHkpXdFeJZZUAMXYmCMJodPpVGuOWDU08jdGEf7wkerHPsUQjsgk4/c0Z0Mc64KqcGtc2h3MXiUz0l2KTIM2UXt3KN6pEh2omu3utFgFVgTYGcQWBRSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590160; c=relaxed/simple;
	bh=yZ5RUy1SHlj4Agc04wu+N+N5u1RHewqN7S9NoTE6/Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tTCfzk6JLbTwgfiFC2baTYjIVV9ek72nhD0UnhUn8bs94+JW/BGzOY0EUPX3ksCv0YZEBHlZQwV4eTpGRes54nt3i61ZZpqt3WyaswuJADY7NiHMJOJ4mexQ7F1/8N4bLujduacJklp6BTo2cQ2fwnK4Swi2owUuyviOJjEoNTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=feNEt3vC; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="feNEt3vC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=DsOHWnokrLGDiA
	aPxwF771u+2jfOFJirl+erfy56Joo=; b=feNEt3vCfrkngOCmdbo1z8bOygAa8F
	xcoycGRGvU387pFb+IJU1JJo4jxNaf/chetGBDun2qYbrF2Wr2qpKYHyirEHN8D4
	0mi7+kHd5A1Imq6oBZjVTBdcegMvKGYuvQBUuRB7grelMNSutWDj0DO3MWFbWZez
	PHyz75Hz7BxqeLZdKPv1t4cDQzIR7qlCc/j6pBOlfXvR7gReFQUwFkQmCPXpNwPM
	2hsbQS6ThQvmSGwqeIGnylj/LIvlTdVOgo8cIcDPYq5+1zVW1SscONfaOC5/X8Wz
	G9/C6Ru3MmWYDwNKvYtTGSWnGUb4Ov/hBrD9TetBXYWAlRbwPcqhVaLg==
Received: (qmail 3825552 invoked from network); 16 Jun 2026 08:09:16 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Jun 2026 08:09:16 +0200
X-UD-Smtp-Session: l3s3148p1@RjViyFhUQz1UszEP
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v2] dt-bindings: i2c: i2c-mux-pinctrl: change maintainer
Date: Tue, 16 Jun 2026 08:07:59 +0200
Message-ID: <20260616060910.1480-2-wsa+renesas@sang-engineering.com>
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
Acked-by: Thierry Reding <thierry.reding@kernel.org>
---

Changes since v1:
* added Thierry's preferred email and added his tag (Thanks!)

@Andi: can you kindly add this to your second pull request?

 Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.yaml b/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.yaml
index 2e3d555eb96c..99812a893476 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Pinctrl-based I2C Bus Mux
 
 maintainers:
-  - Wolfram Sang <wsa@kernel.org>
+  - Thierry Reding <thierry.reding@kernel.org>
 
 description: |
   This binding describes an I2C bus multiplexer that uses pin multiplexing to route the I2C
-- 
2.51.0

