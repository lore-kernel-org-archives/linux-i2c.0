Received: from naesa05.arrow.com (naesa05.arrow.com [216.150.161.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8E330648A;
	Tue,  4 Aug 2026 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840283; cv=none; b=fnzGTn2/8BpQhOO9aj+LXwQfFxZqeA496TPw80EPlrHS5pg14sZBQcVp0ruc/BaQ9yikY4LLofCrUxiS7058w4PIKDLwxoP5lNkoAfShvGyGzM+uC1M6e/yQs5OuqIe/HEB+tB1+vBhRMaZ67u+h/A64BaExasKgiW9KcXFvUoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840283; c=relaxed/simple;
	bh=l14NkZUeEmSiEliJNOziJ+7kDTrcYuUPelCIBKPHRYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sXGymBjUCb3vkgorumJZ4M95dvzPP90j3MrO/zwMTXC7Pt0eDQH9NzRHfzVw12jDRQ+NamXruLYl/M/9t/9an+z/jsPNRqY+N5NUBFGWwRyy5shVOq17PchANjR1r4zxJta33CdK6ECR70BYS60n/LPHSMu2LJSXSibDksbGWPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=KUom6fKd; arc=none smtp.client-ip=216.150.161.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="KUom6fKd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=einfochips.com; i=@einfochips.com; l=794; q=dns/txt;
  s=NAESA-Selector1; t=1785840281; x=1817376281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jmElgJvR2SxXAb5fMQrJa0XzibcaGBksUwer/D+qE6I=;
  b=KUom6fKdUQG8tTV0dzN5VKrTxLkrE8MIc5BClUTt6wcI30GKjtqo1s5V
   F3tQRT3vdfdSiEvQIOXuYn8i6qZ/qbmCq3/1xGuh3fejFbRD6Xzl+b+im
   s5B8lkO0wCTI+gZmN4euA4SwszP1dY8oPccMDYt8Eoqi4aDocAZXzT1Zh
   P5PLjd6II63RdfDPNNzE3qrKo7b+F5h3w4e2C6BcMGmVQG6rWijg9BP7q
   NtaM6Zicb1tPbfMFWFYjdH0G3mnU5zRQZbl6TV/MTTWUcKGZA6VmdCvBq
   dXfSkMGn5yPkdoWVEe5DrC8B2mPSt3AYvQoHBuij1TXK82JgrYAlWsB6G
   Q==;
X-CSE-ConnectionGUID: bffZQSOBSUGxI5Bw/j7g3g==
X-CSE-MsgGUID: rLRGZas7SZKfwSz7pDkUFQ==
X-IronPort-AV: E=Sophos;i="6.25,204,1779170400"; 
   d="scan'208";a="59629004"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa05out.arrow.com with ESMTP; 04 Aug 2026 04:44:39 -0600
Received: from AHMCPU1888.localdomain ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.20348.1);
	 Tue, 4 Aug 2026 16:14:31 +0530
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
Subject: [PATCH v3 4/8] dt-bindings: mfd: syscon: add ESWIN EIC7700 compatible
Date: Tue,  4 Aug 2026 16:14:27 +0530
Message-Id: <20260804104431.1391839-5-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260804104431.1391839-1-pinkesh.vaghela@einfochips.com>
References: <20260804104431.1391839-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Aug 2026 10:44:31.0712 (UTC) FILETIME=[3B743600:01DD23FE]

Document ESWIN EIC7700 SoC compatible for syscon registers.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index fe882d3f828b..8e24c6be2fdd 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -59,6 +59,7 @@ properties:
               - cirrus,ep7209-syscon3
               - cnxt,cx92755-uc
               - econet,en751221-chip-scu
+              - eswin,eic7700-syscfg
               - freecom,fsg-cs2-system-controller
               - fsl,imx93-aonmix-ns-syscfg
               - fsl,imx93-wakeupmix-syscfg
-- 
2.34.1

