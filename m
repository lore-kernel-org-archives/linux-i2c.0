Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F119D52E06A
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792072845; cv=none; b=XLsZHQJHVLQoFq8urjmVRy+Nuz1nGZva92OSE6J0+9cGGX/LTLTD3aNRQyJro1MATGdZB0w6m1i4yBKinCUHRfdz/mdVS4yrL255ouoPLJeGFXKjg1x1mNlpGry76hMVgjWx2e5PzU/PUbRqODe+NLYAMvkZa5O0LZ39lvfky10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792072845; c=relaxed/simple;
	bh=0MyRWputcyymbn9GnSoejC1ng4GIi49RK59WG2Bqlzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Tk3JWdWa3Fm4A2NM7DvrQgaTV34hYKJHeSyJny6bOu1yjMugS0G5boZ+fpn19vH9+UpTX6ojVyi4zr+Hr2PuYlOhc44T5kG3BBOWJqJlVLt7kNlabBAE7NNoShyUIuqIyoWsWg2h6JYoMhaIGbrwdL3pcwFrw2xXz084QhLws2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=f8XKBaa6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="f8XKBaa6"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a0e1b0681bso38757095e9.3
        for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 07:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1792072842; x=1792677642; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IjZ5GoX8cufqsMSGcZxUhgcFDrYZWhJP2v9qR94LpCw=;
        b=f8XKBaa6erWWjd7T1gt59lM4Pvak0lGlgBsH5NA6T9HcU/NTZUqJ/bIM09UEr20z7m
         I00H5/P7g7QbhoeB4qzt9+w8LD9wrkrkRgIJMtU080IKPFbR2emDU5Y4ad+M0dntDHhB
         adu058dHzYUperHTyLjh2r4SdoJKhwGHjQbfiWqAA3GrZUXEOgN5p0s71H7dAUa+75YT
         hO50YoxPm1xyQ23Lo3GLCtAco1BNfzmmoVU7I58Jj7NY1YZBZpu+SXCNZDG85mH5UOJf
         3vL9mRtnV3lsKxeaCYzqvgmrxAWjgqjyQkdRWvjdsLS4Re/ICPUOlkbpPvie2cmvlVR6
         oBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792072842; x=1792677642;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IjZ5GoX8cufqsMSGcZxUhgcFDrYZWhJP2v9qR94LpCw=;
        b=auXM4kr8T5m6tKAgPQowcvWeunlzsroc2Ixeukh4ehMR/VOtcvLADyfxmEWx+/eMms
         bnv6c8jIE0w39QMZFXY7Jt/JGmdHB5d/NSUdEU9Gmz6A4AO27IE39lutFigXbBcatLc/
         +s3HvUmbc90TkuzIdkH5p5NztsQ1+nODFgZjzmQIduHVMss/d8apvg5I0Qnv4YCkqt4j
         QAk2vyH+Aa6XX38QY31yMHeYvi7cWvgxi+pvFrG7Mvjs6yyinYoQDvECfq3D5SyEWUdo
         xqgj4r192zd+tC5Px/Ke0yutpnCUtvBkAEA6ObQMwh/tv7tYFGbldC2NOjgJntRTcLAH
         sicQ==
X-Forwarded-Encrypted: i=1; AKwUvBxzufDsFI8lsIGF2KCCgBydnvR+4xETaGDX4MLr5AOnODkMhKB2nlgzokbgJBx/9nvtCUveW7i7eC8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzeBynU31oXRLQ9BPVmePFJ+AzPsatSwrkE9C2b+CRoo8VtVLv
	LnKW7n1U03uUjCzaFMxyOPj7RY3BuzyJmuT/nL/sJki1OhnkUaDEAe43Mpnh34QCTYNWtS2QDzH
	f4xz7Kpw=
