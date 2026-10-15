Received: from naesa06.arrow.com (naesa06.arrow.com [216.150.161.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC955237AC;
	Thu, 15 Oct 2026 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069092; cv=none; b=KKchYat0KtZEJlckOIMWUb3KX9jzZRYK2FvZqgDibkj+olDA8Ip687eYBK4lU7jYibXCVeAwy29STSLyzs5MJ3RUZKj9rV97KmiExaZ0EHhz6MO9h2C840G+NdVhYKNGs9tiQFllJ4iavPzmI0G0HAdV9l2QYY2MHqXAtCnXLSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069092; c=relaxed/simple;
	bh=jw3+3lJtQgkvf5fDUwPS8TNUCR+dBtI2QeQxiyX6HAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hvgt6W56NJTuNc9FW/8qzIKIvEoAATBPpILrTOiWvrG/8dkNGtIFw+Qk0bbp9EbRu0q65ntXcRLma8jSMDGaR4RfzRFZn0iajmF4XaJiHGFJjQ3qBoBBzdyQYDn8YNKG3efyf8Y14t5E+ZaqtPzQr5zTu3i6XyDWoHdKIqzh9QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=XIdYhLwR; arc=none smtp.client-ip=216.150.161.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="XIdYhLwR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=einfochips.com; i=@einfochips.com; l=908; q=dns/txt;
  s=NAESA-Selector1; t=1792069091; x=1823605091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5/2A2ZLlbiY9nslJ7nQB+Yn+IkxiipPp1ULDmEpmnRE=;
  b=XIdYhLwRUeRsoFk5dFqBFweMdI/JcFoBSuq+bobCiEn4bPUwWWxqC8iq
   0AT/Q3pWgALOoiMbXjZbjh4dlZ8oSmoW6RJ5Q2QyNqaOiNrrx3QPulloL
   e7GUPZoaK5v3T/79GGKPvnBcVH4qKBge/ti74L2/B/SBd/W7Bk+7Vs0Rv
   kX9Uv1S0xLYn7jAPZvWdWepV3l4OmPPAO2YDsNK1/3rnSRkvcDg3u5DWJ
   7WDiPx6jZPYpB+XZ2srIoPCijn6S0twYEwXCiE/J2/Lqn7pkpRLnBggY3
   1fFfiyL9QoA+wcWCZQoD4kePn/jISTQcWcHeNR99T4a6mXL3E7T+Cpn8a
   A==;
X-CSE-ConnectionGUID: 9JbbqpsmT/22CGnmvpDL8w==
X-CSE-MsgGUID: hfkNISd3SSGjiBoiFXcgoA==
X-IronPort-AV: E=Sophos;i="6.27,159,1787032800"; 
   d="scan'208";a="66052732"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa06out.arrow.com with ESMTP; 15 Oct 2026 06:54:57 -0600
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
Subject: [PATCH v5 1/7] riscv: dts: eswin: add reset generator for EIC7700 SoC
Date: Thu, 15 Oct 2026 18:24:48 +0530
Message-Id: <20261015125454.1381941-2-pinkesh.vaghela@einfochips.com>
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
X-OriginalArrivalTime: 15 Oct 2026 12:54:55.0138 (UTC) FILETIME=[60524820:01DD5CA4]

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

