Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614208;
	b=o8eY07Ubh8vk14fiEhu9pAbl7UlrjM8hxvh3qzcEEVZyn7+qwFmixtOp6wIhkHRc9H92
	 eTxerYJ22e3U+S3iwxImzvbW7FlCSQTV5YqerrldkB/paVdSXC3H2NAvuAGk29/AaLkYb
	 QKbSUqGUTFbNz4h6P90O8gJjbMpZdShI6j6AulhFhciqBRHxiajNLEr+xC+LzLYRllkoT
	 Zua44Txq0PV+Rp4GO/I1x3KeeiHil2RcEhWjD7SOrVdPH2r0vXN1TjnenPCn2C2O1nrEC
	 46JIaQJHatKNEYz1HtdRq5YSaZMtWtr/ue+OggDpflLD1xL/4uv6gCdBP0nQGVEL/7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614208;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lyPzL9qDgC5NPyyWRyU2xpYxCkn2FwWXZOnIDyXNGvw=;
	b=nXgqNeJPhTGbVrXaQocU/VxFfQDH9HxA0sYy0T+4mgZ2k7iGYVwmv3KGZwHfgSJGTT2o
	 jdNfAHwGr1lxa0ZnvOmR3/lHsOJkHWxg08cVX7g2y/dOb/4bbDxCXOsSMHlKbN5IkpCjh
	 PPcbFUGd1NJCntPOypf+ZsSGVLYClrvqrEI78XUouvi5EU7YKOi8k9oofJXobP9xyNfQY
	 BVL0KfeaWaLMwx6hQ6x+oeoldBPhd7dVmWCvzCAFPVXib2bXSvjdkAIHRIQU9lJFMy3Er
	 Gki+xwkaROI81Iuy2/xCJ08tYvybIA9yhsNoxKaO2QANXmnEpfooerdgXsxj0gcV0+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="S/ivv2sZ";
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B956606A323
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 13:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B956606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S/ivv2sZ
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-386c71feeeaso2059650eec.0
        for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 05:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795614207; x=1796219007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lyPzL9qDgC5NPyyWRyU2xpYxCkn2FwWXZOnIDyXNGvw=;
        b=S/ivv2sZrFfQAn2czE8r/0ql5zt1R0HFKjY7C1HFMkpX2fSxKA32NOSiKQyRCaqQGD
         GpgUqDytS/+Me5QztSNhy3TsSPhSLheEAKynuT7iFIeJs1qDRmpplUgp/PPySvn0G3h2
         4hjfRd1L8xFQ0KwdvO3RTcXWWV3EhJdEK6+KxmYDZ8ZbjNVsQaz7Cxjeu5SvqEmxVZkt
         ly7gBxHHpfW0GqGvYOdnSkOr2SFzm1pkiYBkof3w15AVQpxJA7gYtLufLzblG34X2hDY
         lHpoBQ2L79mCPq/GZ03INg0FndsQ1Xl8EcoZhNh93VSOQ9JJzmwq2e+GAMYYlCHUnK09
         8ltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795614207; x=1796219007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lyPzL9qDgC5NPyyWRyU2xpYxCkn2FwWXZOnIDyXNGvw=;
        b=gLU7DNMGlHAnHLtehoXrVC52VETzfZ2frbhfTkoU5AhzSilFiHpnH0oae5X+oF16rj
         6dFiQ0LXpH27DE4iWfSK4t3NPHmMMUsXV7tpa9WUS5NqpuvL3G0vH65XQGi+w6njEJNk
         AtlqkXBbryCElPQ2Xn4mnJzjA37zt3SYqQdGBfc8quWKopIVIHkxr+AAoObM1GexvP3A
         ieYm0PI+btO6+E4NAde0bmXR992b0njuyi90hGDbOseu8bNC4rikyMQrb/QUORic1Etb
         rOwHNJ4DQ0cR72+dcT0srF1LBvWdXwNvV41y67+izKAoQSLyNPzzX94SO+3lFjnGv+J0
         oywA==
