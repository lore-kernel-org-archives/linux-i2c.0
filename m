Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958291DBB3A
	for <linux-i2c@vger.kernel.org>; Mon, 16 Feb 2026 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771245516; cv=none; b=f5ZtmYxzIKfThEuSR8LODQG0nuW6aX4ElRt9Y4RKBvF79svGottcs74VdlZnZmmOvXOQA/tQVqV/Pzw7GqHPUVNY0zfWcaqBkKyJHAB1L9RdFIwJv+3gPCpojqpwUm8wka+3lAYFYULMgNU+ds+oDDPwpGCe/a+7as4Q0T5UtsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771245516; c=relaxed/simple;
	bh=WkfZrlH2rNxO52cLVhBbxQV4YB4czTBtNoYoTszUuMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=adZW1D1PhhVH1xsWeot42VCNBx8/hf56IqlgTo2YK7PKB9EGjK9KS+9xFRs3ahkKqmwUnzYwlhR5Ou/WDkDK2cRZQRP1E1Pxhydr2EDFuf+LUGhaQdI+jj/uJxbmNMy2XP6B3M0YMTUY8wA5rSSrtxXnzhgayj/b5bmaz8CrJ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRskJvEo; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRskJvEo"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59dcdf60427so3074047e87.3
        for <linux-i2c@vger.kernel.org>; Mon, 16 Feb 2026 04:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771245513; x=1771850313; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbwGPJS9piP3D1IROOiA3tAkFtRzDUpcLnnixg8UsRc=;
        b=SRskJvEo+A8t/LZIWyd9rZ8tWUYQHovHlhCTKeETdl2HftZnhqg2dmd+2S0LVoI9w0
         N7G/NkQloUuCGQsbH4tYy7ojZIDO+0AgIaqd/ptjKcqrxr8PVtIIFjRMpnZCJejz9/ao
         A06j+VK69gITf6Bz0oVGl7Ivur3/e2X4eQc3zRflDnogYhjRWQXcdeENCGbkUPOj4ckC
         KW6KX9oU2eHX7Qp+eF3c6+A+fSmyvnTMsAW92qDy3HlwkBnGlbWEt3SE2PXe00YLTQIm
         HneuHhPhdo7N6YnSGppULDpxoHme8Suk0ODIgakdm8rl/pXtN1TVpDdGdz7alkWGD/fy
         tQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771245513; x=1771850313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JbwGPJS9piP3D1IROOiA3tAkFtRzDUpcLnnixg8UsRc=;
        b=O2oIsiSoSq2HQ0AvsmIjYS3TmqlmNrN4RZDM6/wEF+EFBmin3eZ6tIGPARYS5T7zBo
         XGW4xywVTEfLQRvDw5y0y1xF4LaHgWBG5WRKgncbJtKhrg6Am9lfzgYZitScDCn42Wav
         a/aPKR+E2JfMTYJ7vfuJczQJ2Z5I8C66yGh+rEj9YhIIku6ahRovOyOvjg4CO0AdovyH
         hfyqPFeMCnc3CXXb/JQddtGH+gw1nQxMdj3Ie3JYPWi22jBHvPb5QeBFULx7NYXaJX1D
         sP0jtMw2oP3z0/LLxoc2om/ZQmDFL7yG23gA8/paPxDy9xsG8GRp411IP/scoJUxqBvB
         Ywgw==
X-Gm-Message-State: AOJu0YyRgC7PFMngSDW76QNeyPGDX8XnvxAmeOe6iumqoMOLKz3/UrH1
	Pf02VKivL5e/5XR03jqRlB/eA2Sj0eNowefJcHoowcfqv3kdaeGW7b2J
X-Gm-Gg: AZuq6aJrLO+kn7646gzY/9AVsRO5ao2ZQF5Wlcox0CySVn6UgJUDaE9vnljbNnM5P75
	4u0B839xfSFNzOyVKETlBx6cjqGYnvMaJvfTOLHfYXq9Fye2oNEGW3V8iMYhvhQJpB99vpVDlol
	hRzRQcI+r9YvRHMgdTwOdWm1pVgQMjn3WNSt4VK14pOWIPzpRzkUguWmodFLvTCihewvGkD9wwW
	ZHg30R3jf4GhEZQ4E7Ok9/K6E6HYn/EVumHaG062gznDg/zip7aEQRQTAogJ2trZQRdw523BI7v
	/flPFdXIYLGQEaZksIdV3FXfoZscbdURaX0SxNkNEpcNVfgnaTy2w5c7JP2S8iOsBqBwSNDKJZH
	6KlOCIL8PY/T+XACMBLo5W2mQicPcfBd+QGap5TkOAMpxnBMoNDa43VQP3w2XkzOveKy32+/ZSy
	876z10Gi3kIeG5us079eTpJvYes0g3znpoLbPImMVFK+oig5M6saZIruSqQWDpORzdto8M
