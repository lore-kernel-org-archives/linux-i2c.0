Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF2239023C
	for <linux-i2c@vger.kernel.org>; Thu, 10 Sep 2026 03:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011611; cv=none; b=IqxU6e/YEC/DS9AF0gra9/uhbulUmqY88djt47i1sJH0EBLvvDG4DM/TnP9OSvGP2xEhIk+7vZxZQgMbl6mHCm/23GA73VXhiWMY1FhykYCpmrt6Tx92Yu+6I/eqNGmPVkxDk/yTN/TGy7p+o8WV6wf3hCzTutzUVvc0lqG6yqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011611; c=relaxed/simple;
	bh=nou7d5wdvtm0ZSXFArEeFJh+YO34NwfkEsOlW1AJ7Ho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HnkRSid4RPakpVE9xzv+dRnL2hpjP8adi48kUkbU95AwkPiXdk3tv7RkWVr7x4tPHyPgy7pi2Fmgrtrb+SINP3K8V1hVMBwvIHpUbaCiuL2QF4mfCx+vOPRpmVA7tCRrBpRWXmMfPFSDXndGsp+Tfx9NOVACrLOvXxeAnWoCfW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=engzz1ea; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="engzz1ea"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2dso600710a12.3
        for <linux-i2c@vger.kernel.org>; Wed, 09 Sep 2026 20:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1789011609; x=1789616409; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xGGb1AqMqEgtlYCXRtEKduBwX2irzbcK3U23NUL459A=;
        b=engzz1ea6FIKE5Dh64kKiydIE+1BmBg0hhRUob7MYW3+h8HneJ4AlBq2dBhZNHsl0E
         6j/NZ2B1JKdXCTzb7NrmP48ATphR3NYrgQsAvCRXcntfUmNgfvQOxoKTSXhQIKJnL5bg
         A8AhlZTyXasyWP+dr5uqBPGnY3YHqSJaAtT5OqIIyVNC3cPNUZxfR7byz5gwWLASTzss
         QzryH5GTrjYguTDXdPa3ZuncTRLDxfK8ad0b/BZ+mBwvwQ4ZX+5BbL1JpLn3du2R35J7
         cYEXIKKUNmbJmck6O2mZSM7qKdBfi3NQgigk3jIQdo/+NnPOZmm53aA3HtSewqdME9zu
         b4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789011609; x=1789616409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xGGb1AqMqEgtlYCXRtEKduBwX2irzbcK3U23NUL459A=;
        b=HFPFIBDRUhTAS6idJw4qOv4twPdch6TUqQFV/IwKYUG+EElbkKEzP92ZpMY8Sk0kbA
         2wHH4qqJgCq2mBCa9J4+Sfwwx0T27RH7tzm31Uf1nDlKnq+MBh2CB8+9G1hQlf8+5XWF
         btDeZ76z3UKDzCcYNjL2wU8ALxhkFF5ufBFf516s1PwYZ7DT7ETgYax13cqQeT+WwCel
         8Rs1KLSwCD0ZKX8vKC0t+0ucLUGPOG+6XzQtaLthEVUcshKrhy3EuL2ub+Abdf9OlJup
         NXmqjpwA9DFotTlF2U/o42BohrjuwWQJFUHh0rxGBbflDyxP9fN7qGXAFSwi428CCtD4
         HVww==
X-Forwarded-Encrypted: i=1; AKwUvBxM24G3y2EnA2yy7iu9RuYam8fmF8GLzKvk71oCvxrG1sg7zKvqtIL7xpeujvdyXjosCrMDa3b5S0M=@vger.kernel.org
X-Gm-Message-State: AFuF++n0jtHQ/p7LVIQq3oUVb28n3pYWV63pUjlH3rID++ITTxli0LgL
	UTH5Dh6bABH/tP/JVqNSWZ/tMu3rYm1GbRy11Cfxoy2Uj+GmjcIZW0X5uLRY9zfAtkeUfdy1+Yk
	AS9uP3O0=
X-Gm-Gg: AYBFou23eJ0f/gs9UqDuXgxlGr0vOxIRAyfmxXzx2V/Bg0l/PS33pc+BM85fLWe8f5E
	gmNhJ31cHYTd2rXatuvOhiBb5waSEntUDRHlddZlDLq4Me0z4SK6dNWT+7MgK54c8Pi4Ahq/G0A
	Y8GVdDac7LuFNJ5q244zFFFo9yMbwALL6iwPYUFW01rdJjfq+s67s0BG9o+vExHVAx5W12S9zCQ
	uje6i9oj+TITHYBlxUXcVRgBzwHf09Y26I5t6hzeCUsKTkB8U4/A6D8BLa49XUTH0/QmlBo3f+A
	mgdpEB4DFkP4jDH065mHKESMZrywFwxWAWEmb55M4cPSQsmHNBy/AQnqkGMmn9Y25dpvz6IiIdr
	XB2hjjrF3S5RJ7zJLxiVUa9Cyu57MWWOiCb4PVygR4W+WxAQz0fdjbdwEpKa733Q1swngCCs85I
	37iIblsS/42Mx7mQ3iSkQKeDjWKhghnrIRGykbYCcFtU/k4Za/d7wNDRNWRZCwXvI5XCfnT2Zvr
	Q==
X-Received: by 2002:a05:6300:6702:b0:3c3:b57b:627d with SMTP id adf61e73a8af0-3dacbdba23dmr7846333637.12.1789011609291;
        Wed, 09 Sep 2026 20:40:09 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435648esm58294850c88.5.2026.09.09.20.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 20:40:08 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Wed, 09 Sep 2026 20:40:05 -0700
Subject: [PATCH v4 3/3] i2c: xiic: don't clobber msg->len to signal
 block-read completion
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-i2c-xiic-v4-3-218df31e9d3b@nexthop.ai>
References: <20260909-i2c-xiic-v4-0-218df31e9d3b@nexthop.ai>
In-Reply-To: <20260909-i2c-xiic-v4-0-218df31e9d3b@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789011605; l=2277;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=nou7d5wdvtm0ZSXFArEeFJh+YO34NwfkEsOlW1AJ7Ho=;
 b=zv+8OaV48dE6a8fuYTEiejGziZBr2QFmPlye9Nl6XoHbC2dZdx4WPijhaETqjKQ9/VNI4nE18
 tUSgNHxdutHADv3R3C1iogVivH5Z5/TSY7eA8cMW0+VNletiLWn/LFe
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

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

Also clear smbus_actual_len here so a subsequent non-SMBus transfer
does not see a stale trim value from this completed block read.

Acked-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 2bdba6c0931f..8eaa411411c1 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -889,8 +889,17 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 
 		if (i2c->tx_msg && i2c->smbus_block_read) {
 			i2c->smbus_block_read = false;
-			/* Set requested message len=1 to indicate STATE_DONE */
-			i2c->tx_msg->len = 1;
+			/*
+			 * Defensive: reset the per-transfer trim state in case
+			 * the rx phase completed via an error path that
+			 * skipped the trim site in the RX_FULL branch above.
+			 */
+			i2c->smbus_actual_len = 0;
+			/*
+			 * Drive xiic_tx_space() to 0 to signal STATE_DONE
+			 * without truncating the rx_msg length.
+			 */
+			i2c->tx_pos = i2c->tx_msg->len;
 		}
 
 		if (!i2c->tx_msg)

-- 
2.54.0

