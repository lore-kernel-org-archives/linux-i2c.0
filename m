Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795701930;
	b=zeF8BJnVCC6hpC+PCq40bwruZnuuIFc6gUmF8bnrJCnEgcDyonFZNeVZ8/0pUarw0a6X
	 k8D2PYhOR4/neNDfeV4i6WvLlRaWkRlIT7+x6wosD+sNuVJt3tTQEgCoc4CQrjVklhwhe
	 Mu3S/5y0fp1tfbqsrl4EZa7Lply6c2+57f+2agMh1v+stFlUZiSw/II9YAT96ovTHBzHI
	 WM4tEKY+CB8zihDztupabcMAD90H9j+xRvDh5Wff9khi9B7cW6V36hzUkBEqwM4fWasr5
	 ozLn8QhweB5s9gZsLcOnDZAfBW5LAUVt8kitGnAqW9kTCZBy1qcoeAH+bYiVNh3aDnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795701930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=O/6YeVqDezPbtpzL6GKQeS19P8hKpEHC15hBz/pmg28=;
	b=DDEf2k19/oJ/3YZyL5H/sL3SroTXLRi24whXK1PJYFfB2JJJ0SlIVP93hknmqJl+sh5P
	 /939Kn533VgPgY6hzBtQfi9nhNpy7GU2fVc5JExNXaElNS2HzYbhmDEnnYI3HmQPdzM9S
	 Ae7z27FujBthqDBPCkFa1HHK8rPxVzq5Ek8qNbIkWKd3+F13DyWeXiER/txOEDskbLOqb
	 SoNiyj5Oz6swXUQHz7GAyPjuCa+U8CxJYcI5a4V2RvCTNaoYya7XT9y84cROGcgLWweai
	 51yNUaySB1V8/Ix5EJ39LkQ55d5YnmfR7Ec6likh48CBL2998Jpvi2s/PY9JLmZCN9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UhP76msW;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E118C606A323
	for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 14:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E118C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UhP76msW
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a2761c69fbso9546082c88.0
        for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 06:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795701929; x=1796306729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O/6YeVqDezPbtpzL6GKQeS19P8hKpEHC15hBz/pmg28=;
        b=UhP76msWmdMp/KWrdrp+ClPjMaygBkOI06EyfKW7xEkyUX6Iozlom+4+mZA6oYQsoh
         QTktd6l59/W6LUCaUSX5oxPGZ2rh1EpWxLnMOLO5lYAl4U9zfSBgPTyAQQfIF0t/9ZLu
         JxW+t6dPL/UEfjF4aS3r1FmJbvcvzNMoEmuV/mM/z/CaTdg+XHpu1007h4+CTmiU77JX
         fzJj26kLFw4tp4sgeaCpXK9l1kl1+VdnJVxqVP5teCbn2wjuQcJMuiiJd46GMg69FOlG
         JLZ9B/0cZ5X1zmLPBxkF3cTBHtjc01H2dZpww0KPPVn+M33O8rq+D3XwAiWK7lcsbKp0
         D2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795701929; x=1796306729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O/6YeVqDezPbtpzL6GKQeS19P8hKpEHC15hBz/pmg28=;
        b=2b9zFeH9x6xPngKCRYHjZv27qEhLIlbR0WhLMWraa11xJxke68SZ6RIBQyrAo/ljw1
         YPh1xYip2gwN9WPnSER5P11ZjRT/U98MBHVa1ztLbae+KcLnw6oZuJRoB6+atF8J4Vh5
         3L5UEZ476GBU3EP0eTtcKvgWIYcP39nArb7nJJtvfzgiJnupKi+u5/VYfV+d8ipgMTqi
         /oJrz1wbGqxPAZsP/KgILh2koDbETya2xPousepXdxN+udFPZ58xgRabF2JPngy6B57b
         o5qYquKOvPXtQLaNoPn34Kto7yXA3F+rrPsFhvkpuVhpoXIy0Af+C/4Irm3yL8wcLfw3
         wdHw==
