Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93CE501F56;
	Wed, 16 Sep 2026 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567782; cv=none; b=HjH2PvfV8NH2OivBmOChkdtTkTFm9BQp/TGKRqieJng/ajBgC2528h+1bBl/EmcvQbRYqL4okZ27451IN+nex9xIlWn+dFm+4tFvwPX+7V/CsjFeBnBmEuSstCB1mNtD09p/Nv727h1evQrs0e9a9mxQr8YeNA3acxSRyQ466UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567782; c=relaxed/simple;
	bh=mqCP1vd+vVQs9iAC8LcQ6bSMWylslJgaPR7VcRxbXuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NULz+4cTVGB2NP+SRl6vrvyj9euR5Zcf6DUCgi4kxxo+O0FQWIn5GaxD5lXEfSF06ss+AZfXhIPwig8Z98jJdIshJH0S1bPYRwPZr5fvTToj4qxMwfRBR80PNm0sAPOi4KYXBlmE9SCM1XUkXdU68Pu7zGp97G+4l3J4fPVx2Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=YCTSYzeT; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=uzEGuj9p; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YCTSYzeT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uzEGuj9p"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hlLNv30CXz8ty1;
	Wed, 16 Sep 2026 16:09:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789567775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pDjS7Hp89fLRW1OmThFE6RADU6V/TD9ZWot3AXQ7Aa0=;
	b=YCTSYzeT4u/AtlvDiXpgWnvKeG6i9XSxv9vV3Qegf7Uw8kwGmtUAXqLQNQNI6wNI93pq6k
	xnsA0HawcIse2G6c3ryg2jpgV6xuItk9DimKqXBUAqpTZRcR+ryNV01KX1C27fWJiYCBFU
	Y9kbZh/Rd2ehYH2NwQGsxHkj1PK6TdtiwS0Je960n+OcfGFvJFnoo+LSd3v3QXkr56rU4W
	B/6cWnTG/Tttrs8Vi4jliEgQ9d4sC0vE8XA0VrfoC2lZVLuWVG4fAGaaGg2ANsY2nREXFJ
	O4tRaG6OEof8xajjI1RrVuHHteRKtiP5ad2E+sZItWlZLLH9d9f99FUYNKR4tw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=uzEGuj9p;
	spf=pass (outgoing_mbo_mout: domain of manuelebnerli@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=manuelebnerli@mailbox.org
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789567773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pDjS7Hp89fLRW1OmThFE6RADU6V/TD9ZWot3AXQ7Aa0=;
	b=uzEGuj9p8QMG4g5/ECjPZ8JGf2cxIRuCQkCK4oWLvc1EKR/Sq8iJIXfmEAMGoOulq5CM3y
	jcHFxIUzn0rKJ3Piot11ANfRjPmKa3ITP8mBJyUdGrph9aeXEptfv2OcTZcXQMCWlHvshr
	tFEoGpf55vyND1rEE28fZBnwkX0FJel8rGKHfrACjPrHtJcWov2sdsrc3YAyhY+EvKslOn
	ISqCthwVWuJUGrI8aIEL4tU3Egjqba358AOhuR8SVuS74qm3JfOdXXFFw9AD0ZgGsmU381
	stP/dH5hQwk4InqH5LnV4QFbGrN6qZVNFuwL9i6TuwVHBcUpIE2ETJdHjw/BIg==
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] docs: i2c: writing-clients: Add missing end of command
Date: Wed, 16 Sep 2026 16:07:52 +0200
Message-ID: <20260916140752.329836-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 89fihszirr4xdfzxchh1g8rjczfmtnk1
X-MBO-RS-ID: 13896d3c5b07b5843b5
X-Rspamd-Queue-Id: 4hlLNv30CXz8ty1

Add missing ');'.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
[first send]
 https://lore.kernel.org/all/20260902150145.705598-2-manuelebnerli@mailbox.org/
---
 Documentation/i2c/writing-clients.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/i2c/writing-clients.rst b/Documentation/i2c/writing-clients.rst
index 121e618e7..8bab8b16c 100644
--- a/Documentation/i2c/writing-clients.rst
+++ b/Documentation/i2c/writing-clients.rst
@@ -258,7 +258,7 @@ Driver Information
 ::
 
   /* Substitute your own name and email address */
-  MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>"
+  MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
   MODULE_DESCRIPTION("Driver for Barf Inc. Foo I2C devices");
 
   /* a few non-GPL license types are also allowed */
-- 
2.54.0

