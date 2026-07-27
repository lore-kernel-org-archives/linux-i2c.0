Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E410A403EB1
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155161; cv=none; b=Afai7c1X8ktDARhigzXVefQK7c5AicO4U2wkAe+Pm23bQitjj9JSZ4hYfCFo46pWh9ER0G+o9B6R/Z//0XKaTXt7FVWhi48i7R9/vhZOHepFbz4r3dKplPiNbWybK3KZxxztgMfAUpkmGvoF36HFQ4EGvT9pSFQkrq8Kenbz8ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155161; c=relaxed/simple;
	bh=F9QGWvPZ4+kaLera9LGiRGm/nB+m43WDHgUWy89CATU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gu2Konvi7j/6xmn/zS3WYcCLv1APxFnzvZXRyaopgncF60r1hk9p614gYpSGZv+fS/fO+evgNQAchRuy9fWHNx45ciS33HWlre+KpvYruso0cVdixEX6YivHYMz4MECGVzdkZnN7KsPXV9zr1T9AooG6zIb7zFCFOoZKub7740o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=l+Pvgr6U; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="l+Pvgr6U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=/coXsvyanqCGmy
	5mDGxOXORMfbohzDDVGTRZ6LcI1MY=; b=l+Pvgr6USsEWOm5ohGpHP6gYTeaQ9w
	2GLTMp16ZrfHlt9DLyhg1q7G6cRHeOGIdHrmJ+3U51tGyTfPSxtlliaAKXSJ29xm
	JBNyaCmbXbe+jftC0I/bW6cKVdhuO9DtzsaSKKgNZj8UUA+nd0dnexitKhU6NqS/
	2s3o3ZqW/c+XbMxpxwxEqoVUA8npYQ5TEsComYQVAyZgdnP34WZn2detd62Bpuiu
	3cHTchtem7vP5yDdFHvVlhujFbbjxwZ+EvvHtiS+m2xuJEZIFXOu5GEzvljq9vGd
	mNJkMoupLYcjISfUUhikvyWiDUcll9C/7Nm2OxT7ftp9kzMuF4n2IaWQ==
Received: (qmail 602483 invoked from network); 27 Jul 2026 14:25:57 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 Jul 2026 14:25:57 +0200
X-UD-Smtp-Session: l3s3148p1@RvMG05ZXJL0ujnuy
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-i2c@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2 0/2] i2c: rcar: add Gen5 support
Date: Mon, 27 Jul 2026 14:25:46 +0200
Message-ID: <20260727122546.4232-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change since v1: * require resets, too

This small series adds support for the Renesas R-Car X5H SoC to the
i2c-rcar driver. Not much changes needed, only skip polling for reset.
And add some compatibles.

Tested with a Renesas R-Car Gen5 Ironhide board. Branch is here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/x5h/i2c-experimental

'dt_binding_check' also passed.

Happy hacking!


Minh Le (1):
  dt-bindings: i2c: rcar-i2c: Document R-Car X5H support

Wolfram Sang (1):
  i2c: rcar: add R-Car Gen5 support

 .../bindings/i2c/renesas,rcar-i2c.yaml        |  6 +++++
 drivers/i2c/busses/i2c-rcar.c                 | 22 ++++++++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

-- 
2.47.3

