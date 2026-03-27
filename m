Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C5A42A80
	for <linux-i2c@vger.kernel.org>; Fri, 27 Mar 2026 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774624715; cv=none; b=m/+4gnpjGwrjqcgcixRuw5XskrE+aj8ir9s07NZGBEjuuHGmwabd3432lFoTryaL/T1/zM5k3BKqcc0IfbXrM/rj/2C9pvoovlmMtKHVNnkqPVr7dRdknFMVYrhFfjOzxguTS7OsvlDAZ8fXnbha2l5motvY4Eq5wg+d4A4d3II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774624715; c=relaxed/simple;
	bh=0uRp6e4Z1uXnlslTJNvz0ym5A9pgUIIzWa16jOnZchk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vh5Q2N2lAfPHjRfyhLwudYLPsC4jvfX9NLe1LQ9gNqKU1yLzBlUfcUVp5OqqlwIbdmztcKGh2prdCUqM0buNR7hdxvVncSqCPvfwSvC5O/wNcjqHijNGhh2imbYvvKxwIrtdPjZzHkYrO+EZ6mQrLDcZzKIc+1TSMoCvv145qAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=MlFq7+mU; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="MlFq7+mU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=VfN9cFvhaoSbbR
	vKpIW4U14cCeVCE0hAGXFbJo4Lvhk=; b=MlFq7+mUNgJvYbVg+ilsnuGupSfjqW
	USqIh6ayzrobbD//n5w3NgRaSJgiGdAs76fZauSSbSM73u6HOKAfdjkLZH99oH7H
	2bAamO071+B2j/poDJhnOybYsggoshCUhKck//cxR92YVn5RCwqVrlqKxPewSYAP
	kGdH9uQ35+lFsJzRnALdHMoh13kdZOTWMfdgGPu/EOsrWE4CCiAjhPfcTI4HjU5w
	h/OwGYvbzEvCDgaq0Ai1Goq4ea67y/EacwEo5zi1nnp0OcAXHvGLz8viuSsGUI1/
	M2sgZ3yZMckWfRkWCRTFUuK+fwqWv19kFQicqJk6/chUEwcK5++3BL5A==
Received: (qmail 236911 invoked from network); 27 Mar 2026 16:18:32 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 Mar 2026 16:18:32 +0100
X-UD-Smtp-Session: l3s3148p1@1haPAwNOEYpUhsJN
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] MAINTAINERS: drop outdated I2C website
Date: Fri, 27 Mar 2026 16:18:24 +0100
Message-ID: <20260327151823.5859-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As stated on the website: "This wiki has been archived and the content
is no longer updated." No need to reference it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d10988cbc62..6593e5c7d821 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12009,7 +12009,6 @@ I2C SUBSYSTEM
 M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
-W:	https://i2c.wiki.kernel.org/
 Q:	https://patchwork.ozlabs.org/project/linux-i2c/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
 F:	Documentation/i2c/
@@ -12035,7 +12034,6 @@ I2C SUBSYSTEM HOST DRIVERS
 M:	Andi Shyti <andi.shyti@kernel.org>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
-W:	https://i2c.wiki.kernel.org/
 Q:	https://patchwork.ozlabs.org/project/linux-i2c/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git
 F:	Documentation/devicetree/bindings/i2c/
-- 
2.51.0

