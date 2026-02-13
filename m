Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8D72D7D59
	for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980880; cv=none; b=JcdwiM1HBEnKu1zwV+Hwf1QNb4SkDEpl4KYqVAfSAELQxDKFrtBchq4La6l+NgIcsdyJw6XutEG8tNP4OCGZwrusMpX18aearcwKSBKADmY4fgO2SgifK2iA2xthlkKW3Za6kPOyhvp4YO9af1DKvf9NQUUVRpws24tRY58Br7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980880; c=relaxed/simple;
	bh=GAwGUaz+GqwpeQvnl1X7ahiwstVZRIvpf/1yMqLpIBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d8ObPbckrYwPKzvw+DQq5RAMt2U+CpuqtVCTxWro8PC71iykWIEh7Du5VIc8xpbdaTviW89Di8hJaOUv5ID2xtFIDUZvjhvEkGn77YHWPNpWUnTJNVZXvM11G2KTrqcM+R2HF0oI4m8YF+sIB4I35DWAPiU1v0l+vRmqSzKoFv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3pf9ATB; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3pf9ATB"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59e6c181402so1062285e87.3
        for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 03:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770980877; x=1771585677; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTB6xTbR9YUCnAVo0azw412iafjXj/Q1IfEGCYfMv3Q=;
        b=i3pf9ATBJI7DwnDhuySZL6KIAWJL9a0bSFHnLx3hmf5RgKkUx/mdXG+EUOYZMc5t7H
         zNSYyJA+CznyUTCJpQKPaycqnPXUUTtv9MGG3Mpod/HZCP7QshAGg9kkDg3gNMt71xEX
         woo12oVlW2F7gq5x7tGuIhU2/o0P7tsOLGTmpz2IoZ0aTdjb3SWifgphrdEhUZrKJBDk
         sh/pI1/XisVt8l6zDAZ90UEE7YWJkDgjyBhHOKLU4A3POfIR8y7ErpltuePOMAwYT9k4
         +pDjuwPylqdT1ArcGdt4m8aiP0M9QWaRvZQQTXHx9LaHPNaD6501xnJnhatJcVDWwEwI
         E86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770980877; x=1771585677;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zTB6xTbR9YUCnAVo0azw412iafjXj/Q1IfEGCYfMv3Q=;
        b=gPJHaPSOpWtaD9WRkXD8ZWZ7ZcqZmjE11gC8jTv5OulMF+U9k3TyNX5EtzWpzSHoB/
         c3eGHLzGEpZwUABULOXEjY7aDHXgnAh4Fnwrd7f0QGkRS/mSI0Z8VCLPN0R+JbatJedc
         RSj/J4D1BNMIUoABAF/XiOM+MzHFh2cU4TSC46NETTL6xRuNOid64M8kdwE0u3StNJh7
         Oi+PMSXD2l8XVc0uu1rJ7tv1mHSxFGbfzlsyEK8nOKB1cWTGAaIQd3Oj7fDz2+So3vdo
         ETAmj8dsGHbNxZTc/ZpfPCACjvW/VaBCHYDcU3dwdLrArSmHDXXNtwowgsGn6erqOUbm
         otZg==
X-Gm-Message-State: AOJu0YzZI4nFUWq5xDBU6Vs6GyMOEWvaWNEkcC6yiwMbciozVy/N1456
	vJMXmuxHVCBA6oGFRSHbXTmd6OqsMiUiqZkwRaEyW6A+McQGCydjdFMf
X-Gm-Gg: AZuq6aK2E3gO2DiJ1mjwZAZKZC/dTxSsb4dHDLXyt8FwL4OHnrAMAbhZMTGTOvL5say
	OQDKYL0KcUjbkGqcRktvPvdsvWirxiiE2TWZd7D4m9zyH8obdwChiYUJKqglBZ+GCT2Y0c1RryH
	WAwikfz9mUuWQNNDAo2P5KBK4Na71Ceu8T2G9okzMZZoHBYV2DyEE7xs66TEp7C5/9dz3/81jrD
	qySXVVVA22jvcWhIidc/hqd6DY3ZNvo703AUhdLtZfPWx5MlIn5D/a0GDa8/YYrfap908hS5sI3
	abVtlYBF0a8ynoMxsDxmhN9oTi6svPcskDZzGPBwRNpgFC15wWoY7pTJf2KTJJVfEivhukawzH4
	pUbJIloJFg+QdIC7fAUF9s13U6GHdN4aqvGI1JkQNfVEcAgToBWYZ38IEoLpCuXokBs7JIwE6UZ
	V6Gje0h+dSFx7c4JxLX9imDwnEqk9qPpCPKhAIq6LNTNwhFRhfLYQ4IjgOwtyHdu74w/4QSHJyv
	bu/BnA=
