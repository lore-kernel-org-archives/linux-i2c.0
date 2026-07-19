Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ABD264A86
	for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784474245; cv=none; b=jCsplLogAkdvIpRp7ZklILWWZW1jal2W7WbrT4uI3S+i1T3duEmB86cxm4ck8IqIA/z+Sm9NDF9KxbpYU1hEz0zLQBs5vQH5Nn1M6L75mFuywKcRXoVkjdQKL+JW5BBpwzNjG9kR5NCA8H3XFHf8DXwwKsFQnQ3A7oTOx+QHz80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784474245; c=relaxed/simple;
	bh=y4CWJt16YdZrTCn8rdj1CNouLpjIWr3Jrm21zLmgNMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mNC+Z0NJI9blazwqpRDfy3WLLLF1G6y5HPLmFHlNr7pLeklJnuJ5/IG+9PEA6gzp/sTMz1p3Ni9WmR3fU9m1a2fDQ+f2bgY5r+mVu5BZcW0EvlzTflaSSmExQcG1rrTEkVjcVDFqJss6umhlM/5JNyMZYz8j1/06dC93PraY3Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxywBAR1; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxywBAR1"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39c62764c7cso25019941fa.0
        for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 08:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784474242; x=1785079042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/8qLIUHsL4QgH657kTC3Y7xhccUy2MxOta7XG4RiyEQ=;
        b=IxywBAR1FgiIhjb1MO+wyTiZAY2GlaH82I8V+V8jl3oOlgS1Q1gRRGA3bvamD6J6xt
         kXjaVLdO7UjVIGesQ4hHMgfES9Z2I/RDDkC2Pbj2fkGaS9QmGJJnECr/Tfi9M2DG3pLF
         YEvRnWobfSAdn8Q7L2yWXjXnR4TR8RO9HjNsMsi1VNUxfsEfAlf3WFtWH6SBl7aVWdKZ
         0KZwqCFgG5bDv5HmmUKkbMd+qsOaNilvyA/L/ZDUW+RG6BD17Ij2p1p8D9CtUsDTRLK0
         ob4QmA6hTOlTKsV1l3J/i56QFVLXmh/9SCOvr22mAnqqhnziU1ctL/sEDqcXnSZUrazX
         ijwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784474242; x=1785079042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/8qLIUHsL4QgH657kTC3Y7xhccUy2MxOta7XG4RiyEQ=;
        b=lk5hHQzVlgaSujyEtLEvYqulUrmxzEChWdRHcfom6OUE1sH3/RY5oamXk56QycN+Ko
         RmkzR8CLkkNKZEmxUFQqo7bfnbuEA9/vjS/HP/3w7v8C+KzmRFJrW4HfmR8qHAgHSEod
         xOtrfLXaZeR1EVfxeKgCxhWNitcLbug++zoyCrxEjCwO0wzFRFzh9OZPReJJaUul6tgp
         IXDc4Bvb4zZ8zzTVNqrVyxErK2rtzsjh1Tbqyx2JVS+RzM2DD7PTu9VZZoz0ZMJVjiKe
         oPYrYh3SJUEVBIACZuUDWiTSwZnrSq+5DIw07mKigiDGpxKYmdNQpYFbojWTDROmKvVw
         /A1g==
X-Gm-Message-State: AOJu0YxPQBU5gQHIBlG21A2HxefilT0Q8NrxvSfTEOf1DufbJ1Wk4AWe
	SZvqcAuVzaHam1wi7l9N30dM865hCfFjpZW/0W3jmeLFLHJp5Sfj/Y4y
X-Gm-Gg: AfdE7clbTTAk8p1USfyzrqztFk/eyiXOwQ0bIxkcmnaOUu5iWhqc403/6snH+pgYg34
	EXoYmawDg6JuSXZb/KdI9AdhrFSeeyWxJoA/FCtMIrzJP1e1gUKW0idgfkcRe2sjoMLtLiZGaGv
	xjJKkHvXFKipaXKTpreOzWEUZn4epPT7Xsi8eV2hQ6m041QcbmXirW1KlMOntEU1pWvRSRioI0V
	OUZzkFRsI9/FSKOFnz1FleGzvKkBMVt8omYCNcEyv17AXoboR+u0gYgyUoGZxsGPlY0DT/gPk65
	D7g9f2YQwHyUqGBq2VO5QIvHuX6n5FSn/Myjozf2ql9xHi8XEuVvFKpAqUtNpfFOF4SVBkGZBM4
	V3Ye9Yl0vuJxS4IKB9PO5lDK832wXJoXSAe6WJh6fcE3sud1UCkX1BBvlPRLHz6b9rnrlTmzROx
	dL+BXD/FZz10uCs1ruu6OMcK+sX3R0c+3oHaNxCSyATMJp8qs=
