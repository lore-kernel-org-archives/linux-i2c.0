Received: from ms2.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971C232B10D;
	Tue,  4 Aug 2026 03:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785814473; cv=none; b=LW9p6lskeRIishUUlk6fiYfnoZOnWx9jLWBhLR98hloSX5qIiIiPi+IYJec4T//GV/TpcAuHMhNqSr33rDBdTIYGYAS2aVP0cSrkV+BNc9EZQMcq/Lqc0V9LQAEAFpuTuLN3hr2TpPlEGybX/+IqkkL8Oa/gvzJZe68RBUJeDVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785814473; c=relaxed/simple;
	bh=LRKFOPO282aSZrWzRc3WxzX1U1+x753cfBqROyXims4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lh4DRxRR7kTj94rUb8AlXuTbtxiGy+A4IULFRfllNAjnHSrSXpsxMRvcg9nptt+AHD+p6zeUUILcIluNKAgquTs6xBol6lbt/DZ5saA7PkGIiuT3x2R99xexjpfbrGFCe6ePe1E2+LoKV2mUHSdaBWBwW5MMwdrYnHr65uizPWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=c5ju38zj; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="c5ju38zj"
X-UUID: 6197b0968fb511f1b694ffd7d3467620-20260804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=CFVEmsBt/C5/w4jFH1LJC7FMzNt7zzaIrJXiIXAUpVE=;
	b=c5ju38zjQ4OO8OZ77rcKNt57mdPHvXF+leUloYiUQoYP8inLYzRWcYC5v4XVcAI7w19oVVIuJSpinto6Ws4x8A2SvtZ8xiK6F57/uIQQ6aBZblnHZQJQI3KNXDm+4VUmfMUSLmmk/re4XqIqlQuuAkPlBhmFMDDNvFnPplXDiOc=;
X-UUID: 6197b0968fb511f1b694ffd7d3467620-20260804
Received: from spmgt1 [(172.20.13.10)] by ms2.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 1628691671; Tue, 04 Aug 2026 11:34:21 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id 6E8911A22CB;
	Tue,  4 Aug 2026 11:34:21 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id E3233C600CF; Tue,  4 Aug 2026 11:34:19 +0800 (CST)
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
Subject: [PATCH v5 3/3] MAINTAINERS: Add entry for Novatek NT72676 I2C controller driver
Date: Tue,  4 Aug 2026 11:34:19 +0800
Message-Id: <20260804033419.693819-4-nina_kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20260804033419.693819-1-nina_kuo@novatek.com.tw>
References: <20260804033419.693819-1-nina_kuo@novatek.com.tw>
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
index 5114e6db7307..ea0f8fde4430 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19239,6 +19239,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git
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

