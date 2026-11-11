Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400092;
	b=rgDkHHiWdwdLHzZVjQ3AecZugoEP8BxM7p2n5sQxpe9TbfpBJ5FBnaODB67tB59RNEWi
	 GlPDQRhRjhqrVOEpd8yisV7rGExWTdMJG69bMrHnDvbJgsyZCTsJ4FbJ7TVgO9drzmpSQ
	 lKSGn2TRCIOF61lEIN3PeljOvvuL6WaMcgfzRAEk2JW8+CcWEaywJSsKTjSYHM8425bk3
	 lj+YHr3qbmIsOzgvuWV6XpBQ5g8acTAPPQQ8DXpH/20okbHvl1MXybzjOOCCvfXzbOpH1
	 F6BKjk/dsPmFxh+h0BKkMzo7eV1iiix8pLKUPMjHI4pwczki0vGaZ3wBx06coJw63SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400092;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mzP/hD5ccS5HLOh6OXi3TMiX3x9RKtjHlgkh9vd9DqQ=;
	b=QuapVrIgjg11DpiN9YalQ24qgY6nvz1ZmJxrX/6GJ/7tdohllUaHqemkHIwtHWh0FXDW
	 VTQF5KbgXNCRe+s4oULjGU0IVX5tmXOEttdN+FBd2hvX1Ky6rLMOJ6Zpj9RqqlQ2HhzhA
	 3rjNR3CDkPDREH4AWP3cbOzK3EeYiYoJ4S3a+tFwUKhDgiJXhgzQ45Zsk3QUdpZnLxNod
	 0IA9sCu81Kf30iLAV4dPBy8Xi5C3M+zQFa0MoUeQCV+02eae0wt2H++sdqwLsPK+6Zxz7
	 uDG78t/g8Pyvyi5Ldp54zMVDA6GWvI/Gwy8+rILNNUt4dImTmIyCWkOU79Fx0toi/Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ViJR7wDB;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39913606A31C;
	Wed, 11 Nov 2026 12:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39913606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ViJR7wDB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794400093; x=1825936093;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=blD4c5WFlJsGyIZkMK9gZUtiHG4pn/pmPvN73ciHboM=;
  b=ViJR7wDBdfG6wPQ4gskkPk5q+Z8nP2pj0CVeNNDOmfyDnjfaThXykN4q
   OA2mHZQ+/UQv1r+Ooy+h/QXN9sNxN5KgXlwG1XSqeuOzGZAbUajzjz90m
   vONy2ESktrbkRA43jsOhzffys1lihwyTrvOeX8fHSIqtRv/RxjKKOKwA8
   3ppn9dTANfooKLUfU7rqeGG2oMr0jnAqZnmnGBdb+UbhFFoD+PzE+XM9u
   aJa5HLJCqShgDOHU5zSYG2ypkA20qIUWVthgdKOC2hGz107DKo/EqBlaS
   9vOJbKe85OmEUCyR8IiuCSYFvJgCFYAzqDu0SSMbyEv67kOkfrkQjBrFz
   Q==;
X-CSE-ConnectionGUID: sTPmaFFsQmGqZRnWpkc03A==
X-CSE-MsgGUID: sw2h0A5RQVypE08VZDlvZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3077485"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3077485"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 04:28:12 -0800
X-CSE-ConnectionGUID: 9LbaeeEyS5qnfMXOfgEyMg==
X-CSE-MsgGUID: AX7nRaYsSk2v+Ze6Fr1fTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8984127"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 11 Nov 2026 04:28:09 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 1E59C99; Wed, 11 Nov 2026 13:28:08 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] MAINTAINERS: Update I2C Designware driver maintainer
Date: Wed, 11 Nov 2026 13:28:08 +0100
Message-ID: <20261111122808.1302491-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My @linux.intel.com address will be going away soon and I won't have
access to the Synopsys datasheets anymore. Heikki kindly agreed to take
over this driver.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml | 2 +-
 MAINTAINERS                                                    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
index a73e2a6e0833..56430a35e5d5 100644
--- a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Synopsys DesignWare APB I2C Controller
 
 maintainers:
-  - Mika Westerberg <mika.westerberg@linux.intel.com>
+  - Heikki Krogerus <heikki.krogerus@linux.intel.com>
 
 allOf:
   - $ref: /schemas/i2c/i2c-controller.yaml#
diff --git a/MAINTAINERS b/MAINTAINERS
index efbef2cad7fd..c2a273dd2310 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27261,7 +27261,7 @@ F:	Documentation/devicetree/bindings/media/snps,dw-hdmi-rx.yaml
 F:	drivers/media/platform/synopsys/hdmirx/*
 
 SYNOPSYS DESIGNWARE I2C DRIVER
-M:	Mika Westerberg <mika.westerberg@linux.intel.com>
+M:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 L:	linux-i2c@vger.kernel.org
 S:	Supported
-- 
2.50.1