X-Received: by 2002:a05:6512:2211:b0:59e:627f:7dac with SMTP id 2adb3069b0e04-59f69c26726mr549708e87.11.1770980876428;
        Fri, 13 Feb 2026 03:07:56 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-387068924c3sm13635831fa.1.2026.02.13.03.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 03:07:55 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Fri, 13 Feb 2026 12:06:51 +0100
Subject: [PATCH v5 2/5] i2c: mux: add support for per channel bus frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-i2c-mux-v5-2-fb2cbf9979b3@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8549;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=GAwGUaz+GqwpeQvnl1X7ahiwstVZRIvpf/1yMqLpIBk=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpjwYGuIK8exFqsvf3DBLtCgfwK6lnbHil0tXTZ
 Aas9o6VEqGJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaY8GBgAKCRCIgE5vWV1S
 Mg74EACm7dC1fqEhgRgE5JXfEyDwBbH77gywCuRIOdeyj9V9C82JIK4FmHsOKeSkiIbKk3es44d
 WG4C7U2KzJgAycihRJB5utVeK65J53nrnRvF4obR+Mae/LDkJRKnr/71hteNBx2og9T72plfmPp
 1cTBBC/uK+vX2R27qaSZ6S1C6kHXvOQhANQTcuurY8trP2qangIPpFnsZXzrvyw0dGVEp5FUWcr
 rkEkJCrSeg4SdJzXFWIadFYpMehHfvCLYcB28OLFigOmMk2IKpH7+yWEoeoh49ss73/sBgEgJtj
 KprPDX/Gu9M+LeGbjs15MzsafBr/VwCrs+gAKPukbgV8sPlNU+GlaF13tHJmfJ2KKDhXQL5SDtu
 dW/SUpf9o4NMhBlI1U42CAP2BQuVeT2qjiqdAcqJiZ6KOjaHsOsEUH+8FzimBX5p392P14aAqY0
 t2VZHTBmna+RAYLKTlUG4hvl/AGasxT9roOCS4AUKrJm1vRAkiUHa9GDM+buy9KgxggwHvgG9b+
 fv7xDYjz2uTrPcpp6kpxScsF/ZFfMP0Xd0G93j1utlAJG7zBZQFT4gOXvaamwMxXZhlXpuajE7T
 Chefgjvqdvi6J4MtwXnYADgybTXPmDufSpmJoCnqrERkEXXtdo1wGE+4MiOeHvo455rOgfdz3/C
 3rBSZQYm6fCuxkw==
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
index d59644e50f14..9116ee3fd979 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -36,6 +36,100 @@ struct i2c_mux_priv {
 	u32 chan_id;
 };
 
