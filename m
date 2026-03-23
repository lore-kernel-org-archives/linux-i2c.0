Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F26135C1A1;
	Mon, 23 Mar 2026 07:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774250045; cv=none; b=Wu8WfMO83tMAYOT2dt6FW+leHoEEeoNcCeOKu1VxFWo8BZAldkOkc5pJ9kSgNyy7wCerCZvfzknMIKEUt54CGvh3mruDXh1fHpLVYqEVae7QHWi6GAIQ3pcvW2a2t/gkZKPrM/APDob4mFPLP8zLXyRLoTcgak8MEPg4WDLxGvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774250045; c=relaxed/simple;
	bh=t1eK9OdJxtR7u2GW5GK4mlGiuucgjU29ii0T1vls+bU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BonvBcmzGX9/XLSHAQB/Yyw7LGJTNGqKLNlk3undh1k7K+ohUp2XlisoNbKhssIX6dag8qd4jqY4mOZ20duhl5ZWEw7BEmLVtfbQR+w+fLNpyHn1AjNpHs/9DQxGQ84YwzLuC6lxlc/DZrah6E+pDi2HjAQ5m4GduQhmi9bbcv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=HSJnLaw0; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="HSJnLaw0"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id AA8D4267F9;
	Mon, 23 Mar 2026 08:14:02 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cViNAGQQJFhy; Mon, 23 Mar 2026 08:14:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1774250041; bh=t1eK9OdJxtR7u2GW5GK4mlGiuucgjU29ii0T1vls+bU=;
	h=From:To:Cc:Subject:Date;
	b=HSJnLaw0SMWt5ssa6F8SguHJCDNjMf4gRw6J8XNZ1l3W02vvfiWiaqkZS6z9HY223
	 65vuL1qeWeTjWalGYnj7T5TBKCHAtLRfzbLWEkS94A7MGbK2EWj8/HB71FRsBdl0B/
	 zAHwpXM/YoRuFwXP+UyNWM/3aI3ditUBKEPzYx492eT3m0MPbY7iO/jQXUrL+91y+f
	 oWDqwk8W6NjpvcdWseCybNamGCJFa81aLqTD/fUm6BDS59bSwDSgApWHDKFveVQC5T
	 FBHBuZZD5R4pFoeJaJqzXUKYlBl92TUifTHOUmPqmZyLI7fv+AzllZ7jm819Qnyajk
	 Wmd0+H2vKzqfw==
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
Subject: [PATCH v4 0/8] i2c: rtl9300: support for RTL9607C I2C controller
Date: Mon, 23 Mar 2026 12:13:29 +0500
Message-ID: <20260323071337.15410-1-adilov@disroot.org>
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

---
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

