Received: from naesa05.arrow.com (naesa05.arrow.com [216.150.161.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E8534402B;
	Mon,  6 Jul 2026 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783325477; cv=none; b=SoL4JUZ2KZT4Y91i6rwCZI750gz6DzjwyGitLZ9YZ/aTWM/xy8DDmb3f1GZ/yT6/4cU2YqQTO+6PPlODrPldupAvCAKP/KxcsbKQD7oi11b9HHIwKRFFjiZpLV6YwKUvYqzX9xA9c1d/vEWGGdXh95gNMxlPE6GJRhOtPp+zBpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783325477; c=relaxed/simple;
	bh=Gu4BDqxS6JFWO6H4l2DoN2sdQebRLWK99ZceaJZbbnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iFbc1GeuKfeqB0zdAOAt4kDYFYOArKDI6ryGsib0nF2UK6YZyZAZQ4sfh2mGaEc1ssRciUsKSn+N+hxQiYAPe2Vp9Fw0XVhaOlOsDeKqI8qv5OJLYErj7E36Mmqhkk8nkBdodgL9AjP/JOsDiAj9N5g199q3//xnb3K+zua6Zmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=MnclCUgI; arc=none smtp.client-ip=216.150.161.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="MnclCUgI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=einfochips.com; i=@einfochips.com; l=1147; q=dns/txt;
  s=NAESA-Selector1; t=1783325471; x=1814861471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x/soSMzIMunRja4pBUpuatUbWTL33m22scGQN9bm8fw=;
  b=MnclCUgI+eqJdTvE1m1nOD2v9BbdtHHYZ27QVJKVVxFTl8WQb75EiJA0
   bFlehXWl7oEBYGX4dqjnFAuhqJ2+WhnkQAMiZZ1rIv54M9ndqEp9Gcp0m
   rYXNeSt7T61aLDOsptg9nBCuOnE+LjbLOQoD6DCg61WVu8s11Ws1KDMjM
   DMuYQrMCl6+4OrUHAi+Ev/1//pT+Ds5jUu45QtXYL9Lk9I4LHWaqwdbN9
   BVeiKPnTymP69Wwkqu377O2DRoJYjri3hMgNOnUoKO8vSH2uU2S+c0Ccv
   rLa13rW/LHmnu/pXY0xZFrVlny5AESl/HhajvpGaptZotWeI/o2KmU6jP
   g==;
X-CSE-ConnectionGUID: T3/7FAKCTUOuP9O9ejn8Gg==
X-CSE-MsgGUID: wbrKJ9ybQ5W7ISqYxRGupw==
X-IronPort-AV: E=Sophos;i="6.25,149,1779170400"; 
   d="scan'208";a="57540309"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa05out.arrow.com with ESMTP; 06 Jul 2026 02:11:05 -0600
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
Subject: [PATCH v2 5/8] riscv: dts: eswin: add hsp bus node
Date: Mon,  6 Jul 2026 13:40:52 +0530
Message-Id: <20260706081055.1126275-6-pinkesh.vaghela@einfochips.com>
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
X-OriginalArrivalTime: 06 Jul 2026 08:10:56.0097 (UTC) FILETIME=[F88A3510:01DD0D1E]

Add an HSP bus node to manage the HSP CFG clock used by HSP
peripherals. This clock is required for accessing both the HSP CSR
registers and the register spaces of HSP peripheral devices.

Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
---
 arch/riscv/boot/dts/eswin/eic7700.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/riscv/boot/dts/eswin/eic7700.dtsi b/arch/riscv/boot/dts/eswin/eic7700.dtsi
index a0fb82f4adca..08067d0c634b 100644
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
+			hsp_sp_csr: hsp-sp-top-csr@50440000 {
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

