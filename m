Received: from ms2.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A435359A89;
	Thu, 10 Sep 2026 03:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789009296; cv=none; b=e/raFSHqZUhY+VHNl3526XGrsexLdo7b9H+bQc712WtZhVBYWeFU03hqMsEUHF0zb4cM/lLg1XCEyEGNcBcpJZ5z+brVmZw6mbsRPz+FLyzBUWnLqSXoF/hEUNS7J7dQxAQBKmtV2EyYhP1vYrSeX+zKysgUSVq4MEHYr6GZ5Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789009296; c=relaxed/simple;
	bh=f25uFmQyjIScjt8F6W7LN4aKZ/Vii854WCG2alAoEEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k/OgtQrxcgmriIBm6CQ1QDp0sBMriNh0rd29JOuga2r1m5UI8vY1rkncNQoTE3l4/IP2dg64vmFRMgLzr/3l5HY/J5igKT8TSIba6Le8uSDbW0GUQf+39H9zie3Q5GK0OtpaxS19hYLdHGOwwussY7rA8R/8OMGth+nSKXiE+Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=n/jHNX8y; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="n/jHNX8y"
X-UUID: e87c96b4acc311f191248d90cf864ef8-20260910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=pOb7P3yujoexkfjfWkZZNL3FXdrf4TjE+I4EDdL2ab8=;
	b=n/jHNX8yoYEY2+OQ3l9/HMx4ubf2TYU0Gu2S+pnGvoX+wDCcqq49K98mUgGqSKt5yMU19TT7G6ePiesnYyuNRnhcWOHVdoYPwr4chpZLX5W9oxy6fw/SMEwK46hVGqjx2gMSdkIoqhNrfmBBI4Ft1PYLZBMcIPb1Z2YbaGVbqHQ=;
X-UUID: e87c96b4acc311f191248d90cf864ef8-20260910
Received: from spmgt1 [(172.20.13.10)] by ms2.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 2019037567; Thu, 10 Sep 2026 11:01:24 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.20.160])
	by spmgt1 (Postfix) with ESMTP id 70BC81A1E1C;
	Thu, 10 Sep 2026 11:01:24 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 16431C600DD; Thu, 10 Sep 2026 11:01:23 +0800 (CST)
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
Subject: [PATCH v9 3/3] MAINTAINERS: Add entry for Novatek NT72676 I2C controller driver
Date: Thu, 10 Sep 2026 11:01:22 +0800
Message-Id: <20260910030123.215609-4-nina_kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20260910030123.215609-1-nina_kuo@novatek.com.tw>
References: <20260910030123.215609-1-nina_kuo@novatek.com.tw>
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
index c392ded5322a..40a22cfa206a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19437,6 +19437,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git
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

