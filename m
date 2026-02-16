Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D017922B584
	for <linux-i2c@vger.kernel.org>; Mon, 16 Feb 2026 12:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771245517; cv=none; b=fFS2U8xmKuiXLxPzTpUCu7HAHMjKIhTTr3O/nNyAsdq4gQkTawGLvsvI0G7KJKsW5S/nK1gRTLS1ikwByvewoQcp6iHGIGXOPcflKIbT/+Q59Ubql/0laaqnzponsWqMGliDOfc1T9R3SPejyQ/MZUok0rRK0a/846UF1QC6u/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771245517; c=relaxed/simple;
	bh=/bBzf2R/gDr+xFsEvUjSSz9V/1X475MKmehIdfO82S0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aztjxQfFI0RrKsJa3PLo4ZVjH2VCAz/lYLCCZtkbV24jgJFwcGDxsZ609VMHoJRSgHBGAGZOcLC+u2vc0hZSWViwkTwRF/+gEJrFkhKl4szwyN9cLP/zMfFehQHKk2sKg0+U+UvZCSn2iXg1P+s60I3FepQa1tF2K9wAd++CyRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpuvhoMk; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpuvhoMk"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59e5eaa491cso3695771e87.0
        for <linux-i2c@vger.kernel.org>; Mon, 16 Feb 2026 04:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771245514; x=1771850314; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KaNXPqSzXRni0/7DZfH0pXrm0ku9rx2g9K/sQobHHbo=;
        b=QpuvhoMkb2B+RqoayeEDpjilHlYjPWF7ut7ct3iY+Lc6Wx90egN//aTXjzF5rFujSs
         JPSDKBeTskqaa30Nu10q/jfv+741zBx8gVSaVQwouMzZjeUDw8TtgG0K+vrKAucl7R/r
         eQqfs0sQKpCgGXaOvfVtYZtkLDmN4ZO5oE7XYaBtDqpbjnmHveU4b79KmoM6mFg7SxhM
         4wL4JSYhRlMfjqk0kmlBVGb5yHcB0Am5/C4z5Kodfvcg8/ycaWR/82D3hPGvLvqai8dh
         +V5z8M5BbZErntIyMwoZZfo0I2xUtYSa4nun6YHUqRqMfobmoHsCDZOOQGawldx2mbEY
         kyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771245514; x=1771850314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KaNXPqSzXRni0/7DZfH0pXrm0ku9rx2g9K/sQobHHbo=;
        b=GmHDCsp+X7N3uQdhOX+V1bfbl9uW/n9UI6yA4DBeLHqSt4IAE3xmAEyjcmUMqMPAra
         ZcORYrM5mwxsRAxa+gFUU5J7gGW/ULzjCtr6Hn4UrRxaatxQxAfQt+Gf9bpvLcNaVb25
         jbT4lfpCnezJfMa+MHr2sOc5cgsV1un7ZwR3K2T30q+8NMM431UdtiAGX9YneCPn04Z2
         vG1/lL30+iVj7Tt5ntGfYY39pekKF/o1rylPkXC10Jv1H2QAbxBmwKCAOieiErzonAEs
         MGZstODo57hdKoWzBPoTaOUhpVZ+3hQ8hNurqHNDDtyaf9DT8uZhBajxnDQmQiZMo+NB
         2fVA==
X-Gm-Message-State: AOJu0YxK+FpHnRrshYFaVv20ADDYcMqx9zH+EUJnL2O3LHldbzdZFiNc
	BsXDiuuYcIQ8VmHHYvURFStq6N9ZXMOTtLTSTECb6Xc7GSsB4LAk1y50
