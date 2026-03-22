Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6647C1A267;
	Sun, 22 Mar 2026 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774182938; cv=none; b=ANDZrsC6eQq8apkSRUSgoKNrPG4bwvmSYQSaKrQ3D/b/ICzMfud+dR9MEOCZ2RqRPDl0ecsgZ17WRvgY/zjTuZAmjHexo0LHYct/9Dj8CQoNgRUd9jBRWKKC5rjSxxsDcmZBPX+ggU3Sv6W//m+SdBzZA7gSVo1+7fguyAQ1dF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774182938; c=relaxed/simple;
	bh=sidq+BQHacM9GeYPEXeG1mmtH3aXVvLOIx81NJZghRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DMe5woLRkL9xtvwKNyXoO/8CSmYKTwBarE2pfbXvRtxLr0b7rs9ONXFW4Cpg+tclsSHRAKdSIl0WYxTIXLQTCf98zTlVD+ptFpBcH9UI0FdlImRF6NxmQgGrdY0r29gIUzMBnuPsOG6cbSTM8vZSmaaXULt6v23kESy9X87Qb4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=YTvi0sCr; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="YTvi0sCr"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 6D6AB26F67;
	Sun, 22 Mar 2026 13:35:29 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FkmRpXbt8elL; Sun, 22 Mar 2026 13:35:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1774182928; bh=sidq+BQHacM9GeYPEXeG1mmtH3aXVvLOIx81NJZghRE=;
	h=From:To:Cc:Subject:Date;
	b=YTvi0sCrYCEsP/5NErYiIOacv9LpAMe4khNHrn4ho0qCydRSb5ioxd3hFJEvH0gVM
	 Gh5an9lU5HIQ8+xY1A6A67+zpVa2j1QtxaOkOGiCIFpwlgoXG0rvuRt7p75fyHyKK/
	 XkYtQv7n9WOXJV+kDfAKa4FjAIIBlI2XX6xFzCqVc8RN2NmISAA2y8mPUgphfK6WP6
	 NlpjmHnvGKuilSxYCmDlYWOdzcJGDl+a0Nd+pzwDXgIv+C5A46apqnygiy+oYgDb+V
	 5E8gYXIDYeM2JHfa559R74+el/MFxQV+G5pM/9n0dIind/bqim07MA7MVV6Rp9uzcR
	 3H9TxrFXJ49pA==
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
Subject: [PATCH v3 0/8] i2c: rtl9300: support for RTL9607C I2C controller
Date: Sun, 22 Mar 2026 17:34:03 +0500
Message-ID: <20260322123411.32102-1-adilov@disroot.org>
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

This patch series now depends on the patch [1] from Jan Kantert.

[1] -
https://lore.kernel.org/all/20260227111134.2163701-1-jan-kernel@kantert.net/

---
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

---
Rustam Adilov (8):
  i2c: rtl9300: split data_reg into read and write reg
  i2c: rtl9300: introduce max length property to driver data
  i2c: rtl9300: introduce F_BUSY to the reg_fields struct
  i2c: rtl9300: introduce a property for 8 bit width reg address
  i2c: rtl9300: introduce clk struct for upcoming rtl9607 support
  i2c: rtl9300: intoduce new function properties to driver data
  dt-bindings: i2c: realtek,rtl9301-i2c: extend for RTL9607C support
  i2c: rtl9300: add RTL9607C i2c controller support

 .../bindings/i2c/realtek,rtl9301-i2c.yaml     |  10 +-
 drivers/i2c/busses/i2c-rtl9300.c              | 191 ++++++++++++++----
 2 files changed, 165 insertions(+), 36 deletions(-)

-- 
2.53.0

