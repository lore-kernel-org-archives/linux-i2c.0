Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7126E39A06A
	for <linux-i2c@vger.kernel.org>; Thu, 24 Sep 2026 01:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214349; cv=none; b=nFcCH5Cd5Ifbdn2caeTNZjfvZXqLJbyA8oZ+afB5UClVjDPcCxcF+agl1yueHbhx0SDbsxJYx+BsK7Gf7/CFeLv2cEVXvq4jhZ3lW3toGR6mpcUwKeQX9U3V3uRy7x8tSUE43hnuzCAGqpDW0v778XRmEca1oa4mu0vtHLGCSoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214349; c=relaxed/simple;
	bh=hjh/huwNpHT4R0O30TFZo10JCsexhfogEIYuCqGs5hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJ5zORStPwA3rHuJyrNLOhBZKC+zbQcoRDj69QSSvIz+sq6o4Pbf6c9LOxbyicRnOWUwYR5zY0tQllHQ+kmd76ocua9Kmkmxl1yVpLad1XUya5k7jpoXsLX+aOYr2bSHZFfi3s+BDyJjOCbQgJtNuiXV2PeBiU9MpSZ09rYNqPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=HId9yRDh; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="HId9yRDh"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dd05d97cso2289782c88.2
        for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 18:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1790214346; x=1790819146; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rFtQiwO6/6BJ7wa+vqmBzThl4fhyokGeBbXcNwOcE/A=;
        b=HId9yRDhWQsHx4gMUpLrT/1UClrCdOuNVrVF5fvkScInGoZ2BM3LfXEjcWO4z+H8+m
         thgC0Rf3ETDoiScB/Yejhu7p55LaV36D9+rR5655NSpz5nNFeJ5FP2UZbRQcLFOMNPY1
         wDXVlZPYoPP+VNdARW7AH//D6AqsCooFePelIhvBtz1b3waBIDUFkGhdSL4MQAJqBgtD
         CMU3V//akV/IUqTTZNlq6HV6Vh1zLdrW6q+DnDQ82BCjnZ3L0/dXE8dG+bt830fSMUtT
         zO6e/4elZ3B9gTvjthCHnHae5iNFKtQ7nYcwD02c7p0G8AWRMlDD0/YCtpsNwiXMG+iY
         I6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790214346; x=1790819146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rFtQiwO6/6BJ7wa+vqmBzThl4fhyokGeBbXcNwOcE/A=;
        b=1Xs1gzaAueFXYzs29+K+rLwVXp5I0VvJAzQ1H9sqlw8tBfV1CXl2soO2i6vDe9omyT
         51awod+/5vX/zkPARlNTySfjgYyFMf1Jp346h2e3xdehFzMkHEEgm59SLSzIpLyC90lQ
         HIjwmtjCtim8p1nSubRmHvFv2Fh+7BnkUMttmLVgWMI69BS4Z7SshBig/2q3269DQ1yI
         +QYoOv9FFH6y1twoSASxyEnn4ltC1BKFU4wgzSZM2ftGgSoyAdpdmTRcgGR8FwR/abn9
         j1dPk/0S66zK7nxViK0TJpKkQsc0XgpjsFtf2LQS4sWJwxxADmV7xtn7+E8mSuOvQWdp
         y7EQ==
X-Forwarded-Encrypted: i=1; AKwUvBzlep++kHwEWWKM7/3sanxj8Kw3R/YQtlnZ1iUNWM2BH7Zi0io9Bc4AIUIAojFvEzOL5ORTwznaOS8=@vger.kernel.org
X-Gm-Message-State: AFuF++nBQLoXbmIflAS6LFBPXPl0b4jhyLW5ZgDN5rg9OaaUUaouzVON
	ILzEr2UGnpyqpp8yByRIZHjlqllZCyRZq6i4vFTvqNb4rZn3EyMT3WYZoqiAA/wKn4E=
