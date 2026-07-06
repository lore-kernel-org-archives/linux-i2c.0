Received: from naesa05.arrow.com (naesa05.arrow.com [216.150.161.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1562F39B4A1;
	Mon,  6 Jul 2026 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783325477; cv=none; b=k/+Od9I53mhDgSbl24eUmkhPOJ3Y7CbZ+JIEriTMtRJBD59yZWJYA7FzVmxkUoSmrO6L6h53Xhp+Ln+vx7fAdXFMX/RjnGm6B31qAXDNOpwmpHbt3aoqcsfnkxlmx+3Jc1317H//DQMAwcbfU5z9BGShmpJphHTTfavwpZKqAGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783325477; c=relaxed/simple;
	bh=Bm2LXbuRY2QCxWA3H2ncpvTvJY7hXCKLg8kieijRnQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MwzUv6ilJ0j0YoR5LI3Z5sG+zDTT+SWjvuzxUzl2GalsR3xDe3EewqXseFGXpGTSNI0OxndjkEL5TDF9DGBGm2qbY1vqFBpHk9qNVoGA9CgGpDQuO13Ijv2WmOZvzscs+YUn7SmE8E5vQebd+TVLQfzGeodRjnwvC8z1p4zndoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=n58rCKtG; arc=none smtp.client-ip=216.150.161.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="n58rCKtG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=einfochips.com; i=@einfochips.com; l=899; q=dns/txt;
  s=NAESA-Selector1; t=1783325471; x=1814861471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MCUcGL7ydFiRV6Lo3K/hbvbkATG0RhAxhMos+kWz6oA=;
  b=n58rCKtGpg7JqcJuh0ZtnYRqMdn1rw7rfMIZS20nhmE8Ve9NtZsJauAL
   Dj1d8Ge/MgRI8p6p7+7Fn2nPqmt2FMxLIi9Tr1w2zEt1ZQ/59u+8rs+37
   u8Ph7uE5D9AfeMOtOwMFGNclQl1MWCocwHht3/OyfIAJbOhEp40Llese+
   w8sSCT3HYA52iAdoWcreaW/h4pcwxtw3iFh/nQH6TsASEPKFMfc0Hvtmk
   IDYTI5r6RIR2YGEMRbIWI3oxPsffjk4Q29WfLOXgFXeo0PpEk8rXgZAfp
   KiozxrzIipugICxlVrc0Lc4NnTK6JrIP2PXxpPHKCvYs2K+lkesx1T/3O
   w==;
X-CSE-ConnectionGUID: gNM+mqbIRpOkTBU5ziJeOw==
X-CSE-MsgGUID: enMvyqpMSxyEqrRmy2ENhg==
X-IronPort-AV: E=Sophos;i="6.25,149,1779170400"; 
   d="scan'208";a="57540315"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa05out.arrow.com with ESMTP; 06 Jul 2026 02:11:07 -0600
Received: from AHMCPU1888.localdomain ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.20348.1);
	 Mon, 6 Jul 2026 13:40:56 +0530
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
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
Subject: [PATCH v2 6/8] dt-bindings: i2c: dw: add ESWIN EIC7700 SoC I2C controller
Date: Mon,  6 Jul 2026 13:40:53 +0530
Message-Id: <20260706081055.1126275-7-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260706081055.1126275-1-pinkesh.vaghela@einfochips.com>
References: <20260706081055.1126275-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 06 Jul 2026 08:10:56.0161 (UTC) FILETIME=[F893F910:01DD0D1E]

From: Pritesh Patel <pritesh.patel@einfochips.com>

Add compatible string for the DesignWare-based I2C controllers present
in ESWIN EIC7700 SoC.

Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
---
 Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
index 467bdcbb8538..ea3d4d4c299f 100644
--- a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
@@ -40,6 +40,7 @@ properties:
           - const: snps,designware-i2c
       - items:
           - enum:
+              - eswin,eic7700-i2c
               - mobileye,eyeq6lplus-i2c
               - mscc,ocelot-i2c
               - sophgo,sg2044-i2c
-- 
2.34.1

