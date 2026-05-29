Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A223B27C7
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087914; cv=none; b=te9ZPFzKnIBo27Hq6uzOJ05HTvjikKX/H+PtKhYTb3XidKOLXuzKQ3h4cJrPglvD0y1SuIog+VFjbCev56sEJw25CmtYqs7rAQOU+XczvgO+UOz9unwJCCi0RPxNdaC3J5jU9V5U9kmOouScVq2m2U0gItX1dL4JtM27hY0IfM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087914; c=relaxed/simple;
	bh=Yo2/tpaInSdJ29WU/fOHhV5R7AfBLciNRQ9yaAvNtKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgQsDcjVGq+PUE2abVrVZLt0NujfAf88yc167I92Jw3zqXxyJy1uYfsYhjQO0T4tesnqGzgq58ytfxHMaZA4yy/3NG9C/2z+NkqCfoPnaRchz0iTb3JbWcVrvzdACLsSl3ezh4/UGdyH45tHj+cD29yDzy3heBZYvqveOVGui+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Ut7TLKOE; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Ut7TLKOE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=KTlvM0u73GGeLJ8H0g7HHktjfRMeUEHAZ1TlxkimbDg=; b=Ut7TLK
	OEji1W0dYH2pOKIvk979HlJOzsmo6nnjGP1sivpGB1lvr5rwM7YFhKTwlQQLZrh1
	i5koph72YEQxKqFlCvMdLeLCBMdeM6/yewW1SQbzEV0CHa5u+8b+tVX4opreHeo5
	yTY5dtlCLWDNEgZlDIWJFlNmSVx2CUYnwupvdcH7OOHg/Z+j5if49K7PGaJkdfk7
	+MGF/jGNAQuxsU23erl5nHlGvzx+alAbCVgmkubtJhMaAwuX58k0JaDZKdcwHYBh
	/jroB/2PSUExiTa7/gF4qPWhXnWvwks6UbrZzKq7S80M1914v5RL7c/vtIC4JeTb
	nUjykh/MF7m1zcGQ==
Received: (qmail 1537634 invoked from network); 29 May 2026 22:51:50 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 May 2026 22:51:50 +0200
X-UD-Smtp-Session: l3s3148p1@BmKQA/tSODhdnheM
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH i2c-tools 1/2] treewide: use https instead of http where applicable
Date: Fri, 29 May 2026 22:51:46 +0200
Message-ID: <20260529205147.145266-2-wsa+renesas@sang-engineering.com>
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

Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2388757 # Issue 2
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 README              | 2 +-
 eeprom/decode-dimms | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/README b/README
index 2d342e5..599058f 100644
--- a/README
+++ b/README
@@ -105,7 +105,7 @@ Please post your questions and bug reports to the linux-i2c mailing list:
 with Cc to the current maintainer:
   Jean Delvare <jdelvare@suse.de>
 For additional information about this list, see:
-  http://vger.kernel.org/vger-lists.html#linux-i2c
+  https://vger.kernel.org/vger-lists.html#linux-i2c
 
 CONTRIBUTIONS
 -------------
diff --git a/eeprom/decode-dimms b/eeprom/decode-dimms
index 32e840a..7682345 100755
--- a/eeprom/decode-dimms
+++ b/eeprom/decode-dimms
@@ -2703,8 +2703,8 @@ if (!$opt_igncheck) {
 
 
 if ($opt_html && !$opt_bodyonly) {
-	print "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.1//EN' \"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">\n\n",
-	      "<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"en\">\n",
+	print "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.1//EN' \"https://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">\n\n",
+	      "<html xmlns=\"https://www.w3.org/1999/xhtml\" lang=\"en\">\n",
 	      "<head>\n",
 	      "\t<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\" />\n",
 	      "\t<title>PC DIMM Serial Presence Detect Tester/Decoder Output</title>\n",
-- 
2.51.0

