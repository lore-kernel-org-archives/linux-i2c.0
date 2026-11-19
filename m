Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095750;
	b=I37hg4/tD0CPPFixfP1jaH3fH0fVkqoCy4u4YaCAKP8gNDI6Z+4O75y+sIuPEBWlAhVQ
	 E+eRNJhILLuIXPSTG7FV5AqktNaUzacbIUH9wcs3lswIU/uNlLRiukrkI3NYsMCQrkjdP
	 taS2mINsS0951SeUFI1Q45onCvy4dfA8KsUGjCpBOAXYhUlanQqmL5WdfU+BBTGuk8eWR
	 JXxB+W49m5xeNO77IksKaA1xk5KVOxNQtKREzAT+HWUQeR4c+UK21XCjYCcvPQqdy7tXc
	 9PafDRkoPdDqgxjF5vFmy0J+xjWZF0abVnQpesKZCDmpE2/HUVG6AFsmHXwxvScMP+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=03N+1oTleZgKa9Qt+3r1LOaqyq+wwqvkfR03GB3AqD8=;
	b=OKIgQEFk/Wru4gtkiAaQFpX0+88eo7BL+FiChx0sOTZ7zvgD3zQaKCwwVcLwm2oA0zGU
	 yCRBLTLHH5v8zh0khnxvFJ7oh90Ttb0m/Y8u6pS502MTWffz7wBAhMc+BAQ+I6FKtbUGC
	 2RPjak4qzjafEELoDfJeRuPIDGMYggIz4fiPoui1tJmvW+JMYRClcovz1y42YjLxfi6nL
	 9BwKdoWEax7S6ySWEmNfAC3N5vuQJ6CxyKwVnKRz+5lDtBvdCn2XkZWvo1ee9fUADk6MV
	 pJ58cVG5MYp+6NuVyvummXWvX7LKwEAZMXwX1OoZT0zQQ6P9PgdUFiduJ5Ooa7J4QwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HRD6SJD4;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6B860A2616
	for <linux-i2c@vger.kernel.org>; Thu, 19 Nov 2026 13:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D6B860A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HRD6SJD4
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4a32576da88so1272516f8f.3
        for <linux-i2c@vger.kernel.org>; Thu, 19 Nov 2026 05:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795095749; x=1795700549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=03N+1oTleZgKa9Qt+3r1LOaqyq+wwqvkfR03GB3AqD8=;
        b=HRD6SJD49lvTZD9jHqV0rBo+BagdKvdzhEasCkmjov7nEjjErn6+SmaWiJ5i2F4bzy
         pdPNCYDgoKy1NhQ9BrmaSve1wFG24v6YFm5GZxABU2D3rsdxPzH86hRpu1w1+J2j6k1g
         7aoJ0Y/3Ij2XUOozXzRIjjJMUI0USHNrcF+ehKHFZQBB95NN4IKX0Rsk8C5IBwxxpsJn
         Vu9hT8C/J4w4RYkfGo1bYt29EiV7VebufUE5zPnfVRmYS9vb89uzcDWf1TwpFJmmdc9s
         rkkBX7dWgM6qyVJCX8ZarQYPo4mKHckymSzubGXT+hmU6VA7oJGY6fjtP7SKX7wRO63D
         93gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795095749; x=1795700549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=03N+1oTleZgKa9Qt+3r1LOaqyq+wwqvkfR03GB3AqD8=;
        b=sfPunMZqIIJkzRmgaeQ8VZy7U2OWcBoz9r0X97w4WgZgxPGUqj7j0BGrfo9p5NkZBb
         fVPNWFiFozOgpZ5xRSCZgD+Oo87Erf0qVS5VyvanPXg3jiO2raJWVYynX+pwhyF9K5uB
         J9cc6bsrAkb4z2tYBMaHssCoRBuaQfMnX8iQcr8hDInlgeXO9l+KNZXQ6CX+wrI8bHDZ
         IcrNb7dmmp6AiZCd/Ap73iT9KjJiQOLgJLgHnZ84NQKxGaPbNBtjSKEAwMLfY6KnBFlK
         3X2GllGX6EVXIoV5Fq806rtCdosji8J4TvauXDh4K+/kDlLz9vkb8yk33hF7wKTHSKKc
         JdVg==
X-Forwarded-Encrypted: i=1; AL+hErEib8wBzcAMgzdZj8tQAgBedHzmmk4aNpVKFpcAHRIV+JI3BD5GGOJ2k5QozkSdTzIq7xJ4g5AYeU4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LtYXTj7UHqkBUR5klGaUvwbN2ETjiUdE6jpc/9T0exc96oVBQ
	1YFK4YKK3Jl5YjHXylHfSRZFf0qi0yvEf+RwCijL5wTfHKtDzcdNO047
X-Gm-Gg: AZFdTZcx3e8vFQwBiJSmL63jV8lcl9zAB2TdYjDWwFDDoXZzWQXebZv917dVuJ+94OO
	APLQz/TL9K0pSkiow4L5oOw9WJYn+mkLhmts6xnjct/Dlx52xHR6D2UMSmksyD+WafSllVCs57l
	5Zv9cOJ5nQMBTnUajtlEmMg1il1OHf5Odl4JODcygq37Acluj1nzXYsUiYOAhnkGO5geU1EMr1l
	R/eriOLDO5AsWuy7872eleQ4gaovfjHuu05+l+XeFy+EGWvgeUdwIzWHwdD17AKFJzDGKEFyvEg
	vpgLFW4H3UijwRLc62RYgbL0igB5udh5sPnaJ8e0lv8QmHtOFbjoyt6qJTo6u1ji1uJRu70sAXk
	FqFnzuj1pgszT23mQ65hNvCa+H+ZjtbFtrxazwx/HQkzZMuy6XX5lxi4SblmjRsxwEeQiHvvZ7P
	8d4NQfdEykY1M6zT8GeknaElLEqETeGfCNoHFces1H+kr/9TtD+CEEjG/BvF+fKf6B/5PIrEaWm
	csfr3hBvSK00qUiKUr++35IHD7zEXWigxE7J7uKrAcbUBd1F0rq/RKYbOUODHrsiLoF5eFRGgVO
	ChxA2OsSYDnAYX73yzv0/rAMJy4Lx3bR0hU=
X-Received: by 2002:a05:6000:4815:b0:4a6:bc53:247f with SMTP id ffacd0b85a97d-4a6bc6269c3mr11252717f8f.48.1795095748613;
        Thu, 19 Nov 2026 05:42:28 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656095e98sm9437971f8f.42.2026.11.19.05.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:42:28 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Yao Yuan <yao.yuan@freescale.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	mehmet.fide@screeningeagle.com
Subject: [PATCH v2 1/3] i2c: imx: do not carry the interrupt status over to the next transfer
Date: Thu, 19 Nov 2026 14:42:23 +0100
Message-ID: <20261119134225.265242-2-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119134225.265242-1-mehmet.fide@gmail.com>
References: <20261119134225.265242-1-mehmet.fide@gmail.com>
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
index 89f2b764bbc4..f20727ffb5ce 100644
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

