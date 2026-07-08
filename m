Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D089343DA2D
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783513011; cv=none; b=RzZTdgV+nsa9adjrw3ToqZlYqDI0vEOOaDLhgfIH+hM7DclTIyIg3pVbX9+dMh7ZHfr/dq6KcT+Q7Qw0FZyi+gAcV/HCZjIF/RomWpXJIKBEaLF+etIVWHL+f5LUUkX5dSshUThEYLd1XJq9yN7FypbSmuZ9ObnQ53hVtS4DMlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783513011; c=relaxed/simple;
	bh=ZxPMsqSzC6U0Vp6f0tS25bdKvZHfqwU18TXuNJQFtdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ok1Fgk1cnmYGkvLSnaIk2xMUIWkRUvYpdS62yKo2OyiSoh6IxXbe7gueY6fI4ljwNm5KSrj0L34ypG3FlJ+1j4mnUYS6KQXJkSfvpA3fH1Nq4i/4Ms33O214ZIk5G6jjdXKu/ObGhvUmcXb2USVDbLqrEJgc4m9B8fQSRTbeBWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UITsSQPA; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UITsSQPA"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aebba706b3so738407e87.0
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 05:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783513008; x=1784117808; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QvewnpOsLjrZCg1uQPoBXdF7ZUbQt8CHA9+FuuFeSOg=;
        b=UITsSQPAj8ifvqOTwQb7pz76Qev7EcFJHSfqAV1JKWggXfyH+nyS72PhoSzrKXp7Hf
         k0sHM3ATKBYjdW9dzB09VOaJe/ZwWJgiVpY4xOIXbIJvLaf4EXDHnvWvsj5uAgOEaNXJ
         fiuuj2cA5tpVWWrxPBsdyELmtxBoFU+DThN/3GG9wCNUPamHX4km9iEgOPkaDqIPUijp
         1bll+wg4Di2GlIJwz3pJzs1vn2OxyadrPGWNPH9jq6Ulvs7Zv+gNBdEKgBL7t9lL5ejv
         jn2vOCbrbO+z/JW3JwprvGFtVEucAl44nuENQ3Gfr8Z6lCpUu7xlyxjwBxYN1Ufwsqm6
         mi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783513008; x=1784117808;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QvewnpOsLjrZCg1uQPoBXdF7ZUbQt8CHA9+FuuFeSOg=;
        b=XYnzytuapZztGdfK/gS5PicPWesLDzq5TsBxAxEFffPNRTAfGY3p1kgITSpQUOJTcW
         enCmPTpE0mSi92qdFT8qy0Y2vhv9+96Wsl/EorCdls0VLe3puJOOSpD+MIeCUin0+Gpe
         hCS3/ZdX5IO/RWYhd+zrS1lJrP38goGT/RaWL/OlfqNamgUdVjxzNuWXhSn3WSadjrDi
         ja4nuTQ3UB1L2dxbBFoIowhqnE+nHpIMZe0llC8S9brL7QML949X6DXdBgLeDi7cGpG0
         63/pTuedDvJg+p4aDdKp+U5EICDE5NlDUPMcAwW4ZT5frqMuMu79WdlUtJ/cTjl2pThN
         vstA==
X-Gm-Message-State: AOJu0YxbZSUZSHWPV+P272/Qu1hI+Q+X51NX+6/wnln9dUnNathHCVaq
	zUC9Qqmf+2Hz5EBF9HGH1d64XNVyUjUuhiyA/S8EeYV6rUfsSdmwQQwa
X-Gm-Gg: AfdE7cm/gdr2YWcg1dABU/wZnLS7zhqogfsSfaLk1ZJf/YuVbXy3M+TZJGRjPUlchhp
	U0DaQp2I8TjAa/z4agOzbegiAf1gd6luKaYRUy0+W7Jg1ewqP+wxHF4cepnfoMjE0Q2SK7P16Rc
	dknhBTo83+KEtf4GU8NNZ6nDGcjwkDxBOttrHc/sX5XHpI1HsPgqJIWRz5dWSWh5L3erpg8eNMo
	pW4NRhnPbXvxyN9UG8uRETeqyC99Z7SVSzv5OcdiDZdgZanbgpgzNOpzBPr9+J+lIJMVwRdiLow
	U/swB/4nSpDjTFbxn0/0BRVOOWvJz7Z/ElAVTfJoTzxVYiWtZMsu6VvU4OQ/nZhTaxC/4chLreB
	6OlEem+4dSHT5SBsL48T8VLH2BQGyEI5pS/Sz7wjt3DTctl1gYNXSeFubXws4Xyt8+DkCZKXYrr
	AZygCE0bzKQ1kbUHMaOHvPIeqXnYc4Xz4niDZJ09q8b+7TK/8nhiKbcnt6BQ==
