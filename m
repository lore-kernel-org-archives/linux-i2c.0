Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C1E1E1C11;
	Tue, 28 Apr 2026 00:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777335490; cv=none; b=NEGgLpY0gBehVJI088iCvUwqXj4Gp+Wql7LzuKZ5WbKnaeYrXf0sFp3TzvX1oaM5oXTOaB1wc5EvC+nGfDmBvf8dMc+5lKHCErciZzBvZz4CibWL6MsHdXo+TcPyg2IT0F+Dum7APF7PPxj4I3QAp+lqXC4yotA752Ikh2r/FHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777335490; c=relaxed/simple;
	bh=pX6+8HgPg+/75SzAsHB9znme86Aih5ZL9FPNk75ERIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aB2nkYX50YLbBY+0CGXU25GiugLUjCFUE2BqYKY2MKtoPLDx1g7/vv+Dok2RRDCR20tLxHaVf3BpzfRRYge/uluaks5KF6iyD3HeepcyHo/551h6jiup7OrgJf0QomYLebDJrkhYhlHDh+b378w+1GtlXMmwIl6uyLGfxfrwQ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTZO1ACo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTZO1ACo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64E53C2BCB7;
	Tue, 28 Apr 2026 00:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777335490;
	bh=pX6+8HgPg+/75SzAsHB9znme86Aih5ZL9FPNk75ERIc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FTZO1ACond1QyuWms2yeUh6w2WvZrK/37C6xfPBDNsQn/yZ915BFqTI8hSl3MyPGq
	 7UX62Cia71C7Hk91H6CuY0lNqX1S03nNgzqrDhRmTD7DsbAHuzpBreCfS5DkivpPhA
	 y3OARf6rlex1UMgYomJpBEHx3TkleSjfc8GIledGH+uw5M/SQZJxAbKs/ljFKtG0qk
	 UoYiS0Xww6ECLlYUY3XvIm6h3j5mgL9Nl3VZL1AykUCKyWJfVFT9UDXHXKZSFpABXC
	 1QtFsceu0F9Bd6Ok2uP0Zh+wgeECWmay9hU6lc6NtVaWqTLhno4vMzNTrVOd10sLut
	 umrHOd78wosHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524F9FF8867;
	Tue, 28 Apr 2026 00:18:10 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Mon, 27 Apr 2026 17:18:06 -0700
Subject: [PATCH 1/3] i2c: xiic: preserve PEC byte length in SMBus block
 read setup
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-i2c-xiic-v1-1-e6207f9aa5ad@nexthop.ai>
References: <20260427-i2c-xiic-v1-0-e6207f9aa5ad@nexthop.ai>
In-Reply-To: <20260427-i2c-xiic-v1-0-e6207f9aa5ad@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2279;
 i=abdurrahman@nexthop.ai; h=from:subject:message-id;
 bh=WbRNSgR6fF75ujIFRpZT+WIk0CWNPjAlMacuue3U6KE=;
 b=owJ4nJvAy8zAJbYltPXv6rsCXxhPqyUxZL7/c3B1ziaWhgZtFrFK/7l1X/ruSL6cYMDSVjL1j
 c2+ms//ngV2lLIwiHExyIopssx55P+mraMtYkPMIXuYOaxMIEMYuDgFYCJT7jAydHBtfsJ7Ujyo
 QjBN2L0pu0lRwTj1x/cph3/Ku6i+WVcWz/BPQZ3xXJja3qblId0ujyKkJq17U3jguKjB1QquM6I
 zzQ/zAgDNJ07Z
X-Developer-Key: i=abdurrahman@nexthop.ai; a=openpgp;
 fpr=9CE24FEC86888658B05CC23FB45585FDABDD10F4
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/default with
 auth_id=756
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

xiic_smbus_block_read_setup() overwrites rx_msg->len based on the
announced block length byte, but the i2c core appends an extra byte to
msg->len when PEC is enabled on the client (see
__i2c_smbus_xfer_emulated in i2c-core-smbus.c). Before this handler
runs, rx_msg->len is therefore 1 + pec_len, where pec_len is 0 or 1.

Overwriting rx_msg->len to rxmsg_len + 1 drops that PEC byte from the
caller's buffer: the PEC byte is never drained from the FIFO and the
core's i2c_smbus_check_pec() reads the last payload byte instead of
the actual PEC, returning -EBADMSG even on clean transfers. Capture
pec_len before the overwrite and add it back when recomputing
rx_msg->len.

This is a pure bug fix; non-PEC behaviour is unchanged (pec_len == 0).
Tested on a Xilinx AXI IIC FPGA block driving an adm1266 PMBus
blackbox read -- with PEC enabled the full 64-byte record transfers
cleanly after this change.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 3e7735e1dae0..959a47b645a5 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -539,6 +539,8 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 
 	/* Check if received length is valid */
 	if (rxmsg_len <= I2C_SMBUS_BLOCK_MAX) {
+		unsigned int pec_len = i2c->rx_msg->len - 1;
+
 		/* Set Receive fifo depth */
 		if (rxmsg_len > IIC_RX_FIFO_DEPTH) {
 			/*
@@ -546,7 +548,7 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 			 * Receive fifo depth should set to Rx fifo capacity minus 1
 			 */
 			rfd_set = IIC_RX_FIFO_DEPTH - 1;
-			i2c->rx_msg->len = rxmsg_len + 1;
+			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
 		} else if ((rxmsg_len == 1) ||
 			(rxmsg_len == 0)) {
 			/*
@@ -562,7 +564,7 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 			 * Receive fifo depth should set to Rx msg len minus 2
 			 */
 			rfd_set = rxmsg_len - 2;
-			i2c->rx_msg->len = rxmsg_len + 1;
+			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
 		}
 		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rfd_set);
 

-- 
2.53.0


