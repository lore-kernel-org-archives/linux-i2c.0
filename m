Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093546;
	b=DhWe6RSsPbFutz+NH5LaClytma3LbHqhGzCmgeEsKadcRgwtOX9KaD5Ik6rLhjLHnc+m
	 rvVJEB5hgFAyTHNHtsOVc2fZfrHb+pKrohfh7w2305a7vr0Ze6CfEv91Rf0HUL+SB84xr
	 vnvsn7Hiy6M4dqMoBvVhJhqNTdGgQ+LTTH7QhM1zbB/mSxitOu+i+7SYZS/kKWeqhiMBX
	 TutIfmpJbK/whBqscCe0Om8ufkFNxtAsW20gRkMs9RIio9hMougYVyslxoZr73Hdbf9j9
	 5Mh5Ep8QdCSkvptS8BGJIuHFl6gy+Vdt/vesXr5Y0i8y3Ydsjw3wHQ5TbYbho2bX80Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DUHaQOoN9eliMKXTBs8DaDAMBqFWvPB/4qsL3rM7sCY=;
	b=H5es81e/a6Le/Prjq66LIjVcn4CQmMgiIX9PnA9pvBRNT5auhWwxTuBhgilxs+CEiS/w
	 U0mDAzYCg6PhgwJhpCgvKm/6RazyaEsMJcYOlaxx6eFzDPHYtbGYvM6CH++3NRCtFxTNg
	 QFclzMVuenJFz+D40dWv5DoAEXUtFslG/4gGAYuVrKsK986V7hKDpv6jlEImQDXy1xvkJ
	 TfGfvw24T83CC30pYIjGFyD2M3XjAHFDTGiptvc6BehXt1BfS5K2d91HZxAwgey5pFY87
	 sUjZOJwxAppUX36Xg21kY3MJCvc9JJwmXZj4HsTcjKrJS3oFMcWWCsAMvn8iqnVTOiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d+P2nS2E;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EFE606A325
	for <linux-i2c@vger.kernel.org>; Thu, 19 Nov 2026 13:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0EFE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d+P2nS2E
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so23033145e9.3
        for <linux-i2c@vger.kernel.org>; Thu, 19 Nov 2026 05:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795093544; x=1795698344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DUHaQOoN9eliMKXTBs8DaDAMBqFWvPB/4qsL3rM7sCY=;
        b=d+P2nS2EjsY+eEi7OdOaWLHvGqCBToe6CKePpe8AIaLlkeEMMnUf76H9Z8f4+J9Ec9
         uGkatbfy7qj0Ou5ygc7/rO4siZdrDrHNehinVgm2hUnVEPu/yzxFifWi4+Q74ziGXC/M
         49rBEs6lJc8S8+UGnNDjlfTdJX5rz4O5Lvbtzuq78ReT4SnBowNt1gFdWVQwSBHGUCPC
         1RRdrjtHI1cznfLQhURsP5c9e5GBNHELhbKn/k2s7CEkKKN7Unw8DAmsFS+GDfPvhBcG
         H8iUG+31DsrqGza6a8TxMWykPivwhI64HlhqVDbrdqTU4dX8O6HBa4ZyqokhWt0ObKsy
         3UgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795093544; x=1795698344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DUHaQOoN9eliMKXTBs8DaDAMBqFWvPB/4qsL3rM7sCY=;
        b=bvN8ZmVpL2nEucYr5zoXb4m9vtAjBWbtAHD7ckPxDoox/uye6UiUdbSeM6OJhKuy6w
         xY92XRoB3ygOzXbIU9hNqExfQ9ouW2Uw7nrT5iNxAMrlfRWVGkkN0M1wBxOILc6eAROU
         q9qwzhBI7QZzQWiisIsPkr6jcRbMOBERBwAk0oFcTKDrYLe6v88l8NipT/pGzrfojqDI
         ptcX9qQdq5GD9kTBNxp8Cv+T/yuG8tWmhYVJ+mVYwQYhIjQHhQj2YOE5jaRaqy6HJGKJ
         sqTCdh5Ju/RwXGTd+OPZaxhN6xL0vHjuMIxjujufVgUnm7jiqLfDK+LP/9FXwHWXljca
         inYw==
X-Forwarded-Encrypted: i=1; AL+hErGC5Avtv/zdMJN4eYay1DBaDDDYOh99mhwPxBGEcoWOkReVv9uId8R6MZfdbnjeE/K4sc+RfJN1jRE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0ZoN0/FLIm2D1TBtAg+292SO6S5uKNVp9hqAmnlXWs03XUOTj
	1MBpXvkFRsat3YPMrLI36YCRJnqBxCycJHD4P6GxbKhlQxpWlXO1ZaHp
