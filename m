Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A611349AF9;
	Mon, 26 Jan 2026 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447301; cv=none; b=qiVxnY5+kzAJdFQJU1JsGQvgIxgQUtI1raConv0D9axhBVI9H8FiOSW3oogaBg6YsleG/T/DWBaF6H9hP64FLixu9F0WTnhabzuakdJbaKezbat5ReeZWxX8b229YHDI/lEw+TDJN9SsltleP5mdGXgcJPldd1rZ622rWy+v9G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447301; c=relaxed/simple;
	bh=VW73wEDlwm86XhzmqjnzsOO/GIvv7ArJjK3GOMgSBcE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OqXb5dmk75WV8QTMWGxH3uHL6XDesysgGHyI1a7/RTlfHMALBXGsVn0073LFveeFGPQfn6hi6+0gfSZ2GNX3yTrgIwaZd4YxQSCVtdp0vk+aM2g3BWjOYnPLvRByuShbf/gsB7mYupjLW8Xhg4tRQTz0fB7x/oG6hJ7eQ+iS1xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIx/mUcG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIx/mUcG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FC27C16AAE;
	Mon, 26 Jan 2026 17:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769447301;
	bh=VW73wEDlwm86XhzmqjnzsOO/GIvv7ArJjK3GOMgSBcE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=BIx/mUcGY7IEDfDiZCVQgafDJKy21iPx2ubRTWSEFUg8Mwfo2s44CdwTOKHBRfevo
	 a2VyTZmO5tOzbccC+YvvltXOemxUcQ/QOzQ+zd/QZHiT+2rsBy8uuY9JjO41Ss1XXF
	 1j3RdIctz+i69nD6lYtJnE3iOacDUY0QuTexlBGr3ZbyFKY+o1HhddBQTEIdId3SeO
	 6gMqQjUbzkf2LyPiVzFNlbqGywdsOBAUie4KSLAjnRb0jel6xnvxkFPdg55OVyTTne
	 unL0af1erk32KJHje2WyY8G3Jm6K370SRKug+3t5M5CZ/7MTr7S9zqJN5Cf+T95Bim
	 +/keDMKugflqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEFED19502;
	Mon, 26 Jan 2026 17:08:21 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Subject: [PATCH v5 0/6] i2c: xiic: use generic device property accessors
Date: Mon, 26 Jan 2026 17:08:15 +0000
Message-Id: <20260126-i2c-xiic-v5-0-88a16a28721c@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH+fd2kC/3WOQW7DIBBFrxKxLhGegcTOqveIuhhgKLOIHWHXc
 hT57sVZuWq7fNJ/T/+pRi7Co7ocnqrwLKMMfQX3dlAhU//JWmJlBQZOpgHQAkEvIkGjp7ZLyTF
 1qOr8XjjJ8kpdPyqnMtz0lAvTLtA4Y6C1pyM4bDvdaPLxqxTKN+rfe16mPNyPJFsvyzgN5fF6N
 sNW/ePEDNroBm1y8WyRW7+PbC9m3Ju4M7Ga7M8hWnA2pt+m/c+01bSE7AldYwL/MNd1/QYbsqa
 iVQEAAA==
X-Change-ID: 20260122-i2c-xiic-3ba89ff5ea93
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, info@mocean-labs.com
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769447300; l=2044;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=VW73wEDlwm86XhzmqjnzsOO/GIvv7ArJjK3GOMgSBcE=;
 b=8Q/hfEyzU9oetCA/lp4xPmLum414rzPxHu/AuVZD4ceCsOa6W4AvAI49TJN3wt8SDE03wwRB1
 kMApOawg1wHCAYOgM3PsjhSaASlZkB6a0M54v0qBXMkOFfGLn9wUeqC
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
      dt-bindings: i2c: xiic: make clocks optional
      i2c: xiic: make the clock optional
      i2c: xiic: switch to devres managed APIs
      i2c: xiic: remove duplicate error message
      i2c: xiic: switch to generic device property accessors
      i2c: xiic: cosmetic cleanup

 .../bindings/i2c/xlnx,xps-iic-2.00.a.yaml          |  1 -
 drivers/i2c/busses/i2c-xiic.c                      | 81 +++++++++-------------
 2 files changed, 34 insertions(+), 48 deletions(-)
---
base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
change-id: 20260122-i2c-xiic-3ba89ff5ea93

Best regards,
-- 
Abdurrahman Hussain <abdurrahman@nexthop.ai>