X-Received: by 2002:a05:6512:4507:b0:5aa:5ef9:a33 with SMTP id 2adb3069b0e04-5b011480498mr670797e87.25.1783513007721;
        Wed, 08 Jul 2026 05:16:47 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13bbbc6sm4471459e87.41.2026.07.08.05.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 05:16:47 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 08 Jul 2026 14:16:15 +0200
Subject: [PATCH v10 3/7] i2c: mux: add support for per channel bus
 frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-i2c-mux-v10-3-09dca03c8a15@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9221;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=ZxPMsqSzC6U0Vp6f0tS25bdKvZHfqwU18TXuNJQFtdw=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBqTj+dIHYCYf2k+Po4HGgt0dZnjbHSOBEeuOGpj
 e/FO7EtiZGJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCak4/nQAKCRCIgE5vWV1S
 MvWuD/0eh6q51w6kcI6+7cnmxB3vllQjpURMjqBJ9UFa/gcDH4uFJndEhosctJb7Wy2gmgt4Ijt
 WculcqTFzlO3Y3WNwagr72dAI4+6dnDRhBCA+MAFZJYeWBlIwbu87gCQU5hSN5sjY9aB/auinnQ
 yMd9wkjsohtT8TmOTEXt6ma0qdj2IYACBpP5rBQv8jEVtEPUqA+9Xih6g0uaJn0/u00gc5E487+
 N//nOz+fCslE7saqSvF1YiMyqEG9xjiTO5sG8P19JbhOwdDY4p2o2uIakUvdYGu5+0drhRkr8h4
 I3K1Nc/kDPGWAoM+D5X+godJkqB5fOVz84wRQzZBpNtnUA3aOXnuvEfjtEQNUum/S29I+PukbDd
 /GCfBJRYVs9kBMOmaBtn1KNyn89agt+1sEPA8Wp0//tuD6n5nEnSIoZ/gE1kvxRNaH0J+peos+D
 pfw2RKaLez1kxmZsg6W5Uaby6xYCGqXwefpAa50PAAUV8iIROP9f1/e/vsUdOE2vb2re53YrSMm
 Uvdf7xuWjmK937GIKbPq+3z6aJke0yK8sE9TC4vqP5aXthmzJfDoJVrgjYkAnlJwL6osG/OyOcr
 ooseSXtEidmrBNM+BztzEnZ0IlMKL3+ZuBCIX4RXevc06F1jHvHTH9Bpq0vl5irljZJb4yxKVRz
 0ZjI7LYyrMBTfrw==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

There may be several reasons why you may need to use a certain speed
on an I2C bus. E.g.

- When several devices are attached to the bus, the speed must be
  selected according to the slowest device.

- Electrical conditions may limit the usable speed on the bus for
  different reasons.

With an I2C multiplexer, it is possible to group the attached devices
after their preferred speed by e.g. putting all "slow" devices on a
separate channel on the multiplexer.

Consider the following topology:

                      .----------. 100kHz .--------.
    .--------. 400kHz |          |--------| dev D1 |
    |  root  |--+-----| I2C MUX  |        '--------'
    '--------'  |     |          |--. 400kHz .--------.
                |     '----------'  '-------| dev D2 |
                |  .--------.               '--------'
                '--| dev D3 |
                   '--------'

One requirement with this design is that a multiplexer may only use the
same or lower bus speed as its parent.
Otherwise, if the multiplexer would have to increase the bus frequency,
then all siblings (D3 in this case) would run into a clock speed it may
not support.

The bus frequency for each channel is set in the devicetree. As the
i2c-mux bindings import the i2c-controller schema, the clock-frequency
property is already allowed.
If no clock-frequency property is set, the channel inherits their parent
bus speed.

