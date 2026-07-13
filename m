Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1272336E484
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927242; cv=none; b=Sh2qWg25yD9Mt3SLDqI7eRkJllzrOIryid70oYFOo6NivQ/moyX1iRn4wHPajUot17+j0GARkDjpxU4C2ApHmw1k3w8IbPHoc6C4SRNxzXjjt+Sn84hOnD8E6fHZNju3V4r/SlYf7Qb1TJDYwPkdLSqbqLD5M5wIt/V0t1zi2lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927242; c=relaxed/simple;
	bh=ZxPMsqSzC6U0Vp6f0tS25bdKvZHfqwU18TXuNJQFtdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W0iJsHzHdRX7WnhCWfZJ6Pu/ZK5QlQzKVekmMXE87qEIMV7BOt8LlwYApKSCfZqebuZPrBdrvSvpYW6ye7qRbBIgweLKg1eKEY5inhLZM19UfRwTsL/5nuJ7kNoYBCOQ0zuFK/cbi8bWaj+banzK7IOYIlZh81Riub+KGCbmPUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoRjn1ua; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoRjn1ua"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c62764c7cso31571021fa.0
        for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 00:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783927238; x=1784532038; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QvewnpOsLjrZCg1uQPoBXdF7ZUbQt8CHA9+FuuFeSOg=;
        b=WoRjn1uaxYU3GUGNc4Q7Q6MtkztpEB0EmkjnZfsG/1avSy/jytCAaq0d5NaFZsjP47
         q4P5UMOL43pnchYxYqA8RhGK9bPhW3snnpEuGUX+rCYbFY0hEukD+XZwO2VD4ZF6qBKS
         rDu8sFPs2281yuSfEw8lyPKBNxiHh+4Rt73vRx96jKTti8dilVjOIrvptzKqwN9JqBHj
         as23upRM+u63SJqOof5vBBoP9JjjqrPVJlyEyPWyEVCrI1ekSBdHHEJJ04Aqca2r6rQZ
         uGXQJrXdVBeC212lfx3o8rLsLcqe+l6x5+mF+YActpVjKIrCRBdK9HuyWUqo65p3h5C3
         Q3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927238; x=1784532038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QvewnpOsLjrZCg1uQPoBXdF7ZUbQt8CHA9+FuuFeSOg=;
        b=AUg6DmjICdXxPYP5op16OAvw0y2L45jIx3Z3eIdLSbHna6ij1EctvisRyH2ULEmdOb
         tXL3kDuRgSvQ0hzXG/jNsPOGlsamzmYa8MKDO6vcrWZC72LlfHVGcCd9N2YjmU/JtqP9
         rOz+oKK1nVKeD57D7Mv9vcqm0y4FUfTNqateN1OEsyk8wjPUHht6jqdKq6JA2BSL7aFA
         lS3cr0jHR81O3fklYZk+XKhbtVXu8K3nw09RFejhHduw//uF+x1xY7ashzggV/S9SaOk
         uJ7HafGR4yhlmUilXVFQLW2yGb7rk0gF3S+RU0BVr0otUJNnBselqIrBoCaSiMQ5IOny
         lpCQ==
X-Gm-Message-State: AOJu0Yz/aEfQ6HnrHpvQytCc9PnJHHG5/IUDJzwVV+jH6QfLpOOjYGdS
	VVIB5aBWUykctfnStAqWD+vkLpYfSElelcnSJEyr1tI2K4j26dTQjeX0
X-Gm-Gg: AfdE7clkCGV3RHHKsi5NQLmp+sGfFFLLq4G+uxDrtHpoaeaY6BfvgPxLsnMPzdM8V0E
	f2I8yeuscISqPOon9sUnBhgJtI6EYumsKk97o8tAHX8M1Y2gYigukqnhcwMrlIPHcfnnzxuXba3
	IsmAsl21OaPhT2tphqQ6QDstVXBtP5K/wW+6l+ruEIfksOnmRalrDUbw4hUuWjv4KszNvDvPM86
	U5eF//TK411UwbDZsRaybyXntSgzoerzppWEwiP67TZ+NHTo75di3bFOcZPn4fOaxXF/aICJkUr
	MDZSatMR09e0Q5Q/xVXjdJH6CDKyZ8HTsJ7BERCG++BOOtM5mVQEbzF60wSe6Qoo3AYjkMsfimU
	KpfKImU5IpJElzdjXfiDUjmJJFNrMBpyuiUu9aB1TjDRaRs21zCayhNy7x577xuUQelwtGkU9Pe
	gPbAl93c7/1raJMOaC6yeKJN4sPcCfOG8pUM4wSlq0lHmM5W25dJS2rgLlrQ==
X-Received: by 2002:a05:6512:400a:b0:5ae:b018:6a37 with SMTP id 2adb3069b0e04-5b023d119abmr1701966e87.12.1783927238018;
        Mon, 13 Jul 2026 00:20:38 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca55723sm2625636e87.35.2026.07.13.00.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:20:37 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 13 Jul 2026 09:19:59 +0200
Subject: [PATCH v11 3/7] i2c: mux: add support for per channel bus
 frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-i2c-mux-v11-3-72bb8af8ee8c@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9221;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=ZxPMsqSzC6U0Vp6f0tS25bdKvZHfqwU18TXuNJQFtdw=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBqVJG7lD2w3RsN1ew2PshvwJ6WTBJg07Y/Bp9tR
 9Aj6tVkCeuJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCalSRuwAKCRCIgE5vWV1S
 MuIgD/kB+HHqt47X203VsYvw8K6Jryr6c0T/97dZ9lz2WB9ulUJsOJ6gJBMaAC51rpR9Oip8lH9
 +wmUAud00muXacKITUZa4W9C2Ufasyo8zepmAMTjGTjxNEVbXgxDAYNovdiVrDLUK2+6g0hs3g/
 ZlhTyPxvbMLkO2Adcetu7k/PiSG4+nIt5YUqTeWNDRB0PdYc3GX3l0kAGVK9aQd3fC7+qe0ZRpZ
 Lma4IbScCi57dafhNAKX/cw7zV3Wr2q/e9lZUbKo4A7sAoaMRP5MDx/2pqokPcOQgAmZeONj6fw
 sCZ+R1zzOuECPtlRZ6vggSXVN+Ql2TtM2IGh5JAmOk8vZ/toT8AOHKpzmnBJ0u/DvDuv8PMo9/V
 uwHesy4kgSn97cIR2Jvjb3PxIJ5a7RkTndSRQXKBQcMvnDzIvEKBA/XTrSd1/HIfgkmCVzPRanX
 F9PFCeK1MmVa0lSVk9WbLjDd8LYYh9CdIWbIKAQCp63KKYsDMMX/PrACLSIZ+j5cQB0C0Eewk7Q
 DOld306qkF1GNFMZKgxi3LzNyMnde7+zzcNrIZsHU/gGX/mKnlgppBzUZUXzZL2Mba5FLvbHGLZ
 jAF8OWGRuGUOg1z/U1AVpQfzwrx9XLrBeBfwvBSyJj/NLFt48GhNFh6ojKlDiVQywug07maHvwE
 6mhoCeHJgI2iPCw==
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

