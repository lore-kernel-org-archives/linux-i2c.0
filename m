Received: from naesa05.arrow.com (naesa05.arrow.com [216.150.161.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E36044C66D;
	Tue,  4 Aug 2026 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840344; cv=none; b=FIYkAl+lC2PrDiA+sd0xRNvx7KLM8xxSbCKDN343H5AeoomucEpZFSkExkNxSrnjeDrI/CYhn6FRcI4m1a5qmusiGBwuuCy4j6PZwToWgD4sIA+4YIwfgwaCd/cYEY1R8yw2AzHqjVXbGufyfeiNphxlH+WBRQHQGwl83tHBWOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840344; c=relaxed/simple;
	bh=jw3+3lJtQgkvf5fDUwPS8TNUCR+dBtI2QeQxiyX6HAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q+um6aivgHQi5kKf02BXuglGRKOVXAdCmi3vIUUv0aM1pbjbc6uKSKLVJZNUPFWbVdf3LR6eZwNAVGM8wDCGAZSxtm/+oc76+7FBVvM2TQczGZdf/UdVMOmA9/+ZD7SdyP4cp7qtl4U/kNtWnN2SnJRPW6PrV05D+lEnS5rYkk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=WlhzEnzm; arc=none smtp.client-ip=216.150.161.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="WlhzEnzm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=einfochips.com; i=@einfochips.com; l=908; q=dns/txt;
  s=NAESA-Selector1; t=1785840343; x=1817376343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5/2A2ZLlbiY9nslJ7nQB+Yn+IkxiipPp1ULDmEpmnRE=;
  b=WlhzEnzm/E3HhacoUL3ZJ91dGECeDQk2JRhx+vhVCoS76sZuMGB75QJe
   +316HmMU5WR+THVhRPt9BQG1LNYdCyCHjhrTO0rwJEfEmxXhJ+Nk/shWd
   6L0EI9U2VN4YzrRTRRxB9FCb69H5YuRrUm22caZkQbqa1c0TdVl6ubilf
   /i21dWRKFwUtUKNV7fojPTFAvtawYZ8v1Z4Nx8BPjl0UAhfT0+7abPtoc
   ZB7ilESsuZ/sdpM3huEzKPdVzxBHNFU8NrzYAmR+hnJ97qCUDrFB+8FQI
   lF04iYP9foVL1WTl9WXx1aoQfUGTuPyWuxylCOvQMBBpKJT/WpMdtpTCw
   g==;
X-CSE-ConnectionGUID: ZUZrybezSBOdsc1AmZ5Iew==
X-CSE-MsgGUID: E7/idmQnTIuCGen8xSRXog==
X-IronPort-AV: E=Sophos;i="6.25,204,1779170400"; 
   d="scan'208";a="59628994"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa05out.arrow.com with ESMTP; 04 Aug 2026 04:44:34 -0600
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
Subject: [PATCH v3 1/8] riscv: dts: eswin: add reset generator for EIC7700 SoC
Date: Tue,  4 Aug 2026 16:14:24 +0530
Message-Id: <20260804104431.1391839-2-pinkesh.vaghela@einfochips.com>
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
X-OriginalArrivalTime: 04 Aug 2026 10:44:31.0587 (UTC) FILETIME=[3B612330:01DD23FE]

From: Pritesh Patel <pritesh.patel@einfochips.com>

Add reset generator node for EIC7700 SoC

Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
---
 arch/riscv/boot/dts/eswin/eic7700.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/boot/dts/eswin/eic7700.dtsi b/arch/riscv/boot/dts/eswin/eic7700.dtsi
index c3ed93008bca..430a210f01e6 100644
--- a/arch/riscv/boot/dts/eswin/eic7700.dtsi
+++ b/arch/riscv/boot/dts/eswin/eic7700.dtsi
@@ -4,6 +4,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/reset/eswin,eic7700-reset.h>
 
 / {
 	#address-cells = <2>;
@@ -341,5 +342,11 @@ gpioD: gpio-port@3 {
 				#gpio-cells = <2>;
 			};
 		};
+
+		reset: reset-controller@51828300 {
+			compatible = "eswin,eic7700-reset";
+			reg = <0x0 0x51828300 0x0 0x200>;
+			#reset-cells = <1>;
+		};
 	};
 };
-- 
2.34.1

