Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C92393DFF;
	Thu, 19 Mar 2026 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943162; cv=none; b=UU2uv5SW2WfvPFyf4mK3LUzrQn4Gkez82M3stmurrtSh8ZzCl+6zLlkF2L+jsg3O9H+OdnBnG4aFd/jrn9C7j9Fzsm1rjvMmL4aFIkxb1RZrwlCuIz9jcON+F+jIJQLNnL5ESs//+nnitAWPgrClDQMBFrd7DkKX2JJ4Ekg7G2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943162; c=relaxed/simple;
	bh=qmK0Audktoq4xDtLFQPsWHK4VSSbJoSClzG0UXYdM3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qu68EBUlkEFiDTA0gomdYxvw8uw7A99vW6Od3uIK21HFiELXghLe716uUJ5iZ/34ZG9lkbGgXSm8SqAysRRYnqjhD++eNLf8L2+XW6gM0RZ3HnGwEbCZ80rsIs8mQoMmOolOCKEgiN/RYn9MJxVRqJpCFiTdUq6ErMOixjV/UMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=CDiej3e8; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="CDiej3e8"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B87822736C;
	Thu, 19 Mar 2026 18:59:11 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZkBH7HKrK_E2; Thu, 19 Mar 2026 18:59:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1773943150; bh=qmK0Audktoq4xDtLFQPsWHK4VSSbJoSClzG0UXYdM3s=;
	h=From:To:Cc:Subject:Date;
	b=CDiej3e8J+OZTZ0brPP2V1pGQktNWCEGqkRN/3tv4EjVBz+C5WT6qGiu0ecOTkMfS
	 +PbWH4jLVIYKZx11aOyqK+MsPN4ozxB5eJk8XN1upwqXnDL2j3tiKhUBDiJsxJopv0
	 oCxR6fIgDK0c/BxUNnmG3nIs+cfPBKmpdqiNsM28KlXzCGhL/c/C4h+/HWRBgegfvu
	 dgqR4YZlSHbnaz7x0YeCO/XjHrrDK8IDFeut5/czHsco0o37z1sx60k+s7L1TK6/xD
	 3wISGswGiw+Dv/81CnUZTa8bkqwPe791w7JwQltF/jAwIxZ5Il+Ru8MBfgOGUZVmue
	 PHsCWbzqr8+1Q==
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
Subject: [PATCH v2 0/8] i2c: rtl9300: support for RTL9607C I2C controller
Date: Thu, 19 Mar 2026 22:57:45 +0500
Message-ID: <20260319175753.32338-1-adilov@disroot.org>
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

 .../bindings/i2c/realtek,rtl9301-i2c.yaml     |  18 ++
 drivers/i2c/busses/i2c-rtl9300.c              | 191 ++++++++++++++----
 2 files changed, 174 insertions(+), 35 deletions(-)

-- 
2.53.0

