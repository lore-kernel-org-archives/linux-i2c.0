Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA424F7CAB
	for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015145; cv=none; b=qNQCVP97vSWlMclYDc1fISO9FRdR8GJjd48TAjrKeWxZRGBeLoXTh0WQ+z5k7Y7Oh7w64B52SHPvszm9pJ2wRzV0IUomhevqFsyjan3nZInYIpEeetcXvxTF01unFKn6PlQ37onYQZ39vRCdx9+s+0fwk0S3dWiR1JpkqNcumwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015145; c=relaxed/simple;
	bh=/8Wrq+rYYeuzHylPud9tnFtGR3R2iGFzmcbe02TkznE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rbjobiZJxQqdbf9QCLOV665oNlE3tKy6AZmAWkkQuT/oEA9ZDGT3xV9H58llXgg6dkAHTXfHHBEz/9k0ENNh5uHpxPfqWheMizK3TLDjH+bSlEHRkmSusGUFDqFUM/kYHmaRTjMEvICRB/G3nlrMUcr7eXR/YnlBkQYaaJ/1ttA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=cChmHgOg; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="cChmHgOg"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c08393b0so2851790a12.0
        for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 11:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1790015142; x=1790619942; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0cquRnCIn6mlXF5rqmfxuhHyvgmYvV6WRP7O37Nb5MQ=;
        b=cChmHgOgrOV/Z98IinDbJFq2nN5Xt4u3o/pO5D2dcfcThwF/qIv6z92qX1wwzv6UxE
         aTL/g4iXapKaiT6PDwVhJpRnQYTWs3SlafuR78kMsLVLgiCoMtQTjTlVSrqktgx7bD3Y
         RrzRj3TauzlXHBy10eDYsS1hZYEDUHTpIvdGAQhI5UzqfXn4Lop5NzQM0hLh3E7AjFaD
         3Giot/qs4OyFOeoY+/Z5ZAzHJX4+gOYoNgOPk53J+CXNem1JkcePOuC8CWATMQNoJme7
         RIWjK9gIpCdbilXy4ppTEjKB/RqWFA/kmG8BSYdWzRRBQIgquxogpq9yw1rg9x19HwGm
         m06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015142; x=1790619942;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0cquRnCIn6mlXF5rqmfxuhHyvgmYvV6WRP7O37Nb5MQ=;
        b=XLDidIZR4YHD7RYlz1iNLeSNoz0xI57AlWV0uCYKFxAoNgzhs+UxfKVwe/1i5pB/EO
         kAweomVx339x+ooS6rSBeKZSEzuxJVhfoN6mOviSOLnSa5477uDGC4nxY2DUr/v+R8zy
         2xZVonSGhGMcpkIO3D4yTfW9Rg96NYX3C4E4u840s2PV4voQ9wIsUwjzWGbMX2Q67iYJ
         s/sCctnFdK7e8ysYA3Hjm7hfbSLiB977CX5UiuOVDXGpJiV+zP6LxF1l9qssW1oCAzAP
         /KUErRkbKABHDRaRJgGUAeg/vgAGjzYo1K84XQXcGs5JQVCCJxYgMWcn0a0UjLaPi6lL
         wBUw==
X-Forwarded-Encrypted: i=1; AKwUvBxLo1113zrW9oFLXHW6HkA+M4QDZHNmbqbiX8piFP8UkfuJCNxV//+hW2acJ/8Nd0OFJkYx372wPmc=@vger.kernel.org
X-Gm-Message-State: AFuF++lq+FwpdR1T26LbUqetu9roWEPu4zuTw3xZbujD0+YNI6McoIlc
	D3VIzfEv6gJ1XSrk72t6lxCeQqiR510se7MJB2fVDrgFE6KWKyLzyhVsTt7fyXCFGGo=
X-Gm-Gg: AYBFou0Vooje5KyeI45bC+6gkUcMjGBLE5h1qiYXJbYfYNF3Dd7cSkH1oDlMBW7X3XC
	So0c7W8l9bM7H6ootBivLVW0qAIV0fZI/rzU80m5LO7a9DCGTPA3wT0ZLAzv6pupEAk1PcxLUXT
	wmz9Kr1quzNRdyxGtnjd+2kBpZ0tNJlzZWN0ydp/Zay04VYZtM8wYAXS20nenpmi1D3uUzFuDbk
	fzbS0yjg7Bw8kmJIiZTMtOmFYmJod5iXTZEjhKYXRV8Vxg3hDkVPhfzZ330xtfRrsgwJfGtbreN
	PmYVPZiftjaGDfas9CBvucCNGcwuehMp65QOCKVHuJedp9asaA3oar2ZqI2Ju+2O1ykr24A2XJf
	T2OKwzp0yqQV9PzptRa+RNEvz9xRownAktZcThlm/dM3qlSMOsD1celXBm3Nm4DHKiDFRL4uUqY
	bynMX4c/LilMPbHIbmgeODu02j+oMyTFLHfBvTxWfBmlPpkdaqlxM/5ZgBKVdrQ9dw6gB+CcRNu
	A==
X-Received: by 2002:a05:6a21:78b:b0:3dd:a006:ed90 with SMTP id adf61e73a8af0-3dda006ee59mr12176552637.38.1790015141934;
        Mon, 21 Sep 2026 11:25:41 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144df9ad683sm12408974c88.6.2026.09.21.11.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:25:41 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Mon, 21 Sep 2026 11:25:37 -0700
Subject: [PATCH v5 2/3] i2c: xiic: defer RX_FULL until all trailing bytes
 are in FIFO
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-i2c-xiic-v5-2-2fca81e810ea@nexthop.ai>
References: <20260921-i2c-xiic-v5-0-2fca81e810ea@nexthop.ai>
In-Reply-To: <20260921-i2c-xiic-v5-0-2fca81e810ea@nexthop.ai>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790015138; l=2996;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=/8Wrq+rYYeuzHylPud9tnFtGR3R2iGFzmcbe02TkznE=;
 b=ubMp+70iyM/WFu2SL6u7ETfFM1C/uksEYesAWisxSq70C57ilk420Kkkx3zFsOacHFpd326ZC
 M+PBTrV7qDXBMzYY1xS+Z5RGXOLlN/FxyN7fsWzYAs0IouoYUBerFqo
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
index 22367a069ded..15fd17b703bc 100644
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

