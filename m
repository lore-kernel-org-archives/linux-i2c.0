Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815CC51121D;
	Tue, 29 Sep 2026 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684035; cv=none; b=JTrhnAvwBxiHNHBGkxlns/EX1/YJbXs7mWNujimFTTBMjeBhOgtzQ3IJC0jcJtO0f34bd7UCCccBIh3GQCzzYqKqJ7CY/Fp6cDHapcnRfWZ2Vc5wBoa+ApeuSipBw1Q8rRschRkmIqY4kFCnHunVdqMAQBV+sj+aQI5gwkx+rTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684035; c=relaxed/simple;
	bh=PGdNY1MHRf5m17iQAMR0PSKSE+do/l7qRobbb8XdTAA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eiTnEfKJwVbcAODGThb7jOmYmFfUeFQkTCwIoWOjXLXI6B223WXWC93eDXvjP83GrAvZJo2jneIthTn4Vm6fe77lIVLsYEMelgU+D6IwuUGxfeQ1y87cv9c97OphYPsg7ss8CHTI/d4NWKjNgEoroO7VBY7ejccqlqU+u/65eyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xZKlmkpH; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xZKlmkpH"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CTuJZuLy/yViJSm/kRh8Si2NEUdVD7jm9zW6AuERlTU=;
	b=xZKlmkpHXhzJZ+r172GAwm8I+Ilx4Ls2mmP0Q9+H17/2/JH/46aytINWDSSaUPM4EAuuoTwZk
	vU0gs9M9FxU+z6c4cCScJp7qOhjPCsEoDArpQMpi6VvMly0o5jYxZ1o4pUOyzRUfXZx4rvj/6fa
	ASdJPl1ENknRwMgrZ/RCZos=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hvGxR2dcTz12LF9;
	Tue, 29 Sep 2026 20:01:47 +0800 (CST)
Received: from kwepemo100017.china.huawei.com (unknown [7.202.195.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 0951540561;
	Tue, 29 Sep 2026 20:13:50 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo100017.china.huawei.com (7.202.195.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 20:13:49 +0800
From: Bowen Yu <yubowen8@huawei.com>
To: <linuxarm@huawei.com>, <liudingyuan@h-partners.com>,
	<andi.shyti@kernel.org>, <linux-i2c@vger.kernel.org>, <acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>
CC: <zhanjie9@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <xuwei5@huawei.com>, <yubowen8@huawei.com>,
	<ouyiyong1@huawei.com>
Subject: [PATCH v5 1/2] ACPI: Add stub for acpi_has_method() for !CONFIG_ACPI
Date: Tue, 29 Sep 2026 20:13:47 +0800
Message-ID: <20260929121348.109556-2-yubowen8@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260929121348.109556-1-yubowen8@huawei.com>
References: <20260929121348.109556-1-yubowen8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo100017.china.huawei.com (7.202.195.215)

acpi_has_method() is declared in <acpi/acpi_bus.h>, which is only
included by <linux/acpi.h> when CONFIG_ACPI is enabled. Unlike the
ACPICA core helpers (acpi_evaluate_object(), acpi_format_exception(),
...) that get automatic static-inline stubs via the
ACPI_EXTERNAL_RETURN_* macros when !CONFIG_ACPI, acpi_has_method() is
Linux glue and has no stub in the #else section of <linux/acpi.h>.

This forces drivers referencing acpi_has_method() to wrap the call
site in #ifdef CONFIG_ACPI to avoid -Werror=implicit-function-declaration
on !CONFIG_ACPI builds -- a valid config for drivers that
"depends on ARM64 || COMPILE_TEST" with no ACPI dependency.

Add a static inline stub returning false, consistent with the existing
stubs for acpi_check_dsm() and friends, so drivers can drop the #ifdef
and rely on the runtime acpi_disabled check instead.

Signed-off-by: Bowen Yu <yubowen8@huawei.com>
---
 include/linux/acpi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ddacac812094..141a322435c2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1028,6 +1028,11 @@ static inline bool acpi_driver_match_device(struct device *dev,
 	return false;
 }
 
+static inline bool acpi_has_method(acpi_handle handle, char *name)
+{
+	return false;
+}
+
 static inline bool acpi_check_dsm(acpi_handle handle, const guid_t *guid,
 				  u64 rev, u64 funcs)
 {
-- 
2.33.0

