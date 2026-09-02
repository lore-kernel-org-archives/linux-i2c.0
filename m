Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E953F4A5C22;
	Wed,  2 Sep 2026 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361346; cv=none; b=ixhynbNvYPpXkUGe6szeiMGscCyB3FlDN9TCq2eVWTvk+UobygxfrOey7jGwkg4M5fOB/5Qm5Byj8bY4G9e2RaNkb2kPK89EHxJMt625B2KuNNah6iGWyGJ1cqLBW9tWira1FuqjG+eim7bVatlQxJsH/REYg4ylgddx+Y2qBHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361346; c=relaxed/simple;
	bh=+QqzBRJtOW8hEl3xXcrLNtZtf+nInAKjRJ3jcMmEdZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QeMEe6YfSXa2hSxZgApsPpUaLUuVJeOY7DsRar8HMnLOHQ1uI0B9FRH7/V2SODUtxc/aFpKAdNu/tWFGiVQulA6fzwifDStaidp4o6qO3wcTt3gFqWZr1279X1QMQtGKxZKGqHkPQJya39djIiTLvhDHTUJ0rcP8TV19YFZRLvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=AkCrceem; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=imQpJ8Zw; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AkCrceem";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="imQpJ8Zw"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hZmD74gV1zMlKY;
	Wed, 02 Sep 2026 17:02:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788361335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=REW6E56t0BNqIjoK99pm/nNgLbAFVG/+rWQGeHwzdDs=;
	b=AkCrceemfgnEuPFqu0yegha6CjwXVo0SnlsWyAYY9R2PcQycpsND/URo/FEGRU6Kmhg5JE
	HLtXapPQ4AuOHHvnt3nWg9D6Ppizv7EQmY+dW06wPaYS3HrQP4V+vUCYpsCK+bNjID+HKE
	YaI8GdF4gtGsqloCbPtsJG81TZo0ul1a2NQ0nyD6YkAtnSmrFP39eAF4kPagVc3Rs3/+Ip
	5c7uhIawMOn5oG19Dv8GDQfUSrbMq7PDWHoxabx2/zQMwnpAim9KSmmej8tXXngQJtRbQc
	mHO/jheH64EHNTMq7BQ8zzPy29utNBaZsebbaFWhhyjktAoPiiCu/giD07LU5Q==
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788361334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=REW6E56t0BNqIjoK99pm/nNgLbAFVG/+rWQGeHwzdDs=;
	b=imQpJ8ZwuOU2lfJnbGooURCUVTYJkwevdfaoy1/QzXbVNHCjoh0loEIQwiZoazwTkwNxDx
	98ZOd23XPqLvXpPVRAfiCUpkn9/F+7K7v8A9/vWFOOLPpdV8VNl0Mmjd8iMjJOIU3shrAD
	rTtL0el3XipZ+97f7MgafLCUfMpootXDLT0T+g+Vvhj1rjuN/JuC2WphrC0/42mWKYpzdt
	GdrgF20UDnTMac/DsRseFVVk/TQkWMy/BX/E85KsatmDto3kyiHjuhkzL4ocpep3v/J3E4
	IK6YoD0DBJpJM3mIs3EYkssDIJMT4g3ubuXCxKNe+sbcuDnCeDS7Vvcqd+txgA==
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: i2c: writing-clients: Add missing end of command
Date: Wed,  2 Sep 2026 17:01:45 +0200
Message-ID: <20260902150145.705598-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 88a4ba85d4660291fb4
X-MBO-RS-META: oud14srrbfnz9rh8cd9fz7jcc7uuc44q

Add missing ');'.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
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

