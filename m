Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F53618787A;
	Sun,  1 Feb 2026 02:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769914670; cv=none; b=VahDBGw74DJvBsnGx8TdyHpdOV+4OOPopyzgF5qaRl9Vvjdfr24QcJnZmkfGcfRwavlK7duGW4Rna3h2Rr0a4buT6M1bNxsDSptcsLzLicipRSXlnLghEfl6oSW6Wdwrddlh88GAYFe4WVx82ESjseuL1FBcMzXsO1ZLRgPblf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769914670; c=relaxed/simple;
	bh=R4QN70gtL6kBwxgirmfc+vVqtNxB/tfOuczO6/4Za4Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oqHooob/nFiGdlRot3hpiQL01vieLDiR0XzRithAQIAyKQM78QYecg75hOP1Jr8KF00VkmigPZ5KUT/nSUEKJCx5Ip48OgpUgL1xpHTZF+GJGd6IyeiOxaG1y92eaYjjrNKaFnIkBBJOdky5phWRmGf/XAR+0I19M27lR82s7gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9tHDRZ8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9tHDRZ8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83577C4CEF1;
	Sun,  1 Feb 2026 02:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769914669;
	bh=R4QN70gtL6kBwxgirmfc+vVqtNxB/tfOuczO6/4Za4Y=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=N9tHDRZ8tOTEpxwmVKian4bOs+iOkNNuHCvnPEiaxCGRKDFSCy54fOmEo9v5pq5sm
	 /t0mU3V97TPKcnBPCdJ4JBuAqCJlNqa+lon57Mei8WBFcygtE27mrJOMeR0A58qwNj
	 3oTXC4bPHiUrhZW/IpdYsY1cCT6bhVkaLFwGVm00l3EO+w2aaEW+7HZZPWlJXbbqGu
	 APEGXx79FWuUm8DsTBdF3FYOrs7096BUQ/ThgrkdjSFVQZMsS3j3u/UHHcYVkAOV4d
	 gfY7NG20EY1JPH3cRm/eNMGiYr5Rm4Tz0wO0oqVeSiMP6PNBgFGtyh81Dv3iveAeCm
	 6p4OCqwtOafbA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705ADE7C6FD;
	Sun,  1 Feb 2026 02:57:49 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Subject: [PATCH v8 0/6] i2c: xiic: use generic device property accessors
Date: Sun, 01 Feb 2026 02:57:44 +0000
Message-Id: <20260201-i2c-xiic-v8-0-deb2dd158d1a@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACjBfmkC/3XOTW6DMBCG4atEXteRPf6lq96j6mJsxsWLQGQoo
 oq4e01WrmiXI83z6nuwmUqmmb1eHqzQmuc8jfXwLxcWBxw/iee+3gwEWCEBeIbIt5wjVwF9l5I
 h7BSr7/dCKW/P1PtHvVOZbnwZCmETkEYI8NpewSjfcckx9F+l4HDD8W2kbRmm+xXz0RvyvEzl+
 7lshaP6x4gVuOBS6WR6pxX50EaOFatqpWqkqpKCi70Go/t0lvo/qavUqCigMlJEOknTSttIU6X
 3KC2CdyDjSdpWukbaY60HgmSTNe4sXSu7RroqHTjSSvvOUfol933/AU4FELsDAgAA
X-Change-ID: 20260122-i2c-xiic-3ba89ff5ea93
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>, Andrew Lunn <andrew@lunn.ch>, 
 lkp@intel.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769914668; l=2657;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=R4QN70gtL6kBwxgirmfc+vVqtNxB/tfOuczO6/4Za4Y=;
 b=YfXXstzqXqVi3zQ+d1PuXev5tPSZc5dWhI07nv2amogmUdyI1ttyJHy/Q1wYH5NcRz61TsIHD
 aEmsRzWGoU6BBp0Ax5QvbOOvTqEFOyqjiHgvGW56kJWLzlhoaa+URHd
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
Abdurrahman Hussain (6):
      i2c: xiic: switch to devres managed APIs
      i2c: xiic: remove duplicate error message
      i2c: xiic: switch to generic device property accessors
      i2c: xiic: cosmetic cleanup
      i2c xiic: cosmetic: use resource format specifier in debug log
      i2c: xiic: skip input clock setup on non-OF systems

 drivers/i2c/busses/i2c-xiic.c | 98 +++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 56 deletions(-)
---
base-commit: 4d310797262f0ddf129e76c2aad2b950adaf1fda
change-id: 20260122-i2c-xiic-3ba89ff5ea93

Best regards,
-- 
Abdurrahman Hussain <abdurrahman@nexthop.ai>