X-Received: by 2002:a05:6512:304e:b0:59e:4f92:5df3 with SMTP id 2adb3069b0e04-59f69c3e23bmr3523627e87.10.1771245512608;
        Mon, 16 Feb 2026 04:38:32 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5b0577sm3175920e87.71.2026.02.16.04.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 04:38:31 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 16 Feb 2026 13:38:13 +0100
Subject: [PATCH v6 1/5] i2c: core: add callback to change bus frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-i2c-mux-v6-1-9be28ecfd7e3@gmail.com>
References: <20260216-i2c-mux-v6-0-9be28ecfd7e3@gmail.com>
In-Reply-To: <20260216-i2c-mux-v6-0-9be28ecfd7e3@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Peter Rosin <peda@axentia.se>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1764;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=WkfZrlH2rNxO52cLVhBbxQV4YB4czTBtNoYoTszUuMI=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpkw/D8XNVBduW5ufUR8JhzXfBil47yj9Ci1zpG
 4/9/BCAdEiJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaZMPwwAKCRCIgE5vWV1S
 MgXrEACCHJ+y+6aLdIWIBMz34AfkkMC771/Z6hrN3cqelZgrb9vN0zqBmObTMGEu3VadlDCSYc/
 2G7HIhieoPs4fGw6lFRrCCZJIasm5dYdjtijFatEYNAzBbBAESjBkgnZ5FQMPeBcN4UgzyqkXoa
 aVgxbBUkmyI8D/ogiGbk4GPxj9Jo0nPjIA8M+L1qmzQnErkUfcAGLPujf4XS2gmHeP3p3iOkuq5
 vCwvoDF8rGxxg1+afj2qFcHyOmxG5RBoACtOPqjgF5lsCH6CQLLMuS9JzhBZLR7266zwVy0iw0u
 RSf2j5WG/a92luoD7bYTsNgk00OT/ui8Jp3OtDEm9Ymz9han/CMpIBgguDihueQTfT94s0bkuyb
 ARzbB3lbgtUzbykrepTWPBnW2HnotrzpQkp/sNkylvmGy1iCxbQHNrkvB8EUL9RIRHaZxvGCaX7
 6F/fsdYJ+zYJrdPD4VfX/ZG63BGYDP6TkbgpLjsC8BA2LL5uu5jLY/d6YuZ9MpKZw/qjIQ+nykV
 DeXke1t1sMW2KzlP/2I3LPb2k4LT1x6GDXKEfLo3DW3wBrp6/12xuKlGJ0GaKiJxtpuZdUG2jru
 1LADLtBvuP5IbfTuWWsEbUW3vhOQAhQ0iKTcZcyQv3Xx8ef1U23u3jSa1gnk1IL797zh4O9nHM1
 f47YQotq9GW+u2g==
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

As a side effect, several bus drivers keep the bus speed in a
private structure and can now have this value stored in a uniform way
instead.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 include/linux/i2c.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 20fd41b51d5c..87654fab2f1b 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -742,6 +742,8 @@ struct i2c_adapter {
 	struct rt_mutex mux_lock;
 
 	int timeout;			/* in jiffies */
+	u32 clock_hz;			/* bus clock speed */
+	int (*set_clk_freq)(struct i2c_adapter *adap, u32 clock_hz); /* Optional */
 	int retries;
 	struct device dev;		/* the adapter device */
 	unsigned long locked_flags;	/* owned by the I2C core */
@@ -835,6 +837,15 @@ i2c_unlock_bus(struct i2c_adapter *adapter, unsigned int flags)
 	adapter->lock_ops->unlock_bus(adapter, flags);
 }
 
+static inline int
+i2c_adapter_set_clk_freq(struct i2c_adapter *adapter, u32 clock_hz)
+{
+	if (adapter->set_clk_freq)
+		return adapter->set_clk_freq(adapter, clock_hz);
+
+	return -EOPNOTSUPP;
+}
+
 /**
  * i2c_mark_adapter_suspended - Report suspended state of the adapter to the core
  * @adap: Adapter to mark as suspended

-- 
2.52.0

