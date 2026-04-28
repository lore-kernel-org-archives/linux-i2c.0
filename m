Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BC117B505;
	Tue, 28 Apr 2026 00:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777335490; cv=none; b=L5lHlQ4kzB6MuKYUZu6oOl6w3M8k+aETDbgtHZwvS6c6u5FUkgKX78lTLiMDaAC7HpRTo4R8pNGu+6khvcdo2ytgFkskRF73fak17zCxYU4eOKdxqP3AzNV/Gevabb1CvJ93oe/GnglSrDRLcqLeLgwoIoHGXJ2k+u70joM4cl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777335490; c=relaxed/simple;
	bh=socDHfUvQqpc9gwIt9f18GJimPy7QixuJ0SteirtT0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iGmR9fHUm16OzjHvgE92STiH87YcnDk19XDGd2TgNU/VqfEF4ahfc98sm9tX8RhIAVsWj7k7O+/y8gj16X9F0tPcUpVFCcilIewkjaFhNTMlDB52WjzYXg8R3NvUC3ERE70P6i+RTzDC01n/KXyQLbzWRnRvtjYP3M/FM9Xi9Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oW+MLxvp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW+MLxvp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C9FDC2BCC4;
	Tue, 28 Apr 2026 00:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777335490;
	bh=socDHfUvQqpc9gwIt9f18GJimPy7QixuJ0SteirtT0o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oW+MLxvpS4tM91Fej4aIsS9mAPEi0PcRTJu5CH+oCKIaAfH9IIFPdT6p6k19DPPgG
	 B3LLM/5JRKhLaT6XUuicL3Vg/Xl4GAxBYmkSJAKQh4RbXq31FKPU3yl2bVmLujLEu/
	 i3erW4YmZsTV3pcSz+Z31L7BUAtyvIFSyjbI7aa6rvNsUt32u1WmKeoc4K5qgUdnkJ
	 /EtAamfuFYMYxZ0IOTALVrxMVV+bP4o8dZC0AdFPlFv7+atxm9LYb2ffw49tj2CF4p
	 wkER2m0yN+qdHhzD7Hj0j2xM+bM4VwczQcvUafhX5ORVx+evuErR+oVwP4TKgcRuuQ
	 oPokcYzNBwGvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDFAFF8864;
	Tue, 28 Apr 2026 00:18:10 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Mon, 27 Apr 2026 17:18:08 -0700
Subject: [PATCH 3/3] i2c: xiic: don't clobber msg->len to signal block-read
 completion
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-i2c-xiic-v1-3-e6207f9aa5ad@nexthop.ai>
References: <20260427-i2c-xiic-v1-0-e6207f9aa5ad@nexthop.ai>
In-Reply-To: <20260427-i2c-xiic-v1-0-e6207f9aa5ad@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863;
 i=abdurrahman@nexthop.ai; h=from:subject:message-id;
 bh=OktgHJV/MKY6BGPhmYAbpjHL8E9xIEfPx0WNo7EeXKg=;
 b=owJ4nJvAy8zAJbYltPXv6rsCXxhPqyUxZL7/c1D+/YWV3ude8c44uo171kVreYnc4A9ndzgYc
 5v1WZ2R7P3SUcrCIMbFICumyDLnkf+bto62iA0xh+xh5rAygQxh4OIUgImUhDIy/OkTW7nm6/x5
 1+NvPnzWVc+QrPBm6t+rbz7kn9jLVvuo14uRYXtA04SNf9iNs+V+fn4mfn3LJqP/D0ptNn9M092
 1Lc5uBxsA3YtVpw==
X-Developer-Key: i=abdurrahman@nexthop.ai; a=openpgp;
 fpr=9CE24FEC86888658B05CC23FB45585FDABDD10F4
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/default with
 auth_id=756
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

At the end of a SMBus block read the BNB handler force-set
tx_msg->len = 1 to push xiic_tx_space() to zero so the STATE_DONE
branch would fire. Two problems:

1. tx_msg and rx_msg alias the same i2c_msg struct during a receive
   (see xiic_start_recv), so overwriting tx_msg->len also changes
   rx_msg->len. The i2c core's i2c_smbus_check_pec() then reads the
   PEC from the wrong offset -- buf[0] instead of buf[rxmsg_len + 1]
   -- and either mis-validates or returns -EBADMSG.

2. xiic_start_recv sets tx_pos = msg->len (typically 2 when PEC is
   enabled). xiic_tx_space() is unsigned msg->len - tx_pos, so
   setting msg->len = 1 with tx_pos = 2 underflows to 0xFFFFFFFF and
   xiic_tx_space() never compares equal to 0 -- the STATE_DONE check
   falls through to STATE_ERROR, giving -EIO.

Instead, advance tx_pos up to msg->len. That drives tx_space to 0
without touching msg->len, preserving the buffer length that
xiic_smbus_block_read_setup() already grew to cover the length byte,
the payload and the optional PEC byte.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 946e3ed2d760..27715646a9fb 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -864,8 +864,11 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 
 		if (i2c->tx_msg && i2c->smbus_block_read) {
 			i2c->smbus_block_read = false;
-			/* Set requested message len=1 to indicate STATE_DONE */
-			i2c->tx_msg->len = 1;
+			/*
+			 * Drive xiic_tx_space() to 0 to signal STATE_DONE
+			 * without truncating the rx_msg length.
+			 */
+			i2c->tx_pos = i2c->tx_msg->len;
 		}
 
 		if (!i2c->tx_msg)

-- 
2.53.0


