Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F9F230264;
	Wed,  4 Feb 2026 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770188526; cv=none; b=MUpWWEXtl1yAllnaPbLeLcu+oUSkSVEJTlv6YEzFEu4CXpnhAiv2fHDROHaKEpyfCV5YZoUcgudz1vRx+kPeOj60BJJRM2RUlv/zFNnjTzbPkB9ojJJyP4QkWnB7vfJAB11Wp/8et/6hUv1fOQ+X3M5tFjWkm/HhaMHBiAuLvr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770188526; c=relaxed/simple;
	bh=xbYtXoLVabpU57x2RmdjqyOY1U9k1ZQ9kSUN4VeCGuY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bojzSb0CDQcuwUo8kP8ZsOFI9637WNnbm6urWIfeam/L1/kbjDqfM0Zpfgh1xLbZ35thAxxDeQZeFr+sh+RBjNS7ryQtg8jocv3/eROlwOQYtp+ASXzfLhBkPDYEh7Kh55wz/lKRrzhJBm36i94nxZoFAJR4fTDEi0jiPICweRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4IQIb7I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4IQIb7I"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B622AC116C6;
	Wed,  4 Feb 2026 07:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770188525;
	bh=xbYtXoLVabpU57x2RmdjqyOY1U9k1ZQ9kSUN4VeCGuY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=D4IQIb7IMXKwifUmUHkK9Irdgx30izXSOyO0SyMurNUY4ZdwhtJKveVKVP3v1ZX6T
	 9BLluq/K/gtiqTqsJN0xmAKTo7Qm8x8CNV75w8N2j6euPllFGG9G/BUnFyaEiL93OW
	 vFK1gqJxWclxhV1VNdwQfTnkRCs+uEU6XDEeUDPqS4WGpZXulHXLiMSqnVZTT3yHhK
	 wuNvtnkffxKqhcpFc9hI6c6u+yNa23JP0Mm3ZfuGkKNcc/EGjRd1L8VlDZM2dhXREU
	 I8jGJou1FRc1fKryxhpcnBc00/Ok9llBB5FqxHtC3z1O22qZ4HLH5CyeI3g3mc2TM0
	 Af6nPvxD9oYOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D56E8B36B;
	Wed,  4 Feb 2026 07:02:05 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Subject: [PATCH v10 0/7] i2c: xiic: use generic device property accessors
Date: Wed, 04 Feb 2026 07:01:57 +0000
Message-Id: <20260204-i2c-xiic-v10-0-c2b996425235@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOXugmkC/3XRPW7DMAwF4KsEnqtAov4z9R5FB1qiag2xA9k1X
 AS5e+UsVeF2JMHv4QG8dzOVTHN3Od27Qmue8zTWQfCXUxcGHD+I5VgXHXAwXACwDIFtOQcme3Q
 +JU3oZVfPb4VS3p5Zb+91TmW6smUohE2A0JyDU+YMWjrPBMM+fpaCwxXH15G2ZZhuZ8x73pDnZ
 Spfz2or7Kl/lFiBcSakSjpaJcn1bcjeYpWtlI2UVVJvQ1SgVUxHqf6TqkqFknqUWvBAB6lbaRq
 pq3QOhUFwFkQ4SNNK20izt3VAkEwy2h6lbaVvpK3SgiUllfOW0kG6HwlcNNJVGamHGIV2UeBB+
 la2X/FVBlLG66TB2PhLPh6PbxwkFUh4AgAA
X-Change-ID: 20260122-i2c-xiic-3ba89ff5ea93
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770188524; l=3230;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=xbYtXoLVabpU57x2RmdjqyOY1U9k1ZQ9kSUN4VeCGuY=;
 b=L3hRvrEH3VS3iFOO+kmUvZS/6u5JSJI2HiMMyhMV5jEAxk4LETpSeRQlAobKaT+TNSGQjvsFe
 OBJW7cJajlCBhGGsfekzT+P3uKMs/ROlAFYWaaqB2GAj7vb7agESVZ2
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

- Switch to generic device property accessors.
- Switch to managed devm_ functions to simplify error handling.
- General cleanups.
- Skip clock setup on non-OF systems where clock is not specified via
firmware.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
Changes in v10:
- Moved dev_dbg() change from patch 4 to patch 5.
- Reworded description in patch 6.
- Addressed Andy's comment in patch 7 (&pdev->dev -> dev).
- Link to v9: https://lore.kernel.org/r/20260202-i2c-xiic-v9-0-ce4695f5267d@nexthop.ai

Changes in v9:
- Fix an issue found by the test robot in the cleanup patch.
- Reworded the clock change description.
- Add a patch to switch to i2c_add_numbered_adapter().
- Link to v8: https://lore.kernel.org/r/20260201-i2c-xiic-v8-0-deb2dd158d1a@nexthop.ai

Changes in v8:
- Made the clock change the last patch in the series.
- Reworded the clock change description.
- Changed dev->fwnode to dev_fwnode(dev).
- Link to v7: https://lore.kernel.org/r/20260129-i2c-xiic-v7-0-727e434897ef@nexthop.ai

Changes in v7:
- Drop the dt-bindings patch.
- Skip clock setup on non-OF systems.
- Minor commit body rewording.
- Applied code-review trailers with `b4 trailers -u`
- Link to v6: https://lore.kernel.org/r/20260127-i2c-xiic-v6-0-e82e2f6f657c@nexthop.ai

Changes in v6:
- Cosmetic changes to address the comments.
- Added a patch to use resource format specifier in debug log.
- Link to v5: https://lore.kernel.org/r/20260126-i2c-xiic-v5-0-88a16a28721c@nexthop.ai

Changes in v5:
- Reorder the cosmetic patch to be the last in the series.
- Added a documentation patch to describe the optional clock.
- Minor commit body rewording.
- Link to v4: https://lore.kernel.org/r/20260123-i2c-xiic-v4-0-4a3eba3510ce@nexthop.ai

Changes in v4:
- Reorder the cosmetic patch to be the first in the series.
- Amend the mutex_init patch to also switch to the managed pm_runtime_
  variant.
- Link to v3: https://lore.kernel.org/r/20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai

Changes in v3:
- Reorder the "optional clock" patch to be the first in the series. 
- Add a patch to switch to devm_mutex_init().
- Remove dup message in error path.
- Cosmetic: use temporary dev variable.
- Link to v2: https://lore.kernel.org/r/20260122-i2c-xiic-v2-0-134f5d743e8b@nexthop.ai

Changes in v2:
- Split the patch into two independent changes.
- Added struct device *dev at the top of probe() and remove() to re-use.
- Switched to device_set_node(...)

---
Abdurrahman Hussain (7):
      i2c: xiic: switch to devres managed APIs
      i2c: xiic: remove duplicate error message
      i2c: xiic: switch to generic device property accessors
      i2c: xiic: cosmetic cleanup
      i2c: xiic: cosmetic: use resource format specifier in debug log
      i2c: xiic: use numbered adapter registration
      i2c: xiic: skip input clock setup on non-OF systems

 drivers/i2c/busses/i2c-xiic.c | 99 +++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 56 deletions(-)
---
base-commit: 18f7fcd5e69a04df57b563360b88be72471d6b62
change-id: 20260122-i2c-xiic-3ba89ff5ea93

Best regards,
-- 
Abdurrahman Hussain <abdurrahman@nexthop.ai>


