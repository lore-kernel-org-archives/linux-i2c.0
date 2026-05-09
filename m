Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D63A7F79
	for <linux-i2c@vger.kernel.org>; Sat,  9 May 2026 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778346912; cv=none; b=FeKz0kFcdIhlwJXQ1SCkcnH6mJnXZUSgTYJbZDGxMIl/hFtHCzYYzftX2WB1IyBKrGH/WCDhOZUFEyC5Ifw1jCFeOVkwQtxBWlY57hJ09QHPcoUZReKn7pxbDXKhGnYaV/9/rdlU7JH7Gu3SPWNnPsCPkBN5M8NGLtqNjqqNFyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778346912; c=relaxed/simple;
	bh=ejfC3OgLMcaGBAhgMp/Se2WQ5CZr2HURw4BT3pRZxdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ev/EfaKS9QP/xBK9UOn1/bNZXbEWShwFbabjg6fynwaph9FzOabkV5fJmhqqAsMxsJLyznQUS3DErZNvA4gphk82h7aUn7CaaRhDV5uKa6oXEZNWUsRJpc6GSRfiHgv4H6a/oQC3MkjCOgHSnJWOx0OyJN9JG3wBdeysLi+kHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=XxRLqBJg; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="XxRLqBJg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=2jsNrvji9QaGa0
	qvZFLTjyAJ3MViRIpoh5v66VxiPSc=; b=XxRLqBJgb7cM0aRH8Pnoz7RDlT1yPD
	bpUwxCGGPvFynreif1Xq28TRzppkV30cGye+4g9prOnDIjb/KyrhiOu+t+imzZF1
	bOlpRahT8qFlpf/P4VXrbZjSsUDw5TWq/sNmzdBdfEosi/OkaLESA/5mZkHoZnHe
	lkYFd3Vzx66edUlxpg5XjXyH++pDSfja7wzTsdj1J2VrxYIdg8z0h7l5YQbHu+/c
	WmHldlTpjXAd1d50wGOQ2tQEUifqmFLQ2naMDHGwC0Pv3sZm4anQpDPhbhJPFLwv
	rgViLJakJAkbpa+5IFrv1gQM2iUoI87LWfFBdKyVgHd7fmGKgolWzEPQ==
Received: (qmail 1940244 invoked from network); 9 May 2026 19:15:04 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 May 2026 19:15:04 +0200
X-UD-Smtp-Session: l3s3148p1@SfV/p2VRCpoujnuR
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: i2c: mux-gpio: remove Wolfram Sang as maintainer
Date: Sat,  9 May 2026 19:13:55 +0200
Message-ID: <20260509171354.12263-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The YAML conversion added me as maintainer but I can't recall being
asked nor do I want to maintain it now. Remove the entry.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mux-gpio.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.yaml b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.yaml
index 4a93d1f78f93..d9d4f63a77dd 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.yaml
@@ -6,9 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: GPIO-based I2C Bus Mux
 
-maintainers:
-  - Wolfram Sang <wsa@kernel.org>
-
 description: |
   This binding describes an I2C bus multiplexer that uses GPIOs to route the I2C signals.
 
-- 
2.51.0

