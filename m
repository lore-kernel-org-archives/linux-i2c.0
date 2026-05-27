Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC96539182A
	for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 20:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912615; cv=none; b=Gk3IRqxm+Ol3mOPop7JGKt1AsIFt06UXigKJIdhCvefE3Uv1kcx5SNW8k9vShPxOdmsyNF85c5/tvfRp+UG7nsTuJMbbQZuR0Mx82ayWjc63LsFE8aLjLC2oQGGceZXck+e78dSVwsJOtbAA+1Zvksv1CjKO0i2zADP3oxzY618=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912615; c=relaxed/simple;
	bh=BXyygT6KooIkATSpczru2FP9H3alp+SSLbQ+JG4TMVk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dn3NmrqfF05W0K0df+AQ+fNDRF4dzs52zC9fwTZU8k0X0gyST8oQ8v14yXARMaZEqGWZDCZn5emtf1GQomB84SXFOkbBDCp5dC48I4f3SqQixRWwvT9PXUmRL07+ZKT4L/eUiZ6MTn5TbyHNuQWQTNVLgvgEBLUPZY7bYLA24C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=pQ/ysguT; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="pQ/ysguT"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-366375c4076so5289415a91.3
        for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 13:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1779912613; x=1780517413; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oZMqsGGe14qMX5APGY1G/LDeh08IMnWvkF2G7ulrX1w=;
        b=pQ/ysguTBgRnIfyZrUSBVFnS0icjuxIORH1+G7Ro7tWWYFAUV2RpX8+8GKE+YQ6ga4
         Ys3/eWjWNGLs5RSkPt/MLyn3zM5DUC+qr3shVlLcwnK11kuor00WvJA2k1kHuDqKEZ7P
         FJd1PToZPJEJYqDr7RYhTJRVST8GgMJkdM/31cTQQV4jFHavBXBIKRHF0fe5ZBSnDypC
         /lDqZmlbTNopayZLrxGB+eenh9WP4c6E6Cmsggj5JmaXb79GKFa/9PRMYy756LaDeO01
         85NSmgnGBop+ga0g6oFCA/JB4Y6Bj8J4WEKe49YWqTjHgd3qRTE3aOjgrdN/2BtFmJA/
         HUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779912613; x=1780517413;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZMqsGGe14qMX5APGY1G/LDeh08IMnWvkF2G7ulrX1w=;
        b=CFq7EOFkejec81Vl32gtVNB4ah/58ikIoxldTOZUSlpHTVoAjyiXVAhRfbKpi3fxL2
         3TB5LkEg9vWUneTB41PbbuK1jvZ5TqXamUMNnsgJnv8yibLlZRpnqgfoI8j6haG0rV4O
         G3u9M7K6LTTWR05i14OluGAgKt+tI5w7ix1Y7GNd0i9tY1Qbv3chnr+JHq2qkryCdQ/E
         c8DI5/xA8lsAhZbsIo4LMolhqsC3zxzgoULSKGYpV9RBaMDnAAOIiC+60xKY5Gy32/0Z
         8+MJyDMZFwW/fzJc1WN8gZEi8Ny3Clec44EjW92VZ0nQFlLS+o3nYp3p7jtx2WNGcrII
         84PA==
X-Gm-Message-State: AOJu0YwKe6+U/UpPAxSZ143maUAId6sQFULUYjib/ZkbYo16u4BD8w4X
	zB4S4TSjJsoJXZcGGOwDhwDM2/W4VNzwFHm/j/r48vfyU5Rx2EZNZNGokn45SN0jwXA=
