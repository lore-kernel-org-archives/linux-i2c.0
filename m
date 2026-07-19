Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6D83A48CE
	for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784474248; cv=none; b=SQjD3bmcXJIF43v+Lmx+4WpKcHYWyh/QlC2I0fURiiDfju2bsGF5qJwerAF5a1XqadQIQY0n5dBY54x197RlfpGIM515NqIVMHP6Bv406jbw07YPsj6WLJsWGS9JEHYaIiRuhK5v9hc4bR0ZwApesqzTAKeSUEA1NHv6kxvOWtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784474248; c=relaxed/simple;
	bh=YG8BYZkd6HTx8BUh6LrDh9EFQErHmuXWXTr5T30njJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f34JvruRHELezOFvQs3LfMizYrKiuIBeTOWpkpyAF5bcSGA/fMvRD/Zr8JfqpYlWsQfjsy07fmG02ve3d7qABh8cgfzP/YhxtLodMLB2YUx5i1KErV9OtrFg4lg+2tnDj8Kfp9qpePeOvAdaXMkbOrEW8TVTpjOpPvACEtx/7Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAcheaHE; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAcheaHE"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b159850b16so5573988e87.3
        for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 08:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784474244; x=1785079044; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pZbKZC90lt57E1POL/jmjWN3NoQ7bSkmvoquyJ2AsB4=;
        b=VAcheaHET60ysoNMoY/HqSH1X0a9xP7uMfQzqtRNyGhdV0YBkJB/att6hUzurvxr/s
         PA9tLapC5LGbuVqavKN8UauoZG9LE+HPLDVF+YcLgoh3WicBd4CkM6l6Cc6kOZrtmxX8
         yvTecD2w4sd5v8gBJyTPxxcUgUOZPLspIan6Zyucg0R7HgWjbTWZyhFURGoaTOqgKJdh
         XmETY4ZAXVzdbX398Q8ZiUS4YLWBQsarWDW0sqg520YRiyxfCiw0m6Cw5CSybJ+TKvpE
         o9qNqyjvNscFQHsLsog+BwLQjpmO2yuEPlAg6d335dOnlND9wr25WTUXyxhX0QNTwrQ2
         BB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784474244; x=1785079044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pZbKZC90lt57E1POL/jmjWN3NoQ7bSkmvoquyJ2AsB4=;
        b=sxQWrJhoOUHVdlL2FjlsGJ9x6PPcVl7xDbcf4c8kcsPndcx8moVrJYmj6iE7e/l60Y
         18JRK2530Nt3Jisv1wrjF73J2BN2+kT6OB7zStQPf5pgY76m6EqJLgg9fwsfQwQcmRRm
         4bxlC4xyvXDi7Jnt2gR8ifjWzxZIFPFlAGsSzbod1dsdYtFUIzt2MqdJlVqfdzWbb2PD
         wLN/m2u1+FBNvlWmq8jehCqz6TJjQ7nYkSs1HZ1mxHc/yNX+5KO0JtXbpL/yw1vvS+e5
         mT+LJIDkwdh27wcomluQLGIWlnwPjSMW/gZfhfJzU0sHD9nFkTVFeWU26ba1xewC4Kj+
         me2A==
X-Gm-Message-State: AOJu0YxmdyPt0ZCT3tmp4u0Y83ob3z5xsW1lVvf424HSFgHEix/IKrUJ
	GBZmuFiCRWUc1mo9NnKjhJBGO5OkIwjTObNqewD64vapy1wnav5QOFGJ
X-Gm-Gg: AfdE7cl+bEG8HTLXWJCw206T8DmQ3ncWyOkmBTrT2RbVYf257XKXzzffjHpEnXR2iSB
	RlhCekftjhS7ZWkvj5k54QYxLjRlGo425RYZq3XEamCXD+pb4XA0G1EWe4fKCnhuGreQtnB7IQo
	hkjHbEJ7bqjozRkcipgHF+ShZYpfsoaSW6fgqRX3UkgB9OgmJBZpMJARCzgwHQqx4CjsBa5gYRf
	y1ZzfsNZ/lV/1sun2ucWG6+DB43QsB7pJ0MhaDXsUyUCZzWVzoRBoo19xvKt1MesXPXDRW/knr3
	niQSOMJ5xhCtg4OoMG3x+zN/lUK80P+P2Jxpw537mxG3pBk43BQYRGpo/W+CChTZ+ppuouo/psa
	M0xCsO5aJINXBSI34AeErpugVTIamG1ksGFzFFUFrm48+bLTsJn/b4xOailIHL6rVU+ZJg0eYpr
	MnRbKa3FM2r/ZfUVfAgMDYN56dBMwrmaBL4VOEvcyb12Z8r8Q=
X-Received: by 2002:ac2:455a:0:b0:5ae:a9eb:eff1 with SMTP id 2adb3069b0e04-5b28fabb075mr1708930e87.58.1784474244144;
        Sun, 19 Jul 2026 08:17:24 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b291e26e5fsm1835096e87.80.2026.07.19.08.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 08:17:23 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sun, 19 Jul 2026 16:59:46 +0200
