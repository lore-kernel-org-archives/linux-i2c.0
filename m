Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.4.11.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509915;
	b=cCdyFdnqvV69mAMouUQxFeMF+gkIl3AkUZHTzJCvCvVMum6HhruUqC0KmDsAsYs9AzNt
	 uFwZjXPufleOeNklht7AJNZhcZVL3tYb7pNS0ppSS7Sgn5jQVVB1kf3F9ZV32UqKQSD3z
	 Rnz+Y2GzHsKMlmadhhrO7oK6iIoZYGy2pTQMhiwxZk5853OX9TtlWU05bTj+IMnIUX8rU
	 H7RecHg8YsN3ThhYtkWG3WtwQu/xcscxVjdPCatjnPDXzR6M2ZWzkOzNsBHqw96Sf3Sf0
	 zux1XEumggDQ/KSUKlEL8Gkhdnk1u7PjdDIYSk1yHIfEObI8AXQc+dSQY1SelGeDAZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509915;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0J35JZ6m+w9sBvce+BHkK7sHy2n6yiNgOnlVQ5/R2aM=;
	b=Lxi50r7296l/aAvtAuljK3aAWgXlbnCL+aYYwA7gq2gmFVVfFsJ3OhLfHvwwk0MXIGFc
	 OOWzSDgDJFV//afmLlqGYGcMopx72qTAChurjn//AvXOw6qQSIbLrvxCitF5w23yx0oqF
	 Sr++8IXmpioTp5y3H8DmiOfaRjVfAFC50E+8NZ0ECeJC3sw1rRs4jUwmBj2K8hauoJJeA
	 ksP5YC/Bx/sl63ObIA4rIvclbi1xONj/Higz06nZLmjx8d3D8oU016HNclI4kJfCYjPFu
	 mQXwrPEV4lY3m7Q3sLpeliQEQyVPWIl2mNG9GsJcxcuR5XGewExdJViSBH31fURNd0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phrozen.org;
	spf=pass smtp.mailfrom=phrozen.org;
	arc=none smtp.remote-ip=46.4.11.11
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BC0606A32A;
	Thu, 12 Nov 2026 18:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77BC0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phrozen.org
Received: from [2a04:4540:1403:f2fc:83ce:6656:246:c906] (helo=bertha10..)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <john@phrozen.org>)
	id 1xRa0A-002Xe4-2W;
	Thu, 12 Nov 2026 19:58:26 +0100
From: John Crispin <john@phrozen.org>
To: Stefan Roese <sr@denx.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	devicetree@vger.kernel.org,
	lei.dong@airoha.com,
	Linqi.zhang@airoha.com,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Rajeev.kumar@airoha.com,
	upstream@airoha.com,
	Weifeng.xu@airoha.com,
	zhengping.zhang@airoha.com
Subject: [PATCH v2 0/3] i2c: mt7621: add Airoha AN7589 support
Date: Thu, 12 Nov 2026 19:58:17 +0100
Message-Id: <20261112185820.1315718-1-john@phrozen.org>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Airoha AN7589 carries the MT7621 I2C controller with a second
control register that holds a 16 bit clock divider. It runs without
SCL stretching.

Patch 1 resets the controller with reset_control_assert() and
reset_control_deassert() instead of device_reset(), as the EN7581 and
AN7589 reset controller has no .reset operation. Patch 2 adds the
compatible, with mediatek,mt7621-i2c as the fallback. Patch 3
describes the variants as match data and uses the wider divider for
bus rates down to about 3 kHz.

The series applies to next-20261105 and has no dependencies.

Changes in v2:
- Add patch 1. It replaces "clk: en7523: add a reset operation" from
  the clk series, as Philipp suggested.
- Patch 2: add mediatek,mt7621-i2c as the fallback compatible (Conor).
- Patch 3: the extended divider supports bus rates down to about 3 kHz.
  Set it up before the controller is enabled.
- Link to v1: https://lore.kernel.org/r/20261111093941.691801-1-john@phrozen.org

John Crispin (3):
  i2c: mt7621: assert and deassert the reset line
  dt-bindings: i2c: mt7621: add Airoha AN7589
  i2c: mt7621: add support for Airoha AN7589

 .../bindings/i2c/mediatek,mt7621-i2c.yaml     | 10 ++-
 drivers/i2c/busses/i2c-mt7621.c               | 69 ++++++++++++++++---
 2 files changed, 69 insertions(+), 10 deletions(-)


base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
-- 
2.34.1

