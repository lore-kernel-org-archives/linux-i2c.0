Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8468634D4F7
	for <linux-i2c@vger.kernel.org>; Wed, 28 Jan 2026 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594109; cv=none; b=j+rr2GJAhISolMMdN2Mt7bjZgaZf4TsJoSRjRg474aGkOjnOn5Ul4rgoVtP0RpAxF/KKkGFJEdAIbIdbdY4Pf8KoWl91lX8+Fiz6unJES06bEHZ/X/YaJqrtr4XG12i2ewM3bjpg2eGTV/hrgwWMylAT8IATtgi6enodRImhl2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594109; c=relaxed/simple;
	bh=eRPT6fwWSu39UFp184/6KNALMdSEu1tiZOm0jan9AEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MnzporO+LZIW0RU5kHdkIez3dMXPwAHqjeig92lmRQzTpBPwWJKCSfpYbGLeIcgKlqi+7c8aFJGlAMcbY8LqAV3HYN1I9qY3bfdLgEojs2zADWAV5BZ0gUrekxzCybsW6JkdMiHPNMvnRamiaKnz7j85DSpLGiGyUF31f0Wa/U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXr6Nwpu; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXr6Nwpu"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59b6f04cae6so6955132e87.2
        for <linux-i2c@vger.kernel.org>; Wed, 28 Jan 2026 01:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769594106; x=1770198906; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LgqAxD6UfwmKx5Fd0jcW4Pat4uqGsb1EaPQx1jaWDA=;
        b=nXr6NwpuzH2MH/rlNcwRpksHBG6CF4FVpdfDLqnunFBY7K5K8rpNEDpU/RBAnwamch
         Z27gLLtiGjsZJmZoFjp1/cdbqXDo+Ffx96z4Sy6KMEpGwe3C6w1yZAsa06yA75gBoDdF
         746vrc5h6vIzwMstY0LJ01YpHT+bhKXCJ8WuFZOGIpAXmmCWB5zEgdkyk0TN5nWwvJOH
         Ie/ZMyT2OqB2I2WQzQ0Fq4bnz9ohocfILAJXUTb2obqxe5Du9TW0d/YHBajuQAGy7Vm5
         SflNXtX+Trlgz/yX9KyK6Nengstf8IiABgbPPsKtLxyJLAi8vZPZeLcWgSczy8/LoF4R
         MtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769594106; x=1770198906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7LgqAxD6UfwmKx5Fd0jcW4Pat4uqGsb1EaPQx1jaWDA=;
        b=YdNPOjB9cGxqHboEo2GMlKKIA+jg/0Nx2XYLVwmqKkHJBu3PoKkZNK7gHsgDCmzg8c
         HmczuJzk1tL7K3/bbpM/E2vxZvZcyGCwwVD69BpU0wSiszLZeRuAB0ctBy4bEEwhfDkr
         8TK9EJgfsVXYK0yRx9pOaSwL8kx5e0C7Cmf/K7gkGiNEsPlcuP/6pKE+WXgSGJ99y5ZP
         6kKT1xzaCERel2RA0z708adLCgVsdkd9QIyShCbfdi2JORQxi2981RDCOxr2NhilOzJ/
         M8yO8So2b+EEwVbMfncUmJ4o9GyE6OtzU4gf5u89yCof1derldKA2t85K5YJqYAHwQsq
         4U7A==
X-Gm-Message-State: AOJu0Yy8qncH1EaWcIjwEfyCRZxTrX3haxgYhxGtOTsyhAh9uPy/bQ+N
	kyZA7+cHPChR96naWG2v9TuAW81UJHZG/rpRAmQ/mFbAvbegHDQU8W3H
X-Gm-Gg: AZuq6aJNE1q17LO2L1WvTxjP0DEq6XWfsq2dXwqJJ5bV1ogQ9eUvFgrxNktm1lbc2WD
	TzI2DjOvmrI4VMSvMMyqC9Ft7q22t9UbFrSVGMfAhJdFkFagvY8wg8bcLMpGO23rkXUKpIRWmAo
	g0k5BBMeUbvbNKS39R6h0N+ChzE0S4CbkqU1wOVBZfRMEfl8+3HAuYfRo6GSvSpRDUaSsgtOOUs
	L7OfTbNMFFhvg8WmGECun/UWW44GzgLZ+fAYyjnpxBO7v6X3PwVOkxHUvm2qRrfTJg6lOyisFQ0
	GPTaMyKfu4da2frG51zVBWpjLWRwb2kaQDPzqVb7/HCut/OKez+3L2eAPNPAt3GXKdyI+S1/H6P
	SmPnuKHOioh0U/wfGVIKBcetqeeS5l39Zqk7MqMn0ZqoznnC7ctRhlKINEbSxrFpLfS8XvMW2vO
	QsJDVB5eu41hgxBFL8ju+xANQux7mKhEpluTexGy03c1feVNnO7FMQ5FoW
