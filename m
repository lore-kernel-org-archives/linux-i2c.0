Received: from naesa04.arrow.com (naesa04.arrow.com [216.150.161.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB6C3E3DA6;
	Fri, 14 Aug 2026 07:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786690879; cv=none; b=HyMtUzKGoagi7S4Mnw7Nn2OKa+ChZdDZugg2zot3PXvL/6CJCKqK0BwAhKshGdZGpVKPixe5ONNLrts5zN0fve8kQ8CUL7gHyP6Llekat3XY/0H3gFHoI35ZrS1BRHZVue1oh9JPjQNUEK1hYzhvdFdF94c5GTqj7e7D23Ce00w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786690879; c=relaxed/simple;
	bh=jm+oE8S/vYQoJ8+K+P6hVT7lG2+3P0noNPeo2sQwZSo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s31OhfdufEfEEJm32Lc9voHnL4KDmD6x5YbnNSvfl/ytxV/HfL1wezjGpusqqUfQL9MhAXiU1QG7nV33bFxDmOBGtvx2A08OWsMTdcNXM0Kfqm22UgK/L3uUhaJ/6uYJyswq9U3WPV+dE+vJIWkNH/gXsaWTHXrtYzcbiLUvjYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=aYDi9iR+; arc=none smtp.client-ip=216.150.161.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="aYDi9iR+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=einfochips.com; i=@einfochips.com; l=1345; q=dns/txt;
  s=NAESA-Selector1; t=1786690878; x=1818226878;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=35kPGPxm6j/S2N/cOMJwAviB4ZxNUz3laule5pBoHr0=;
  b=aYDi9iR+UEnLZHs7o7YiASu6cC1FXkHdSeR4uxrKU2QpjvyZgqBXekjw
   qdMQtGpA7VZlRdFWEFWGy3tJxFhoq8fMiAkwVHKdWU2M2mLsMpMSptmms
   /WogV77DfUFdCKCWALENQ22whkh9g5cML5S9HCzXUdwC/uZ4LIy6oMoT2
   uUgY14899y7M7jmXoJOLGfAwuNR0uqPL70skcSf+iVYcKFe+EBZDy0oeT
   PH2tNIbPAI85d2VqiTr3/S56ncduk7/sWMXzM/nmvGD5iOHB648JqoDyV
   duU2uHdqEMgfr8haahnSn+HVr0KAThTVsQ3rFFfhZVUlFF5mpAiVFl25B
   A==;
X-CSE-ConnectionGUID: c1IId2JLSbuCCRsSYftZqw==
X-CSE-MsgGUID: 0YKAMxzMQaGMuh7X00GLKA==
X-IronPort-AV: E=Sophos;i="6.25,222,1779170400"; 
   d="scan'208";a="119916396"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa04out.arrow.com with ESMTP; 14 Aug 2026 01:00:08 -0600
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
Subject: [PATCH v4 0/7] riscv: eswin: eic7700: Add support for clocks, resets, pinctrl, HSP bus, I2C and watchdog
Date: Fri, 14 Aug 2026 12:30:00 +0530
Message-Id: <20260814070007.1662455-1-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Aug 2026 07:00:07.0521 (UTC) FILETIME=[8A4D3510:01DD2BBA]

Changes in v4:
- Rebased the patches to master branch of linux-next tree having
  latest tag: next-20260813.
- Updated dts file
  - Corrected the pinctrl-0 property for i2c nodes.
- Drop "dt-bindings: mfd: syscon" Patch as it is already applied [1].
  This was Patch #4 in v3
- Link to v3: https://lore.kernel.org/all/20260804104431.1391839-1-pinkesh.vaghela@einfochips.com/

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/Documentation/devicetree/bindings/mfd/syscon.yaml?h=next-20260813&id=d86dadc6feeaa86b6a29db5509bfe8c65b66c7b2

Pinkesh Vaghela (1):
  riscv: dts: eswin: add hsp bus node

Pritesh Patel (5):
  riscv: dts: eswin: add reset generator for EIC7700 SoC
  riscv: dts: eswin: add clock generator for EIC7700 SoC
  dt-bindings: i2c: dw: add ESWIN EIC7700 SoC I2C controller
  riscv: dts: eswin: add I2C controller support
  riscv: dts: eswin: add watchdog support

Yulin Lu (1):
  riscv: dts: eswin: eic7700: add pinctrl support

 .../bindings/i2c/snps,designware-i2c.yaml     |   1 +
 .../dts/eswin/eic7700-hifive-premier-p550.dts | 196 ++++
 .../riscv/boot/dts/eswin/eic7700-pinctrl.dtsi | 888 ++++++++++++++++++
 arch/riscv/boot/dts/eswin/eic7700.dtsi        | 234 +++++
 4 files changed, 1319 insertions(+)
 create mode 100644 arch/riscv/boot/dts/eswin/eic7700-pinctrl.dtsi

-- 
2.34.1

