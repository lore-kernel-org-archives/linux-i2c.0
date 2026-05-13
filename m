Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC39E3932E2
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778666980; cv=none; b=LxWHduW26YdfLtfbWsRuDMvzd0f7G/kv2cbgtu2P4zWVAmzTn1AzSSk5jbqqvGxH8TQiI93KGGH5YzuFEPsShdaMGi3KmiFF6xTn4v2DjOLzDoENEoGx0LMJr14+IrvOpwStrQ3998hJB+2R3mOUIHBPORRSgIDx0EQsKBrbdqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778666980; c=relaxed/simple;
	bh=IcTTcY79qLYulJ6DtpHIU8j/lmilEm/EM7tnCfD/M8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQGKx29Cr+Ihl747wG8n6xI4QvtaiYWDpOf4Nv5X/05n11Vl9lGWMR0O4QDlEKLIfbjo43wtR7YPsb4EwJfSn9yVmiC8yQyoTC9p8XDWNhCHmzw4D0vYAC1IzFkAeQvlm8qUE24PAOig5OYuk5yHU5aKPz0T7xHNSH4MviD1rrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=AO/z7VQL; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="AO/z7VQL"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1329507c387so4386384c88.1
        for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 03:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778666967; x=1779271767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tMy1R3v8/cknJGc/Ns+zpumuALOM+zMl+dD92JAI70U=;
        b=AO/z7VQLoF5Ai3klzgi+FIjvtnULOh9mlYAP7q8PIAUX7RcrZrpaA/8s8pxhfQXEA5
         oBC49e9rGrEwLuaagoZsjIX4m/kSlmIlnkjXMNgsIu0OblWmj6MbD63p4MPJRk+j+Z3L
         NJsWhDaoUta6b4Hm3+JgJS6tRoDJe0oNbJpuThi3liuDNH8b1m5l6ZZ8l1kPt1v3YoCS
         FHwM0fS43UxCAY4Hljz9umgXsfOkc6jfJcYkpnu1F3JSnoCNK21l9gfy/Qywqm8VHcLj
         83atKQiox+MVRYAl/IXociBKQbamECNAMXtUZrf8tmxSGDSRXTx7qko75/jNpUmg+ug5
         PkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778666967; x=1779271767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tMy1R3v8/cknJGc/Ns+zpumuALOM+zMl+dD92JAI70U=;
        b=S66klWcZFVryUYTIKYCfJ5JfGGlMpJO67lfVphe10rvyK10BIzxGLqDdszTCOG3LMz
         F/avxgHZ1Hc3PHUpA3S/Wbg4De5oSFv8SOUM1As/1fC7j9TrXcb9//Ll0RyVByT1vHcP
         w3PprCynOxOqb2b1Ipcz1L5Y7gRlgZaEoP1YVkDeAw4OuT/6RDqtxesPXBudXFh2yY4k
         8VvzPAdX64L03kuTAn+B4kuMQkaIoWb7qTzyi1PHPrSO2oeP+jV1O5eST4ZJyVjtHSu7
         fU+Myfu5ljNB17DPWYsMh3z84iFHpItwhrxPAE9xajUYMXohJKFfePEUFUXl9dTDxNZH
         AZTg==
X-Forwarded-Encrypted: i=1; AFNElJ9KUGwg5lxPS0WVOYnf3gzN1kk6tQZjva3fW3v++l4Tl7lH8GLT8F9VktGhTM19G51Ex2RYsa2ge/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiiUSh9qnRkVbJy19ag8iSC/H3wqaTa5D1diQ+BU2IGNZ7pjib
	Zef7p/k+8MBBKhzXvuaLziE2gy7FVIl8RaYfPAq7DZEn1KUHcOLLGP05ChWxk+ueCBQ=
X-Gm-Gg: Acq92OHO2FjVcwxUOkq2yg2PNNIiqpqjdOXwtZAd7KfYsbO1ITgbRRy5ef6UD6TCHYk
	C8jUzcsWNUSjwxjH50qeZQL+gI82DM72hIWKmSEo57aSwOjZOsONJXX4W1XZGmuRgLVor8yKI7j
	bRxzbTq3JKtme+HMH/HWKMril7e9tOocaSVH88p6d3tXsk0uLUacaemYgLETdxZkikQeHByBeuz
	Fxpo0ZCTVI1B4GtESCeYIZ0W7tJ+DkSCtkPQORFK9dQmTPbspjcQs2yLgqnlRHlf1ISktxPKa/4
	sQoVnWfHnh0bD0+t9fMf+fqzB75QnFmxawls4cnXbT3RJznpZxK91Kcul2Cm0yrWshcqV/GhWDo
	PwIIWAb3JY5nva2a2XpKGEO91VJqjRJenAj3DTsQdh0g0z5Of3MBSMRM2bBVYl55qG2sir1yNxZ
	ISUeC1XzEvO71zCU3hTuxPxckdog==
X-Received: by 2002:a05:7022:221a:b0:11b:1c7e:27d0 with SMTP id a92af1059eb24-1349a1371cbmr1363410c88.0.1778666966786;
        Wed, 13 May 2026 03:09:26 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132787673ffsm29430265c88.15.2026.05.13.03.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:09:26 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Wed, 13 May 2026 03:09:23 -0700
Subject: [PATCH v3 2/3] i2c: xiic: defer RX_FULL until all trailing bytes
 are in FIFO
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-i2c-xiic-v3-2-ccb3cf70ba03@nexthop.ai>
References: <20260513-i2c-xiic-v3-0-ccb3cf70ba03@nexthop.ai>
In-Reply-To: <20260513-i2c-xiic-v3-0-ccb3cf70ba03@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778666964; l=2850;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=IcTTcY79qLYulJ6DtpHIU8j/lmilEm/EM7tnCfD/M8w=;
 b=8UzUUME/YlH55KnDDiPY7DoH5eRhIrJtdDWJN+ZdsYZdmJv2TNw+RDEb56gmi96+eB4cGHrvn
 NcNUmEzIP1QCKmqoa4Ww1l2y7NtSLi/b4E649DTiFNOGaoW5qwoQjrC
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

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index d4308716d461..2bdba6c0931f 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -548,10 +548,11 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
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
@@ -572,11 +573,8 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
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
2.53.0

