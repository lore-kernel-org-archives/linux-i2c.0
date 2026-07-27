Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BBD3F0765
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785152112; cv=none; b=K7x55Eh+spwnB6MU7lBPiibLDnX+uoAQV5n5idAO6bwxJyZE2SfroUhAiAD4x3sOu4rDc63ZHbhn+mAQxHxJ7cS8n1M5mCuuoNqVy+4x0iLgdxCiyeLxfgLlN8462UVW3b6RKSWa6Kin+QtijmvFSr4JRWHF6b+o/9Bw6fbmWdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785152112; c=relaxed/simple;
	bh=X7BOrbOKgVYBaWBjnm17gHA/GSUobwLU4YlTZtFnIS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QgrFbK97CrnPuB2yZXwmXrFmc1nJPkJv7JYNUl0Y7Ad68clsN8l3k5CQwB3qjXlPLbyq2KtnR5QUXXRyRytdNxxkLmATN9ZD8D9zwm/aUknPTn23gJLLlBqXuVXhThF9QR2AgqWPWPITDLcIv2t1gtAaeeVIXeSb46kz7vtKmm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=bRhQ1bOl; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="bRhQ1bOl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=b1qPyzRIxoinFY
	2OA75dNXzOPaDtWK1gRGmwyQZb+38=; b=bRhQ1bOlUxNtS15Y3IdvM+BgyY4Mpb
	rU9payV2iwC7Du7c7/8JeKcMG+N5mb8k/qnjpQWJcJLYMWvvAmw9jOt8F6w46Gtv
	LcGf57c5mXNweoRCt1ViSiotUkng5GXsBpoQQSxRSBGaUEfL+k3UOlYNhTi5N0iH
	MkYTzPAOrYNvZDxSu8io+apXK2zksqhj5ojuB4u1jdkd2/PT8LwrxmUM1LieEWC8
	nrB779/rttjkFvaZ4mdYeAlyu9YBQC+bqe97mj5BYpK8fkIspUrnCWq6uCBXKoz4
	uUQ4MaeG8G6bi9uY8FaHYMBoCldylZucjizvzsbm1dL7aNvan6lJ38FA==
Received: (qmail 589247 invoked from network); 27 Jul 2026 13:35:04 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 Jul 2026 13:35:04 +0200
X-UD-Smtp-Session: l3s3148p1@M5YIHZZXMs8ujnuy
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
Subject: [PATCH 0/2] i2c: rcar: add Gen5 support
Date: Mon, 27 Jul 2026 13:34:41 +0200
Message-ID: <20260727113441.11193-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

 .../bindings/i2c/renesas,rcar-i2c.yaml        |  5 +++++
 drivers/i2c/busses/i2c-rcar.c                 | 22 ++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

-- 
2.47.3

