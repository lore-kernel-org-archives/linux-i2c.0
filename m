Received: from naesa06.arrow.com (naesa06.arrow.com [216.150.161.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CFA4D9548;
	Thu, 15 Oct 2026 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068907; cv=none; b=HGH1xS44zWZI2aptEFzcBNsyQbAKLDeC+aD8I513vDQIcbyGMT/NNBjub1Gr287bqGOpi9Em0xBrQKoNpLpM7LJEcqH8DWLF0zcnM5XgDBH87DxfIhY7T64so0FdxeUING7ptMcQYebKqcsnbUMu1/nQsqsulDLW4RWA5p0XpG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068907; c=relaxed/simple;
	bh=EJu6DxH54Gw5adnAm0IHXB6UtK7blcWKzs3BBpauYX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AYg2AFnBCXL7dhV+9Dj/5X18t7JQFC9GWwweBTpvP46LOWKh9MWD74yD/lFfw1okJVBZOMBcUIJYj5Pw0rKaGumuVAq9nEWUZB5MJaVN5DqaJzYGtAZu6u9lWwFm4SVEg4ulGIgpA/ltsh63ieDZJN/3OjujX//PqUwVfStkCO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=ZjlzSR4L; arc=none smtp.client-ip=216.150.161.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="ZjlzSR4L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=einfochips.com; i=@einfochips.com; l=1059; q=dns/txt;
  s=NAESA-Selector1; t=1792068906; x=1823604906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pGoJaqzf0Pm13/tc1znKfx68RvIc/HqnuBFWlxbKnd0=;
  b=ZjlzSR4LqwBIKYvIQtvrauAN0uEtPR+SyPR4+P21z5MQkDs1LYNQjxWH
   V7xqxQGJf9bFoq12zg3ckwKBxTl0rpis1oUa3ZFWM8qV4oPeBHHAVz++9
   PyzQdcY/M85iu7uxJ0V3OY1gyFHKVxdUq5qWpsc5XQCWEWWdnRWtkmF+K
   v0IbS04fIfWnGoatERwsT8ZWK9Rx4G1ehoI1FiOljTPpIb2SGC+Ywmt5C
   8FOzEYgw8TzExSnNKJBNfnkVI3o8n14TCEYoLu6/oq0StUwTkKfwOod7q
   WnpNT5deZkl9W80slrV3xTJ+p99O4uL0+GF9nwg0KljnjMeG7gJmheku1
   w==;
X-CSE-ConnectionGUID: b2HqlNGoTu6dY7zBVQRKCg==
X-CSE-MsgGUID: ZKmNGI22Sx2Ubadu9wwDPg==
X-IronPort-AV: E=Sophos;i="6.27,159,1787032800"; 
   d="scan'208";a="66052750"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa06out.arrow.com with ESMTP; 15 Oct 2026 06:55:04 -0600
Received: from AHMCPU1888.localdomain ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.20348.1);
	 Thu, 15 Oct 2026 18:24:55 +0530
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Min Lin <linmin@eswincomputing.com>
Cc: Yulin Lu <luyulin@eswincomputing.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>
Subject: [PATCH v5 5/7] dt-bindings: i2c: dw: add ESWIN EIC7700 SoC I2C controller
Date: Thu, 15 Oct 2026 18:24:52 +0530
Message-Id: <20261015125454.1381941-6-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261015125454.1381941-1-pinkesh.vaghela@einfochips.com>
References: <20261015125454.1381941-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Oct 2026 12:54:55.0294 (UTC) FILETIME=[606A15E0:01DD5CA4]

From: Pritesh Patel <pritesh.patel@einfochips.com>

Add compatible string for the DesignWare-based I2C controllers present
in ESWIN EIC7700 SoC.

Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
---
 Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
index a73e2a6e0833..76f09b68bd51 100644
--- a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
@@ -54,6 +54,7 @@ properties:
           - const: snps,designware-i2c
       - items:
           - enum:
+              - eswin,eic7700-i2c
               - mobileye,eyeq6lplus-i2c
               - mscc,ocelot-i2c
               - sophgo,sg2044-i2c
-- 
2.34.1

