Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA79D369D59
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927238; cv=none; b=O9uHxd4OPwDulvkartP7oYvtTt0yANZZT/V4h1ph7hp2P5hg76ZpKVtpAphLK9Lx1woQV9zP9tluI4xyQXxRx+7vizcjHXGTJhfQjUk9KjVlDXDDKRnTtXRMmhNAwn6ySWePsKKD1e9Cpt48zuW9TT27UxlLjNKu+nYsT/vbyYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927238; c=relaxed/simple;
	bh=vnuM7kAv6UZYVTKxBCbKpa+2q5drZUiYDWWf72AF6A4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oBGUN6GEnH61aHnrY7UgjY/1aFZLGnS22hz0kvzItBor3owB2P2yK8wW3Fpv+OpqX+89oR/VGer86G1xjVomRkJHk/SWNB0ZhbpicOSBFjAUUCZt+oCM7D1QDYN2rsxQWZHdSXCYtyy5T0JMXe4T200J3vUttYIeQ6/JYLCt4+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIbHWTxb; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIbHWTxb"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b011edaf7dso2550265e87.2
        for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 00:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783927235; x=1784532035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dprxgYd134ZCbde7II6xEs/NYUu1NZeUWNqjC0nuXDg=;
        b=OIbHWTxb6r+g9ERfRhtijfh4cnx0oeXMkKDNAfOOzk/jBM/2FFY6LGGasyEpljdhn9
         FtiFEyBygnzGPhD29ZsS2Qw9uT8dcC4eFL1zVEVYIiewJoe9ACoEGXcrVBmZC3vTqIJ3
         QCz5JbXyBabTBlVmYdHXjaZmyX7sRLgkyeyUzn6y5ZpGsAr7WNxSr3p/WagAcUCLqW9G
         PmeZe+ZZtBi3qFYhxvD6VF6eyNdszg+kzDVSbSjnSrKMH33BWRS0TpwprbEHakEF31eO
         KJQ18LA4z0tw/q+9PQU4rtjMnZnFJzuBmt4yVgjSl8Rc7jCgzHcbP6riVSHNCJTPb/W+
         rXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927235; x=1784532035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dprxgYd134ZCbde7II6xEs/NYUu1NZeUWNqjC0nuXDg=;
        b=m+ejNbTi8argLJFNDLOpGPFNjS2Fg1ItAvFEkeOBcisREmtRCpWUfb8MIluqOird4K
         pXdW1+Jc2+uMlYbb6qKvAHjiAx7xBmwQVYm0k+9LZvciQglB6otkzLAq7LATJKsOsX6t
         wSpyz/e3FsB2zDoaPgLnXGsVbOG02JG3G92CIl0FgLiU6ukQqDGoJfncfXk2ZcpNQlHD
         Viou5VoRXIvmSHR1EJFm0yGRO2FjWG3SftQZ8DLXjZA3dUCUFATp8MBsq/5kzIeL0msG
         8gabmiAqMB1g5jYGxm2FR+q/CizgfSCIZQUOXXDoHj1BYW+RJB0E65QUtBcjDRQBdz+7
         ITFA==
X-Gm-Message-State: AOJu0YzADQFlwS15RU9POzPDj4CqWZiW5tHNLf0JlGgKoG3UOn5jh4Ry
	YG0W4WMZZP4NbjRvX5T+PvhINxjKv2i34KtuIWf+rxG1HN97en6850ow
X-Gm-Gg: AfdE7ckn7I1JMnRRhlP/wXKNhiFLrcl0x04+OnMjtL7VlwLocvE+LcSoCJ8AaA5EdAU
	oQDVu/1z4frVcnBD2Ph1/yRVSmPS3FAHLFMkuFIlMPM05VjJZVxvglkepqd1bip1wL/6xjqWW8R
	wQyBaBnarokSgX8cnHGduzq7Yu9z/Dm+MUMqSPsBlMFdZow7VY9qtdEC5J+OisQzGFHl4eSxzXf
	SOjx7sDzxo7IkMxI32ulky+Tshzd9FGiPRT6hS07HMKT/3k+S92ExkTpGLo3iEmkFV2GTRU8Vzr
	nLNkDW0Cs8fm5pdCxS47Icqk9qlr9KSryEOcOz21nwCn/4IVyDX2S98naTME+rsLlQ4QrEfd2Xc
	8KKxR7D57EYQ22+opMhR9wdHZibJvimb+X89+L7r3PsB6wfgUBH+QFfvGXBhwRoYR1gOyWU3zF4
	oJAm2NyLBQSruraNCsKL432FWPFYBD85MU3Dt9f66TxwPZbpqwcify10gt4jzVJPyV1Hlf
X-Received: by 2002:a05:6512:3056:b0:5b1:5142:5c30 with SMTP id 2adb3069b0e04-5b151425dadmr568417e87.4.1783927234912;
        Mon, 13 Jul 2026 00:20:34 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca55723sm2625636e87.35.2026.07.13.00.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:20:34 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 13 Jul 2026 09:19:58 +0200