The following example uses dt bindings to illustrate the topology above:

    i2c {
	clock-frequency = <400000>;

        i2c-mux {
            i2c@0 {
                clock-frequency = <100000>;

                D1 {
                    ...
                };
            };

            i2c@1 {
                D2 {
                  ...
                };
            };
        };

        D3 {
            ...
        }
    };

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/i2c/i2c-mux.c | 161 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 149 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index edf16683dc83..48ecb11f4a99 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -36,21 +36,118 @@ struct i2c_mux_priv {
 	u32 chan_id;
 };
 
+static inline int
+__i2c_adapter_set_clk_freq(struct i2c_adapter *adapter, u32 clock_hz)
+{
+	/* If the clock frequency is already set to the requested value, do nothing. */
+	if (adapter->clock_hz == clock_hz)
+		return 0;
+
+	if (adapter->set_clk_freq) {
+		adapter->clock_hz = adapter->set_clk_freq(adapter, clock_hz);
+		if (adapter->clock_hz != clock_hz)
+			dev_warn(&adapter->dev, "Could not set requested frequency. Requested %uHz, got %uHz\n",
+				 clock_hz, adapter->clock_hz);
+
+		return 0;
+	}
+
+	/*
+	 * If the adapter is a root adapter without .set_clk_freq() implemented, this feature is not
+	 * supported.
+	 */
+	if (!i2c_parent_is_i2c_adapter(adapter))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Update the clock_hz for non-root adapters, even if .set_clk_freq() is not implemented,
+	 * to allow the clock frequency to be propagated to root adapters that do support it.
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
+static int i2c_mux_select_chan(struct i2c_adapter *adap, u32 chan_id, u32 *oldclock)
+{
+	struct i2c_mux_priv *priv = adap->algo_data;
+	struct i2c_mux_core *muxc = priv->muxc;
+	struct i2c_adapter *parent = muxc->parent;
+	int ret;
+
+	if (priv->adap.clock_hz && priv->adap.clock_hz < parent->clock_hz) {
+		*oldclock = parent->clock_hz;
+
+		if (muxc->mux_locked)
+			ret = i2c_adapter_set_clk_freq(parent, priv->adap.clock_hz);
+		else
+			ret = __i2c_adapter_set_clk_freq(parent, priv->adap.clock_hz);
+
+		dev_dbg(&adap->dev, "Set clock frequency %uHz on %s\n",
+			priv->adap.clock_hz, parent->name);
+
+		if (ret)
+			dev_err(&adap->dev,
+				"Failed to set clock frequency %uHz on adapter %s: %d\n",
+				*oldclock, parent->name, ret);
+	}
+
+	return muxc->select(muxc, priv->chan_id);
+}
+
+static void i2c_mux_deselect_chan(struct i2c_adapter *adap, u32 chan_id, u32 oldclock)
+{
+	struct i2c_mux_priv *priv = adap->algo_data;
+	struct i2c_mux_core *muxc = priv->muxc;
+	struct i2c_adapter *parent = muxc->parent;
+	int ret;
+
+	if (muxc->deselect)
+		muxc->deselect(muxc, priv->chan_id);
+
+	if (oldclock && oldclock != priv->adap.clock_hz) {
+		if (muxc->mux_locked)
+			ret = i2c_adapter_set_clk_freq(parent, oldclock);
+		else
+			ret = __i2c_adapter_set_clk_freq(parent, oldclock);
+
+		dev_dbg(&adap->dev, "Restored clock frequency %uHz on %s\n",
+			oldclock, parent->name);
+
+		if (ret)
+			dev_err(&adap->dev,
+				"Failed to set clock frequency %uHz on adapter %s: %d\n",
+				oldclock, parent->name, ret);
+	}
+}
+
 static int __i2c_mux_master_xfer(struct i2c_adapter *adap,
 				 struct i2c_msg msgs[], int num)
 {
 	struct i2c_mux_priv *priv = adap->algo_data;
 	struct i2c_mux_core *muxc = priv->muxc;
 	struct i2c_adapter *parent = muxc->parent;
+	u32 oldclock = 0;
 	int ret;
 
 	/* Switch to the right mux port and perform the transfer. */
 
-	ret = muxc->select(muxc, priv->chan_id);
+	ret = i2c_mux_select_chan(adap, priv->chan_id, &oldclock);
 	if (ret >= 0)
 		ret = __i2c_transfer(parent, msgs, num);
-	if (muxc->deselect)
-		muxc->deselect(muxc, priv->chan_id);
+
+	i2c_mux_deselect_chan(adap, priv->chan_id, oldclock);
 
 	return ret;
 }
@@ -61,15 +158,16 @@ static int i2c_mux_master_xfer(struct i2c_adapter *adap,
 	struct i2c_mux_priv *priv = adap->algo_data;
 	struct i2c_mux_core *muxc = priv->muxc;
 	struct i2c_adapter *parent = muxc->parent;
+	u32 oldclock = 0;
 	int ret;
 
 	/* Switch to the right mux port and perform the transfer. */
 
-	ret = muxc->select(muxc, priv->chan_id);
+	ret = i2c_mux_select_chan(adap, priv->chan_id, &oldclock);
 	if (ret >= 0)
 		ret = i2c_transfer(parent, msgs, num);
-	if (muxc->deselect)
-		muxc->deselect(muxc, priv->chan_id);
+
+	i2c_mux_deselect_chan(adap, priv->chan_id, oldclock);
 
 	return ret;
 }
@@ -82,16 +180,17 @@ static int __i2c_mux_smbus_xfer(struct i2c_adapter *adap,
 	struct i2c_mux_priv *priv = adap->algo_data;
 	struct i2c_mux_core *muxc = priv->muxc;
 	struct i2c_adapter *parent = muxc->parent;
+	u32 oldclock = 0;
 	int ret;
 
 	/* Select the right mux port and perform the transfer. */
 
-	ret = muxc->select(muxc, priv->chan_id);
+	ret = i2c_mux_select_chan(adap, priv->chan_id, &oldclock);
 	if (ret >= 0)
 		ret = __i2c_smbus_xfer(parent, addr, flags,
 				       read_write, command, size, data);
-	if (muxc->deselect)
-		muxc->deselect(muxc, priv->chan_id);
+
+	i2c_mux_deselect_chan(adap, priv->chan_id, oldclock);
 
 	return ret;
 }
@@ -104,16 +203,17 @@ static int i2c_mux_smbus_xfer(struct i2c_adapter *adap,
 	struct i2c_mux_priv *priv = adap->algo_data;
 	struct i2c_mux_core *muxc = priv->muxc;
 	struct i2c_adapter *parent = muxc->parent;
+	u32 oldclock = 0;
 	int ret;
 
 	/* Select the right mux port and perform the transfer. */
 
-	ret = muxc->select(muxc, priv->chan_id);
+	ret = i2c_mux_select_chan(adap, priv->chan_id, &oldclock);
 	if (ret >= 0)
 		ret = i2c_smbus_xfer(parent, addr, flags,
 				     read_write, command, size, data);
-	if (muxc->deselect)
-		muxc->deselect(muxc, priv->chan_id);
+
+	i2c_mux_deselect_chan(adap, priv->chan_id, oldclock);
 
 	return ret;
 }
@@ -363,6 +463,43 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 			}
 		}
 