+static struct i2c_mux_core *i2c_mux_topmost_mux_locked(struct i2c_adapter *adap)
+{
+	struct i2c_adapter *curr = adap;
+	struct i2c_adapter *parent;
+	struct i2c_mux_core *result = NULL;
+
+	do {
+		parent = i2c_parent_is_i2c_adapter(curr);
+		if (parent) {
+			struct i2c_mux_priv *priv = curr->algo_data;
+
+			if (priv && priv->muxc && priv->muxc->mux_locked)
+				result = priv->muxc;
+		}
+		curr = parent;
+	} while (parent);
+
+	return result;
+}
+
+static int i2c_mux_select_chan(struct i2c_adapter *adap, u32 chan_id)
+{
+	struct i2c_mux_priv *priv = adap->algo_data;
+	struct i2c_mux_core *muxc = priv->muxc;
+	struct i2c_adapter *parent = muxc->parent;
+	struct i2c_mux_core *mux_locked_ancestor = NULL;
+	struct i2c_adapter *root;
+	int ret;
+
+	if (priv->adap.clock_hz && priv->adap.clock_hz != parent->clock_hz) {
+		mux_locked_ancestor = i2c_mux_topmost_mux_locked(adap);
+		root = i2c_root_adapter(&adap->dev);
+
+		/*
+		 * If there's a mux-locked mux in our ancestry, lock the parent
+		 * of the topmost one. Mux-locked muxes don't propagate locking
+		 * to their parents, so we must explicitly acquire the lock above
+		 * the highest mux-locked ancestor to reach the root adapter.
+		 */
+		if (mux_locked_ancestor)
+			i2c_lock_bus(mux_locked_ancestor->parent, I2C_LOCK_ROOT_ADAPTER);
+
+		ret = i2c_adapter_set_clk_freq(root, priv->adap.clock_hz);
+
+		if (mux_locked_ancestor)
+			i2c_unlock_bus(mux_locked_ancestor->parent, I2C_LOCK_ROOT_ADAPTER);
+
+		if (ret < 0) {
+			dev_err(&adap->dev,
+				"Failed to set clock frequency %dHz on root adapter %s: %d\n",
+				priv->adap.clock_hz, root->name, ret);
+
+			return ret;
+		}
+	}
+
+	return muxc->select(muxc, priv->chan_id);
+}
+
+static void i2c_mux_deselect_chan(struct i2c_adapter *adap, u32 chan_id)
+{
+	struct i2c_mux_priv *priv = adap->algo_data;
+	struct i2c_mux_core *muxc = priv->muxc;
+	struct i2c_adapter *parent = muxc->parent;
+	struct i2c_mux_core *mux_locked_ancestor = NULL;
+	struct i2c_adapter *root;
+	int ret;
+
+	if (parent->clock_hz && parent->clock_hz != priv->adap.clock_hz) {
+		mux_locked_ancestor = i2c_mux_topmost_mux_locked(adap);
+		root = i2c_root_adapter(&parent->dev);
+
+		/*
+		 * If there's a mux-locked mux in our ancestry, lock the parent
+		 * of the topmost one. Mux-locked muxes don't propagate locking
+		 * to their parents, so we must explicitly acquire the lock above
+		 * the highest mux-locked ancestor to reach the root adapter.
+		 */
+		if (mux_locked_ancestor)
+			i2c_lock_bus(mux_locked_ancestor->parent, I2C_LOCK_ROOT_ADAPTER);
+
+		ret = i2c_adapter_set_clk_freq(root, parent->clock_hz);
+
+		if (mux_locked_ancestor)
+			i2c_unlock_bus(mux_locked_ancestor->parent, I2C_LOCK_ROOT_ADAPTER);
+
+		if (ret < 0)
+			return;
+	}
+
+	if (muxc->deselect)
+		muxc->deselect(muxc, priv->chan_id);
+}
+
 static int __i2c_mux_master_xfer(struct i2c_adapter *adap,
 				 struct i2c_msg msgs[], int num)
 {
@@ -46,11 +140,11 @@ static int __i2c_mux_master_xfer(struct i2c_adapter *adap,
 
 	/* Switch to the right mux port and perform the transfer. */
 
-	ret = muxc->select(muxc, priv->chan_id);
+	ret = i2c_mux_select_chan(adap, priv->chan_id);
 	if (ret >= 0)
 		ret = __i2c_transfer(parent, msgs, num);
-	if (muxc->deselect)
-		muxc->deselect(muxc, priv->chan_id);
+
+	i2c_mux_deselect_chan(adap, priv->chan_id);
 
 	return ret;
 }
@@ -65,11 +159,11 @@ static int i2c_mux_master_xfer(struct i2c_adapter *adap,
 
 	/* Switch to the right mux port and perform the transfer. */
 
-	ret = muxc->select(muxc, priv->chan_id);
+	ret = i2c_mux_select_chan(adap, priv->chan_id);
 	if (ret >= 0)
 		ret = i2c_transfer(parent, msgs, num);
-	if (muxc->deselect)
-		muxc->deselect(muxc, priv->chan_id);
+
+	i2c_mux_deselect_chan(adap, priv->chan_id);
 
 	return ret;
 }
@@ -86,12 +180,12 @@ static int __i2c_mux_smbus_xfer(struct i2c_adapter *adap,
 
 	/* Select the right mux port and perform the transfer. */
 
-	ret = muxc->select(muxc, priv->chan_id);
+	ret = i2c_mux_select_chan(adap, priv->chan_id);
 	if (ret >= 0)
 		ret = __i2c_smbus_xfer(parent, addr, flags,
 				       read_write, command, size, data);
-	if (muxc->deselect)
-		muxc->deselect(muxc, priv->chan_id);
+
+	i2c_mux_deselect_chan(adap, priv->chan_id);
 
 	return ret;
 }
@@ -108,12 +202,12 @@ static int i2c_mux_smbus_xfer(struct i2c_adapter *adap,
 
 	/* Select the right mux port and perform the transfer. */
 
-	ret = muxc->select(muxc, priv->chan_id);
+	ret = i2c_mux_select_chan(adap, priv->chan_id);
 	if (ret >= 0)
 		ret = i2c_smbus_xfer(parent, addr, flags,
 				     read_write, command, size, data);
-	if (muxc->deselect)
-		muxc->deselect(muxc, priv->chan_id);
+
+	i2c_mux_deselect_chan(adap, priv->chan_id);
 
 	return ret;
 }
@@ -223,6 +317,7 @@ struct i2c_adapter *i2c_root_adapter(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(i2c_root_adapter);
 
+
 struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
 				   struct device *dev, int max_adapters,
 				   int sizeof_priv, u32 flags,
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

