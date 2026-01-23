Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3926C2D9492;
	Fri, 23 Jan 2026 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769186057; cv=none; b=gs+/oUJ4pSbdanmArT8S2A8NjLMbeXANf09GrstJJ/63uUU/NoMy7jbV6lslJr/kIAfeiQX7ikptbdW0m9wd874CQ2bM43fh4EivJBM+ocMUjhhJCyyGoXewKiV19Ldbv/Lh0o9UYGZc6NQN90MlWvWNFTpatL9ONjtbxlCRz/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769186057; c=relaxed/simple;
	bh=SH2RWWiwpkeWyZQeIGuiuLmQkTXrbQiB6gtTSnYx/14=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SRP+ph5ByTGMHWOkJo2lWWF+VirHXxF3mInYgfdhdqfatG2Rx+52V9Dcf6aQcNFtvw07qux5UhpVngkT3lcH4ttwMD7yD8DmdtRV+9tRF6vi34w+NPvaD6UKbjwTmdq5PU2vUe7dQt+HVg+r68ntiN5fZgoT2UI7Vc7zpeL+cnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sB4/yzzk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sB4/yzzk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFEECC4CEF1;
	Fri, 23 Jan 2026 16:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769186056;
	bh=SH2RWWiwpkeWyZQeIGuiuLmQkTXrbQiB6gtTSnYx/14=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=sB4/yzzkOfQLoN8l/lgSi5tZTxM7tgMUq6hWreDNSMaD1xDGceibW2az5uI8+3kzZ
	 DaEeXuOENCQqd5GaaLRjZVnsv1pV1VijOek8nOEXxKRrxPwNiYORyOzg1TcLZPMLqC
	 jo7jDjeeEwsctyuwmiEdcfSUcJOqIsgitv1NqZTh3+lVihmwvMgC8BDdkUhwjLmyby
	 Wz7Ok39SsXjEbZH09zZy/WE3ISqxkqRNpQtGWu5R8sfYTcCIUt7+rXRgTP9ZfraLA6
	 ayNXYViPwNBIeyBywPnQ7lLPHBVEnZdicaNEkQ0zZo19LuTWa8I0PApniCQz5ElpDw
	 Jp+tQbAmzbuRg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8534D74EF7;
	Fri, 23 Jan 2026 16:34:16 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Subject: [PATCH v4 0/5] i2c: xiic: use generic device property accessors
Date: Fri, 23 Jan 2026 16:34:13 +0000
Message-Id: <20260123-i2c-xiic-v4-0-4a3eba3510ce@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAWjc2kC/22OQQ6CMBBFr2K6dkiZtgiuvIdxUejUzkIgBQmGc
 HcLK0xcvuS/l7+IgSLTIK6nRUSaeOCuTaDPJ9EE2z4J2CUWKLGQOSIwNjAzN6BqW1beG7KVEmn
 eR/I876n7I7GP3QvGEMkeArmREktdZGhUWUEOtnbvGG142fbW0jyGrs8sb73Aw9jFz/5swq365
 8SEICFX2ht30YrK+hjZXkzqaKqDqZJJ9aVxGo12/tdc1/UL3bsVxBsBAAA=
X-Change-ID: 20260122-i2c-xiic-3ba89ff5ea93
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769186056; l=1708;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=SH2RWWiwpkeWyZQeIGuiuLmQkTXrbQiB6gtTSnYx/14=;
 b=flb3w1tYsbw3Rosf7jIaipmBHlhMiYFVpLk6X/cKjH494wEKjC4uGWHOqcn+Seh/WM9J0DYCi
 PsXPY+dxdfnD7Pt5LDibPjYywOKDLlBX9IKIV7N3hsOt6CzxS1vxM2X
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

Switch to generic device property accessors.

Switch to managed devm_ functions to simplify error handling.

Make the clock optional since the driver is designed to operate without
explicit configuration in firmware thus making it useful on platforms
where clock is not or cannot be provided.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
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
Abdurrahman Hussain (5):
      i2c: xiic: minor cosmetic cleanup
      i2c: xiic: make the clock optional
      i2c: xiic: switch to devm_ managed apis to simplify the error code paths
      i2c: xiic: remove duplicate error message
      i2c: xiic: switch to generic device property accessors

 drivers/i2c/busses/i2c-xiic.c | 83 ++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 48 deletions(-)
---
base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
change-id: 20260122-i2c-xiic-3ba89ff5ea93

Best regards,
-- 
Abdurrahman Hussain <abdurrahman@nexthop.ai>


