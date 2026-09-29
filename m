Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE9550EC1C;
	Tue, 29 Sep 2026 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684037; cv=none; b=PFxAvV+3ki/8G5e5syw8QXy9DDBwk0fgmXM9gBOLFiEJCe+vXm15EpaCGe+TD8ZijHnB5/Y+XINNaIe0fRu8FLLOSsHScmtzcjp+3d6/NGUxU8maGhkqKjaqSegcCNKUih0WAmcjrozAXeKOEwkZ9Lrk8/Ad4J0P/irPaZJQmJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684037; c=relaxed/simple;
	bh=uLH8sQX88Q9Sg2vdzOsVaORUDs6PNndjR+fwrDiwLI4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FvldojHPCrcDEkCwin1ECcZsl82c3uPe7FSaD+lwFccvzEr5AgN1vaHYXhXxNrJNMX4s51TD/EfolfGbzBRk8Y1THYYmgp7yT48G/WQ3oXI5jNDM9FXWJAlRi2+uGJXLi0j8i41c+KIydzTwLX7ru+X+2GdG7Wgj55wofLxDnDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=l7ONBpVc; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="l7ONBpVc"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IP4pHjjBymY8vzPf4WXiJrLI1WAkRi6Uu+NxzgUBglw=;
	b=l7ONBpVcWE8Ddq3RWD1VCs8QDktBpeg5Cp4SX+v2Akw++NzoTbh3W+NOsmGUr8gBblgsJxkKs
	bMpvjGufEy/ofkB3KpFwtVypDMeefqAGM0BpAaGHecBeP8k1ryC4S2hhoNDRE3fcAMYIV55HiP4
	wR2o613oNEcQXNGam+dOWp4=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hvGyW3MrGz1cyS4;
	Tue, 29 Sep 2026 20:02:43 +0800 (CST)
Received: from kwepemo100017.china.huawei.com (unknown [7.202.195.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 920754056A;
	Tue, 29 Sep 2026 20:13:49 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo100017.china.huawei.com (7.202.195.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 20:13:48 +0800
From: Bowen Yu <yubowen8@huawei.com>
To: <linuxarm@huawei.com>, <liudingyuan@h-partners.com>,
	<andi.shyti@kernel.org>, <linux-i2c@vger.kernel.org>, <acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>
CC: <zhanjie9@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <xuwei5@huawei.com>, <yubowen8@huawei.com>,
	<ouyiyong1@huawei.com>
Subject: [PATCH v5 0/2] HiSilicon I2C bus recovery support
Date: Tue, 29 Sep 2026 20:13:46 +0800
Message-ID: <20260929121348.109556-1-yubowen8@huawei.com>
X-Mailer: git-send-email 2.33.0
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

Changes since v4:
  - Patch 1 (new): Add a static inline stub for acpi_has_method() in
    <linux/acpi.h> for !CONFIG_ACPI builds. This is the prerequisite
    for dropping the #ifdef in the driver: acpi_has_method() is the
    only ACPI symbol referenced by the recovery code that lacks an
    automatic stub (the ACPICA core helpers already get stubs via
    ACPI_EXTERNAL_RETURN_*).
  - Patch 2: Drop the #ifdef CONFIG_ACPI guard around the recovery
    helpers in i2c-hisi.c. The six recovery functions are now compiled
    unconditionally.

Patch 2 depends on Patch 1 for !CONFIG_ACPI compilation.

Bowen Yu (2):
  ACPI: Add stub for acpi_has_method() for !CONFIG_ACPI
  i2c: hisi: Add I2C bus recovery support

 drivers/i2c/busses/i2c-hisi.c | 142 ++++++++++++++++++++++++++++++++++
 include/linux/acpi.h          |   5 ++
 2 files changed, 147 insertions(+)

-- 
2.33.0

