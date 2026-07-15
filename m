Received: from ms1.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103BC37A488;
	Wed, 15 Jul 2026 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100908; cv=none; b=QiK2kMUxIMw133wv4L7vtOFBeo9RyWXiASQpy+tmX1SPkel5NCmxaeNROn8rX9SOO74c3/Q+uJK3DJn9k/FWwddhRlv5ML6AxRLcFBKeVBxxCBLFyA8lNcZdzwOotzJgKZGP3BvNpBlMLlZABXAiWuH7SLTiPdk/dWNg4w3BmbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100908; c=relaxed/simple;
	bh=wB9zSxXY+QuMCHnm8Ys//UkoWVD1r/HNAaHJk6X3rTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X6OEkDY4/FiZS4JnktgnmzXKYZepuZglB2NaWRSnApLpUkJi6pm72VwWDdn6sa+Sm33nDQBuztHz0envJz5ZZQjIIWQL3sjHftg7flecYs+7KTk7RsR7IgjiWqS9g9s+mNFOpJ4EA/5uZECkd71Z/tFtBnVls5d1QOtThid8wok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=C8K8IPJ9; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="C8K8IPJ9"
X-UUID: b212936a801f11f181a149c3f3c08161-20260715
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=ZsynN+8DvIOk8GF/ZWuneoJbGiC7ln7wtkDXOvCGlAI=;
	b=C8K8IPJ9zlqx36oXfYpV5ecUhaqGuU3caEGfkZzglk+DyCbgSw/IbTOmDJMfKEV6Ubi2SHUU3yborHFlxVZAhxBnOKBFqY5qgO+bOw+kjWAxywiM6KXI18EfZkohB/CGiZQPOiS32Pya6ftpHH6GrK+rjuDlvyisjVygLaedOhw=;
X-UUID: b212936a801f11f181a149c3f3c08161-20260715
Received: from spmgt1 [(172.20.13.10)] by ms1.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 1088219467; Wed, 15 Jul 2026 15:35:04 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id 79E971A1E1C;
	Wed, 15 Jul 2026 15:35:04 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 7CAE6C600CC; Wed, 15 Jul 2026 15:35:03 +0800 (CST)
From: Nina_Kuo@novatek.com.tw
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
Subject: [PATCH v3 1/3] MAINTAINERS: Add entry for Novatek NT726xx SoC I2C controller driver
Date: Wed, 15 Jul 2026 15:35:03 +0800
Message-Id: <20260715073503.147552-1-Nina_Kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20260715073443.147490-1-Nina_Kuo@novatek.com.tw>
References: <20260715073443.147490-1-Nina_Kuo@novatek.com.tw>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>

Add entry for maintenance of Novatek NT726xx SoC I2C controller driver.

Signed-off-by: Ben Huang <Ben_Huang@novatek.com.tw>
Signed-off-by: Nina Kuo <Nina_Kuo@novatek.com.tw>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 806bd2d80d15..15df47f9e81f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19234,6 +19234,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git
 F:	tools/include/nolibc/
 F:	tools/testing/selftests/nolibc/
 
+NOVATEK NT726XX I2C CONTROLLER DRIVER
+M:	Ben Huang <ben_huang@novatek.com.tw>
+L:	linux-i2c@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml
+F:	drivers/i2c/busses/i2c-nt726xx.c
+
 NOVATEK NVT-TS I2C TOUCHSCREEN DRIVER
 M:	Hans de Goede <hansg@kernel.org>
 L:	linux-input@vger.kernel.org
-- 
2.40.1

