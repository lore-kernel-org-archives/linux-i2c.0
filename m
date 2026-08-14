Received: from naesa04.arrow.com (naesa04.arrow.com [216.150.161.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2F23E022D;
	Fri, 14 Aug 2026 07:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786690819; cv=none; b=TktsJRblwGTtZox0q4jy72Jr+SathfbOv1hN4oNZo4Fe1Mrxc6FN+0xtNcyX2skByYFdqqBWZ0EYEl/o+36vjMYjNqWGmHGmHlXjYF1R0bPwis0nUXt5yrWS2gfaG2n0IoSJKI/7u8J4FPRT8Qn1cYIt3pCM1ikHl2+rWLkShc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786690819; c=relaxed/simple;
	bh=zhMkW4peb4ffgzKBsDrgfAIZ4eDoQR3OisNYIwJRv90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G/HLMApbGrzEgm3HF+drh3MWIdbyJOWpRcChegQGlob59k8Y1PbK2Kxju2Yl07AlX+wY13gToWCfuQstM7ednfyj+LlQjnjaiUExx2lE1sxVEhMHVIRW/PG8IUuZw7FQznmXmftBoP+Nni6tETHjSaLmZcCuimecfZvzoxSTM2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=gT6MMdvF; arc=none smtp.client-ip=216.150.161.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="gT6MMdvF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=einfochips.com; i=@einfochips.com; l=1013; q=dns/txt;
  s=NAESA-Selector1; t=1786690818; x=1818226818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RFCB65wa4dZGmLVFZqs+LWJsSkVireZtnJei79QMCq4=;
  b=gT6MMdvFjqgTiXFgBvv8AWE2NciPbk5lxhsoSqDKE95SFJm03x/0FLBY
   PTpFGJn0chx9pGJjnwWmt6+afIGDssfort7oA0jmueblHB3gE9XBJg4X6
   j7mxrDkrwV6hXRCj65ka7/O6iO6tGCZndMY2S48fTwQnAGJrc18JyLJO1
   UvA39dgQ34FhxTyxfD+QrdfSJzIWhyhIQw0TJp2bwFMjL6MUxPUaO3WGR
   fv18wQ9AtSWV8JOnC4UAkY8tpRzD9axBdirtQ/71ihN1NcXDw7IKCzJbx
   6cuaj/sFgvxEpOKdMwQSikQHI97z73rADWVEbV+53Zuv458dwTp6iuCYE
   Q==;
X-CSE-ConnectionGUID: dWPD+P3bTmm+KNu0fSjBAw==
X-CSE-MsgGUID: Y8YugGPeSlq5jSTMfOMHJw==
X-IronPort-AV: E=Sophos;i="6.25,222,1779170400"; 
   d="scan'208";a="119916477"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa04out.arrow.com with ESMTP; 14 Aug 2026 01:00:17 -0600
Received: from AHMCPU1888.localdomain ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.20348.1);
	 Fri, 14 Aug 2026 12:30:07 +0530
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
Subject: [PATCH v4 5/7] dt-bindings: i2c: dw: add ESWIN EIC7700 SoC I2C controller
Date: Fri, 14 Aug 2026 12:30:05 +0530
Message-Id: <20260814070007.1662455-6-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260814070007.1662455-1-pinkesh.vaghela@einfochips.com>
References: <20260814070007.1662455-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Aug 2026 07:00:07.0755 (UTC) FILETIME=[8A70E9B0:01DD2BBA]

From: Pritesh Patel <pritesh.patel@einfochips.com>

Add compatible string for the DesignWare-based I2C controllers present
in ESWIN EIC7700 SoC.

Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
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

