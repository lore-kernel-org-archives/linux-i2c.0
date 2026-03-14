Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220E715746F;
	Sat, 14 Mar 2026 08:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773476839; cv=none; b=cjhPqZYpjuw5/Qz00X0GwT6kZI3VhOHv5JkgBBp4VdnAfZ47xoTurRfpihL5fhybjNQaHLIVVqQP0Qey8QFz7aDWP/j9+V0gDyD01h+ZRBgxDSg22U2+fk9ple1ErqDeesCqqwAa8U/Sd0Ew4sYbD5nbYKK/oxj9CXdUSW/eFKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773476839; c=relaxed/simple;
	bh=B0+rwl7k5Ymu86+8SPURTOEvovnWeyeCR4ShiKDU9Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZtHBvT/HQoSzyE6QYg0vTJcSMM350aL7kNfKBcAXkSEGYhcBvCDz5kTLVlTUJKmb84QYzRWu/9j0yY/sMV/474NGa6t6YBGhJR2g3FngoAUlvUtPSU1NZvIFkwNwDV8BzXAhzwRPPoTn9+G+ogOiWAEGsfmOTf9wEigCblKOFKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=gOvO8lft; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="gOvO8lft"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E76EC2676F;
	Sat, 14 Mar 2026 09:27:14 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sggo6NPvid9b; Sat, 14 Mar 2026 09:27:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1773476834; bh=B0+rwl7k5Ymu86+8SPURTOEvovnWeyeCR4ShiKDU9Bc=;
	h=From:To:Cc:Subject:Date;
	b=gOvO8lftKqqSlVuDp1PzwJj1KIKAKsPp4gL7iULTyBzKTlwARjWcrKy38JtKS8OVn
	 JLpOH3MvKDL9i50vukmFhS6HQ1/srSU0Gkeq+f+JQ3LDyGcRadIloL/rRjxYPRJg3x
	 jXehOJle63wTuanEAAbXyw9VgkYjxGugQp2ou0LF20y+CnN2LjBjkzNQx7Ec5fQsvg
	 dy69/KYzw36NAElkZ8Srr4O3jxNoRTDpDWTfjMHRs10icOgpSIk8rBwY0IQIU3xpDc
	 0h9zQ/EJY4P1tOGtXONKQK4MsniVX6AH9hKbJBh+muWHMJ0TR6u7i5gPhCyoNY5fmz
	 YNxhrcbge1jmg==
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
Subject: [PATCH 0/8] i2c: rtl9300: support for RTL9607C I2C controller
Date: Sat, 14 Mar 2026 13:26:20 +0500
Message-ID: <20260314082628.25206-1-adilov@disroot.org>
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

Rustam Adilov (8):
  i2c: rtl9300: split data_reg into read and write reg
  i2c: rtl9300: introduce max length property to driver data
  i2c: rtl9300: introduce F_BUSY to the reg_fields struct
  i2c: rtl9300: introduce a property for 8 bit width reg address
  i2c: rtl9300: introduce clk struct for upcoming rtl9607 support
  i2c: rtl9300: intoduce new function properties to driver data
  dt-bindings: i2c: realtek,rtl9301-i2c: extend for RTL9607C support
  i2c: rtl9300: add RTL9607C i2c controller support

 .../bindings/i2c/realtek,rtl9301-i2c.yaml     |  15 ++
 drivers/i2c/busses/i2c-rtl9300.c              | 179 +++++++++++++++---
 2 files changed, 165 insertions(+), 29 deletions(-)

-- 
2.53.0

