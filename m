Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598977;
	b=Wt0j9vqNp8iQoB+AlD70lAkVqqVWCvNqOHg342zQiHDYQKvUlu2eS8g8kOvnj8friaoF
	 uEzQ+Udd6atGvzEDHXGGmatzHDbj7WElZK+BsQTaX4YrMA4i51kjZFYRDy2nNBDEK4I3i
	 ybASPtDDIMlkm2C8w61xbVhUymCEbAx5jDfsqj19Z7s008hpeJj3A/D9s4wsdCyHdpivI
	 iFJ6W417fxLNFX+e1IfjEhhJCad69Cu9I1nDnkx95alACS3tu6AzfBClYF1t/nFttmjOg
	 Ft3n09wkn0SsDJRY6/jmOK1GjO23yRjXBRDtzuqDY8zNg7tQKso3qcb+HUqz6eONeFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q7vPTpyG25KHlbD48LUyUXAGxP+fU7yyx1dKZKZGXsY=;
	b=yNF6N9vy0sdDd4HK+THzCYNHs4qErOgjlvGTQT7kYWVnDMdKvOEBumWNLVpm/7rFuGom
	 5VaeVQqW0/vRsgVytSeZJOWrvAawb0K8i+jrfxv0eHIdJpu9VwkrKBpXkxMHlhGT0i5QH
	 0ksaXgJ0zOEuzzBbsqTpn3ODoi15b6maST514HoWUBK2XZrqPDuqF0V2ruBKH8jzdiAbD
	 LpT7zp2ip+Z3Z66ItmHY5g02u4dRKJ9tmJWSpJozbGfkuhhlLeA6MK5KA07NZnrbH2iyO
	 E1ZV9dpaHNdALUrSYVo4igwN8FLAf8K5Rc2PmESF8P0YgC4KmSGPO8v/Q3eEiyniDNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SzMHivtY;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E84E606A31A
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 16:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E84E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SzMHivtY
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1e2957d7eso9357165e9.2
        for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 09:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792598975; x=1793203775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q7vPTpyG25KHlbD48LUyUXAGxP+fU7yyx1dKZKZGXsY=;
        b=SzMHivtYzl9WEeITRjfux9Cu/BCfwpYinjhFZLBbmsxXxXavmD/STXYNYc2rwY/h5Q
         t90Q1RwdYIQ0uOfUAi9xLPg9zWFkdbHqr33dJrPdbd+NaWqTh9Pu16/FLr2fB8AKTRbX
         bk4TnhWi/MQZ0R2jtvqj5hmHWUUB1coY0e7mENxEH3CjzoeO9CcfQLEc1Rafk9pBF9ML
         4bT2meXKaTFCkXRbF9t/I/O+f9OwoZkduzaJh/YN/q57dIskFYEpufAfy42sx8nWUb6x
         X3dzjfXJCRtd2MYpriLbHjvkiH5MTkj1tf5uMEXKJ6CfkD8y4KMjHzD5gJIo7Wg4QFHZ
         a4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598975; x=1793203775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q7vPTpyG25KHlbD48LUyUXAGxP+fU7yyx1dKZKZGXsY=;
        b=NcBqNMIGWjza2BahHx5BEfVrDxV1Q6cn482Nh/Elt3xq3R/Zy5O1G7uYJm4XfU7mTN
         Ie5l6ZV3J7P27Gdc/tO+q+RAoRGALhfz3B3NEarI4zqENVFOR8sPuH6On9oYA3L6jjO1
         xWFEPXfyOYCxjDh5EGTRvcs+EuYKVMmKAOxY8xiKn8qgUbV0VOswUfvy4cQSCphx6P6x
         IZeu9wF0Zf2u57wZaYsCDtZe/0cR1DFhVweKcmcGYztdPrYDr2c1Vesj9q9ahUbd3d7A
         DQkxE2VKbQNUJjW65iRZPOM7qDPmsX4MqloTTeJ6NFpmY5bNa+cSOasHGdtyw63iEL7f
         yVPg==