X-Gm-Gg: AYBFou1MRyj6bUpAMsACJ6kaCXggMz1meyC837ACZhcOkRvYIRNm+UvpCwbrx3+3y6n
	ty5vj89b9WbdugAhebTgsuD2iHqXSEWvbxHXSv+cW7e1eT45SuPGsjDeAJzwpeZ8jzT6ZCww+U9
	Oruie8VMPSQvj8WUMK1PPnyEt4A8A49rnXLSCUZh3zQHdysZs3dvQSKicjBdvSPCD8i198rkx/2
	C0P+ualOFXuvdNVPj/8dAYC+Bp8PvyzhMCWbOZyc5VT8jhXcwxCe1vZnLDwjy/mNZJdN08UXYXo
	IPes3+c22/lNYrL8VxnCsNMXVJXsY/GF8FucIY1PV2IiNuY8y/u9hF2RbNg9oP72MtOdJ/Fhlyx
	ArDWhhSqrlCe+VMJDWkfx2ZNxQ2i4243zBv6ui7JzAEeJmXHDXgEMuaCk2gihF5HZVO0FOX4z/M
	QfSLeX32QmCrey+RTK8GGcELgw7LiytDlZdvH29j2qnRh8n9cuVJS3uMV7UikQ/FUIaM7oedZQ7
	PcofpSJT2gThPdBF/0u0mcjb27+0C77eCXIZPoYP5m98HE6R3RvY1WEZH9JXlyY9QQP3RrbEaJ2
	ALgdN5102R17NPl/mkVR4Bz9xQEMsVmiFYM=
X-Received: by 2002:a05:600c:4e44:b0:4a1:fba8:b13d with SMTP id 5b1f17b1804b1-4bb7da12957mr112752995e9.9.1795093543797;
        Thu, 19 Nov 2026 05:05:43 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b3a7sm42546305e9.3.2026.11.19.05.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:05:43 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	mehmet.fide@screeningeagle.com
Subject: [PATCH v2] i2c: imx: do not acknowledge the last byte of a block read of one byte
Date: Thu, 19 Nov 2026 14:05:42 +0100
Message-ID: <20261119130542.180192-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

In the interrupt driven read, the read of I2DR that takes the count byte
of an SMBus block read starts the reception of the next byte. With a
count of 1 and no PEC that byte is the last one, but I2CR_TXAK is only
set in i2c_imx_isr_read_continue() for the byte after it, so the last
byte is acknowledged and the target goes on sending. The read fails with
-ETIMEDOUT, the bus stays busy and the following transfers on it fail
too.

Set I2CR_TXAK after taking the count when the message is then two bytes
long, as the read before the interrupt driven state machine did and the
atomic read still does.

Fixes: 5f5c2d4579ca ("i2c: imx: prevent rescheduling in non dma mode")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v2:
    - Test the length of the message instead of the count, so that with PEC
      the data byte is acknowledged and the PEC byte is not (Sashiko).
    v1: https://lore.kernel.org/r/20261116124430.1358948-1-mehmet.fide@gmail.com/
    
    Tested on a Colibri VF50 on the Iris carrier, kernel at this base plus
    "i2c: imx: acknowledge the count byte of an atomic block read" and
    "i2c: imx: keep the error of a failed read", with the M41T0 RTC at 0x68.
    A test-only hook passed the messages that i2c_smbus_xfer_emulated()
    builds for a block read to the adapter, alone and followed by a one byte
    read, with the read message starting at a length of 1 or, as with PEC,
    2. Register 0x05 (0x01) as count byte on the interrupt driven read: v1
    read 0xff in the PEC position (40 of 40); v2 reads 01 01, and 01 01 00
    with the PEC length (250 of 250). Count bytes of 0, 0x13 and 0xae read
    as before.

 drivers/i2c/busses/i2c-imx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index ccf08cd63151..eabadeb47e2e 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1095,6 +1095,12 @@ static inline void i2c_imx_isr_read_block_data_len(struct imx_i2c_struct *i2c_im
 	}
 	i2c_imx->msg->len += len;
 	i2c_imx->msg->buf[i2c_imx->msg_buf_idx++] = len;
+
+	if (i2c_imx->msg->len == 2) {
+		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
+		temp |= I2CR_TXAK;
+		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+	}
 }
 
 static irqreturn_t i2c_imx_master_isr(struct imx_i2c_struct *i2c_imx, unsigned int status)

base-commit: 25e7ab89f4774b0f842cee0e8a20c11f755924d5
-- 
2.56.0

