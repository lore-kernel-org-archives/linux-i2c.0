Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694599;
	b=lz0UATg6dW6SRW95FO8Xd8duFtl/L2XQh5NWLeSGj/eTWPcXvcgRuaXFrTNJmcZyBSn7
	 wJQIt5uBQdp6cIGK83N88j+vxyMM4FVlXFzzd+XfCMtG5ADeNp70UdxtgDF0l29iK27LS
	 FrZuVWeVlMzdPhAAFLg3YWU0pQ9p+c5XS2aKL6tWXzlfjFP1jvSZMLym5uCXgNemxA/hb
	 6iThCsEfYK3z7ZJLiuoB2KtoYorRUbCflsmD273TT4aUwRn+/ubk2odddaPb23ojQHSZO
	 rUpHgn5lmP9V+7qr6mwlvKlqOKIaRDt1EvVDvffJUMsq3ULEtjiZr+KJnPtK0mFUouw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694599;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=/giysDG79yh2AQk/VRr8fH0SzK99quvNSud9CE+SPJw=;
	b=yKsS1fltgIocOhLnyu6awCKAldGqjj4Q7nYWmIBwSrSt8pCVbapMGCXUFWTn8cT5/hJV
	 o/U+X1GA3+3cxk4Pm4l1ctPWRLya3BfyYy0WBvu/aHGnaRLZdXQF+fr1U4V+I9DJkI80X
	 TiPTe2uqdXuz+fzeZRtEiMrMVN3qmJxS0RykFirp1tv15J0DHZC+ejIFP+FkFTV9F15HX
	 PVzAqbtF0bMismU5Q1Y5DZ3Wr1fEMT3cE4+xzPHqKctjCFcUOMldm/UiO+yt36yMm3fqg
	 iS552PUsx2aBcYa3VUMUO0vWEFinVdtfTlKNykpCR1nDnt3o/lu7uCTYgUISZ4GbeVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.147
Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com [23.90.104.147])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1864606A324;
	Tue,  3 Nov 2026 08:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1864606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793694602; x=1825230602;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=fKIT1odc8juQtbc/yg2Qb9XwR2x9WyUKoI+trK5ZRKs=;
  b=QIbwsNfWFknF9458j24afrzaqyU11Ix/IqiMB+r01Yl6JD/SNfm+pXGg
   E/57zdPF7Gm4cvEmHMbQzjQGYZl0nZlv6tVW8E7xdwZvc+K+BrFDV/QpM
   lPu4pRZyuNXW2BF48RDVzeaKBnqbQhbpYL/+bLU6/r9/5ruF+gmxuhV0y
   cZHBycp1341jFglSPBqa5Z3tXdrs3tnZ5MUwphBw7cWSXjfWoQEoPF8iS
   AQTBVmZLRZ3035K7q40FJ8DdCBjpUNSkL2U6C4v21L2sYxI0+lA63gfaC
   3bfFtgMBEaI7IlHNhJqx0Ip/LskoIih+9VeQE2/r2FzO2jh5h1K6ce4kK
   A==;
X-CSE-ConnectionGUID: 934Ie9vNTzGq9yPtCoPvOQ==
X-CSE-MsgGUID: Oh6tvUaPQ3Wb6gOLqZ0KGg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 10:29:54 +0200
X-CSE-ConnectionGUID: xuzxpQYAS9acAy2rIn2kug==
X-CSE-MsgGUID: wwCpMMWJTsi5DF/Fq5253w==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces01_data.me-corp.lan with SMTP; 03 Nov 2026 10:37:46 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Tue, 03 Nov 2026 10:29:44 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Subject: [PATCH 0/8] i2c: nomadik: fix several issues in fault handling,
 optimize layout
Date: Tue, 03 Nov 2026 10:29:36 +0200
Message-Id: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHGb6WoC/yXMQQ6CQAyF4auQrm0yrYDEqxgWWKpW4mCmYEwId
 2fE5ZeX/y3gmkwdzsUCST/mNsYMOhQgjy7eFa3PBg5cU+AKjQXj+Op6G/BmX3U8HYlJpKYyNJC
 7d9J9yNml/dvn61Nl+h3Bum6kkHkHdQAAAA==
X-Change-ID: 20261025-i2c-nomadik-fixes-73121cc61408
To: Linus Walleij <linusw@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 srinidhi kasagar <srinidhi.kasagar@stericsson.com>, 
 Ben Dooks <ben-linux@fluff.org>, Andrea Gallo <andrea.gallo@stericsson.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Dmitry Guzman <Dmitry.Guzman@mobileye.com>
X-Mailer: b4 0.16.0

This patchset fixes several issues in i2c-nomadik driver.

Patches #1..#5 were previously submitted as a part of a patchset that
introduces detailed fault reporting feature in i2c-nomadik and
i2c-designware drivers and i2c-core.

In patch #5, the new structure declaration is moved to different place
to make it independent of patch #3 (avoid merge conflicts).

Patches #6..#8 fix other pre-existing issues found by AI review of that
patchset.

All patches are mutually independent and may be applied separately.

Patch #1 Optimize struct layout.
Patch #2 Remove automatic retransfer on failures.
Patch #3 Fix error codes returned by xfer() callback.
Patch #4 Avoid excessive prints by replacing dev_err() with dev_dbg() on
	I2C faults.
Patch #5 Add quirks that describe hardware limitations of the controller.
Patch #6 Handle PM runtime errors.
Patch #7 Fix race condition with IRQ handler.
Patch #8 Fix possible long busy-wait loop in interrupt handler.

Link to the patch set that patches 1..5 were submitted in:

https://lore.kernel.org/r/20260903-i2c-fault-reporting-v2-0-fedeb91792e6@mobileye.com

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
Dmitry Guzman (8):
      i2c: nomadik: optimize struct layout, change unsigned char into u8
      i2c: nomadik: do not try to retransmit I2C message series on errors
      i2c: nomadik: return proper fault codes
      i2c: nomadik: change print level for fault messages to debug
      i2c: nomadik: add quirks max_len=2047 and no_zero_len_read
      i2c: nomadik: handle pm_runtime errors
      i2c: nomadik: fix race condition with interrupt handler
      i2c: nomadik: reduce FIFO flush timeout to avoid long interrupt handling

 drivers/i2c/busses/i2c-nomadik.c | 105 +++++++++++++++++++++++----------------
 1 file changed, 62 insertions(+), 43 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261025-i2c-nomadik-fixes-73121cc61408

Best regards,
--  
Dmitry Guzman <Dmitry.Guzman@mobileye.com>