X-Forwarded-Encrypted: i=1; AL+hErEayy+PS8xlkxj3MWkc6yxwlWKueGPhGANzLLF+XDgQEmZ5F9XbxS66aw0srxy0Mo+trLCAmIfhB0k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/a71EjbpXC5YDGTV4E80r1/okOjclyGZTM0wPSVGkOEnjoikNM
	+GxOt/1VndFgBzGkH+m5B5wNd65C9p6YYDAbMvXI58yyHu2nmA7e6z5g
X-Gm-Gg: AZFdTZeIJuM6VJCuFl3gxCuzKCW6pUwpMgwyRshKA5qDjz0pyaHAazQyKHe67GcrDvA
	3+zCST5aSrmJw7eB3kIAgTXApdsUJFjOMDU2Hbtfr9wO6bCwcmU5VO6bBvujF7ohk8JsjyOmpZc
	pzXdCD/8CIoq//gq9u/1EBgHXVqjm5c4jHqkLsW4s3hwFBgO21KFGmYtKDXTgRHWn1xlh1KDxA+
	UqhsHyh4fvX6O8oSbIMGq4Hxb0S4npY63HgOza3HLdsCiGsD0wIRXlJlgashTB9Hn03fJQxmIeW
	kwoGuwFsPfRj+DWDDmy3YtDBPFAqrwKW+BIvusfldlrlv/UZUhWTaIRno0rjD+H4GYXlzfmkUO8
	ofG++h5GIuualzW/sLREKDGsKV1lpUqWxhO1e7J+Tn3k64giOEiPipZiJq56O+FtOeXZvsQTIeW
	8J85G1JVZ6ddr4K+H/O+mdFAdKIo8MW0ALJ0nQtz478TkJZEHxgyW21BMU+UA33XAD9FW9OnkFH
	DSrzOl/VkM23/SSW1GcY92gHCFa2hhL+m+TjMMIQzWH+Zu2S7O95k5wN9AK3wfmnvrjKiqK+HmD
	9pyb1N3y9QDnVDPqQrDQeRmhsX9Fn8s+Y8QdWCKK4oJHJAM=
X-Received: by 2002:a05:7300:1c95:b0:385:8851:fa4a with SMTP id 5a478bee46e88-385885211c2mr18419448eec.6.1795614207200;
        Wed, 25 Nov 2026 05:43:27 -0800 (PST)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567daaf70sm56773511eec.28.2026.11.25.05.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:43:26 -0800 (PST)
From: Cong Nguyen <congnt264@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
	linux-arm-msm@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: qup: release the DMA channels if getting the interconnect path fails
Date: Wed, 25 Nov 2026 20:43:20 +0700
Message-Id: <20261125134320.2701213-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
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

On QUP v2 controllers, qup_i2c_probe() requests the tx and rx DMA
channels with qup_i2c_req_dma(), then gets the interconnect path. If
devm_of_icc_get() fails, for example with -EPROBE_DEFER, probe returns
directly. The channels are not devm managed, so they are never
released and stay held after probe has failed.

Every other failure after the channels are requested goes to fail_dma,
which releases them. Do the same here.

Fixes: d4f35233a634 ("i2c: qup: Vote for interconnect bandwidth to DRAM")
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 drivers/i2c/busses/i2c-qup.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 731bce9f9a92..53e74de5244b 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -1784,9 +1784,11 @@ static int qup_i2c_probe(struct platform_device *pdev)
 		qup->is_dma = true;
 
 		qup->icc_path = devm_of_icc_get(&pdev->dev, NULL);
-		if (IS_ERR(qup->icc_path))
-			return dev_err_probe(&pdev->dev, PTR_ERR(qup->icc_path),
-					     "failed to get interconnect path\n");
+		if (IS_ERR(qup->icc_path)) {
+			ret = dev_err_probe(&pdev->dev, PTR_ERR(qup->icc_path),
+					    "failed to get interconnect path\n");
+			goto fail_dma;
+		}
 	}
 
 nodma:
-- 
2.25.1

