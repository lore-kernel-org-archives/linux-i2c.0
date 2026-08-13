Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E161D44683F
	for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611167; cv=none; b=qVLzcApsg86iOEdNqOM4Uzxhd4otzS4n+qAYpd2no/hYjrijq4pWwWaqyUWP+doxpFoy9r1SZq/WedofoUBe3tgy6itnwGPtdRnTlGYunFRY/aywaJk4f29kxtDJtip8tmHn2Zfz/mobYc2IfI0o21U/NuntBgFZRPr9oxmMZqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611167; c=relaxed/simple;
	bh=ldbF5ILBtjfVdXOICss/RvJxBQ+h5ZIfdab/mT+/gKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPQiHtbK8Y17jZyKvHXxMbJXscXu3JQkF2gS6LjqU5PpZjGfH7dy4Kc8dcuJCo2ww0674zEr118crCvNHiNb9wqEHrHvO1dJofXnMWNgUnCEh5U3P4rAp1UawD/uQNGuZ8gCLGVL3RKk1lQbJ/phBtwTNRfBQqXc3R9avy3mns8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKMSe8rB; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKMSe8rB"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so1463301a91.1
        for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 01:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786611165; x=1787215965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sX9XI6O6qjCjlu3Bv7EdsrhNGWhNvzRT2+KyAOXZhAk=;
        b=aKMSe8rB+bOM7nIKZPrqaIcQ+zsSf5HAW4IAAZW+xj1HQJdFdRstb5GRwXycvF4ZWe
         E3tA9XPUX8mKMVu9OxuYTCSA5fD068gyTF0aOnASajKyEUMxvPBvevUvJfo96s+Lxuyk
         2u7RHratoi2iY0o5oq9/81ncqcsicFhZDM580xHCQbrMd4fN69yinuHPe2vYjbjvdSPQ
         S7Zwj7wehsojA7OLR13GPTF6njsmNP4uLfSU1Mep6SfR0NOg6EfFo+Iq56xmFXuyXl7j
         B7I8UqyeqJGBTAIHdYNxpIhD8VPFBHuJvzN4idFBkDR6x4dJwGNrBrqDsXKDGlgbnjHr
         XSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786611165; x=1787215965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sX9XI6O6qjCjlu3Bv7EdsrhNGWhNvzRT2+KyAOXZhAk=;
        b=P6IR9LKuoCnEdwnmVdLGeYay5goRn6GCW3iV3sx1oUSG5k5geN/ae+xDmxoWdlfABm
         gBfkOak3Td+uPFI87I1E7LJR0JkaBtFmswTaMjz6rMxJGolP7bxF7Hybnzg8qkrBKdI0
         mGtGHOkxDqmcVBGFJDEsIa99kQI/lhEK67LO4+W9HWj7CkdOMU5SnFxHbrzSwLgT4ee8
         YydSSGKBOQyD3oMRvBnuw97TewxS5a0XNpVghQ1hyMYgxt0bwoLghlmr57OsDxoNOBBG
         FReGXYZSpbe/8NZ3C+AYCO5H3pzN/AInlo46MKzCo8yzPC+Zxn87NUgCmUfRxfWGHOVM
         NmWA==
X-Forwarded-Encrypted: i=1; AHgh+RrTCm5iLG2kftewHLR3/ecqAy/dXW7EL4GhNkf/48vWPpgYhaV8KYGL/M2EoXEPqp/aYgO7/lXapL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNXyh2NvRlfO3PdloUFkn/RJ6MUYXoAmLLuE3F7BEDZdfIMrRy
	foYyFYxUykGbpPpZDj++kbW3oQSoY6v9C4+08ylJXNmZf5emTzoj4csM
X-Gm-Gg: AR+sD13DJUjdzxiz+wOwbmechzhwg1k7KWgq3xokLsQ7sLXZ1Z4Q5Rv4gYfUfCS4Li0
	NeQL6RYVvykzT4L9bv9mZcVPUzNPo1nKOmXCv7bMQKd91kSYvcbbFtSu1QTqz+N2+vLbrjjDKQh
	oM8t+qhNNs8ZdjPv+pe/R+PPfQpblSluClLHnSrMMXGR6WjmapSZhXYdMGegY8TX/d25xJYM0kw
	daRLSD6NwobHtlM0zQXG5+/GlzL2x6CeXNeNruv40S0u/4xHmBmTRpSA5djVehYMZNcuiExcg3x
	xBXliv5Rp3cD0WI3/MtAKtJZEFmVYbThT569twZMWNnaqXKxb5mWcRqyvaJ4cL1lNHVbuXTM9q8
	/n6NdiKJtL3zVZoQCbo4FCNXa23n2hqxHVrZCweLqR9JyaXYpTX7pPexndXhGw2ac/BIddTrJ6U
	itO3hMzUP25U82sbO+4Sv37ugemWAUTqP6ZJZq/AqD1y0lyUiNZ5xKape1+Z7w6ppdIcnTyfMwP
	Gpcn2IOTWA1i3NOo2Z7y7RiZx98rRghKtgX8dEwrXIrfHjutD/glnFKWvR9kOafiLE629h0i4OY
	r8PUtYWyBWcmtto=
X-Received: by 2002:a17:90b:278e:b0:381:25ce:bcc2 with SMTP id 98e67ed59e1d1-3931e0242f8mr5395506a91.6.1786611165058;
        Thu, 13 Aug 2026 01:52:45 -0700 (PDT)
Received: from phuc-desktop.. ([14.160.25.72])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ec0223e31sm5465372eec.25.2026.08.13.01.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 01:52:44 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Kamal Dasu <kamal.dasu@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@kernel.org>,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 3/3] i2c: brcmstb: Correct optional IRQ handling
Date: Thu, 13 Aug 2026 15:52:13 +0700
Message-ID: <20260813085213.44001-4-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813085213.44001-1-phucduc.bui@gmail.com>
References: <20260813085213.44001-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

dev->irq is assigned from platform_get_irq_optional(), which returns a
non-zero interrupt number on success or a negative error number on
failure. Therefore, 0 is not a valid IRQ number.

Check for a positive IRQ number before requesting the IRQ instead of
treating 0 as a valid IRQ.

Also use a positive IRQ number when reporting the operating mode. The
driver sets dev->irq to -1 when devm_request_irq() fails, so the mode
check should only consider positive IRQ numbers as interrupt mode.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/i2c/busses/i2c-brcmstb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
index 91525a36e575..3adc73f3d608 100644
--- a/drivers/i2c/busses/i2c-brcmstb.c
+++ b/drivers/i2c/busses/i2c-brcmstb.c
@@ -655,7 +655,7 @@ static int brcmstb_i2c_probe(struct platform_device *pdev)
 	brcmstb_i2c_enable_disable_irq(dev, INT_DISABLE);
 
 	/* register the ISR handler */
-	if (dev->irq >= 0) {
+	if (dev->irq > 0) {
 		rc = devm_request_irq(&pdev->dev, dev->irq, brcmstb_i2c_isr,
 				      IRQF_SHARED,
 				      int_name ? int_name : pdev->name,
@@ -697,7 +697,7 @@ static int brcmstb_i2c_probe(struct platform_device *pdev)
 
 	dev_info(dev->device, "%s@%dhz registered in %s mode\n",
 		 int_name ? int_name : " ", dev->clk_freq_hz,
-		 (dev->irq >= 0) ? "interrupt" : "polling");
+		 (dev->irq > 0) ? "interrupt" : "polling");
 
 	return 0;
 }
-- 
2.43.0