X-Gm-Gg: AZuq6aIFkdaWTBSdVxCoXY3od1mJvWbASNRLlBKV7iDpUzrDgAXg0HT3JkqtToOujQi
	GMLyVbWnn0cFegUYu7rrn+tlKf4i/WYVSN+VjQWuBB3gLo4DcIIeCI8Po0xl+gYE1dZFbFhSFPX
	EeXOWtEg1ZnoPbLmptCFah6wwQmcwpAfEGZ0mjg30jiNegS7Z+QmNU32vrkZ6tUfxK5cw91gCq2
	8nOwsMEju5Q10ERyyATdNXQOOomc2nMY3JwSt61aRNzCQP2MzJirfpZKDw2fgKW73G73xquqZKP
	ZbDfq1+TbfmZ9WTAlgtxt5pA45JI3+RkUb25I4sDa2agQNyYG5oH7JzW2cz8R4C7Pz5hXJZUZpm
	byldEiQsx39Uu+F1H/hasIiSR4KpacqDOwF/jdC8kH+CXEC+42EOR8atLdzUHggonlD9EmAjCDV
	bjGt55UXywcYPA/kkVj/TNtVQKkp/sdysPR6uJwZRel6LBeQkRNtQ+bB/pte3M7zgk+uzS
X-Received: by 2002:ac2:4f04:0:b0:59e:459c:15f7 with SMTP id 2adb3069b0e04-59f69c23b4fmr2689862e87.14.1771245513793;
        Mon, 16 Feb 2026 04:38:33 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5b0577sm3175920e87.71.2026.02.16.04.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 04:38:33 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 16 Feb 2026 13:38:14 +0100
Subject: [PATCH v6 2/5] i2c: mux: add support for per channel bus frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-i2c-mux-v6-2-9be28ecfd7e3@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8944;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=/bBzf2R/gDr+xFsEvUjSSz9V/1X475MKmehIdfO82S0=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpkw/IPz4xzOf0GygzsdQUR9jYSoA8MYUX8kYSp
 CwhsOUu8/KJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaZMPyAAKCRCIgE5vWV1S
 MhlBEACRSkI9YUbj+XI6UXMYW3BF06vIgS/RBysjCddJxOIXqoFXdLXo+HvGzpMSfsebQ662nor
 yMP/mDH/4JANEiwR/QgPu2K8FanwF9u4vhC9lyc810zQPOjtIvvh/2DWQCXuPJsjbY0ktw2I80Y
 vApTtlcrnhdGPyF0I7rUe8cCPqjz8Ghwk/Esf1zc2xGlglsGXK+9TyeUOqffP/BwnJ3SB1p1L/p
 rALCgYGrvki5sK1Ep/AZ/f4dj5PnIpN1COZtWuoD22KgYFq665psaZeTteuxHeDKKV5U3GMLwaV
 9ONe5HrK4g0CXpfsv7Y19cS+N93MMzRbE+sF/X0jXbgfJaLz0KQwACwJdJTCAQaIdIJ7k4rkCHu
 cAgOyyuR25Mx1uh501QQaheYBAFAc5n2iKtC3tAbgumsd5oDNuWRsa4UmneGTTjDGUGkzVO4SGG
 99k76a4jH4G8XRr1lPYjjiaimtzZ1EsJlcyilUzBIZpcWwRzcoQa9q5iBIcKdzaYeHWGJNblt7l
 4vxpPEAFn2ZvwtniWSPzofj8iWOf2rGE4hq585/6tRMKt0e0ni0bFRkFxbeG9S2JGOkx5alYp//
 6dOUIoZeXUmk3K9yVNUbObftrCg0J+ifKpkfbQ6sFohpuZHCO/zwxt0M2d4lgYhRBj5WkH8fLb6
 n6/Z9zCHfqQ9SUQ==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

There may be several reasons why you may need to use a certain speed
on an I2C bus. E.g.

- When several devices are attached to the bus, the speed must be
  selected according to the slowest device.

- Electrical conditions may limit the usuable speed on the bus for
  different reasons.

With an I2C multiplexer, it is possible to group the attached devices
after their preferred speed by e.g. put all "slow" devices on a separate
channel on the multiplexer.

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
If no clock-frequency property is set, the channel inherit their parent
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
 drivers/i2c/i2c-mux.c | 145 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 133 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index d59644e50f14..f125b4b8ae58 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -36,21 +36,113 @@ struct i2c_mux_priv {
 	u32 chan_id;
 };
 
