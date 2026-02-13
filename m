Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698A230FF30
	for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980878; cv=none; b=lTwFMREP9Nnmm/9q1JH9mhzsqgRdOSchdgGTWY2ifZ8RTeRrEjMhpDiyzG0l2CdkPZCegFL8qScGuzZE80pZCe58OAC3fCtgsoRwhbGVGAtt2KV3Z4OCD9qWXbOTYP9aDL84rx9b9LPGp8CAewE9yYKliHtz/zukC69uGwPIlgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980878; c=relaxed/simple;
	bh=eRPT6fwWSu39UFp184/6KNALMdSEu1tiZOm0jan9AEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lqKWVqSUswzQT6Dxhn/XaPXtV50Lo5F0T0bs1FSDgfSVJbbvIouRsLLS6aT4AXs3yFXchfYmOwD7WRe/pKPFrGHlThJjJQxLmj4RxEVgbJyoRieKQdFqTyKHqlvhhmw0it+VhXW8d4JXj8AYJVezAfawlaysZZDRuwGg0vaLsiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8EfUbj7; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8EfUbj7"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-385c2f88618so5545801fa.2
        for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 03:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770980876; x=1771585676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LgqAxD6UfwmKx5Fd0jcW4Pat4uqGsb1EaPQx1jaWDA=;
        b=Q8EfUbj7axc7DpLQYGMwU+r0FWAefSn9l0prjb3bL0olZYVR+cRUvzw3EedpgkSHBZ
         GV4ferdk8qc+WidZjAGpeCVH24dxvN8ePxhzb6mN1AwLcPlVf3EpswBYcJFu9JapYe7t
         jl6WQ4tS/ZCEEGs158nbpJWs5gJnjwvGFF3M9YZ9QA+wDRm3ECIWqTtqYZ/sknC5D4NA
         XK4EcXAJf/kB3xNBRbIdkKVbGxZ+W5LLLYZEM+NQYxmx/Uo6A7B9kzSb4UFHvniNUEIZ
         LNoOU3+KkVnTvQBCw53GAr4vVeBYFAhrIs8VnLufPP3eiL90gdX4Zn/BggB3X8RvsgE4
         XHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770980876; x=1771585676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7LgqAxD6UfwmKx5Fd0jcW4Pat4uqGsb1EaPQx1jaWDA=;
        b=jcJ6ItnM2bg+MSYsx2TIcMT8m36iP+S0iClR3L9b225RiMvjWdihspfj3k7y157cl/
         1bNaSAmdyS9tdneKi0zMCM1ZDy/eue/3cRd8iKLRO6ITavxdyiHnO/PNEzEci0up27VX
         2kbpimYwxqxLYswS3RS73a6oTDUg2m2bnPOgQAnZXCXWj0YLKKhyP05MirHkRw+5hn4E
         NJOcxQOqxHriZBMw5hgJDfywu9Kz2Jr424Ye9B65UeyOkuDwxBAArNdiFzTysr4uNrGJ
         l4TawJHif4IocmoRFz7jYVEHHv7GYGmi5GcHPJBoGl91U9OVzIqxORQxTQEgXcVAY2OR
         Xcnw==
X-Gm-Message-State: AOJu0YyOGpXxIKniGuoSg2dCjVqcQLenqleL8ZliByIKeUdbNjO5nN/G
	5YcSF9CzYoH31XjqCmHV+ZbqTOm0IaGbO8z0jSCCRwHSanc1PxvK8Bj3
X-Gm-Gg: AZuq6aIgy1GxHGzo7n5/CzsEfKbZmkzqjiVWWnn9q/e7dxHB3/vwmd5y6Kzj/4unc3n
	TIiRtV2HMgJTl6AT2J7BOC6+icMsUFywtSA448Jz8aomX1mMxgYCnGsqpdtwpmc48lvCafrwj54
	7t6iRMkBrNtmMtuRDdBZuChb7HLVrHznDFNp/uRo8O+2G6U8gGswVnTKX/gvKW8rVLHIGLqJXpl
	qWUgKpNqAtyyWC+eQvwkmBfU7G/SksWtphe+eIwdJa02uu1FPd01RXUGgFfycj1mY3iao/i/6eo
	zb3IUzixTjrlRmyslAilRcxKbFZURrn14fRMeAWv4EtCnO9qhG20T7Z4ZsKoPbG2enK4AwTTvix
	v5QvL36BIutLrYtVm07zPPlJp1sLTdYLJi3GOWmemZAkMtNsCYOa1Ctd9yAJcck1wFnR8d+xc4F
	J/XHJVdnVNreTozkLisjfeM2foEw5CNS5pHPWaRWSV95DRwwKNTWcOvCVdZNGB9W+rDNe+
X-Received: by 2002:a05:651c:515:b0:385:b735:4fa0 with SMTP id 38308e7fff4ca-388104ed3dcmr5707731fa.7.1770980875385;
        Fri, 13 Feb 2026 03:07:55 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-387068924c3sm13635831fa.1.2026.02.13.03.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 03:07:54 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Fri, 13 Feb 2026 12:06:50 +0100
Subject: [PATCH v5 1/5] i2c: core: add callback to change bus frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-i2c-mux-v5-1-fb2cbf9979b3@gmail.com>
References: <20260213-i2c-mux-v5-0-fb2cbf9979b3@gmail.com>
In-Reply-To: <20260213-i2c-mux-v5-0-fb2cbf9979b3@gmail.com>
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
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpjwYAOcTbfDdGyuIUMkxx9uPWkK7ETY2/cJ3ME
 4K7m74QleuJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaY8GAAAKCRCIgE5vWV1S
 MqLYD/9U0GGb/59bRkWRe3Vd9n15zS9gSWS6D5pjlLovgKJzfMpAwTJCt6jhJlISgg0/ZSZCOiJ
 kT6IvfdKCas38bNpTPq06XdOIlGuWYXocy4SMUmmurTDe2RDP3wY14o2cgbe+e8alLWml701cHE
 sea+iijidaNNBFldYucq0Oo4ItfjqyEKZ64cmtt1jbu6WNDa5VYT0DDiD4YwYP3yimIeo57gASN
 W6VZvh5T84OxXFDCKXvArAgqu9/Nmz4JGrpeXXhABd3dNzdinkIRv2wbxK1BEg+Dmki/FiggZUq
 wShfC0Hy+YGNfKAXKDpOSJPnoV/suh7EPUy3nefT9XClLty4JwETs+/8uCqe5j3mXXfFLBeWKkZ
 xAkNHu2V2JbjbNxPPZLlg9XZTvLdWekZRhVbXYi5ZTiiiUx1ohpSh8Qlp65clxA+hQVCutN9yQn
 dTio5Yf24T+8S/oj0VpQNZxT3wa9JYLhR400yXtW7MrRTFaV2SVMYCbAVtC/CwyG0EYaFI+wb42
 2Y29s/Ls0SdmOvtadHSir0Wh4lZIQ197eNnrIJv6+jH7ulfberV6hREs5nStMGI7QUwxzVMtDee
 EnOUHuH37xGpsrdERAtAUT2JmTvLJnznqG4FwSVzKziv71l73MPvvcwg5PE8R7bYNH/Z2PscB4R
 Wq1P1dKs4WudEEQ==
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

