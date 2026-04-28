Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CE61E9B35;
	Tue, 28 Apr 2026 00:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777335490; cv=none; b=eG0II+gPdbKtVAG55AKQY3B5xz/sTfd1LkK5mTt8+1HLzZamo7qseFUZ2x2+P57wM33L1uIoK4LiurSiAiqI9sbtoPNK0EP33OU0DqFxLmoFqoZ17B86D1nfzJYeVNAEaAYxeAG4qm/WmTsVYRVU1soOawysPvgfVFLtNz3wN6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777335490; c=relaxed/simple;
	bh=d+UqHWNaoYjdpV1iYpCW920gidcbWxrsiy5vMFkmcMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SFhGHr5p30pSlD05+mq+xRnUfagCjmwhIgOLlpaTJ6O46Lwh2/NRdaJMJ82rL3M0anuE+lRiOl4r8kxUoGLc8z9A3lLCsq76aEwUCYae088oyVaB+wVYz5RLdbbKJqCpYxkFMAiMLINtobF5wjAPaP5rwVOkbAvuhUFL8SSmkA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLFNUe3b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLFNUe3b"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E450C2BCB4;
	Tue, 28 Apr 2026 00:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777335490;
	bh=d+UqHWNaoYjdpV1iYpCW920gidcbWxrsiy5vMFkmcMQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lLFNUe3bSNg/1uCqlXTdkE/mAURCsQ0gFP2NkN6gwGhvqAVgokLWkvRVWQB5JNpvx
	 fjWBef9v1Li2V961/m5TG99K4BdL+VT/UKBcr8IKSVOmXuPk+8CVNmDk3K+i+ldWva
	 UjoU9GICSwSCbRbC7bwfkihJ0RcmfI9eKAVeVMF3JI4FmaKv2c9uMqfn/WaNnngSH4
	 DRMPmdjIWGPXmEQsypkkCxd0STmBFUvRG3d+ZU6VcTG/zdjEwqCBTeqk5wdnPgU62p
	 NNa2kELd0vCK+khH/t9ICpNPO1CDb9alxf2LDrZXzs89Y3EwGTfNV4KwGemvRomJ3z
	 +TSm+ay0M/lOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D85FF8870;
	Tue, 28 Apr 2026 00:18:10 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Mon, 27 Apr 2026 17:18:07 -0700
Subject: [PATCH 2/3] i2c: xiic: defer RX_FULL until all trailing bytes are
 in FIFO
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-i2c-xiic-v1-2-e6207f9aa5ad@nexthop.ai>
References: <20260427-i2c-xiic-v1-0-e6207f9aa5ad@nexthop.ai>
In-Reply-To: <20260427-i2c-xiic-v1-0-e6207f9aa5ad@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720;
 i=abdurrahman@nexthop.ai; h=from:subject:message-id;
 bh=/BR++2xUka9oKwbdfFmIjG9WrhZsf5+FmlIpH4Pjs/c=;
 b=owJ4nJvAy8zAJbYltPXv6rsCXxhPqyUxZL7/c5Dl1rVsxY3/f5udq7z6ZWXx1n2lu9jToncwV
 nQ8kNa6vuJvRykLgxgXg6yYIsucR/5v2jraIjbEHLKHmcPKBDKEgYtTACbCacjIcIOLUWjar5tb
 n+Tu97xhFckYv8L3SMvfx/KTDnMU3Em03cHIsOGUcENQ5t4lVzP5PCTOxCUzhAVOOVD/xHJyg4d
 ObZ81KwAG1lBj
X-Developer-Key: i=abdurrahman@nexthop.ai; a=openpgp;
 fpr=9CE24FEC86888658B05CC23FB45585FDABDD10F4
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/default with
 auth_id=756
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

For the normal path of xiic_smbus_block_read_setup() (rxmsg_len less
than IIC_RX_FIFO_DEPTH), RFD was programmed to rxmsg_len - 2, which
fires the RX_FULL interrupt while the last payload byte is still in
flight. xiic_read_rx()'s bytes_rem == 1 branch then sets NACK on that
byte still on the wire, truncating the read in the PEC-enabled case.

Raise the threshold so RX_FULL fires only once every remaining byte
(payload plus optional PEC) is already buffered in the FIFO. That
routes the drain through xiic_read_rx()'s bytes_rem == 0 path, which
reads everything out and emits the stop cleanly. For the non-PEC path
the full payload is still read out through the same bytes_rem == 0
branch; the only user-visible change is that the controller waits one
extra byte-time before servicing the interrupt.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 959a47b645a5..946e3ed2d760 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -559,11 +559,8 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 			rfd_set = 0;
 			i2c->rx_msg->len = SMBUS_BLOCK_READ_MIN_LEN;
 		} else {
-			/*
-			 * When Rx msg len less than Rx fifo capacity
-			 * Receive fifo depth should set to Rx msg len minus 2
-			 */
-			rfd_set = rxmsg_len - 2;
+			/* Defer RX_FULL until all trailing bytes are in FIFO. */
+			rfd_set = rxmsg_len + pec_len - 1;
 			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
 		}
 		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rfd_set);

-- 
2.53.0


