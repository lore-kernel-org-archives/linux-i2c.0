Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B55C326938
	for <linux-i2c@vger.kernel.org>; Sat,  8 Aug 2026 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786202553; cv=none; b=VscVerYNyauidNInv0AfxXgPkbF4dpoJuTvqbSJrKttDfE0+5BrMGb6Rj6YY4xBAOvFjI0lXtcXYkMiHGBTDoHI/2HXMZA5llMME2yNsSCOZwKKIKL/BwqPpsNTe86erRuR3Ffb2Ji0TuNvGn90XxIJiSuNOBRsI5YyouSNhmhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786202553; c=relaxed/simple;
	bh=pUVoEvqTkBts2j5M0WNdQpyr1pnzEIN9t25AtarzmiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lHr3IoLm43iisEhTG85Lyr/73NeuVkAsm5V0/mCs/+CGU5SKUCx3mJa1jdw3i1hh35UBckhzOVItnumv/FH4SolxQcaKQLm+uS8QdqhC78r46dyKQAG0R23e9C5C64R1V1nn/HegtWyu+vZ2llxo7LREAAyg1mWyS0cZdJdc5/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcDCOcWC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcDCOcWC"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cf52d15d88so3835755ad.2
        for <linux-i2c@vger.kernel.org>; Sat, 08 Aug 2026 08:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786202551; x=1786807351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bn5LTk57U4QWCUdbGncuYOxjBXWL7RxJ7HrZaPl5EUU=;
        b=GcDCOcWCJt1t3arAoAbWBmnwSy7oPG4AGkSJveTC8F3QP4ZRku5WgEJOEHqeJABkrj
         6501iqlJcYPOJIfXHZC//6yJCD2VJYzpY7rVp3mzzL3hD/aoDmPUkmLUXUinS5fYtPzU
         L2KoEdufBCN8vMdQJGtPExrDMYQzDzevQQjL5V+3m4oRroMQ50qWnyeabOo3JAbeUOlM
         bEm9pYZx+FN8e4xGMHYfLiZh717NZQE+dEukBmGqtkj6bk3PdhZ0KADbfYn5cpBCT+jY
         +Qnyd9m/b4rkteA2W7ni9swcvqNKBJ/PXT7SpYa6Wejg7S/L7KMOAD/TW4KS+WviDyBw
         1fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786202551; x=1786807351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bn5LTk57U4QWCUdbGncuYOxjBXWL7RxJ7HrZaPl5EUU=;
        b=BpZFBhH6YTohOUegtxq+AC0StleBPd4FzGNoxo0XbYXwK5TR6Nr29SnEzz6SlHmd4m
         K33mrsNbkYGi2KT6NEHimkHUxXDx1FnX7z7SfrHAnZeGqRe89NMC32lJ/mbzwNqY0LxO
         DDCim9Yz3bKIndrfEw7kS9uUGYxSchGM+f5+fb3kMZU9HMpMGfOu6idpHwEEOSPWgm4m
         SW6ZIJdo8dwBvjIR1P5XmV7qz4MF+D5zxXe3uJrnut7Q9jRTuo4XL8jS9zno3F1kN1PX
         llpJ+3wTJQOZZY98OyUlAuQLgf/UVwfE+G+NYtc/kW3dxIyG90oK2PxUEhy7d7hBDmCm
         oh9Q==
X-Forwarded-Encrypted: i=1; AHgh+Rpc3caFnJiviPnBtL9CFQ7QCUcoPFBb1kIcryYFFhw2gQrubd6gml9TG2tYyl2kIvO70OLXYiBzVeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtYKBgM1/nwyfoCAADyzTJZIVapa8hs/XGwtJvp0OHM4xAOoVJ
	nj2l+dCgHW5Haz9RApEX+rHyzuRs/xAEa3MwnpI6JOWPjy1Ay7vgpNK+
X-Gm-Gg: AR+sD10UMMLDpb7vyQ6eZO145kX2dII07PcY7qDmsdmDi+uCmTcs3l1Sfalj/WKj1dQ
	z/IMUf4jnJDoCKQ2o9zT9Vl/w4J4+C9k34Z5WVdjCVx08CiMp2+EIiIrFzcDXB9iRj1y6vQzWK4
	OLN1gK+JU/kdE04x2bcH4sl2w1LxdmSk95macazAVbtXgJfYtcaXw6E+QGI+dCZUd4agiZg2TG1
	+M6yY9nhah4YVIOTuunTI7DCn0fsO9YefwPBJwXoThKasKxNc3KymoDDB8zEca1Ozog8mIhnMA1
	PFCfsAA291908OHXQ5hgzIuspN84jDy4cDE07+SeqjFSqIA31/fCbp6QlJfgmgfKNk2BTknq1hc
	3qzkUnnRIiBvijsUonGzKiNTesUsTfsjgqkryMobWwUtRWLQOtC82hpI5SgDczuYofPGs6008OT
	VbA4MilYfoIlCTU3jm+AA9tjWMPgHx3bYrVY99HbOROKWfztdJRg==
X-Received: by 2002:a17:902:ef02:b0:2bf:7b62:a038 with SMTP id d9443c01a7336-2d2a898f9abmr104950805ad.9.1786202550819;
        Sat, 08 Aug 2026 08:22:30 -0700 (PDT)
Received: from lgs.. ([101.36.111.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16b446bd3sm19442305ad.61.2026.08.08.08.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 08:22:30 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Elie Morisse <syniurge@gmail.com>,
	Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: amd-mp2: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 23:22:20 +0800
Message-ID: <20260808152220.2938557-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amd_mp2_pci_probe() calls pm_runtime_use_autosuspend(), but
amd_mp2_pci_remove() does not call the matching
pm_runtime_dont_use_autosuspend() during teardown.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the driver
remove path.

This issue was found by manual code inspection.

Fixes: 529766e0a011 ("i2c: Add drivers for the AMD PCIe MP2 I2C controller")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/i2c/busses/i2c-amd-mp2-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-amd-mp2-pci.c b/drivers/i2c/busses/i2c-amd-mp2-pci.c
index 5b41d18b62d3..2b7f7b3cddc5 100644
--- a/drivers/i2c/busses/i2c-amd-mp2-pci.c
+++ b/drivers/i2c/busses/i2c-amd-mp2-pci.c
@@ -371,6 +371,7 @@ static void amd_mp2_pci_remove(struct pci_dev *pci_dev)
 {
 	struct amd_mp2_dev *privdata = pci_get_drvdata(pci_dev);
 
+	pm_runtime_dont_use_autosuspend(&pci_dev->dev);
 	pm_runtime_forbid(&pci_dev->dev);
 	pm_runtime_get_noresume(&pci_dev->dev);
 
-- 
2.43.0

