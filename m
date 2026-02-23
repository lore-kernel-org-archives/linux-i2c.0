Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B69429C327
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857231; cv=none; b=abJegKgfHbQp5SBJbnsOFOkqsJA6K+N4SDmL1rqCmgYgCWXYNjY+OSVwH4af/iHKaXFWmaNmYwuNzwEpTKmVjLPLEwRowgZEuL3gkXyYLH+uo7bOCdhvXbr1bOajiHF6qJcqjWo2XvFJlxJaQs99ib70BDNF+BWo/wDej7ThNcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857231; c=relaxed/simple;
	bh=koxBCehUmN3RuwVhQnNS8zqbXgiVP6LXVx/A/SkLKJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gTu4w7gSTknJRBRMwM8tvYWzCGSr5GMrLjvVa6ZouqVbf0YIpmWAPIbw8hSOTuq1BCo9UzJ527E33vf1RyKDChIDm+aHmNUDGT1t7tgwnSl95YRYDH0Qpj63j87M8sMDcnDFJ+Pm4ktq+dbRbS4HXPFCEa3rP3YRlWoKrLYoZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMjfayva; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMjfayva"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59e6c181402so5564312e87.3
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 06:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771857229; x=1772462029; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZXG84vOT5vo62fVrV4g27oZ8qKjWT76ti4NF1pkRLs=;
        b=HMjfayva2bCxl+G9QhT/u2KesxdhiGSp82hQ0ct5VtkLpISoCFFRVu9TfBK9OmUUtT
         lLzH4FU39qFQ/0zwG5dTe59xip0ZQ55q1vn6JTMIPYhm/pWvdYAMv67JLhQhIXMwVmeV
         mXc6v8Lq4diXbQ0ZgFgGg+eRV62fCTvDc/kXn/7mK/NCBQTmuB+EwJraNCJ51TgrYEFt
         b0z6LxjtDGG4yZB5aidWW2XrWHYTI13NG8nn846KHKgdQYeyZsPSPXVlVDkLEkWUT+v+
         grGyJC2qZUXNRUhQnL3E/IuzqyF6ToaU51LkrL7dTJT7z610jLvKPvpGjeIWVn7ywWrZ
         g+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771857229; x=1772462029;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/ZXG84vOT5vo62fVrV4g27oZ8qKjWT76ti4NF1pkRLs=;
        b=huyOpoPiJWl/r9QINawMbiajpnvZbaCzin30fdhav46b2uC6EWu9mM/PNV9LPnexin
         cqylIAA/sfqtQFJTqZ5lxI7TWtgEsxqVOtcCHmVsMNG0bXBug9LA0acHxk3nKlAvwWQ+
         yFvBtH15GCbdCEg0BqN54ExDmnfPG7GZPYIEKyFrIHoCDMLaPo914M9YZ7/XCXXM0Gjs
         0g1tSdwZ34YmoUZ02TssJbqti4xktJdc1C75k3Xa92dZPcB7EjwoKIP8++5XBzc+zejq
         wyyG/+lM5SCO3KdmRDiMOy1Y05sB+3v1nkQBtj0MPojJY2I6Vx15ZxaFC3BFJFBpCRbO
         k3wQ==
X-Gm-Message-State: AOJu0YwvVUad6wwF7kOkGc+/jaaaNLJmD2WsX4eHnGDmC9siA1pi+KNz
	6XzGzg4/ovhqSUCkI33gcZzqtbmQgqaCRnLbJGEi5YJ7mzi6cDydWUja
X-Gm-Gg: AZuq6aJyplipDru4UBrJp8fVP59f48k3pQJg448eLQJ52u6Mf1AT09mvwb8w/9n3YBL
	YMZgcN0XZSwdhmhwjfMfrrHHS/vWHSFLoh6rL5R3j6wsUkpqhkuh4ABJkgrPnBUqWzpl2Iw83W2
	UBRKyGdQm4osD55/NPgrQx1vWYMYx1RA0ptau8Tiq+XWXZo1dY/E97Sh+InhC6H4Ih5vOFYrjMx
	VaWGlx0Z+IsJoRtKyQOqhBCly6uF0XqkEAwo6Ke22uwUL1QtDLxFt28VLeMWx+pQnCEz7AeI2EN
	pOOHW7YdqQzJJ+ZLe2/qZy8D+FGO8YNr6cuHFbnpgRVQ9P3VEZLrk/isRZ1PyxebDVha9TlfYE2
	3uAzPOWSt8I4V7hbxeXeIEZcezAMNuPOGegr4h5JJUeU/cDfvIrnKDrL+JmbkedlEvZAVx649si
	qMemhklRdfarfqpeRx8Q5yutrESElbGf6yUDQrLR6CZ3Ns46wVs5XdTXsGRBNG303Xvl5L
