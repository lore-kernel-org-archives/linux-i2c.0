Received: from ms2.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB84227EA4;
	Thu,  6 Aug 2026 03:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785988602; cv=none; b=qIiQJ9sJVApwIJZD20ZDEaKWxf50S0CKOmxh3DYzWlspI1I2GG8mt4DdnH75OYzvhcOg1fjZutWTkdSOhrQCOzMWOJPNDv2hQ5+t0OYP8+53P91IwRjEVZUTy1yc8XLDFa6nx2gm5aPKAvCWPtyu0IRIE2ka3RKrUETDFV++NrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785988602; c=relaxed/simple;
	bh=rJekQmlnVO10VdZwH+dCh7aWCtFkwLmwYNGPjuv7ZQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OnjnpwE38exu9S/ETbrOGug3Md1pKMbUgPidSJClt1zRBytj54Yd1bj+CCYBvZHbnNORddQoSoO5lYzB0f9wqr7s7qS8T/OV+ick+0o1J+JWCD3mQ+oDTlejpZGY+ROPI6uhtKdwjG71XXy4y1Yahps/o8+dxSC7snhFhorwjjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=MnQQ1lpb; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="MnQQ1lpb"
X-UUID: d0b6dae2914a11f1b694ffd7d3467620-20260806
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=xerqkNpnlx5WAscmDjtSRZ43rR2sDhgDImFaryTd7vY=;
	b=MnQQ1lpbCXq/aR+rQYDcrR46k0WQY87m9YwoS1UtFc7vog7uFcPLzr/LHESD87HcMozwvFa3KeWACKWX+4HHBqFUaiuyxEwxz/a/x/OhbIE9AHbleo0LO7KJNp0hNQgF8xRBQP3Euweu+mw7Y5N7PpwBNS3t7GyPh2pQoBLbW1s=;
X-UUID: d0b6dae2914a11f1b694ffd7d3467620-20260806
Received: from spmgt1 [(172.20.13.10)] by ms2.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 67192207; Thu, 06 Aug 2026 11:56:34 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id 1983D1A1E1C;
	Thu,  6 Aug 2026 11:56:34 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 763BFC600CF; Thu,  6 Aug 2026 11:56:32 +0800 (CST)
From: nina_kuo@novatek.com.tw
To: andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ben_huang@novatek.com.tw,
	toby_chui@novatek.com.tw,
	shihpei_hsu@novatek.com.tw
Subject: [PATCH v6 3/3] MAINTAINERS: Add entry for Novatek NT72676 I2C controller driver
Date: Thu,  6 Aug 2026 11:56:32 +0800
Message-Id: <20260806035632.777782-4-nina_kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20260806035632.777782-1-nina_kuo@novatek.com.tw>
References: <20260806035632.777782-1-nina_kuo@novatek.com.tw>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>

Add a maintainer entry for Novatek NT72676 I2C controller driver.

Signed-off-by: Ben Huang <Ben_Huang@novatek.com.tw>
Signed-off-by: Nina Kuo <Nina_Kuo@novatek.com.tw>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b592cf49746..1f12595dea2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19230,6 +19230,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git
 F:	tools/include/nolibc/
 F:	tools/testing/selftests/nolibc/
 
+NOVATEK NT72676 I2C CONTROLLER DRIVER
+M:	Ben Huang <ben_huang@novatek.com.tw>
+L:	linux-i2c@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml
+F:	drivers/i2c/busses/i2c-nt72676.c
+
 NOVATEK NVT-TS I2C TOUCHSCREEN DRIVER
 M:	Hans de Goede <hansg@kernel.org>
 L:	linux-input@vger.kernel.org
-- 
2.40.1