X-Gm-Gg: AYBFou3z3DN+NRW6vZJFTkWagsLnv2f1Q3tjTPB2u7xG2WBLyupN6DUEx9OJFEeatTf
	oJhlNT6OJsnJEC4rVAKZ2OVnglIjWtASujUnSlrVvVXBF0/UE9KSBJFeakh4VMExyODPrMpdUoR
	7AgLHN4SA5VZ6yOfgCbznUx26YDtvtLBzHRplUVS7FaY8IK1lK9SBYeSEy0ujp8EggIhqxS2aRE
	n3g14WUL2/Shsbqj5qwxBD6oGyws7zkk0DfKXeGqKOGbiTx1FDXa5ovDOb7iwgngm1iz+NJha4Y
	7BRuobKNL16RM3QFx2yRoMIbA0jplQdTzW3sCR2lHF0NVhs6ScoxxJs3ZWPsWMKNKeMir/iyjoR
	G4QShiOyBjvGCPJLgwciXYiUYlozrmE+0sXZdybHCrNDL+yqsAnKD54c9ijA0YkTzwEvO5BoDTC
	gbg8pVBAzd3U7LHW/oQ/BtKrCPFJ8Yd/EGxNlUZqyTfszKZMKlqso+OqrBDAJsCCJWtxo/YPsf2
	Q==
X-Received: by 2002:a05:701b:4292:20b0:143:89a6:9ea9 with SMTP id a92af1059eb24-14503f9735emr748692c88.19.1790214343219;
        Wed, 23 Sep 2026 18:45:43 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14501794269sm2927598c88.8.2026.09.23.18.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 18:45:42 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Wed, 23 Sep 2026 18:45:37 -0700
Subject: [PATCH v6 2/3] i2c: xiic: defer RX_FULL until all trailing bytes
 are in FIFO
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-i2c-xiic-v6-2-3a15b6397f5a@nexthop.ai>
References: <20260923-i2c-xiic-v6-0-3a15b6397f5a@nexthop.ai>
In-Reply-To: <20260923-i2c-xiic-v6-0-3a15b6397f5a@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Raviteja Narayanam <raviteja.narayanam@xilinx.com>, 
 Wolfram Sang <wsa@kernel.org>, 
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790214340; l=2996;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=hjh/huwNpHT4R0O30TFZo10JCsexhfogEIYuCqGs5hs=;
 b=ESsvAdfXRm0tlYcUbq3pUgtyTWOnDdmGWS56m6a/HeF5Da0WAGiwNahnaVp2p7ITa0+jdFYf/
 c8mhvMhlJF/Dy6plYKFa+nUrdBkJh84xQiUAqmZ5J7Qt0jGOh/jwkQx
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

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

The deferred-fire formula is rxmsg_len + pec_len - 1, and the RFD
register at XIIC_RFD_REG_OFFSET is a 4-bit field. Widen the
chunk-vs-defer guard to (rxmsg_len + pec_len > IIC_RX_FIFO_DEPTH) so
the boundary case rxmsg_len == IIC_RX_FIFO_DEPTH with PEC enabled
cannot write 16 into that 4-bit register; it routes through the
chunked drain instead, which already caps RFD at IIC_RX_FIFO_DEPTH - 1.

Fixes: e4c1ff772e1a ("i2c: xiic: Add smbus_block_read functionality")
Cc: stable@vger.kernel.org
Acked-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 6cb264cbc366..b4177d655cce 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -546,10 +546,11 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 		unsigned int pec_len = i2c->rx_msg->len - 1;
 
 		/* Set Receive fifo depth */
-		if (rxmsg_len > IIC_RX_FIFO_DEPTH) {
+		if (rxmsg_len + pec_len > IIC_RX_FIFO_DEPTH) {
 			/*
-			 * When Rx msg len greater than or equal to Rx fifo capacity
-			 * Receive fifo depth should set to Rx fifo capacity minus 1
+			 * Trailing payload (data + optional PEC) exceeds Rx FIFO
+			 * capacity; drain in chunks. Fire RX_FULL when the FIFO is
+			 * full and let the ISR re-arm for the remainder.
 			 */
 			rfd_set = IIC_RX_FIFO_DEPTH - 1;
 			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
@@ -566,11 +567,8 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 			i2c->rx_msg->len = SMBUS_BLOCK_READ_MIN_LEN;
 			i2c->smbus_actual_len = 1 + rxmsg_len + pec_len;
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
2.54.0

