Received: from naesa05.arrow.com (naesa05.arrow.com [216.150.161.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E89A4477F1;
	Tue,  4 Aug 2026 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840284; cv=none; b=nIuodY0VQJhlbzuheiRR0XKxMWSYKOygeYdiYDSR4bQke4euRJmNYZG+NvYzW5r1/paKL8EzkrGyQAA7QE11h52+epTcQlzx6JvKkVC5rn51tSyi+uPAv30QENaaXqVZEoSRvym9IShWmxQEMpk6C/8D7ixiHLVjJYG+WWC1d4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840284; c=relaxed/simple;
	bh=IgPFcaWjJKZXYSiDEOt9HHAeookxKAzELEI3gWtwbJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I6wymcA9osz8ozzhIY5SCsYYPBR0VntiTAJPyCR9XNU4VrSZJJAtIy3N4VTNlvlFMt9mkOZ7If4TdCiMEZqcfZ+oEJQj/0mt+fuu0G/+zCtjxOkWdudDXgFIX8mu/y+w+4QfhS0/5uSEtdm+Q1J8t2QefAAbVdCs9iKnJhv/DFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=k4fg2y3I; arc=none smtp.client-ip=216.150.161.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="k4fg2y3I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=einfochips.com; i=@einfochips.com; l=1135; q=dns/txt;
  s=NAESA-Selector1; t=1785840283; x=1817376283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fhMulqfAdieip+w70VJod08BqyqQUojtyVidc3DwEBk=;
  b=k4fg2y3IP/+LRnH+CMXq4umTA8zb9sPNx1oPwGZIITZ8+TREpr8E3/XP
   6u6l5V1O9C6Q+IGSZbUodPADPobSWORnDROF3Ywg8YgoM3JUrTYmoSRbA
   OAMVCz6VGga65Mn915nAmS37mY+PWuWxIAmsNfrEIUfp5xh1cFMy7T9/D
   ay4CzYZ61YTZOzDi99xjL4C+BoZV+VyGsuQ+gxgCRmpqpw9KpHRTFG9H1
   pkOwRXxN+BPfXGJ9sIrDlIt0MPi03PCHDRvW2H4UBFAzVUK3N1+lM6ogt
   NaXTWWG1vnPLFPbGSqb93LSKCcJfIl5vEUWNjjJIxJUpqs1U85aGfUia6
   g==;
X-CSE-ConnectionGUID: rvS3T3juRemI57OTRGZ4DQ==
X-CSE-MsgGUID: zIyuZ8rdSr2Tgr21PrQ3Nw==
X-IronPort-AV: E=Sophos;i="6.25,204,1779170400"; 
   d="scan'208";a="59629008"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa05out.arrow.com with ESMTP; 04 Aug 2026 04:44:41 -0600
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
Subject: [PATCH v3 5/8] riscv: dts: eswin: add hsp bus node
Date: Tue,  4 Aug 2026 16:14:28 +0530
Message-Id: <20260804104431.1391839-6-pinkesh.vaghela@einfochips.com>
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
X-OriginalArrivalTime: 04 Aug 2026 10:44:31.0759 (UTC) FILETIME=[3B7B61F0:01DD23FE]

Add an HSP bus node to manage the HSP CFG clock used by HSP
peripherals. This clock is required for accessing both the HSP CSR
registers and the register spaces of HSP peripheral devices.

Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
---
 arch/riscv/boot/dts/eswin/eic7700.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/riscv/boot/dts/eswin/eic7700.dtsi b/arch/riscv/boot/dts/eswin/eic7700.dtsi
index b16e3e28632c..771a88645d83 100644
--- a/arch/riscv/boot/dts/eswin/eic7700.dtsi
+++ b/arch/riscv/boot/dts/eswin/eic7700.dtsi
@@ -252,6 +252,19 @@ plic: interrupt-controller@c000000 {
 			#interrupt-cells = <1>;
 		};
 
+		hsp: bus@50400000 {
+			compatible = "simple-pm-bus";
+			ranges = <0x0 0x50400000 0x0 0x50400000 0x0 0xa0000>;
+			clocks = <&clk EIC7700_CLK_GATE_HSP_CFG_CLK>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+
+			syscon: syscon@50440000 {
+				compatible = "eswin,eic7700-syscfg", "syscon";
+				reg = <0x0 0x50440000 0x0 0x2000>;
+			};
+		};
+
 		uart0: serial@50900000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x50900000 0x0 0x10000>;
-- 
2.34.1

