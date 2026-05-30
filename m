Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C834315F
	for <linux-i2c@vger.kernel.org>; Sat, 30 May 2026 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780147789; cv=none; b=THJo4kkUfzSf0YO758UCCDn22xwm6wlGOwsaXfU3fY2CQaRn0ShK777q/cW+C3IdKV1ZokwGtj42hsEEKn82C+QvnGMbG9ljfigxrF7NNeORPJHmcF8CAzt5+I4jxn6o59ZDVFEeMHkBA3xcTqPkG7u5o3BSm7aGDBCM3aSYo0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780147789; c=relaxed/simple;
	bh=XsVvoWj1wZ2iA0uIOQcCz91YXiMxnLMyrmgIFGuHtfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HbC3keE9j+ttwuQ8FgmbTJNl7wz7NhaejH5MGJaAbyJsoiI3PMqC6a7ED7caomsWqnHLjMsupfBbS0XWlZXemVuOp6ogt623WfIm0erEdjXSoTiqB3TRKmTwNojljIo04T9En/yyH7TwDGsslzqQNG7cpflhDlqPAXgzqy8nw2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=RAAa2E/M; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="RAAa2E/M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=hlut9sFSQFfDH0
	gBMrfHdAWEb1cFpLOqiufv4c4O4ro=; b=RAAa2E/McVBwHg3cI42e3taomRke2Q
	lSvQY9IMeRuAy2uaepa0DP5WNdb5gxvXqC1xROYqnkef63nfVviWJAieMUZVGHqj
	WBtzvh+bbgMUchGeas9y0K6SwfQ2KceOqtIjzKycoPqeaYgdvvgEKxhNSP15HhEX
	hkt20pQyh2cA7HW+lYEewjqoItBPcIChWDkwEznOR4k/FXb0pleu6Z6kVlNCaw7w
	31KJUQ6nWwJWPii+OU7aisjXgLM7PHh6uvuzO9/H5P+AklkNEemqL10/CG4YJc/T
	wTduxRc7rzbGdcwyx1Sm0HXpk8Ai6NxEIQK3pSu1IRUi5aGLwLQoD0NA==
Received: (qmail 1756049 invoked from network); 30 May 2026 15:29:41 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 May 2026 15:29:41 +0200
X-UD-Smtp-Session: l3s3148p1@8rIm9AhT9rgqAQ4KEBW5QLbOwWyJKVt/
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH i2c-tools] py-smbus: update outdated link
Date: Sat, 30 May 2026 15:29:34 +0200
Message-ID: <20260530132934.2818-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The I2C wiki is stale, point to the git repo.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 py-smbus/setup.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/py-smbus/setup.py b/py-smbus/setup.py
index 26db33a..59dfa7b 100644
--- a/py-smbus/setup.py
+++ b/py-smbus/setup.py
@@ -10,7 +10,7 @@ setup(	name="smbus",
 	maintainer="Mark M. Hoffman",
 	maintainer_email="linux-i2c@vger.kernel.org",
 	license="GPLv2",
-	url="https://i2c.wiki.kernel.org/index.php/I2C_Tools",
+	url="https://git.kernel.org/pub/scm/utils/i2c-tools/i2c-tools.git/",
 	ext_modules=[Extension(
 		"smbus",
 		["smbusmodule.c"],
-- 
2.51.0