X-Forwarded-Encrypted: i=1; AKwUvBwP6nCBMLXcR54HCrS31DIS/ogiHfEgZe1/7IMQLQwnOsLdrsFncEj8eQzcQmgnDqQYBEJZoRxXyg4=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8r6QH6tCt0wZGNMpZ/+vNUM8oi7eIb3SSlqa66+rTXgbUVhIV
	+xbE1f77XHzxtHJB8JdsRZiYYYiPk7fQ0ZDd8L9J9hXstlOc5jVg2MgX
X-Gm-Gg: AYBFou0OLL1FPgJTja7CMxGra29bfuo53YOKHKmCMWTnJNmTBK2RHJFg3BIR0QX0AoV
	WUIYMOJeKEibtGvcVuYbLJlHOrGZsBuEyZ+r966N06dznvYpgks+eCrd2zUFx+p8ttZbFEFVywd
	wbOFJq2qtHMDEIndhVzsnEUn8vyWDvyOjYeBYph0IlKSV9uL8VDgY05VpIcgjSQkOpX82VJi+00
	yNV4wGL4Ld3g3dzZ4FyFeGMUtTgNw5UIXkXjr25hC3IvCQsqWX8B0/7jbkbTV005ZFh8306dblx
	VbymcFcVdyhiYzwq+NG7X9LaAx3nC/iDgApCF5uYDydjNg/nRUsvburebXEvBcbg/UcN06hIXag
	wQbiqZaYeXrtHrZsu7VKcHAF4AK5SXbvEDX83S4EVbXV0YZL6NHWQ1gFDhPZ86hz/GIJpoCoTgQ
	Drk/e1Q21NRq09+8CHHkz1VlkUZMC1KV4tPYKB9rT4dMpMKZxtwXGulSEpdIGGy6Tr1UIuAHtED
	bdqf6oRepxLVqbnFX2yy2RBHL0FnH2ATmJoNcazhPP6lCGDmkgVo/DaCLEo5UE8LKtAYfq9FSE3
	jlhIfsBV74EnwOneUyRRkV6ieZFmvqyqF5gZ7cPfc2PDrjqMagEcD4tZV73q
X-Received: by 2002:a05:600c:3b82:b0:4a0:108:3b48 with SMTP id 5b1f17b1804b1-4a1fdaf7464mr60190065e9.7.1792598975417;
        Wed, 21 Oct 2026 09:09:35 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e254f0bc2sm6226569f8f.1.2026.10.21.09.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:09:34 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Stefan Roese <sr@denx.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] i2c: mt7621: fix copying uninitialized kernel stack with reduced page_len
Date: Wed, 21 Oct 2026 18:09:24 +0200
Message-ID: <20261021160925.286424-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
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

When a page_len is less than 5 bytes in mtk_i2c_xfer, uninitialized kernel
stack data is copied and written to REG_SM0D1_REG. Equally on the read
part, an unnecessary read is done.

Guard these extra copy/write and read for the page_len to fix leaking
uninitialized stack memory.

Fixes: d04913ec5f89 ("i2c: mt7621: Add MediaTek MT7621/7628/7688 I2C driver")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/i2c/busses/i2c-mt7621.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt7621.c b/drivers/i2c/busses/i2c-mt7621.c
index 19dde7c4069e..b4d2f9c5514d 100644
--- a/drivers/i2c/busses/i2c-mt7621.c
+++ b/drivers/i2c/busses/i2c-mt7621.c
@@ -96,7 +96,8 @@ static void mtk_i2c_reset(struct mtk_i2c *i2c)
 	 * configure open-drain mode, this bit needs to be cleared.
 	 */
 	reg = ((i2c->clk_div << 16) & SM0CTL0_CLK_DIV_MASK) | SM0CTL0_EN;
-	if (i2c->have_scl_stretch)
+	/* Set SCL_STRETCH only for Mediatek SoC */
+	if (device_is_compatible(i2c->dev, "mediatek,mt7621-i2c"))
 		reg |= SM0CTL0_SCL_STRETCH;
 
 	iowrite32(reg, i2c->base + REG_SM0CTL0_REG);
@@ -302,9 +303,8 @@ static int mtk_i2c_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/* Set SCL_STRETCH only for Mediatek SoC */
 	if (device_is_compatible(i2c->dev, "mediatek,mt7621-i2c"))
-		i2c->have_scl_stretch = true;
+		i2c->have_scl_stretch
 
 	adap = &i2c->adap;
 	adap->owner = THIS_MODULE;
-- 
2.55.0

