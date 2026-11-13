Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794555175;
	b=ejZMADM/hDypDNzQMEimBVTviuWSRPNe4GCbbmw2vcper8qpC4QyHbtTLtLOwRquF0lC
	 8nRFtAnWI9zALMPxcvsMcBVVhoBFJL7zXI3ZH3361GEwQUOnM/ROpuRDBZybS37MlfhxX
	 7CdHZlIeBS6BFs1c/5VNb1UnPo7CHL601GwSLSNkl3deNxDFaPFZ17A9dAb3GVur5WYqU
	 kaDo8xWagXWqrG+Rqj+vA6HsvWQ9UqmkLoWm+KSg2hTlGka6eQzyy4vvNrsVZunNgmqOA
	 WYOqKS7JT9xANc38RRWeUdV6YQfUJNhZJ56WFifd1Q5OOw3CetR99a2zltRdt//iqPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+S0kn7e/e8eb1jZgh+ha8xm/Lm8wUpKn755lAIdoRTY=;
	b=5MkJJJHW3+eP0pAxLdjxF5OUrH+8XqKVgH92S60+bGUSxFLkR4CeBs8t+pS8NRYEU7ow
	 X3F2QPNCs6RSeh0QIZrXZnSjhCX2pjupEmv9AynY92+2FWsypLEx6kJ3h6rmpJfnVvWfx
	 kaPq7BFRy6nECoAi8nrppnl9PqAQOd3eMJBmFBxrWG5ZOIlEklk9SVoGp4OtT982oqJZb
	 yBSeevTOFcsZCdnyC9EzfTROp5n3fVqlI81MV62k2z6LF6XRXBhTZtzp+ZuzifbWcqyIZ
	 DZmS7w2fTwN9l/4lnzFUZFLzz+po4JfAboggRonhrIPIhFz6d0NQ8r30Zi7SD+xCgRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hwj7pfUC;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCB2606A327
	for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 07:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDCB2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hwj7pfUC
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e09aa5264so230357f8f.2
        for <linux-i2c@vger.kernel.org>; Thu, 12 Nov 2026 23:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794555173; x=1795159973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+S0kn7e/e8eb1jZgh+ha8xm/Lm8wUpKn755lAIdoRTY=;
        b=Hwj7pfUC1dvZhZwvhnfPkIfuostmed7pJJ3l3pdCgBHdzbxhSeTqW70YMzRljyUb9b
         fzoPJnqs+IrGvnb8Ba/sWT2eWDlWqDSPhv9ftqIpii+h7z9CLGRL+wibdC/ijP4/+djG
         jNiTk0s/LpOi7oPteseT+6wF0t9tk12nQ7N14jKypKAge1tabzgNnblOiKMJgG12wAyj
         MnHJ5EBajX80JKPusnBvGB5okYbM9yM2t5SMcml0GQhWTXZWgFepbTciKxDTtuLMzo/V
         n5JYdD0Jtkeh3YYXSvJ1eWeO8vbJLBV0QU5e4CxLHX+o8vFK7HIEojCA9QyLAd6/AqG6
         VCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794555173; x=1795159973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+S0kn7e/e8eb1jZgh+ha8xm/Lm8wUpKn755lAIdoRTY=;
        b=dBvPc77iv77lxlH3Pgnf+a+HSs5SxGm4TElDCeoXMvb4SQRdgfw3wDVthaw+AGFx1g
         UwHO2KV5LPEzcSvIrsjTYZa4h6r/d7H3zOgIog68dd8DJM6303qun7yC0MsbxpNVNjnS
         vZNhT37Ln9l9bm12TLD4mA5BPmYwErdbeT2QU3KLH9PQZ8c8Xl5X2I+k4APGNXeaqeDd
         dbJPoBakHTBXFx/cbqVO1XjOYz42EkWluWRHduotLwvHMUtoLqea407xH4xZqFRhNFw4
         MR0xU1IxE3Ucv1hQdVm41LTw/twALIAGQ9t9k3Qg6j0I4aHvQWQCyQOCKO4pzECpeedU
         Y65w==