X-Received: by 2002:a05:6512:608c:b0:5ae:c2ea:b3f1 with SMTP id 2adb3069b0e04-5b28a1681bdmr2552035e87.10.1784474242005;
        Sun, 19 Jul 2026 08:17:22 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b291e26e5fsm1835096e87.80.2026.07.19.08.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 08:17:20 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sun, 19 Jul 2026 16:59:45 +0200
Subject: [PATCH v12 2/7] i2c: mux: add idle_state property to i2c_mux_core
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-i2c-mux-v12-2-a5010d623a57@gmail.com>
References: <20260719-i2c-mux-v12-0-a5010d623a57@gmail.com>
In-Reply-To: <20260719-i2c-mux-v12-0-a5010d623a57@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2781;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=y4CWJt16YdZrTCn8rdj1CNouLpjIWr3Jrm21zLmgNMc=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBqXOp7WFi6OrXLhmafy952YX+tICQUAvJ64aqCl
 Vj2SS1Nh5qJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCalzqewAKCRCIgE5vWV1S
 MkUvEACBhKgPGGuR3qHycC2u24eW23zFyI1Ka1kJ15o928/alNJoCF3E2vkSsJV4VO5HlIYSk41
 zqiZk/1/NYlEorRIdrRZtru7cocnd5lvayoiFDAHbbnDagGn8dATvnwbnNaRS68e/fs2hatNr7p
 V1TC1e4Md6L3gecHbpOafI2p0RCVCi7z0Ashi0+vkc6eNk7up8gDQQ6nq+vHhWw0PGGL3WWqkxx
 vIQCC2JEr+CkU5+srA5H9HXSJIe/L6Vm6cPgiGPv/A77TNNsqhsy4694qp56yMbqNrIUh+H49/G
 zFIZcV+ObnEU8tPDX26wQp7O8+Oh4dpHMEy1L+PdgjcHkZp3bI34jol4oTMYDz5A8QgW0OikWNk
 2GKObd44wxpSQP+ycs/vbJGz4Llwzc/UJqj5fpwmgrgVS1GKgJccx9J+dRo0OR+K2v3jX8eS1yK
 ++ZnzcuP2gDUocLAS0bQBvGXgbesOHGLeZd9ofSaS1VmzPNuJQfEXQBYgi7iCfvwAs2247KZ2MP
 E8KDM1988ewRpD5W7LXCisjddvDw1saTLeyE7lesX1A4UWvar614kDCgua0vf2nZTYdRE/1s2V9
 jAc6Ne0iJa51R8vfiImtgKzfkgBlO7B/S7sDmf1hcTFpLM0aKvGbHSZ8ubUgwi4Nqa1nkqCzRQX
 dLQM/h0YMYzrSKg==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Muxes treat their channels differently when idle.
Let the mux core have this information to make it available for
internal use.

Possible idle states are:
 - I2C_MUX_IDLE_AS_IS: Leave channels as is when idle
 - I2C_MUX_IDLE_DISCONNECT: Disconnect channel (set HiZ when idle)
 - I2C_MUX_IDLE_UNKNOWN: Unknown idle state
 - <n>: Enable channel n (starting from 0) when idle"

Default value is set to I2C_MUX_IDLE_UNKNOWN.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/i2c/i2c-mux.c   |  1 +
 include/linux/i2c-mux.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 681a201c239b..b126ce7338c2 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -247,6 +247,7 @@ struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
 	muxc->select = select;
 	muxc->deselect = deselect;
 	muxc->max_adapters = max_adapters;
+	muxc->idle_state = I2C_MUX_IDLE_UNKNOWN;
 
 	return muxc;
 }
diff --git a/include/linux/i2c-mux.h b/include/linux/i2c-mux.h
index 1784ac7afb11..a348f81e7a90 100644
--- a/include/linux/i2c-mux.h
+++ b/include/linux/i2c-mux.h
@@ -15,6 +15,10 @@
 
 #include <linux/bitops.h>
 
+#define I2C_MUX_IDLE_AS_IS      (-1)
+#define I2C_MUX_IDLE_DISCONNECT (-2)
+#define I2C_MUX_IDLE_UNKNOWN	(-3)
+
 struct i2c_mux_core {
 	struct i2c_adapter *parent;
 	struct device *dev;
@@ -22,6 +26,18 @@ struct i2c_mux_core {
 	unsigned int arbitrator:1;
 	unsigned int gate:1;
 
+	/*
+	 * The mux state used by the driver when idle.
+	 * Possible idle states are:
+	 *  - I2C_MUX_IDLE_AS_IS: Leave channels as is when idle
+	 *  - I2C_MUX_IDLE_DISCONNECT: Disconnect channel (set HiZ when idle)
+	 *  - I2C_MUX_IDLE_UNKNOWN: Unknown idle state
+	 *  - <n>: Enable channel n (starting from 0) when idle"
+	 *
+	 * Default value is set to I2C_MUX_IDLE_UNKNOWN.
+	 */
+	int idle_state;
+
 	void *priv;
 
 	int (*select)(struct i2c_mux_core *, u32 chan_id);
@@ -38,6 +54,20 @@ struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
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