+static struct i2c_mux_core *i2c_mux_first_mux_locked(struct i2c_adapter *adap)
+{
+	struct i2c_adapter *parent;
+
+	while ((parent = i2c_parent_is_i2c_adapter(adap)) != NULL) {
+		struct i2c_mux_priv *priv = adap->algo_data;
+
+		if (priv && priv->muxc && priv->muxc->mux_locked)
+			return priv->muxc;
+
+		adap = parent;
+	}
+
+	return NULL;
+}
+
+static int i2c_mux_select_chan(struct i2c_adapter *adap, u32 chan_id, u32 *oldclock)
+{
+	struct i2c_adapter *root = i2c_root_adapter(&adap->dev);
+	struct i2c_mux_priv *priv = adap->algo_data;
+	struct i2c_mux_core *muxc = priv->muxc;
+	struct i2c_mux_core *mux_locked_ancestor;
+	int ret;
+
+	if (priv->adap.clock_hz && priv->adap.clock_hz < root->clock_hz) {
+		mux_locked_ancestor = i2c_mux_first_mux_locked(adap);
+		*oldclock = root->clock_hz;
+
+		/*
+		 * If there's a mux-locked mux in our ancestry, lock the parent
+		 * of the first one. When locked with I2C_LOCK_ROOT_ADAPTER,
+		 * this will recurse through all intermediate muxes (both mux-locked
+		 * and parent-locked) up to the root adapter, ensuring the entire
+		 * chain is locked.
+		 */
+		if (mux_locked_ancestor)
+			i2c_lock_bus(mux_locked_ancestor->parent, I2C_LOCK_ROOT_ADAPTER);
+
+		ret = i2c_adapter_set_clk_freq(root, priv->adap.clock_hz);
+
+		if (mux_locked_ancestor)
+			i2c_unlock_bus(mux_locked_ancestor->parent, I2C_LOCK_ROOT_ADAPTER);
+
+		if (ret)
+			dev_err(&adap->dev,
+				"Failed to set clock frequency %dHz on root adapter %s: %d\n",
+				priv->adap.clock_hz, root->name, ret);
+	}
+
+	return muxc->select(muxc, priv->chan_id);
+}
+
+static void i2c_mux_deselect_chan(struct i2c_adapter *adap, u32 chan_id, u32 oldclock)
+{
+	struct i2c_mux_priv *priv = adap->algo_data;
+	struct i2c_mux_core *mux_locked_ancestor;
+	struct i2c_mux_core *muxc = priv->muxc;
+	struct i2c_adapter *parent = muxc->parent;
+	struct i2c_adapter *root;
+	int ret;
+
+	if (muxc->deselect)
+		muxc->deselect(muxc, priv->chan_id);
+
+	if (oldclock && oldclock != priv->adap.clock_hz) {
+		mux_locked_ancestor = i2c_mux_first_mux_locked(adap);
+		root = i2c_root_adapter(&parent->dev);
+
+		/*
+		 * If there's a mux-locked mux in our ancestry, lock the parent
+		 * of the first one. When locked with I2C_LOCK_ROOT_ADAPTER,
+		 * this will recurse through all intermediate muxes (both mux-locked
+		 * and parent-locked) up to the root adapter, ensuring the entire
+		 * chain is locked.
+		 */
+		if (mux_locked_ancestor)
+			i2c_lock_bus(mux_locked_ancestor->parent, I2C_LOCK_ROOT_ADAPTER);
+
+		ret = i2c_adapter_set_clk_freq(root, oldclock);
+
+		if (mux_locked_ancestor)
+			i2c_unlock_bus(mux_locked_ancestor->parent, I2C_LOCK_ROOT_ADAPTER);
+
+		if (ret)
+			dev_err(&adap->dev,
+				"Failed to set clock frequency %dHz on root adapter %s: %d\n",
+				oldclock, root->name, ret);
+
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
@@ -61,15 +153,16 @@ static int i2c_mux_master_xfer(struct i2c_adapter *adap,
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
@@ -82,16 +175,17 @@ static int __i2c_mux_smbus_xfer(struct i2c_adapter *adap,
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
@@ -104,16 +198,17 @@ static int i2c_mux_smbus_xfer(struct i2c_adapter *adap,
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
@@ -362,6 +457,32 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 			}
 		}
 
+		of_property_read_u32(child, "clock-frequency", &priv->adap.clock_hz);
+
+		/* If the mux adapter has no clock-frequency property, inherit from parent */
+		if (!priv->adap.clock_hz)
+			priv->adap.clock_hz = parent->clock_hz;
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
2.52.0