X-Forwarded-Encrypted: i=1; AL+hErFGNEzggXPg0OzdKtLycm89DEsZrGs+wRVABkvcgcVIQPyD/vNWn5e+gdbC5PWbv0TFACkrQlMdIYg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8P3Cium+hQ+QzYgg/KsLD9QgVn/vtU7XFV2uWRsocjr0BB7Zlj
	IGXTO3rul+uUIeXC81nj0NLDb1/2MAFlneQ5xvnarWupL8zEvqISKWF/
X-Gm-Gg: AYBFou20bklUGNNMnbGaIecrA9T0y0WG4yRi+Pq6+aOMPUtiDjkCkKCmwXB7pcT6NSD
	/WUV/Ow6CZafkoOGrLCJb2iMgMyJYl2VWVPYHGoJEZ99KSPMlTYKTvZf14HMmjbZTBoM8QLlBJ0
	5Q/U6IEUgTChwEZe+d0V5MKrHPJTWnIPPfHALf0R92bVbmqtelJE5n/MzbxLRla54TOwtgaGexR
	UHuUI6hMWaPTELX6cj21RwQLls04SCLZFwvvue3joPhdO8ZZR/3G+83CYGQMXaAjkGJuMj5EbTr
	JSrHgXNgm/ht3usGitrFksjqOT3rfFAYCSuaTg4tylpc8/XBtHNwckH18e1PkXzdtD2GCaLnM/h
	s1yPvYPO9IbOdvzNqxIpeT3Zfm/cCoRU3C7+Qf0NrTiJe56ppjg9EpljY+s0eQiPbkcCzn+cMuH
	SC0/Uj2Noyyebqku6CXoGTURovL8QK1tOyU7BgfYi3IC1J4pBxNkgywXBrbzruKa0Guv4TLpCkl
	lmLHb4zgUXox1toDdFE/rw/N2o0uGfC5evv+NoazBuZLvnkaG4CuZrLqDzDgPhAwniYIvJOT9wz
	6TrKjiA4Ms/W2QRqjQZBTm7a6aNJRCC6kuw=
X-Received: by 2002:a05:6000:29d3:b0:48e:7e1f:8cee with SMTP id ffacd0b85a97d-49c73259d1fmr2428976f8f.12.1794555173288;
        Thu, 12 Nov 2026 23:32:53 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5d223a29sm3799903f8f.8.2026.11.12.23.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 23:32:52 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Yao Yuan <yao.yuan@freescale.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] i2c: imx: do not carry the interrupt status over to the next transfer
Date: Fri, 13 Nov 2026 08:32:49 +0100
Message-ID: <20261113073250.1037215-2-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113073250.1037215-1-mehmet.fide@gmail.com>
References: <20261113073250.1037215-1-mehmet.fide@gmail.com>
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

In DMA mode the interrupt handler stores I2SR in i2c_imx->i2csr and only
i2c_imx_trx_complete() clears it. A DMA transfer that fails returns
without doing so, for example a DMA write whose address is not
acknowledged.

The stale status stays until the next DMA read. There
i2c_imx_prepare_read() calls i2c_imx_trx_complete(), which finds IIF set
and returns before the address byte has been sent, so the read returns
0xff for every byte without an error:

  i2ctransfer -a -y 0 w20@0x03 0x00-     # unused address, -ETIMEDOUT
  i2ctransfer -y 0 w1@0x54 0x00 r32      # 32 times 0xff
  i2ctransfer -y 0 w1@0x54 0x00 r32      # correct data

Clear the status when a transfer starts.

Fixes: ce1a78840ff7 ("i2c: imx: add DMA support for freescale i2c driver")
Cc: stable@vger.kernel.org
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/i2c/busses/i2c-imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index ccf08cd63151..1987a0fd8132 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1657,6 +1657,8 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
 	if (result)
 		return result;
 
+	i2c_imx->i2csr = 0;
+
 	/* Start I2C transfer */
 	result = i2c_imx_start(i2c_imx, atomic);
 	if (result) {
-- 
2.56.0