Subject: [PATCH v11 2/7] i2c: mux: add idle_state property to i2c_mux_core
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-i2c-mux-v11-2-72bb8af8ee8c@gmail.com>
References: <20260713-i2c-mux-v11-0-72bb8af8ee8c@gmail.com>
In-Reply-To: <20260713-i2c-mux-v11-0-72bb8af8ee8c@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
 Peter Rosin <peda@lysator.liu.se>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2493;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=vnuM7kAv6UZYVTKxBCbKpa+2q5drZUiYDWWf72AF6A4=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBqVJG2jUPsQ+B917os5jCn8R16fUEqvn3JkO3eJ
 spLK8xMh2WJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCalSRtgAKCRCIgE5vWV1S
 MtZxD/9ASSOsNq1O1WXCwFDoTWIHuFHmsrumS2i+YzrgmZvlAUXbOxWVxCXxSPHTayTfPpEvrpf
 XSTy7kw3jB5fM7qRPi1N5FOp4MfZh4YVyrKnKtq1LDZP+FG336Mb64Un8vMYxZ2SMBYSQZdJBo6
 j2ERjEtS0MUZT7rxZlBkW8N5+jLfGqGnxhnP+xOwtVNeuM5GYuJ23esdRstjd7sVyA6NJdhM6na
 fHGmFomp3OaWL0V8iWXI7rlg5x1bkNUdwZaje0A5zk/2TI4LsBS4O1oJ5yOQuUORp9CRb8dhTAS
 2/Gsv/laAx0CIPvAAHVlc1kCaCii5MlZDfNmuSqWqEksEijbS9gTwZQIs2mLC7RIxxpgHNf568g
 +fi8BqjFL1F9lAWfw/seqUpC37YdLqQOT71e0AbURBbzGfJAhy0sqlTp3bvDsSQPW45ZS5lzRn6
 QYEMJB5HXcr8nPaHa608aPj+x0rqdsCfeFBPRLHtBW+3rI1s0VawM0iF1hoqCdDgtiskSjnEUyu
 mKVOLHQINzOqudtvzWAiTEn1qbfvd0KcjsPF0jy0pbWkec5CubMb+wgOL8pDq57ChHAiBMdr7GO
 k6Q1D79MPQlDyzAGLVSUe40ypi0CKtUHhYojuOLDOjFTLiNy/uuUPbnSLAnOTgagqgwecOHu5QQ
 tIxxsRjJpi4YDzg==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Muxes treat their channels differently when idle.
Let the mux core have this information to make it available for
internal use.
Reuse the same state values used by CONFIG_MULTIPLEXER.

Possible idle states are:
- MUX_IDLE_AS_IS: Leave channels as is when idle
- MUX_IDLE_DISCONNECT: Disconnect channel (set HiZ when idle)
- <n>: Enable channel n when idle

Default value is set to MUX_IDLE_AS_IS.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/i2c/i2c-mux.c   |  1 +
 include/linux/i2c-mux.h | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 681a201c239b..edf16683dc83 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -247,6 +247,7 @@ struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
 	muxc->select = select;
 	muxc->deselect = deselect;
 	muxc->max_adapters = max_adapters;
+	muxc->idle_state = MUX_IDLE_AS_IS;
 
 	return muxc;
 }
diff --git a/include/linux/i2c-mux.h b/include/linux/i2c-mux.h
index 1784ac7afb11..624fadbaa703 100644
--- a/include/linux/i2c-mux.h
+++ b/include/linux/i2c-mux.h
@@ -13,6 +13,7 @@
 
 #ifdef __KERNEL__
 
+#include <dt-bindings/mux/mux.h>
 #include <linux/bitops.h>
 
 struct i2c_mux_core {
@@ -22,6 +23,17 @@ struct i2c_mux_core {
 	unsigned int arbitrator:1;
 	unsigned int gate:1;
 
+	/*
+	 * The mux controller state to use when inactive.
+	 * Possible idle states are:
+	 *  - MUX_IDLE_AS_IS: Leave channels as is when idle
+	 *  - MUX_IDLE_DISCONNECT: Disconnect channel (set HiZ when idle)
+	 *  - <n>: Enable channel n when idle
+	 *
+	 * Default value is set to MUX_IDLE_AS_IS.
+	 */
+	int idle_state;
+
 	void *priv;
 
 	int (*select)(struct i2c_mux_core *, u32 chan_id);
@@ -38,6 +50,20 @@ struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
 				   int (*select)(struct i2c_mux_core *, u32),
 				   int (*deselect)(struct i2c_mux_core *, u32));
 
+/*
+ * Mux drivers may only change idle_state, and may only do so
+ * between allocation and registration of the mux controller.
+ */
+static inline void i2c_mux_set_idle_state(struct i2c_mux_core *muxc, int state)
+{
+	muxc->idle_state = state;
+}
+
+static inline int i2c_mux_idle_state(struct i2c_mux_core *muxc)
+{
+	return muxc->idle_state;
+}
+
 /* flags for i2c_mux_alloc */
 #define I2C_MUX_LOCKED     BIT(0)
 #define I2C_MUX_ARBITRATOR BIT(1)

-- 
2.54.0

