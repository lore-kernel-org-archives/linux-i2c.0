Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E5C395260;
	Wed, 25 Feb 2026 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023874; cv=none; b=FBkKGiqxpCTwthZ/EyOKt0hSPtNwKGV+x0RdwTl5pmJxhS6TfZqv/GPFmQF63iteQtd7cSS4ZqQuhdHtWXj1g2AP53syamuZ8GI9ocKXIWZy8fbQIo/GQCDHvLco3EEmCiAZQFx2QShbuHT2Lf6erKIjt5Z1rHp3CJzwUyC0xCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023874; c=relaxed/simple;
	bh=ZXV/yla8bcjxuf0sk96PcDdqZTEVf7gRx6xLOBprjr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oR1j9tWdYAiD4cq2tAo32Em+38zKE8q6s0/dfaFZg25VqbOk9p2oTUXT6YWdPGJu2EOT5Q+o9A4WLKsOevTGcsc33+2ckwUSAd/3gxMZUNWRs7REg+Yu4SGInzTnzrC5dJjCT3qjXE3EJQNBsilfVJnIaEapscQT4AFDUoEFqTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/Ac2Y5/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/Ac2Y5/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772023873; x=1803559873;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZXV/yla8bcjxuf0sk96PcDdqZTEVf7gRx6xLOBprjr8=;
  b=O/Ac2Y5/sbcaVw+oDalax5PKj7bTWyoti75PLIZSq032vWGgcKBSkNKr
   +MjoSqXDnlXvsO5NmOcFOlBEloL0TBqhmfigPohz9IuCxts12f87rLK/l
   hmzKuFsk8079BCXwV4tHokLjrnoWARoSCJMvE3Vf9eEzh0TIa+9QDRyvK
   rs9S0cRU+g7rH+cywDTO+1q2vuJ4G7x8IHF/bGQ+qWaiLVH8iOobOsE6o
   PXIxVO4U0DvYKEj1WmhtpUPVZvuLCHMBr7Je2Ogs8tYWRS3Kwr4LC9fBk
   05U/asxIBzD8BpZ/giuDRPMqBsyB9Th6RBmxHL13rkj/gbIXcuVDTuk9T
   Q==;
X-CSE-ConnectionGUID: AtrNBKCuQ06pgWqumLoYyg==
X-CSE-MsgGUID: KWiYAK5PSeGqTKkhlmmkeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="73032599"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="73032599"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 04:51:12 -0800
X-CSE-ConnectionGUID: TCpzfEuMSt2IStlu0xftOg==
X-CSE-MsgGUID: AthuT+v2SBum/MzknFo40w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="213917309"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 25 Feb 2026 04:51:10 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 31A3C98; Wed, 25 Feb 2026 13:51:09 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] dt-bindings: i2c: dw: Update maintainer
Date: Wed, 25 Feb 2026 13:51:09 +0100
Message-ID: <20260225125109.3794977-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jarkko does now work for Intel anymore and since I'm currently
maintaining this driver, update my contact information here to make sure
patches get Cc'd to me as well.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
index 914200188809..082fdc2e69ea 100644
--- a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Synopsys DesignWare APB I2C Controller
 
 maintainers:
-  - Jarkko Nikula <jarkko.nikula@linux.intel.com>
+  - Mika Westerberg <mika.westerberg@linux.intel.com>
 
 allOf:
   - $ref: /schemas/i2c/i2c-controller.yaml#
-- 
2.50.1

