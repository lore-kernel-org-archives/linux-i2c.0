Received: from ms1.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAEB40097E;
	Tue, 11 Aug 2026 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786433449; cv=none; b=mdYKAtBzzZpl6ZVA9InStCSVsmUZ8JS2mxN5ui/1F86UOgTORSlye5Msac33/Q8U0fVm772IlFY//IJWmjOhmjMnoKbk6OlL5jmQXkJAD1aVDdBxnrYOs2+00yCYQPZTpQCZOHVNKRGx0SwB2dKC+d9oeNCnHbQ6njelMf6dbkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786433449; c=relaxed/simple;
	bh=nXriLJpfUc0+smbhMCOB4HeQEJCj6z0eHGR0waZeJ9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T6+ES6/8yptBJvIzPre/d6yeFWhDZFlYY3b7xEmYGTU6+EMNel0L73BlhEf1mKFzVISzGoOBrzADfxeruxQ9QRvn8TsPSbReQqelg5nDe3cFIUndjIvfV+uUPOPQKYV7wWIHFL6EY9Ok1Oyk5ZclHJaHHQTSbjcI3ILt82lc0dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=l4sjz4mi; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="l4sjz4mi"
X-UUID: 890b35b6955611f181a149c3f3c08161-20260811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=0uk8P03Q0qUTSiQBgA4pxwZCEOOI5cssSqD9zVylQUU=;
	b=l4sjz4mi1Zk6mjTmrQsdoZz6L7UJNG3mucZBnfNk4lOku131Hs2ibeTTAggWNLBlw79tvq8BDewCZFt75p6N1Z6JrgkDF3MFtP2VzWhdM4spBCy3Gd8wgjK0mGg7WGohYd7j2utHlLiCVA7W8k4JnXhiw5bPXd8Yk4Ayrb9Q2mA=;
X-UUID: 890b35b6955611f181a149c3f3c08161-20260811
Received: from spmgt1 [(172.20.13.10)] by ms1.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 497730190; Tue, 11 Aug 2026 15:30:32 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id 636891A22CD;
	Tue, 11 Aug 2026 15:30:32 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 6C88AC600D0; Tue, 11 Aug 2026 15:30:31 +0800 (CST)
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
Subject: [PATCH v7 3/3] MAINTAINERS: Add entry for Novatek NT72676 I2C controller driver
Date: Tue, 11 Aug 2026 15:30:31 +0800
Message-Id: <20260811073031.1019576-4-nina_kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20260811073031.1019576-1-nina_kuo@novatek.com.tw>
References: <20260811073031.1019576-1-nina_kuo@novatek.com.tw>
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
index 8014b9f8253e..8355ca8311cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19236,6 +19236,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git
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

