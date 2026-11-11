Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.4.11.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389995;
	b=GVwJ0pbyOuSjJUISEDUDxEXKnQR8TnEwcfCgCe3/A6KzSEtlLVh6C/S2IQyD/onpzwpi
	 hZzZqmEFSDSjW9+x9iFQ720nwNIZ+dRQE8Sl6PHyMYOL3qaVezda0QS0+QYXJ1SGXc6vt
	 UnuO5F6b0FBNIZT3+g2TXC4JhS+KibE2SK02aj7fm5TCFRXJmS9UUo3uePW2gIUZYXT13
	 TZH6FdhLlxL9mP0uhYKzKfGDRFgL2u5DfAwNKCLODmC/cKlCBzucUBdpbmTv4KHRBuMLf
	 ukrKtYVoLVZJ2pVLZuhHg6eCIUSyOLF33ARBf8HLv2VrhxPC2lFkzN2oWBHzdcK5r2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389995;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=abWzQtHrt+TjxHKzP0zeTEI+lW/THVkeGvJ2EFubgB8=;
	b=UlYoX4NLzjcsW481ziV0W1JReTvWp4GyTV5ZGlmOihye5h3wYoqZ8r4Y+Kx6hxAtz8rc
	 iUmmZJRb1qdGrZl+dt4zRLCwrTHwColTAA+jnQof5e3vgTyx901AFEjp+dgJTEQKd1xH9
	 4lekXPWQnyRqnAPnudeC69s/9Zw2Gi1FjyIeSPvr/CdnnfBaxfLfnL+k4jMPuZ27bmYPj
	 FoWmdQlivknbL0mxBktxb2prOSAPOTaYMlyvgwSCyOAKOkVNIF7uIuWkfX/rN/N3kqMYK
	 JrDGs4eMUAlc6Mn1CFZW9RsEk2J5z+/e59L6HcQuIhOZimEO4bYaM6x9Jb83FJNExrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phrozen.org;
	spf=pass smtp.mailfrom=phrozen.org;
	arc=none smtp.remote-ip=46.4.11.11
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ADE606A33A;
	Wed, 11 Nov 2026 09:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25ADE606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phrozen.org
Received: from [2a04:4540:1401:33fc:b262:f9a8:847e:6650] (helo=bertha10..)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <john@phrozen.org>)
	id 1xR4ny-001U9u-2v;
	Wed, 11 Nov 2026 10:39:46 +0100
From: John Crispin <john@phrozen.org>
To: Stefan Roese <sr@denx.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
Subject: [PATCH 0/2] i2c: mt7621: add Airoha AN7589 support
Date: Wed, 11 Nov 2026 10:39:39 +0100
Message-Id: <20261111093941.691801-1-john@phrozen.org>
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
control register that holds a 16 bit clock divider, and it runs without
SCL stretching.

Patch 1 adds the compatible. Patch 2 describes the variants as match
data.

The series applies to next-20261105 and has no dependencies.

John Crispin (2):
  dt-bindings: i2c: mt7621: add Airoha AN7589
  i2c: mt7621: add support for Airoha AN7589

 .../bindings/i2c/mediatek,mt7621-i2c.yaml     |  8 ++-
 drivers/i2c/busses/i2c-mt7621.c               | 58 ++++++++++++++++---
 2 files changed, 57 insertions(+), 9 deletions(-)


base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
-- 
2.34.1

