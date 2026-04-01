Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AC530E0FB;
	Wed,  1 Apr 2026 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775066844; cv=none; b=lXjoZCbYYi9IRu3Ra4v5y6XIxVL7rM9sf9QI4GsTo6uLK/ityXAk8NoJkJqHHocIxFQWJRvgxHQ4l8hs471DwFHVYlyFoxX8H487VsaCHCsPzgrVm86gKWYqCBFRHJmJoayNUtXu1NNrTiHUASl9QMDT/siLqBUFsHK2KMQPgcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775066844; c=relaxed/simple;
	bh=P6J/pDQtdzKb099VvUqh3kUI/mTGY3Jovzx7TNHMv1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JK899W1XJFWfAB7bAeo1Zy7Q97/9UlAwhJ5COJL2z5lj2Ua7glo0tXCYvya798nCSZsaEJx4Q+QdDQNgdApiPKQp7Vn2L2Ng3c1dJD80JXVqn/sxXMHqZl0gwD/RK/PjumWeDvYOSpupttArBZXMLfwl3AYosvQONzRIRyeUAfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=OUs7Zx68; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="OUs7Zx68"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 45A4D267E0;
	Wed,  1 Apr 2026 20:07:12 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oDo7rCWxQaSS; Wed,  1 Apr 2026 20:07:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1775066831; bh=P6J/pDQtdzKb099VvUqh3kUI/mTGY3Jovzx7TNHMv1w=;
	h=From:To:Cc:Subject:Date;
	b=OUs7Zx68G6pSPzLS4LoABlf6N7i/XMMz3FGhQ3yY/xju4VGaWFj+RO8Se8YqcNbZV
	 cpOHDTL9WMuePN+E15KjWLY6d28gub3qyF/gGCIrOM21OCjitn5mR8h/BHW3wNOM07
	 RhwguO1emDqcRfIuAkAs6ag6fiH8SmWBbLeI5Jq2BWrjs7x2MArAK7mgxpxTr6gjUC
	 EwsDUNP88f/dueFJd75M75A7LqyenSt8U0br2AK5eEbV6phIPgGk6sDkbAeRYtyiBT
	 6ILqD63Kxj406lIlsKNqjwyIISQJm+ITFj91AjGVhyXvrLXI+GOXZhsaT3LnD9FmiK
	 xGE2rXD5CMg3w==
From: Rustam Adilov <adilov@disroot.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rustam Adilov <adilov@disroot.org>
Subject: [PATCH v6 0/8] i2c: rtl9300: support for RTL9607C I2C controller
Date: Wed,  1 Apr 2026 23:06:40 +0500
Message-ID: <20260401180648.337834-1-adilov@disroot.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series for the RTL9300 I2C driver adds i2c support for
RTL9607C SoC. They are somewhat different to the RTL9300 and
RTL9310 but not enough to warrant a new whole driver.

The patch series was split into patches that add/change something in the
driver to smooth out the RTL9607C support addition in the end and for
ease of review. Because of that, the patch 8 depends on all the prior
patches before it.

RTL9607C primarly uses the i2c controller for communication with laser
driver over on i2c interface 1 or 2.

I have successfully tested the byte read operations on my RTL9607C board
which has GN25L95 laser driver in OpenWrt.

This patch series depends on the patch [1] from Jan Kantert to be applied
first before applying my patch series.

[1] -
https://lore.kernel.org/all/20260227111134.2163701-1-jan-kernel@kantert.net/

---
Changelog in v6
- fixed a typo in the commit subject of Patch 7 "intoduce -> introduce".
- added "Acked-by Conor Dooley" to Patch 5.
- Link to v5: https://lore.kernel.org/linux-i2c/20260326152656.14030-1-adilov@disroot.org/

Changelog in v5
- reworded the commit message in Patch 5 to make it clear that the existing
  devices also have i2c master controller clocks.
- Link to v4: https://lore.kernel.org/linux-i2c/20260323071337.15410-1-adilov@disroot.org/

Changelog in v4
- moved the patch 7 that changes bindings to be before patch 5 where clk
  is introduced in the driver.
- changed the "realtek,rtl9607-i2c" compatible to require the "clocks" to
  be specified and with it moved it out of "realtek,rtl9310-i2c" check to its
  own place for cleanliness (how it was originally in v1).
- Link to v3: https://lore.kernel.org/linux-i2c/20260322123411.32102-1-adilov@disroot.org/

Changelog in v3
- Patch 7
  - reworded the commit message to better describe i2c clock.
  - make clocks property available for all compatibles.
  - change "realtek,rtl9607-i2c" compatible to be under the same if statement
    as "realtek,rtl9310-i2c" for "realtek,scl".
- Link to v2: https://lore.kernel.org/linux-i2c/20260319175753.32338-1-adilov@disroot.org/

Changelog in v2
- rebased on top of the patch from Jan Kantert.
- Patch 7 (to my best understanding of Krzysztof's request):
 - added the "clocks: false" for compatibles that are not realtek,rtl9607-i2c.
- Link to v1: https://lore.kernel.org/linux-i2c/20260314082628.25206-1-adilov@disroot.org/

Rustam Adilov (8):
  i2c: rtl9300: split data_reg into read and write reg
  i2c: rtl9300: introduce max length property to driver data
  i2c: rtl9300: introduce F_BUSY to the reg_fields struct
  i2c: rtl9300: introduce a property for 8 bit width reg address
  dt-bindings: i2c: realtek,rtl9301-i2c: extend for clocks and RTL9607C
    support
  i2c: rtl9300: introduce clk struct for upcoming rtl9607 support
  i2c: rtl9300: introduce new function properties to driver data
  i2c: rtl9300: add RTL9607C i2c controller support

 .../bindings/i2c/realtek,rtl9301-i2c.yaml     |  15 ++
 drivers/i2c/busses/i2c-rtl9300.c              | 191 ++++++++++++++----
 2 files changed, 171 insertions(+), 35 deletions(-)

-- 
2.53.0

