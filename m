Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61043392C48;
	Thu, 22 Jan 2026 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070756; cv=none; b=VXmM5ayUumeJMHWMGmP0swpbc6pRordjJ+jyM++GxD9jv3yBNXC9pjLHXr41FqQb7kkdUAk5IHJ2Fxh28bz6AoqlHiMUjnBqpaZQC4Cnehi2r8zh4DXKGYUf77y6N+sb9f5trTR4zLK1gk7ZBa6Ts2iARj8pHSY+ouTzOOu/VfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070756; c=relaxed/simple;
	bh=LLhB3J4m5a0dTpoW8ctYFKn5mu2uLbvwih+4M0rsLMw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fAfnQs/0iQwg0HjUUMCE6Tc3CjP5iqdMJN01H6sh9GOhRJaLHa9+U0V8o5WoflqrAnrOAlPBTwnQH3M5n5X/PIUzj+nZEPbxTTCfqDsURBTkUuTz5BjcEHYwrKTyixFwBRPXk0GdM525IwwrMvh8kKafTkkFRT6Q1gtjhHK58hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qciHDGOc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qciHDGOc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 005B8C116C6;
	Thu, 22 Jan 2026 08:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769070756;
	bh=LLhB3J4m5a0dTpoW8ctYFKn5mu2uLbvwih+4M0rsLMw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=qciHDGOcWXwHztpkMdmH5sLi8OjH1DY+ZUWSXH601WIdcAWIP9ISwgcYJnGOCb2XP
	 Y01ALQVWn+WrE/cxwMPMR14HQu8nGNDzVZEUBnJGdqKzeNfKLe8IJogQxWtnh0rVgS
	 0+XcpadOE9ZsgTlJDimoXUjSm13GpZ/b63WsSVPyOyNHYOZ86hckTJJFCtp6rsXsj/
	 mJ0ZPBl/3Rdki1ks5bH8xfCHHwjXrHQ0ScCXJ/JLYFnP+9MTdd+8LeVL1+VZUkWvwd
	 Q7C0a3QioPL6QJSdmJzh/puEvq28qZMtv3+0wionsM+QUMwbFqWkeHdqn7Hz1hnXoq
	 v5Ad19SPOIFUw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1820C44500;
	Thu, 22 Jan 2026 08:32:35 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Subject: [PATCH v2 0/2] i2c: xiic: use generic device property accessors
Date: Thu, 22 Jan 2026 08:32:30 +0000
Message-Id: <20260122-i2c-xiic-v2-0-134f5d743e8b@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ7gcWkC/03MQQqDQAxA0atI1o2MsYp21XuULqJmOlk4SsYWQ
 bx7h666fPD5ByQxlQS34gCTjyZdYgZdChgDx5egTtlAjlpXEaHSiLvqiPXAXe99I9zXkPPVxOv
 +Wz2e2d6WGbdgwn+DqnGOumtbUlN3PVbIw/Q24zBzvEfZt7CsJSuc5xfG2wXWmgAAAA==
X-Change-ID: 20260122-i2c-xiic-3ba89ff5ea93
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769070755; l=951;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=LLhB3J4m5a0dTpoW8ctYFKn5mu2uLbvwih+4M0rsLMw=;
 b=+tZ5Zf3eiPLTTqfzu0IBnoNfd1f4U1RPJdxysXHB1nD2bss1wzmnJw6G50cAfKiONnI38O2zC
 /Y+ZUkpeoGvAl2HZE38t5EzilD1jGZquagjFfSeVLJwpxFXF18IjUyc
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

Switch to generic device property accessors and make minor code
refactoring.

Make the clock optional since the driver is designed to operate without
explicit configuration in firmware thus making it useful on platforms
where clock is not or cannot be provided.

Changed in v2:

* Split the patch into two independent changes.
* Added struct device *dev at the top of probe() and remove() to re-use.
* Switched to device_set_node(...)

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
Abdurrahman Hussain (2):
      i2c: xiic: switch to generic device property accessors
      i2c: xiic: make the clock optional

 drivers/i2c/busses/i2c-xiic.c | 60 +++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 33 deletions(-)
---
base-commit: 944aacb68baf7624ab8d277d0ebf07f025ca137c
change-id: 20260122-i2c-xiic-3ba89ff5ea93

Best regards,
-- 
Abdurrahman Hussain <abdurrahman@nexthop.ai>