X-Received: by 2002:a05:6512:b28:b0:59e:92e:7d07 with SMTP id 2adb3069b0e04-59e092e7dd9mr612809e87.24.1769594105281;
        Wed, 28 Jan 2026 01:55:05 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074bfe83sm459483e87.97.2026.01.28.01.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:55:04 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 28 Jan 2026 10:54:27 +0100
Subject: [PATCH v4 1/5] i2c: core: add callback to change bus frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-i2c-mux-v4-1-dee49ce276c0@gmail.com>
References: <20260128-i2c-mux-v4-0-dee49ce276c0@gmail.com>
In-Reply-To: <20260128-i2c-mux-v4-0-dee49ce276c0@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Peter Rosin <peda@axentia.se>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1616;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=eRPT6fwWSu39UFp184/6KNALMdSEu1tiZOm0jan9AEk=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpedzehXVLc5la3fttcAt9Pf63CW8xGjrpt9Gtl
 m5Jrx2wvzCJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaXnc3gAKCRCIgE5vWV1S
 MkRqEADXrxdBsBlenpKcAm45b1vgUJl5qzd/GhpRErNbr50L14Aj7bdwJ2ihLfpLoh60Qft2yBy
 NNAl7O56qyFBmGeWfyLSQehsIh775Ud4kJ7icMlu3t8clHbjFtCrnlygOiTL6HjIHg8pQiivtRl
 GYv6hW7pFiU2cmCQ7c9PEx5J7o3WM3f3R/HWi+VS1WP7+0WGVjEV+7mnQjOFAAfpl1vtf0UfqLn
 JFXWQ9WvO1sTUUAMtAklTsoztuIL6csWXW/4KJlJV3TwmylgA+4Hojjfm7mDMrjC8VZ3e806uLk
 eG1iPk9kvJuKpkWng6bVCPmlCcocTgEtgDLe5HkAV+MUaBFldysjcJiooWse/4mvGui2ZuhfNoe
 9hsXpZqX4pxg7vHNsF+7IjgixG5VlAyB+kufL3Ul0X5m8Xh+XrMx69S0041/Eon1ROMHxWZEqBQ
 7VeysczxzbQRPSrAPv0bUHW1Aq4z9xLC2KxAzzto6P1IAdLgliqaB7W47k+dYFSEzRVlBx/RgGe
 rzPrux72Ged1sYyIBsVr8oo/WV5bKbfg69dk0jGBjUs7y7mxh87UrBeZwFgYtT4r3+xGb42CtYw
 702+BI6VraEFM4CivtIYhY1Eaay41GgmI5F/gTmMF5XX5FwzWJwTyAk1SI62UyoRViH1Uf/KiTE
 X4kYiUc2CpYCVHQ==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

All devices on the same I2C bus share the same clock line and the bus
frequency has therefor be chosen so that all attached devices are able
to tolarate that clock rate. IOW, the bus speed must be set for the
slowest attached device.

With I2C multiplexers/switches on the other hand, it would be possible
to have different "domains" that runs with different speeds.

Prepare for such a feature by provide an optional callback function to
change bus frequency.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 include/linux/i2c.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 20fd41b51d5c..d147e388dbab 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -742,6 +742,8 @@ struct i2c_adapter {
 	struct rt_mutex mux_lock;
 
 	int timeout;			/* in jiffies */
+	int clock_hz;
+	int (*set_clk_freq)(struct i2c_adapter *adap, u32 clock_hz); /* Optional */
 	int retries;
 	struct device dev;		/* the adapter device */
 	unsigned long locked_flags;	/* owned by the I2C core */
@@ -835,6 +837,17 @@ i2c_unlock_bus(struct i2c_adapter *adapter, unsigned int flags)
 	adapter->lock_ops->unlock_bus(adapter, flags);
 }
 
+static inline int
+i2c_adapter_set_clk_freq(struct i2c_adapter *adapter, u32 clock_hz)
+{
+	int ret = -EOPNOTSUPP;
+
+	if (adapter->set_clk_freq)
+		ret = adapter->set_clk_freq(adapter, clock_hz);
+
+	return ret;
+}
+
 /**
  * i2c_mark_adapter_suspended - Report suspended state of the adapter to the core
  * @adap: Adapter to mark as suspended

-- 
2.52.0