X-Gm-Gg: AYBFou0ilellf30NlmYQiwdFDYCtQBG7bQEqxjWq4oM63lC97BDJWqeSm6UptIbt9zh
	wDZYwrgat5vYyyjhvhJJQmmLx65R/guvAN0x1vs8M4ioADZeSDTNfWJjLwFp+3wMmhNbeumLXxV
	ehBImtaLfN97iOZr+s0R6VYdgYxu4MA5ftyjcFpPo/omOHyYmPt1VmxWfhHj17mvYE9qlq6SdBp
	qYqjrt8aHEx+X4+SlTmXPTxIJdohgOyOoPDsAsrS3iFlIJDdtaV7nEX++8l/dkOk302M2fIE+WQ
	vCzl+fkaS/h2qefL9dfWh2960zH4f7V0saQK7aqA/Di2dKMwcR/L+ygN2yrpoLtdozlJXfksfoX
	PV+AJyAl/NYev3boI8upeEikF0pn1dkE0S2Hy9sDpDD/p2MK8rV67QtMuF0syPDAIP9BVbS5/g+
	YJMyj+aBztMTqaSKjcJUrXmbYcyEK36hQiaQ4znGVaO/4WP9JmhS/JQT+pTouvW7UX2esZzAUzV
	Z0bZZQK09fJyDU4WuS8M4CbU/PSib35b2GQ3la9HYx+FO9aHgaRv0jYDpdA6qOUqQ==
X-Received: by 2002:a05:600c:1553:b0:49f:e8bf:8f9b with SMTP id 5b1f17b1804b1-4a18e443ea6mr372999995e9.4.1792072842052;
        Thu, 15 Oct 2026 07:00:42 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bdbace19sm76448915e9.14.2026.10.15.07.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:00:40 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 15 Oct 2026 18:00:34 +0400
Subject: [PATCH] i2c: rk3x: Disable the controller between transfers
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-i2c-rk3x-disable-v1-1-81625845c175@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDQAxA4atI1gac+Fd6FXHhzESNFlsmWgTx7
 p3q8lu8d4ByEFZ4JgcE/orKe4kwaQJu7JaBUXw0UEaVyUyJQg7DnO/oRTv7YqSiqskXff6wFmL
 2CdzLfi2b9rZudmK3/j9wnj+BZc+7dAAAAA==
X-Change-ID: 20261015-i2c-rk3x-disable-24672d4f38bb
To: Heiko Stuebner <heiko@sntech.de>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1742; i=alchark@flipper.net;
 h=from:subject:message-id; bh=0MyRWputcyymbn9GnSoejC1ng4GIi49RK59WG2Bqlzk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRduNO+qsfyNUfr68zvNveOzHwVd8p2lcn3aw61j1/Y8
 P3OOni0uGMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICpnv6c4Z9NTaSB50vO9RNM1/QdezxLxeSf3LuLjHGVEc/Pv9r+Ysp9hv9BjC6
 +si9XhKxUS/wW/eCUm9xE//td62X/t2byne+fx84BAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

The driver leaves the controller enabled once a transfer completes, and
an enabled controller keeps tracking the bus. If the lines collapse under
it while idle, as happens when a target's supply is switched off while
its bus pull-ups stay powered, its state machine wedges driving SDA low.
Every later transfer then times out, since the timeout path only requests
a STOP and never disables the controller, and the stuck state even
survives a kexec.

Clear the enable bit once each transfer is done, successful or not, so
that the controller does not watch an idle bus and starts every transfer
from a clean state.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/i2c/busses/i2c-rk3x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index fcede9f6ed54..dbf1ed30fda6 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -1125,6 +1125,16 @@ static int rk3x_i2c_xfer_common(struct i2c_adapter *adap,
 		}
 	}
 
+	/*
+	 * Do not leave the controller enabled between transfers. It keeps
+	 * tracking the bus while enabled, and if the lines collapse under it,
+	 * e.g. as an unpowered target clamps them, its state machine wedges
+	 * driving SDA low until it is disabled. This also gets it out of
+	 * whatever state it was stuck in when a transfer timed out.
+	 */
+	val = i2c_readl(i2c, REG_CON) & REG_CON_TUNING_MASK;
+	i2c_writel(i2c, val, REG_CON);
+
 	clk_disable(i2c->pclk);
 	clk_disable(i2c->clk);
 

---
base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
change-id: 20261015-i2c-rk3x-disable-24672d4f38bb

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

