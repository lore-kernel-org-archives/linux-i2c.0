Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332FC4035DA;
	Thu, 26 Mar 2026 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538846; cv=none; b=BXTdgbdeuz58n5sEoNjMJCzYBH4tnVA55Qij1ltJkBvAGeWLekR877171lzvJLwMP5oodKlidQ50QuiLxsfp96Be0PR7tiIdCf0MW1uOQCNlATZBd3ir7iPozyls0m4r0Jg1mt9wocM3hgp/A2IHACpFEvQvkJoSenBzyuWgn7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538846; c=relaxed/simple;
	bh=F/NVPAUEX863N5p/JogYiLbDmDQADflpMpHbLXA+WdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y8W6g3x/CSa7L4ewat6UaW4Z334G2JXvSywy9YCD6gLZQ1jY4WNU3ZarJkBaK/w0Tbkv/OFPS5NcjkhdVPijUqm40g1L2aJW/uTp2Or1KTzdxBF/8cImF2I32saMACk7H5Czlz+vnpjDW2wnQWvzofX068vjTuah7m2qpyXC5Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Pn8mO+aa; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Pn8mO+aa"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5A8E426272;
	Thu, 26 Mar 2026 16:27:23 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ugizE2OidUAj; Thu, 26 Mar 2026 16:27:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1774538842; bh=F/NVPAUEX863N5p/JogYiLbDmDQADflpMpHbLXA+WdI=;
	h=From:To:Cc:Subject:Date;
	b=Pn8mO+aak2XI2zdbheSVMH022Bgqk1IGkLOfPrpceEmfiIg1zOusLvNa6sTOFbA6Q
	 5C760+VihtUfegyp94dDeH4lltyvgSomc/wN8aPW0jWEdiYfUz/MfhgbDs8Q1/7F8v
	 xBD9pv6xk2kkkyFGV88ljoIEmzA4cY9h48HtScYADDXpXQ7D6EWv1lVGuhZGVdy1jJ
	 ts9lRWN4jtm2KCnmOCvRkZ436fR9yJtrQYQC7KH+aHd/6whSnYPtsIpZ5Xg56XJmD0
	 yh9KdrLcOBEKzrEH+MJAKTwBMJKjqdp3aMxTVnYZDOL0OUNB6HMZYMan9l/SqrdI++
	 rNlJTuoZ9Idpw==
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
Subject: [PATCH v5 0/8] i2c: rtl9300: support for RTL9607C I2C controller
Date: Thu, 26 Mar 2026 20:26:48 +0500
Message-ID: <20260326152656.14030-1-adilov@disroot.org>
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
  i2c: rtl9300: intoduce new function properties to driver data
  i2c: rtl9300: add RTL9607C i2c controller support

 .../bindings/i2c/realtek,rtl9301-i2c.yaml     |  15 ++
 drivers/i2c/busses/i2c-rtl9300.c              | 191 ++++++++++++++----
 2 files changed, 171 insertions(+), 35 deletions(-)

-- 
2.53.0