Subject: [PATCH v12 3/7] i2c: mux: add support for per channel bus
 frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-i2c-mux-v12-3-a5010d623a57@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9225;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=YG8BYZkd6HTx8BUh6LrDh9EFQErHmuXWXTr5T30njJQ=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBqXOp/KZnLcuCWA2pGTPKguNRXwtXMkauRDwo2H
 maddf/ItWGJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCalzqfwAKCRCIgE5vWV1S
 Mo/FD/9Ulecov/E5wbrfvNooC+4ObhgHGozcDB69wh3tQzASRrc+cE7YduB0EeCErzULHmy3QVi
 YEngNnTlT9mgqrI2CwIRh/INzi/sGc/XrbrM0YkDJas9gZfO0/TPQH3iiOs/LlXrDCT6h6mErVg
 mj2pX2v/wMcg02opxNjPkrzTftYx7R+bbl1r5y12GfQf623W5Dx1h8hWVNwJW+tXZUeEdSRaGD3
 7Qab1+/0wFiJlUit0E5MsM1RyYHeMW9jZn1lx5oPzvo/pcqaWqd5ZQhy9Oa5ZroYir4tbpjYoTy
 HMGtzaMFAD3nlLAOqPsT2HCb6yOCHK1q0pZIBQWPQH1wVUT96vGU7aRsPJwXBQ14IadE7mPHdbJ
 00yMQgC4FsxFS7tYgzrF6cs7VNfyXsZ2d8lWHsffSsz/eGir+zDJ6anrRI0xsVLO/u7JLphSljP
 Ea3n8QPvzSg2gfRyCQNH6Px4V0cGtuPvjcMBESKW5MthAZZLp6aTpUjp7coPmj7hIrwgjouJJvA
 i2U5tTeTUpqrHMsy9DRmrTZd3TXZ/x4P3rgzgcwWA0LsByWbMipFhzc6ST7tZiCm7Sv6RoifZ9l
 01R64dwNWe21DOjQDP1RngXPfg81GqDP2+CuHU2ntjtztp/3lsvnb9TXH0rrOPgKK/xVoxYzsmq
 6nDlbkU+SYd2UiQ==
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
index b126ce7338c2..00de5f124132 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -36,21 +36,118 @@ struct i2c_mux_priv {
 	u32 chan_id;
 };
 
+static inline int
+__i2c_adapter_set_clk_freq(struct i2c_adapter *adapter, u32 clock_Hz)
+{
+	/* If the clock frequency is already set to the requested value, do nothing. */
+	if (adapter->clock_Hz == clock_Hz)
+		return 0;
+
+	if (adapter->set_clk_freq) {
+		adapter->clock_Hz = adapter->set_clk_freq(adapter, clock_Hz);
+		if (adapter->clock_Hz != clock_Hz)
+			dev_warn(&adapter->dev, "Could not set requested frequency. Requested %uHz, got %uHz\n",
+				 clock_Hz, adapter->clock_Hz);
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
+	 * Update the clock_Hz for non-root adapters, even if .set_clk_freq() is not implemented,
+	 * to allow the clock frequency to be propagated to root adapters that do support it.
+	 */
+	adapter->clock_Hz = clock_Hz;
+	return 0;
+}
+
+static inline int
+i2c_adapter_set_clk_freq(struct i2c_adapter *adapter, u32 clock_Hz)
+{
+	int ret;
+
+	i2c_lock_bus(adapter, I2C_LOCK_SEGMENT);
+	ret = __i2c_adapter_set_clk_freq(adapter, clock_Hz);
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
+	if (priv->adap.clock_Hz && priv->adap.clock_Hz < parent->clock_Hz) {
+		*oldclock = parent->clock_Hz;
+
+		if (muxc->mux_locked)
+			ret = i2c_adapter_set_clk_freq(parent, priv->adap.clock_Hz);
+		else
+			ret = __i2c_adapter_set_clk_freq(parent, priv->adap.clock_Hz);
+
+		dev_dbg(&adap->dev, "Set clock frequency %uHz on %s\n",
+			priv->adap.clock_Hz, parent->name);
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
+	if (oldclock && oldclock != priv->adap.clock_Hz) {
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
 
+		of_property_read_u32(child, "clock-frequency", &priv->adap.clock_Hz);
+
+		/* If the mux adapter has no clock-frequency property, inherit from parent */
+		if (!priv->adap.clock_Hz)
+			priv->adap.clock_Hz = parent->clock_Hz;
+
+		if (priv->adap.clock_Hz < parent->clock_Hz)
+			if (muxc->idle_state != I2C_MUX_IDLE_DISCONNECT ||
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
+		if ((priv->adap.clock_Hz < parent->clock_Hz) && muxc->mux_locked)
+			dev_warn(muxc->dev,
+				 "channel %u is slower than parent on a non parent-locked mux\n",
+				 chan_id);
+
+		/* We don't support mux adapters faster than their parent */
+		if (priv->adap.clock_Hz > parent->clock_Hz) {
+			dev_err(muxc->dev,
+				"channel (%u) is faster (%u) than parent (%u)\n",
+				chan_id, priv->adap.clock_Hz, parent->clock_Hz);
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

