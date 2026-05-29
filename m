Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ABB3B47CC
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087914; cv=none; b=U3/PGX1dm8dvwvpAYnW9YFbmlTSpqhY2+ywRBT3xuA12SQGXHnSgGg/N05lCXO0sapcMm03DrY0xuwBBKr9Vo06Bh1IF8bzRKfhmVSU/jvYRV41l43s33FaJXYe+sCts8cmCVCPVKD5U9ku0uzc1Rgo6lmdtQNOA7c9Wo/teqow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087914; c=relaxed/simple;
	bh=RfBeNtGcMCGT8GgyKTP/EloUHhD2UW4CYRQP+N/hzCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YBGlSF8i0W5D6S84VJuXVp5bUhlwtjdd/HoTuisD0Fl4UC5ggaQOt/hXl3NkHe79WnQBLTu4gd58wnnyi22TesWbSC+hcGorGDa/ZNLqyOmM5nPD6zYVg/GPTz77rDg2uSRgoAeDkXkzuscAY0g836kN8MezXaJnPcKnIARryO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=U9K6vaWv; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="U9K6vaWv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=0ievDCA3FhS5zI
	wobEFrTTryNYU9UD1tAjr7ajODSNc=; b=U9K6vaWvjz7WNO8RdwwxybessWmULp
	ccpC7SpZYci7aOkAHo2+GUfYeIWJFl9UL1tA/IhDtQMFSZCFAqsZORpMohKVtvOB
	A3y0D4DsdyzztwXPzterv6GRCx+9eu4Ps8sGz2WawuROu8INqZLon4zWGB2uOcwt
	9z1FzR8yeEZrL0V+vOHPvgMTiEdisd6WgtDiKdWQIp4VpAGNazusdZ0sKBJpt6v7
	aH+zq396BbgH+gvlxq9zy/nJHWt3w+FajihIMIgXROs7fEW3Vx5W1gc0fmSjapZq
	WO75yR7cnyw884UoVlV2ysz8U6ha2bu4cBga2dRuFSVYLQUAwdBEdpBw==
Received: (qmail 1537595 invoked from network); 29 May 2026 22:51:49 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 May 2026 22:51:49 +0200
X-UD-Smtp-Session: l3s3148p1@4AWCA/tSNjhdnheM
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH i2c-tools 0/2] treewide: update hyperlinks
Date: Fri, 29 May 2026 22:51:45 +0200
Message-ID: <20260529205147.145266-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While looking for i2c-tools related bug reports in distributions, I
found one report mentioning the outdated use of http. Patch 1 fixes
this. It further made me check all links and update outdated ones. This
is done in patch 2.

Wolfram Sang (2):
  treewide: use https instead of http where applicable
  treewide: update outdated links

 README              | 7 +++++--
 eeprom/decode-dimms | 4 ++--
 eeprom/decode-vaio  | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.51.0

