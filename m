Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4B936402B;
	Thu, 29 Jan 2026 21:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769723006; cv=none; b=U089eMGtHG4xFpGI9YsXpmFVlDSBAbiR6jakPXCbiPckulDb4qbN2NKMvIj5FauLDbqHmyUMFKmpjyWEI4uh0gFNsz3//djZH/DcdZtZtU+bWvOLfCkt7kqGxQ3pCSHAKTJ7CR6yakEc7iBqohCfb22eiU2L1jf3IRKHgujI7Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769723006; c=relaxed/simple;
	bh=7smW9wv7mnfx4la6W1Qts9O6kM1lftllC1c0AQLzYw0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Hg220pG7YTK3rgEB2D2GaN7FCrqiMvIRjT9HXoPJleLmsRCfUcGx6/4+RmXbix/J4/CuioO1DkCSHxjmy22KiAbkRkcZ4ZGb2hRWhOssrrnXzV8xTTgxqJhtD0d8lJv2c0OdT0U35oWA33Tx+IOl1le6/iDy/UWuLuSMN3NGoIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2fX8xji; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2fX8xji"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE4F1C19421;
	Thu, 29 Jan 2026 21:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769723005;
	bh=7smW9wv7mnfx4la6W1Qts9O6kM1lftllC1c0AQLzYw0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=O2fX8xjiBytJKz1dtLSUIoLjqIENP5rpV5zxiSiewqicWudeffKeUxf4qPOAXl+vm
	 EApcR21/73tz1mJ2aC3PmvJ4qPQQ7OgSpQoHOpn4+5b/P9Y8XzXf+F1g/nHJ7CgTft
	 yIoQ5BXSCHZ8abGIMCfCQKkZsL6r+3F41JztREkvD5ZQm6o7Wf/xHYn90iC4OwXkHN
	 J4uRcB3WuQ1q2EWVcREW82UsV1POteGkTpGK+8t6KI3S4LborYJUPZIpUhcH3FMGrk
	 leBhZW9YqPmbEa/QqdDTI0+KiDytrx5k5cF9++UIYoaKU2XbSp/Db8/F1ijF+6FPdn
	 IRQLPl+Y0EIWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993DED73E9C;
	Thu, 29 Jan 2026 21:43:25 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Subject: [PATCH v7 0/6] i2c: xiic: use generic device property accessors
Date: Thu, 29 Jan 2026 21:43:12 +0000
Message-Id: <20260129-i2c-xiic-v7-0-727e434897ef@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHDUe2kC/3XOTW6DMBCG4atEXteRPf6lq96j6mJsxsWLQGQoo
 oq4e01WrmiXI83z6nuwmUqmmb1eHqzQmuc8jfVwLxcWBxw/iee+3gwEWCEBeIbIt5wjVwF9l5I
 h7BSr7/dCKW/P1PtHvVOZbnwZCmETkEYI8NpewSjfcckx9F+l4HDD8W2kbRmm+xXz0RvyvEzl+
 7lshaP6x4gVuOBS6WR6pxX50EaOFatqpWqkqpKCi70Go/t0lvo/qavUqCigMlJEOknTSttIU6X
 3KC2CdyDjSdpWukbaY60HgmSTNe633Pf9B2Xj/2DJAQAA
X-Change-ID: 20260122-i2c-xiic-3ba89ff5ea93
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769723005; l=2376;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=7smW9wv7mnfx4la6W1Qts9O6kM1lftllC1c0AQLzYw0=;
 b=d4ZaXTI8ZTXU3UokV9L94MlJcMelypXusSRQkbs4aKOPqCOI/p+76DFcmQapIHKmR6z4TxqgA
 FcEf4ua9LK1BFZoBQq2Su5sNs7Yj75FrF6TbpX9Tu0opg7AUPJA2FPa
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

Switch to generic device property accessors.

Switch to managed devm_ functions to simplify error handling.

Skip clock setup on non-OF systems where clock cannot be provided.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
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
      i2c: xiic: skip input clock setup on non-OF systems
      i2c: xiic: switch to devres managed APIs
      i2c: xiic: remove duplicate error message
      i2c: xiic: switch to generic device property accessors
      i2c: xiic: cosmetic cleanup
      i2c xiic: cosmetic: use resource format specifier in debug log

 drivers/i2c/busses/i2c-xiic.c | 98 +++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 56 deletions(-)
---
base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
change-id: 20260122-i2c-xiic-3ba89ff5ea93

Best regards,
-- 
Abdurrahman Hussain <abdurrahman@nexthop.ai>