X-Received: by 2002:a05:6512:3091:b0:59f:6c3b:6d3c with SMTP id 2adb3069b0e04-5a0ed8a0556mr2804029e87.29.1771857228506;
        Mon, 23 Feb 2026 06:33:48 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb16344sm1631709e87.37.2026.02.23.06.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:33:47 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 23 Feb 2026 15:33:50 +0100
Subject: [PATCH v7 1/5] i2c: core: add callback to change bus frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-mux-v7-1-ec75b214718a@gmail.com>
References: <20260223-i2c-mux-v7-0-ec75b214718a@gmail.com>
In-Reply-To: <20260223-i2c-mux-v7-0-ec75b214718a@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2473;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=koxBCehUmN3RuwVhQnNS8zqbXgiVP6LXVx/A/SkLKJU=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpnGVU3pImY+NWazZLlexByac0kY/hMMlKtqzJv
 e9xVfT04j6JAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaZxlVAAKCRCIgE5vWV1S
 MhosD/0XnbcAzCIPj1635aCrdLCtY5TJLNP8ObSXOAaHcIKi3jRWMFcPXPmuEYnvcHxyZrQtThM
 gVckS2NTcVX+3Cj0fblydVNv70lOKxRPlYjnXNkjXF7N27AvOb2A5eY5URJ2bYNOMLFftfWOhkE
 QREkYMV5eSG/PJuTDkdgg87uy3FjuLlYxzrYTAzr5Dkzlfq9QM+2gYNrcNMzIbcEwpGAIDHAgcW
 STCAV325YoV0LVvczNkH+4MwSnjM5GBIPHvry/wFKppUwjsWphoPWYMXBIYWn3AW2pmuI4n5gbI
 NQmoRzcphKsMKFTmtF68krmuqEqO6BagZKhsG7BmEXLPIQQRuNvpd8/IKGuFTH98zLkYULRIBhx
 SrvfgNqKRrqtEtI+FjstCJxw7knWC3jIF9kSYNKyjgLbXIXqZkIf3capDa2uZTgzkKSRxrZWdkB
 s05Qxa65bq1RyNzVEkFL5tpbOwXLprRFJ7+lLL+/JoNhMkXihwy+rBeQjABrHIttue9u7jnI7Bz
 cILhNd+Il6GTNL5czhX3PbBI4VMt9U7yCUylUgTLJMrWOWeb6nfYrpuMoB+KEOFoHSZ2VXIdGyD
 bilSw+JZ0VvDLxOK+SazGOYHERiYfMwtpJWM5znhM7XJlvIRNMYePCr5cvCwLbdTN9UfqWYaLir
 AMnPiXBBEk5N6Sw==
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
 include/linux/i2c.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 20fd41b51d5c..f81decb3f1f7 100644
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
@@ -835,6 +837,38 @@ i2c_unlock_bus(struct i2c_adapter *adapter, unsigned int flags)
 	adapter->lock_ops->unlock_bus(adapter, flags);
 }
 
+static inline int
+__i2c_adapter_set_clk_freq(struct i2c_adapter *adapter, u32 clock_hz)
+{
+	if (adapter->set_clk_freq)
+		return adapter->set_clk_freq(adapter, clock_hz);
+
+	/*
+	 * If the adapter is a root adapter without set_clk_freq implemented, this feature is not
+	 * supported
+	 */
+	if (!i2c_parent_is_i2c_adapter(adapter))
+		return -EOPNOTSUPP;
+
+	/* Update the clock_hz for non-root adapters, even if set_clk_freq is not implemented,
+	 * to allow * the clock frequency to be propagated to root adapters that do support it.
+	 */
+	adapter->clock_hz = clock_hz;
+	return 0;
+}
+
+static inline int
+i2c_adapter_set_clk_freq(struct i2c_adapter *adapter, u32 clock_hz)
+{
+	int ret;
+
+	i2c_lock_bus(adapter, I2C_LOCK_SEGMENT);
+	ret = __i2c_adapter_set_clk_freq(adapter, clock_hz);
+	i2c_unlock_bus(adapter, I2C_LOCK_SEGMENT);
+
+	return ret;
+}
+
 /**
  * i2c_mark_adapter_suspended - Report suspended state of the adapter to the core
  * @adap: Adapter to mark as suspended

-- 
2.52.0

