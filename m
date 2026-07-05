Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C522F8EB7
	for <linux-i2c@vger.kernel.org>; Sun,  5 Jul 2026 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783275058; cv=none; b=agjv9wz6dGrNlam2e0+5iMj9AoGF4Rpkey5QcEdMlMxtq2e3dtQTw2vAE+T3kIYeVeOOzT6aLb5xTeMozgqZJwSxsm3rUi/i/uiJdOsi8bWldmtfkfzpvJpa8bpEb18QJDa/Xd2EnQMP93eNNqbG4DvMqMRy9ZF5jI9efaw3IdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783275058; c=relaxed/simple;
	bh=2erSDTwjeamZfRCwUaYf3lkTICbXv8ENuqhMEX7jtzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jSaOEmROJl3iXQXq17WUoYOHLN4X8dOSoRtKipLOBqh2ufKt2H5O+yifstDiCXscOhjX+XEAUUP74jzOcQ3DC/ZRx8d7U/OBXi6y4R4YKvPZlfkcOQEBPXH0BBjLXne7bovyI+zRVbaOGLuDBxNNDHTwx9VjG66LG/8OvENxIdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=RSib451n; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="RSib451n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=k1; bh=N
	Ly1UKZLvQ7OUQ+CaqIBju4kla/1txmQe59TWtmcuuY=; b=RSib451nYlihw9DiF
	sDwZgRiFBSeeN1234cphdS6f81cv8W64IlBMr85wZL0mJkh+X0pXcmxTQasGjmeb
	xz+BUb8o5HGo4la52D4LnPX3EjgxIMAxN7PqZD8OvOWQF+wzBzKycWfbrPAUaWbm
	k2+hh8XLEqXo/Wc8Nod3xEjiRoDFD8J8Vtvb7dCHpswOAn/QnvJNvWSOEeg+/Wmq
	RxxhC1nIrEuGUtxLeFECjJWiSXFAK+R/SnhLX4+bVMoL9gKBWorRwidWlehGlR9R
	38XWZ5FoTdbkK87/OmIOkwTYvbsltTKw5hmMJjyerwymuR/PYvEHliGtfmEJIsii
	q54oA==
Received: (qmail 2314655 invoked from network); 5 Jul 2026 20:10:51 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Jul 2026 20:10:51 +0200
X-UD-Smtp-Session: l3s3148p1@JYnxE+FVGittKjOS
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Stephen Horvath <s.horvath@outlook.com.au>,
	Brigham Campbell <me@brighamcampbell.com>,
	=?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@bootlin.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH i2c-tools] TODO: add file and describe items for the 4.5 release
Date: Sun,  5 Jul 2026 20:10:42 +0200
Message-ID: <20260705181043.3757-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We need help, especially with tests, for the next release. To make this
visible, document the planned items and explain where and how people can
participate.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 TODO | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 TODO

diff --git a/TODO b/TODO
new file mode 100644
index 0000000..290e610
--- /dev/null
+++ b/TODO
@@ -0,0 +1,23 @@
+Items for the 4.5 release
+=========================
+
+[.] make i2c-tools accept bus paths (Brigham Campbell)
+	[x] patches available: https://lore.kernel.org/r/20260530-accept-device-path-v3-0-20c01b8f6726@brighamcampbell.com
+	[ ] reviews and tests needed, please help
+
+[.] add DDR5 support to decode-dimms (Stephen Horvath)
+	[x] patches available: https://lore.kernel.org/r/20260629-ddr5-v3-0-07f45075a51a@outlook.com.au
+	[ ] reviews and tests needed, please help
+
+[.] add document to describe the release process (Jean Delvare)
+	[.] he agreed to the idea and wants to provide it
+
+[ ] print I2C_M flags in PRINT_HEADER (maybe Benoît Monin)
+	Benoît agreed but did not know when he has time. So, if someone else
+	wants to do it, happy hacking!
+
+[ ] utilize CROSS_COMPILE (maybe Wolfram Sang)
+	Guenter Roeck once did it, but his repo is gone. Merges still exist:
+	https://github.com/arche67/i2c-tools/commit/60581c572354dd5dbe98b78e3a0431cbc1167330
+
+	But can be written from scratch, too, of course. Any volunteers?
-- 
2.51.0

