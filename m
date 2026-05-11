Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4B33A3E7E
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 07:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485603; cv=none; b=jp+mFFumvnSYy1j0ajstF9kLWC88EvpNsy5EZqBiX8399BEaXBMz79SV8SIToLHTAyEs/zH/U/YYrIOVTcOOgZgNHjT1+YE39zg458vhhRCoc+Z5wvbjOBmAfHajmM/Vh0OA3Vcy5vSttYPu2rMi+g0YEOzpkTlyRdpY/mpC+M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485603; c=relaxed/simple;
	bh=tjDfjq5O5p81+MNuIlyxeuaZBrECDSK/ynhLod78ZDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D4O3Y0dzy83lwersUljvKP0n+pB7skTizHghDzl2HJmEPZmq3971BQCkKhmPYVcSVZklgsPJIgtY5Cm4K8n2IonGd1JiXZws10m7Xnzesmrc5DXEM14PGBWgIcDK6w7T+KLya+zIwPpJr+sTLnWr01TXbm65XECyzUPGe0o2j3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=JN46uooX; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="JN46uooX"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f7020a928eso5323716eec.1
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 00:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778485586; x=1779090386; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4Dha3V3dyDcgOa6Jz5YYLbPJnxJR4aqvkeRMGSz7IM=;
        b=JN46uooXf5K2XbnJJb5r7O22CMd6ZG6gIdr14gKhrZqFo12cWj0JgR1uK5dlU7+Ut7
         xx0Y7m00vZfES8X7eSWWx6i45KleHKclco8fWZKmFUcDtjbqO6GG0BkzW5Xp1wttvS4X
         Pg7/rGsBg86IKCqpJw0UK1m3m7bFIYzOTcXhedUqPXlVFO5YY7TYi016D7sD668E2i8p
         2yJlZKG7jY28d2qD/eWjYD+7XTnnj6Ey6v6JspH23b0mKwfFDl4MFrNrbJ17X1UmfaCn
         45Qn1WioTAjiOE4oYSzwAfpsvG936ufSwThYYlICzuc59qTYePFleFkvofqw8ML7MuAD
         2Baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485586; x=1779090386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d4Dha3V3dyDcgOa6Jz5YYLbPJnxJR4aqvkeRMGSz7IM=;
        b=R4NVKT3xaMnzrNJGtrjIS7/WidzK7ZX/iX0EE3blKj3ajEBXHnbSc1wVqPFN3LpqEl
         gK0swlwaLl0bgy3Y3I5WgB9G3YVBE6XlAkYmmliSVp0OPR7hJXPDrmTQm2NK37fFQqtE
         xzR9qEPYFqRnZLtz3uxybVTYtACY3AsD8I0sWVSjQu22jzexaAavZinOUELTg7kSd2BJ
         FvKZjHEYhMCgpom9CeswG9utCVxSd4dv20FUsLqnkCZNHy7JaD+VxE2jCjmmzzc/Q53j
         Ic3iBKQJRQbEcWTnHE9NOwguKzCmePk74NUKMGCGoCUa9OrnkXm6sOq9ABp9Wj4gEp5x
         taRQ==
X-Forwarded-Encrypted: i=1; AFNElJ942ikNvYXnY7vgPMIZiZ6LCOsfpFzKRyauD9/ltKV4CxphXXz6bTYPYDAynjPH2RZ2bIvsMTZKKlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywos5bokM6p4bOZ736chZBtd/du/n/EM8bboEjeV7MzQM5PKd9G
	m79GtzlLkKieJMDXGFxpLePfoCWpYhsD/SUlB+o8pnAkZRIJQRFZGPw2tlrpVnOCzcU=
X-Gm-Gg: Acq92OF5mvIekFyUxrwONyVmU1J0An7f/m6tGusZcc2UQOf2DkXz4NwBCnbg+l8YjfW
	sSNGvH9x1+GbtuCyCGzX9YBdKiAcTqF8CSBMgR2XAjwoCSMWhfnn7HXDwDGbdMEVCNfNqnkd01H
	9pgBmH4498QAAXI3AscjNo9c0cu0oMTc+vIR7T/HHbrzmEHa4bZ5baouvKMsA/vgeKzN3sddfMq
	Mqrz7kgwqqPcJzkh1Ufen3STwMT8UMwShmzyxR26aXNc8KslvDCA6YrY5h6Om8Yx2ZmvLbe19wO
	SRuhntgttYZtEPZTNjuKsk8faxRUPPK3w6Hz5ROFDKqnvMleoruDkIoo+DagTy2auNAUCU6lu1z
	3qesZWEZrNp9k6DdRZjdzJq4c49hHxyLeDK97I5S+gqcQXl9t2cmYjqJ6tECZ+ebz7S+LdcX+//
	P9rF1R5/i9ad15ml9y9OVogEYKtQ==
X-Received: by 2002:a05:7301:7c12:b0:2ed:e14:7f5c with SMTP id 5a478bee46e88-2f54b89204emr11224440eec.32.1778485586024;
        Mon, 11 May 2026 00:46:26 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e381c9sm12205702eec.26.2026.05.11.00.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:46:25 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Mon, 11 May 2026 00:46:14 -0700
Subject: [PATCH v2 3/3] i2c: xiic: don't clobber msg->len to signal
 block-read completion
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-i2c-xiic-v2-3-c16380cb1594@nexthop.ai>
References: <20260511-i2c-xiic-v2-0-c16380cb1594@nexthop.ai>
In-Reply-To: <20260511-i2c-xiic-v2-0-c16380cb1594@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778485583; l=1863;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=tjDfjq5O5p81+MNuIlyxeuaZBrECDSK/ynhLod78ZDU=;
 b=gw6nqk9h7ji67ko8VcuiZnbtsh798I4nAiW0eLEU4honRN1DaqpqzEms07K7iy0hP7h8OdbMo
 ofqTUL9Hms6DQLDAvItHCCZB8xleHHnL0lXGtsTNLop4I4Aoo64vfcL
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

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index a9452eca26df..24183483f1b3 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -865,8 +865,11 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 
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

