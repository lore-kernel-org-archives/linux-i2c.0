Received: from ms1.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E207A3B9DA5;
	Thu, 30 Jul 2026 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785396645; cv=none; b=m/en2H6YXSZkCiHXfBt/ZxdBBSLc6IYeY3Upz+4iegVdz+ZOLSrDETRQl+5Asn2FOHZs9OVMvNRxu2TfZHRkLXq88wLK3e7IbErUj55wB6jfRlCHBm8GivIzS2FzyvMqIzhVNm/YLrzueHVg/97tBuKLtWxSCPcPnAQ0Vro2XBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785396645; c=relaxed/simple;
	bh=6TXZKdEnbW7i9nRJzLGVnqljcADpSme4dvc0RsxH184=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fTP4bLDlK5A3c5eA+s2gq+R+25gxNHebVBA4tiBU6pkmXLf+hVGO8dwLfpQV1qECTNzm3bNv5Dk09zvCrYHD7RxPzZv9NGO2JZ5p97fW4Wq8zsUBJprFsMzFVKKbKG86+oIWrmU9WZr7hhLCo5hAuBZnZnKfsYqG1Zs/UmCj9ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=H6eUdziU; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="H6eUdziU"
X-UUID: d8134a188be711f181a149c3f3c08161-20260730
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=jfK24GmPYqYMhMGctvb4tqDEAAUW2MrgsU3XEf4rzBo=;
	b=H6eUdziUj8DlVKIYL1hc6HFpTy2j0CcqmSqcZC4DzaabQRWOdz6LGxp7w6NJHc12hp6eIcAraVTuKv5rmuyc6wJSYWqtVo/pvvuhz7ZCqEscRXKWIVzaPH9R0eTyqGzHkeLJ2am433ebyXzXNH958rGZX8Shw0m9tF6Szi3nh+s=;
X-UUID: d8134a188be711f181a149c3f3c08161-20260730
Received: from spmgt1 [(172.20.13.10)] by ms1.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 1236281900; Thu, 30 Jul 2026 15:25:30 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id 5FBE11A22CC;
	Thu, 30 Jul 2026 15:25:30 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 713F1C600CF; Thu, 30 Jul 2026 15:25:29 +0800 (CST)
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
Subject: [PATCH v4 3/3] MAINTAINERS: Add entry for Novatek NT72676 I2C controller driver
Date: Thu, 30 Jul 2026 15:25:29 +0800
Message-Id: <20260730072529.492398-4-nina_kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20260730072529.492398-1-nina_kuo@novatek.com.tw>
References: <20260730072529.492398-1-nina_kuo@novatek.com.tw>
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
index 2f9472c1a090..f12020622675 100644
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