X-Forwarded-Encrypted: i=1; AL+hErH7BxY1pihfYA2upb4nicJDQWdYhjCOWisoQjhVro5zxM98705ShchCERNmFksJtJ1k8t59y+WHwSE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZgRZqrEFbPcFHCOzBko4ip7REX5sqCY5Gs6gNyUlMUF9lP7ff
	nsDh4ZdZ7DSm0HLXPx0yeD/OoxlRBUUmJzNQMyYZWUfebUq5B+JiyjOPvx32Lw==
X-Gm-Gg: AZFdTZcMrmtuC2xzVZwgL/9xTT4tzdHGEAADaMuMZDKCbinPgsYShAQtKOODDBgaQeW
	I8+NLBL4d2FtZRO24wSZPNH/gyFU5RKw3Bg5vBqgYt5zr5Am8tL0pb/IzDQ8tYbeArrGTyCQTO0
	X+tg8JgOxdAoqB7dxE0+Gu+kK3134Gxdx9ZdTVBuzothPE9Va/fojsZSKa0xJyUBCjy1ks153tu
	2H93+1XHKRsaRNAoIiyUoTd9bOvUAnSmNUyX4lf2I01EaDtG7KX321VmQu6YzJuuP7mbLdNlj7I
	MqTvlWGqNoyXljfW6pXzPY0SLNFb0txbvnjqiQlZykl2BJJXZdbGnMhtBN+6Cc7bgrvhswPV1gP
	FnSEiDVvBvoZ4aUxPFNquOutVx4HYC+dfrJdlbOvXFaxqKSxem6Je7J5MuV4c8BO1oEAX2XNbL0
	Hjwu6G7cVh1zqjB3sDTyLdljXDayaosLXpKw7K6PtmkZtwmaLbNiJOPVAnRpdxJnnQ1P6w2IhRs
	HOgVXSCyTQbjmlXUyIsxbwdpK5Z8ZHpIgFBDAEfKCM0xZ7DeBQV/mzV28sG57CSy0KmjeShNt7/
	dlkfJuakNMpbYUkL+KRxHUIIfeOUSm40SAAqXlFaIGTvvRA=
X-Received: by 2002:a05:701b:230d:b0:1b5:8a6e:8791 with SMTP id a92af1059eb24-1b58a6e8aaamr4752365c88.7.1795701928900;
        Thu, 26 Nov 2026 06:05:28 -0800 (PST)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c1142sm48644542c88.2.2026.11.26.06.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:05:28 -0800 (PST)
From: Cong Nguyen <congnt264@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa@kernel.org>,
	Ed Blake <ed.blake@sondrel.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: img-scb: disable the clocks when probe fails after init
Date: Thu, 26 Nov 2026 21:05:22 +0700
Message-Id: <20261126140522.3991135-1-congnt264@gmail.com>
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

img_i2c_init() resumes the device and drops its reference with
pm_runtime_put_autosuspend(), so the device stays active with both
clocks on until the autosuspend timer fires.

If i2c_add_numbered_adapter() fails after that, the rpm_disable label
only suspends the device when runtime PM is not enabled, and
pm_runtime_disable() cancels the timer. The clocks stay enabled after
probe has failed.

Disable runtime PM first, then suspend the device if it is not already
suspended, as img_i2c_remove() does.

Fixes: 93222bd9b966 ("i2c: img-scb: Add runtime PM")
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 drivers/i2c/busses/i2c-img-scb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 9d2ee449a40b..0fabc54ad572 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -1324,6 +1324,7 @@ static int img_i2c_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct img_i2c *i2c;
+	bool rpm_enabled;
 	int irq, ret;
 	u32 val;
 
@@ -1400,9 +1401,10 @@ static int img_i2c_probe(struct platform_device *pdev)
 	return 0;
 
 rpm_disable:
-	if (!pm_runtime_enabled(&pdev->dev))
-		img_i2c_runtime_suspend(&pdev->dev);
+	rpm_enabled = pm_runtime_enabled(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	if (!rpm_enabled || !pm_runtime_status_suspended(&pdev->dev))
+		img_i2c_runtime_suspend(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	return ret;
 }
-- 
2.25.1