+		of_property_read_u32(child, "clock-frequency", &priv->adap.clock_hz);
+
+		/* If the mux adapter has no clock-frequency property, inherit from parent */
+		if (!priv->adap.clock_hz)
+			priv->adap.clock_hz = parent->clock_hz;
+
+		if (priv->adap.clock_hz < parent->clock_hz)
+			if (muxc->idle_state != MUX_IDLE_DISCONNECT ||
+			    muxc->idle_state == chan_id) {
+				dev_err(muxc->dev,
+					 "channel %u has improper idle state for this configuration\n",
+					 chan_id);
+				of_node_put(mux_node);
+				ret = -EINVAL;
+				goto err_free_priv;
+			}
+
+		/*
+		 * Warn if the mux adapter is not parent-locked as
+		 * this may cause issues for some hardware topologies.
+		 */
+		if ((priv->adap.clock_hz < parent->clock_hz) && muxc->mux_locked)
+			dev_warn(muxc->dev,
+				 "channel %u is slower than parent on a non parent-locked mux\n",
+				 chan_id);
+
+		/* We don't support mux adapters faster than their parent */
+		if (priv->adap.clock_hz > parent->clock_hz) {
+			dev_err(muxc->dev,
+				"channel (%u) is faster (%u) than parent (%u)\n",
+				chan_id, priv->adap.clock_hz, parent->clock_hz);
+
+			of_node_put(mux_node);
+			ret = -EINVAL;
+			goto err_free_priv;
+		}
+
 		priv->adap.dev.of_node = child;
 		of_node_put(mux_node);
 	}

-- 
2.54.0

