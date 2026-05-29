Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776E13AA9D4
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 20:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087915; cv=none; b=hct43S+qB4AE154uegHfSr1DcjDE0qhTasGUpxUWH/WeZ7Fl3/grQkKPj+M7kxtMhzlPiWutHBfr9EUWzgeJTcjZvQOAYUtic8nCDFhArkiECPV7eOQnYS2fb7mTzsCiokl9PgMw+pZsQ17WeuibAYsFQ0w4iVqnCgD5im328ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087915; c=relaxed/simple;
	bh=2HqyQ6uBx/RpHJMS7qxHhWzlU8abaLSlW9gM1JP/ydI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJCIpHRxzcTXAU5KPSIwa7flISEgbAUHFyVTf6IgwaWxr9Ux1Ui7MiHQ23bAXxvoVCTskG0GIk5FLyzHn8EjtzLJkByLoI2MOX4FoR7gOG9RIV6czUuSCMgBvjGg/dCaXe+wSv7VEjMAP4nuVnbweJccATvh2qKjCEzLB7pSrps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=d3AmSewI; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="d3AmSewI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=amv80XrJCfMDm5CYbJmwUkAa9FDhPSnkwmb3VijiIf4=; b=d3AmSe
	wI6JAKCDPz7RYJ5ydJXliQAfCVFA2o8qLs49yny23IPQf9fWu59J0DNtqkNAuhtp
	liVBFj5+j2MR7nU6hLBJ3fAz1ZczZOYj2dWafJXZpp5ATgasg9JJPohbHPQVK/iN
	EvWdqn+dKw/RmdwXol435I7Lktnd6x6Jxw3hQsjSGrZsM8AB7aqpJ3k/hVKKKXPu
	jDnjKtAksOY3fSmwlQ/Z+P/5BvliLhSiI8P7ufy1pJSswIcveOZLjRmpbwOGMGh0
	bwBH8lbwDrbb4Z+7jhRZywJ0JBhlFQKk8xnpaR5lTvMgunDD8kqHAqkz3PiONHHa
	tmf590C23bO66Tag==
Received: (qmail 1537661 invoked from network); 29 May 2026 22:51:51 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 May 2026 22:51:51 +0200
X-UD-Smtp-Session: l3s3148p1@Q7mdA/tSOjhdnheM
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH i2c-tools 2/2] treewide: update outdated links
Date: Fri, 29 May 2026 22:51:47 +0200
Message-ID: <20260529205147.145266-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260529205147.145266-1-wsa+renesas@sang-engineering.com>
References: <20260529205147.145266-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jean's page has moved, point to the new one. The I2C wiki is stale,
point to the download folder. Add a link to the git repo while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 README             | 5 ++++-
 eeprom/decode-vaio | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 599058f..502132f 100644
--- a/README
+++ b/README
@@ -9,7 +9,10 @@ applications. The tools and library compile, run and have been tested on
 GNU/Linux.
 
 The latest version of the code can be downloaded from:
-  https://i2c.wiki.kernel.org/index.php/I2C_Tools
+  https://www.kernel.org/pub/software/utils/i2c-tools/
+
+The main repository can be found here:
+  https://git.kernel.org/pub/scm/utils/i2c-tools/i2c-tools.git/
 
 
 CONTENTS
diff --git a/eeprom/decode-vaio b/eeprom/decode-vaio
index 74ab633..a3cb391 100755
--- a/eeprom/decode-vaio
+++ b/eeprom/decode-vaio
@@ -20,7 +20,7 @@
 # Please note that this is a guess-only work.  Sony support refused to help
 # me, so if someone can provide information, please contact me.
 # My knowledge is summarized on this page:
-# http://jdelvare.nerim.net/articles/vaio/eeprom.html
+# http://jean.delvare.free.fr/articles/vaio/eeprom.html
 #
 # It seems that if present, the EEPROM is always at 0x57.
 #
-- 
2.51.0

