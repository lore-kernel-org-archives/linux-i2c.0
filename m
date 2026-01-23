Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6496A3321DE;
	Fri, 23 Jan 2026 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155385; cv=none; b=NcU4Wk3gWCESNhDP+92qqzv2HeSVrIN1VAH0EsaIQT6gqprO2V7EAu9/4C4oxStx1ezQ8fQ9dQVvBLuNdMMXDb/lMOzeBmL2UxpmrZg5S6uwaJZUxgjGp3aQVbwgrFQVyguG7wJ0HhU7fqswZAyH1H9kdWG06tp/x2TFFREM4a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155385; c=relaxed/simple;
	bh=1rwOw+x2PuObmHQg0PSYLfFOWrx5Tza0EXXyewj+reY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cOXMeAL2fyHLvbS7kgzB1oe2DTn0oN4gZ8vqWOCTsZi6Tl5rPoAnrxiOfX0y92r/W7g1owz1man/pmqvvyzl/oDoNsNBTlO3ExG+lpS/I9TGZ/B4ulpJDV5X6l/mydpOsjv6w8t3bJkK34+23oyR+Niao5QtjoBS27xGD/pHvxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5M3ZMUR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5M3ZMUR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 012A6C4CEF1;
	Fri, 23 Jan 2026 08:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769155385;
	bh=1rwOw+x2PuObmHQg0PSYLfFOWrx5Tza0EXXyewj+reY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=h5M3ZMURzTxI5wPf2Ucxh6Gy0tAq52oWGxoXz0fhRkDeXGOJU+5E9cIilh91suocc
	 4n8FLg7ULFGtkJ0q+Z3PXKiSSkhRTPvFiUfP3/cRGxCb6OP4zGZb10FuyrfZvJ6KzB
	 smFmTcA6JTywPdx90BerdWprydp8lv6Fk7w8uEiwQRYEx2ZEAXCo1OHYa/m4Rx0KPF
	 2IGuAHP84P+CZmEXg6BBSQCXPJAKqPLeekD4HjQ84CsJorHt7CEsbj6ZJHLLD4UGpE
	 bgallqBYDaL17+O3L8PTiAVI4PWAbt9WLjwIUbvrYgEpl27wZieH7hkfLgKYH1nq/L
	 TBvbmzVBv0TKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF05DD72349;
	Fri, 23 Jan 2026 08:03:04 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Subject: [PATCH v3 0/5] i2c: xiic: use generic device property accessors
Date: Fri, 23 Jan 2026 08:02:43 +0000
Message-Id: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACQrc2kC/23OOw6DMBBF0a0g1xlkj4GYVNlHRGFgHE/BRzZBR
 Ii9B6goUl7p6eitIlJgiuKRrCLQzJGHfg99S0Tjbf8m4HZvgRILqRCBsYGFuQFdW1M6l5Mttdj
 nYyDHy0m9qr1dGDqYfCB7AVQuJZqsSDHXpgQFtm4/IVjf2f7Z0zL5YUwtH57nOA3hez6b8VD/n
 JgRJCiduby9Z5pMfUWqbdt+Nx4SmeEAAAA=
X-Change-ID: 20260122-i2c-xiic-3ba89ff5ea93
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769155384; l=1405;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=1rwOw+x2PuObmHQg0PSYLfFOWrx5Tza0EXXyewj+reY=;
 b=USCULF/Lt5spK7qklBMl8/C7UImXxBOgAQSZhQzHy4Un6pnZOdalSTsrFx40NPp29mtap4Ceq
 2mnIqUUI5wRDBX1nEhY0RzJZBjQVzfpPeu33DzJW3XmvnaZBlvBoABY
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
Changes in v3:
- Reorder the "optional clock" patch to be the first in the series. 
- Add a patch to switch to devm_mutex_init().
- Remove dup message in error path.
- Cosmetic: use temporary dev variable.
- Link to v2: https://lore.kernel.org/r/20260122-i2c-xiic-v2-0-134f5d743e8b@nexthop.ai

---
Abdurrahman Hussain (5):
      i2c: xiic: make the clock optional
      i2c: xiic: switch to managed version of mutex_init
      i2c: xiic: remove duplicate error message
      i2c: xiic: switch to generic device property accessors
      i2c: xiic: minor cosmetic cleanup

 drivers/i2c/busses/i2c-xiic.c | 74 ++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 39 deletions(-)
---
base-commit: 944aacb68baf7624ab8d277d0ebf07f025ca137c
change-id: 20260122-i2c-xiic-3ba89ff5ea93

Best regards,
-- 
Abdurrahman Hussain <abdurrahman@nexthop.ai>


