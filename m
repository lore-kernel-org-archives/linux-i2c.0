Received: from ms1.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535F5411FB5;
	Wed,  2 Sep 2026 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788340715; cv=none; b=q/5In4O0KFwE3PDBA258fh2qp5JE0c5y8GiwWeZXR66v1EBr5pHFAobDsWf3sOUxEEo5dlW5yKp0ix8Dlx8RAIZxaXShuMNwjCNb4Oe5Zq9hkHdunnbfEUYcp51NpPQfx+Xc0YhZz9d0Vu5qMncBMYoE5KgJv0qr9drz2NfUFCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788340715; c=relaxed/simple;
	bh=33MebzVKqJWV4gRY3VPk4dvyct8bgsS4+zYSk7at1to=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GJdnefTVGfv1FZxFFyljXcsApXoFSwEnHepfArh114Q3Co5mTytlUoyss7I46s4duxtuAFxrDeEjuIkQ6EfLUaxrL0Kg3bVGnqCjL6goL3uQs6QUAfduXxJkuUrOzv9iavEnBBIN4bgko4iDBIssPQAE8qlENgdDT6QullTqubQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=F7egXK90; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="F7egXK90"
X-UUID: 8a969a9ca6ae11f18b9d37ce969ed3ec-20260902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=kFhCpgOj6eX6WaR499VMn8FK0lxHT777PZbWGzMR24s=;
	b=F7egXK90wWyDRosNNsq4ycgEefVBSfTTkWwl47iev70Cn0AWjf2NhJIrnCSRtWZRQUpQgFTLKdedxcmSHtFbwin2z7C6EJgWXs/bRAblywj0xSF6Pfj9JeUcZ+VGGfj+TkDHkd8wjH8CBfaqAmaBayvGyYA5FuhBxuqshf0BrG0=;
X-UUID: 8a969a9ca6ae11f18b9d37ce969ed3ec-20260902
Received: from spmgt1 [(172.20.13.10)] by ms1.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 1974544510; Wed, 02 Sep 2026 17:13:20 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.20.160])
	by spmgt1 (Postfix) with ESMTP id 6FB931A1E1C;
	Wed,  2 Sep 2026 17:13:20 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 01DCDC600DD; Wed,  2 Sep 2026 17:13:19 +0800 (CST)
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
Subject: [PATCH v8 3/3] MAINTAINERS: Add entry for Novatek NT72676 I2C controller driver
Date: Wed,  2 Sep 2026 17:13:18 +0800
Message-Id: <20260902091318.208074-4-nina_kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20260902091318.208074-1-nina_kuo@novatek.com.tw>
References: <20260902091318.208074-1-nina_kuo@novatek.com.tw>
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
index 4dfc1fb14ef7..3f83ddf5b113 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19438,6 +19438,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git
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