X-Gm-Gg: Acq92OGsTAC2jhDGYY+3Z2ppcdK6urhXn8Ok4xKpG2PNMJS4mzr8R71h+JQ76GpoTr2
	94vsl7rJT/VjWyC9hxn+pfyJWID41+EcHouxq4g4ItBuyoMp4wHiP9Q1hmD9oupLAnKqgD2oe/q
	b24OV1algPZUvhP3y/m4UP0HS/yrMFu37lDbng8ZP06VMZp47gwJ6LZP9MdG6Xn8EvQX/qRLexl
	ioMhSZd8y1tuzNK4ILPoMc5qzpmmcLk4U/uwCVilhqX5TSKzvZKfn4v+B0pyWBcNGb0qzvK4IJE
	qw2zQtAXQQY+5jB7sgB0cyUKJmSeSEdEI6WzZqEg+w1zu5o14qo+VxyAUEfGhbN1SeDHCz/ZIXt
	xU4b1xPEGZGWIhnXC2va2vdi6a16JIbOKJJ+7aBloRqHG6gCp8xPv9gZkt0OkT0zwFFZtMWuvGY
	QLLwoGGjQY+TkHmlvs6/m9hh/O4YjeyeeXkL9gxgRskH19KbYGKbU/+w4AfFzpOCEa0nAkO4KoL
	Mhlp8K3zCAOs/YSTAIP1b4=
X-Received: by 2002:a17:90b:33c1:b0:368:cefe:ddd0 with SMTP id 98e67ed59e1d1-36a6765aa6bmr21951985a91.15.1779912612799;
        Wed, 27 May 2026 13:10:12 -0700 (PDT)
Received: from wakbuild.c.googlers.com (27.117.125.34.bc.googleusercontent.com. [34.125.117.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a71d9416csm21875253a91.3.2026.05.27.13.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:10:12 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
Subject: [PATCH RESEND v5 0/4] i2c: designware: Improve device disable
 handling
Date: Wed, 27 May 2026 20:09:48 +0000
Message-Id: <20260527-dw-i2c-v5-0-3483057f8d67@wkennington.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "William A. Kennington III" <william@wkennington.com>
X-Mailer: b4 0.14.3

When the I2C controller attempts a new transaction while the target
controller is shutting down or restarting, it can lead to bus lockups
and system bootloops if the hardware enters an inconsistent state.

This patch series addresses this by ensuring that the internal state
machines are properly cleared when disabling the controller if target
activity is detected.

Additionally, it adds a shutdown hook that gracefully sets the target
disable bit before disabling the controller. This guarantees that any
incoming requests from the controller are immediately NACKed during
shutdown, preventing the bus from hanging.

Signed-off-by: William A. Kennington III <william@wkennington.com>
---
Changes in v5:
- Fixed one last inclusive language mistake
- Link to v4: https://lore.kernel.org/r/20260507-dw-i2c-v4-0-9a447b23bfdf@wkennington.com
Changes in v4:
- Updated language to use inclusive terms
- Refactored some minor comment / code nits
- Link to v3: https://lore.kernel.org/r/20260504-dw-i2c-v3-0-57e56135d602@wkennington.com
Changes in v3:
- Split the monolithic patch into 4 logical patches
- Reverted stray formatting change in the PCI driver's dw_i2c_driver struct.
Changes in v2:
- Fix description footers
- Fix emails

---
William A. Kennington III (4):
      i2c: designware: Introduce shutdown exported function
      i2c: designware: Convert PCI driver to use shutdown hook
      i2c: designware: Convert platform driver to use shutdown hook
      i2c: designware: Handle active target cleanly

 drivers/i2c/busses/i2c-designware-common.c  | 32 +++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-core.h    |  1 +
 drivers/i2c/busses/i2c-designware-master.c  | 31 +++++++++++++++++-----------
 drivers/i2c/busses/i2c-designware-pcidrv.c  | 14 +++++++++++++
 drivers/i2c/busses/i2c-designware-platdrv.c | 14 +++++++++++++
 5 files changed, 80 insertions(+), 12 deletions(-)
---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260504-dw-i2c-d5a1b1a0036a

Best regards,
-- 
William A. Kennington III <william@wkennington.com>

