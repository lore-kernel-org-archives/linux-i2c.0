Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1BC40D56F
	for <linux-i2c@vger.kernel.org>; Tue,  9 Jun 2026 19:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032727; cv=none; b=P7DyxEfPP9Go92dXvLQd2Pf7sh638BZsLhhc30uBfaUveEy3iksTuxTSvGZFHE+65jqZUwJjqh21Pk7zuyF51SKyD0SGVGKhha/+VxQ+X923Krj8iVYaP0k91pvqvKSaIUQeDWcH6XcaBGd+xGLyXLaLY0EJ3nb9mnQDfq8NCs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032727; c=relaxed/simple;
	bh=RXV/PHq06XgAldkOsFPotMbvl1e477O+U6rNxjxuSck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E44ImJW1hoHIz4jn8ISAmxmxlsyEIvMjRy/7W5NMf/yvhBf+8U9Gh88Xn7veVT+38mZXhaN/29V9KpkIFUg8IpXSd90GBJKm12p7y5oipIc8iZfVztkesERjGW+yySTDSGf7ebGNNRI55QzQCdtw/Dhc7fDay54Y1gzeT5E4+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=UXTUhett; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="UXTUhett"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=k1; bh=m
	AbCO/VYkP25Ftu5+PXq7OJjIReokztKQk8IWp8H0yk=; b=UXTUhettkOyhhyNbP
	fhLsEffj1dUiKzsOHwsZX6Fomkn3twn25Q5M+tkKqefX7D0tk3P+OhZdPAJq9aNV
	dWzxNomDGYxhefiMkVf7a6twzboNovZt2xJTZBWQIqtT6c/Idd8Xu/fmfvPEy7Xj
	pv1yZTnPPqADZorKlpVUX7KawyTJPoHruX2voSNAutkaVoAgtTLL3VXMgFv0yVFJ
	k/PP4fgYa5j+DpH2LRbBgArxk6ez7S2hnYogfOWe0WRuc6wCfkSjcDef7c333JiD
	q19TgwGeQGdqcC6GlUZYaU60M0pHEMePIS83tWzjkim0+/9YX7mhwwW5BoHmWBgx
	1qdqg==
Received: (qmail 1394293 invoked from network); 9 Jun 2026 21:18:39 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Jun 2026 21:18:39 +0200
X-UD-Smtp-Session: l3s3148p1@uqqN/tZT2LsujnvA
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH i2c-tools] i2ctransfer: man: make data block suffixes bold
Date: Tue,  9 Jun 2026 21:18:23 +0200
Message-ID: <20260609191823.1772-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Highlight the suffixes for better readability. Inspired by an upcoming
documentation update from Benoît Monin.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 tools/i2ctransfer.8 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/i2ctransfer.8 b/tools/i2ctransfer.8
index 4bdf436..e2dbb89 100644
--- a/tools/i2ctransfer.8
+++ b/tools/i2ctransfer.8
@@ -129,16 +129,16 @@ bytes which can be marked with the usual prefixes for hexadecimal, octal, etc.
 To make it easier to create larger data blocks easily, the data byte can have a suffix.
 
 .TP
-=
+.B =
 keep value constant until end of message (i.e. 0= means 0, 0, 0, ...)
 .TP
-+
+.B +
 increase value by 1 until end of message (i.e. 0+ means 0, 1, 2, ...)
 .TP
--
+.B -
 decrease value by 1 until end of message (i.e. 0xff- means 0xff, 0xfe, 0xfd, ...)
 .TP
-p
+.B p
 use value as seed for an 8 bit pseudo random sequence (i.e. 0p means 0x00, 0x50, 0xb0, ...)
 
 .SH EXAMPLES
-- 
2.51.0

