Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E4543E49D
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783513010; cv=none; b=F+ElRmVrxt5K843wdX+RJGtvRsCmz6D2eshD8FTwa3Lq7mexleHvtr4LZyPUZVMXe/A5lWAe9fMSmmR8qOYB3vYGwglQ0yVoWoilhhiVCboJ14tQH9dVcgWcQzLPjejpUmVaCXYNo7dZVJCzI2WYgh3Q/ofgzTkuGvYcnbDoqKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783513010; c=relaxed/simple;
	bh=vnuM7kAv6UZYVTKxBCbKpa+2q5drZUiYDWWf72AF6A4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Khr6M+j6dHe44BzxIu4Ma9PEbWgGiZQhYrzq6Ysqg7IwrLEzoLH4jOq3Q7RXwnc5/SZXIJLdTEyFq6DI8CRdRzGAX3IPuK6LS7LgA0iTQDE0xe02Ww44YGQzqtD69WOwPwViWN+D04EVuxNVIWoFHItcJCyDZeK69qd3oDLUWpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5yGfxO6; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5yGfxO6"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so552057e87.1
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 05:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783513007; x=1784117807; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dprxgYd134ZCbde7II6xEs/NYUu1NZeUWNqjC0nuXDg=;
        b=F5yGfxO6nB0R/LtTexKijrlV0hSHnQd28pP4MRDJc3x5hUyrdu/55SWO3xoGvcXZ0r
         zEhfgvmJDjkFG7Y8IlanP5J2Lqr39uu1d1ltzKdzFofq3gJwGOjhORucj15DvqoLw6Dt
         TUtTW3ISyoPOKhmRuEFVSzWi1Ureo6NYTSp7WzsQAoh81uETyDslxyDKuCMnWJYNa4wb
         nj5IK/XXjBf13mLeOfEayC3AxP/ZpnFRlP0DehGduXi+y4IZDMiHCEec6qT1E/rIy1MY
         BcUARPVwq5ZClhCkSjMkODhOAFINBSLfJrrqlJX4mqwGMtaiiLY8D+uw5qSN/VmUmW6Y
         PKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783513007; x=1784117807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dprxgYd134ZCbde7II6xEs/NYUu1NZeUWNqjC0nuXDg=;
        b=cLehqoqIS7+TRmmgMpNYsPkuSdyRDWGMvg2iiEtabf8lA9gpBRfYl+gGulNrNBAT05
         X8ILUaZ6JgRylmc1nVVPPwB2742MASo35W+Aeaq+TpNn3MYauZqW5hTzYBfTuvcy1Q0I
         jNRwkJ1eRB6U3gBgXEiS692WvXirWJF8G5MMaO13AiIfGvFfUSRWLetdmjQKs+0dnv58
         joQoFGCxglBiKu2b9SGg8Y3SA5F/y+bRaMwS9p+tU1pkxy5RyvD4Lyk0f7S8xN8ZaTTW
         /kphVfffFrb7Bi1BABHKVVYXpnGN54t2u+ejnP1k8Cs4KN6F6Ok6buz/+tZjbmnEE/cv
         DB7A==
X-Gm-Message-State: AOJu0YyLCoJDxbP1luIykP1LZBiQJc/jBJlQClL3JpqaY72CpJwjep5h
	O0NbQoheqrMZkLUZaMBPCGWaeK2e3kvqzZ+T2uJUpbYZS8Zv0Xk2WgiN
X-Gm-Gg: AfdE7ckR2deK68ctRXKvZ1csbHdsf68AvowA8PzA9DmqhnriV4nw2XO/33pq/oqYZev
	q/CDt03oMOWjFubLPuX9cIa8Eo3dahFkLVVjy31A8hS3BO7PLUw40IBxCmnnrl7PQa2pnxm0Cci
	BtrJBFPM0WRelIms2Ir7Gl/YtU/JEuIJy0YKnCCz08M6R8ivubbDeRJcnaahwkTRBV6/rxTXaI0
	/RgglQpviGGOaTy3XWp/Hxg6462w50viVb7QEJOgDzTrlUMt4lI0P6e4eKCX+xCoEuEEAMJD2lw
	N0z1Dkgw2+evT40mjwPtVm5VWQERGYPjgwtT9odz7817X3gArmyIeZDWq1A6lMGugknMJ86fs08
	UBzwdO8u0QL/QUdO3taHmWGYglWAHVsd8k3ZcdVJcw6iK3AhM6WieTjK9F/0z7Axwg7tMu4P3PS
	5zBNHj0vzGJr7YkPqTnxnDmtpBCqeQTgpNmXBFeMtsTlin5m7Lf8tMsGT1dw==
X-Received: by 2002:a05:6512:a351:b0:5ae:ba7a:1790 with SMTP id 2adb3069b0e04-5b011463d96mr446741e87.11.1783513006560;
        Wed, 08 Jul 2026 05:16:46 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13bbbc6sm4471459e87.41.2026.07.08.05.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 05:16:46 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 08 Jul 2026 14:16:14 +0200
Subject: [PATCH v10 2/7] i2c: mux: add idle_state property to i2c_mux_core
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-i2c-mux-v10-2-09dca03c8a15@gmail.com>
References: <20260708-i2c-mux-v10-0-09dca03c8a15@gmail.com>
In-Reply-To: <20260708-i2c-mux-v10-0-09dca03c8a15@gmail.com>
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
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBqTj+ZIeiEY9dQXZiMT2fIww5fOHHhJFEr56Zm6
 ckTIvC184uJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCak4/mQAKCRCIgE5vWV1S
 MlTYEAC03316kkiScZ6WDaKlYfKvfC96yu4poE+QyJ50unYADe31KxTTRvmM+iMhIXKZPdQ93AU
 Zu+pEEDfIBy+/Q3v8Ks+9NI1OKtVbexmzkVZcvoZtgpArn2zPYTcrQZW+y4siq3O+suCfCDWIWc
 RqvAC0mFykVipVHtnSf+vm+mffOZOGIDS6FBhPTbcEzSxqRJsUtMX2C368QXMB78qskG//WOHQ4
 pbn8j8U0f8DGGcKoGZ7OknatGCL+lq8x0Bz7rJ+CLxsfUn2EZy77/Asa+pXkLIBje5GaxstDATS
 p4rLw0/dkZLoqp8KI8FvipT79c12eFsgO1xUqqnrz2RYl6199suUiz2BCn0fvnfi1aAFC/AYY1B
 7+M2Sif7XNhEUSsLZNnU2nZ79L0Qp7g7ILSQ2SanN+79beBBvKlqx/zA8M4RkaWWkynnjse6n+N
 5UGSB8almhq5Dmxe6+bI/+p6YjxkG99E7PSEmJ85g4jaC+KcQIOEPXZqB0dOSNh/l7zQbCj+T2+
 1A9taM/fatS+K3Ae5ZGjjRS46DaxJq2iMua0IrtaJQZGRgAlYqWB0LA6C3HwBzvEXVQYrKX7pFW
 JpKem+qgKaa8BmI45utBZl0jnLIQvv4UnLhiQv6E6cDEIBkGX7He63rCc9ffoBNqrg9QN2vC/Pq
 2wJqQkqqrPufyTw==
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

