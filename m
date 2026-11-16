Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.4.11.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851641;
	b=swpCrMnBwSuy90JUG5XWGNKzE/57C5JLVjIi42XxjwjTPeR1O4LPI3amXdrgqhil6whw
	 yb+37RSOZhgR3pxTpZoIOgZ/Q/mUWmkMR2o7k7NKcZ2HFxBPKQjjDe1kEMKISCi9h9zQR
	 SQMfMiGo52J2hhD8JyRdblOeOAy2XaJqF3wMI80p/4jghf7MB33NU9etja8P80CzpPSi9
	 XHsImTT8jvCJlv6lHaqgk0eQv3N2y6SETPZSqNVu3yvjrl1Kq/4mstuHAdUNrPQGgkWhU
	 2BFfuBeDmxD3ls/65gyr23P4r+seAg8PcOTP8+6b4xra5DjjyXUcJwF53ppja9Pbwzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851641;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=d6JNnFfoaeyGY+wbe6iG5ANoRSPTTnQEghBDjZz1BM8=;
	b=igwuEnuWutcTDm2holN+sHMuevYijOr6Fyumqk0pGJpe7IN5elPzJyTzM+xGSXhLfIU/
	 Swbg8lGqh+/U6IFtx8JsKTloN4FTr5bWYbHX9q09a88Mps0JubL0LFZvidVYgfpcvt8UH
	 IFvEj7SK0CP5oziUldmzG0KEGRJ0KM73Y4dTj01OmBc1ct/V3+aaYnmnUuOymBJpIm2Gx
	 005yJh7nzmH1Y7r/WOHTLDCNUOTWZKcADWi0BR9HWVhoZo8Q6GdQdIOvRKsOmyj9oiADc
	 fZnEuUrTtD0/bN2YH8j7McuEt6WR9St4Im3cQXEfRyCQLppkeIV/6J0j1Rak8XVNNJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phrozen.org;
	spf=pass smtp.mailfrom=phrozen.org;
	arc=none smtp.remote-ip=46.4.11.11
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC15606A886;
	Mon, 16 Nov 2026 17:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DC15606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phrozen.org
Received: from [2a04:4540:1403:e6fc:5f71:2c1e:7d62:945f] (helo=bertha10..)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <john@phrozen.org>)
	id 1xT0tp-004GoI-1y;
	Mon, 16 Nov 2026 18:53:49 +0100
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
Subject: [PATCH v3 0/3] i2c: mt7621: add Airoha AN7589 support
Date: Mon, 16 Nov 2026 18:53:40 +0100
Message-Id: <20261116175343.344425-1-john@phrozen.org>
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

Changes in v3:
- Patch 1: add the Reviewed-by of Philipp.
- Patch 2: add the Acked-by of Conor.
- Patch 3: compute the AN7589 divider with constant limits, so a clock
  rate below 1 MHz cannot wrap it (kernel test robot, sashiko).
- Link to v2: https://lore.kernel.org/r/20261112185820.1315718-1-john@phrozen.org

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
 drivers/i2c/busses/i2c-mt7621.c               | 70 ++++++++++++++++---
 2 files changed, 70 insertions(+), 10 deletions(-)


base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
-- 
2.34.1

