Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C464E3259
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062159; cv=none; b=i87x4ThiA97NDR/g827ZYplYKzYUQASYHS3lymqEeVGu1HM994JSwBIz45aa8+f31eECxSXGM90QiC3LqLOa3vNM9fAQqwU9B0XASwpLBonQDpfCM95M42cLdO4VF/ApLHfcW5sD4uU/tUrUiU0ZUTFsW30TSzNumqAlSrO12bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062159; c=relaxed/simple;
	bh=exMpd3cjGy/5DzcDxw/bxloMWbnVNyP4rtgPVcTa9gY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VLXBubIEOc1mBoeGWc8vlIOusixTlT9zefCauWusRSVk0a6JDoewGGdEJDEexNpkBrv/kQUsaCYhjsNp6tm16WWs7u8oOIBmmvtnMbtx7SibSufcTlV2sQMv571jTJo4O132KKhAigKvRhU9e8sFGfx4TuHLIPO/u5qR8Qf8VqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJxGkOYU; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJxGkOYU"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bccc73eea4so2634297e87.1
        for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 04:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792062156; x=1792666956; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zhrogpInrHDbhterqGtAmQBWlA/ZRMWIahc1n13ojCw=;
        b=JJxGkOYUWolcuvPHKqGCLrMqTtrK08yzNm8gflkVrhCRFO1ILWHUuPLFExi1i0AswR
         x5zdS9grnL1aXy6mQw2b9nGfb2tJLv4WDq0xlZ7i+1tiz/SHkls1nNO3LKqzo5LCGpJA
         2fPYPdfhu7fLi7T6LKj9EmS7MSX7ay1KxXkdwRlJ09G0Pdkg7481JpCmy05YXXckvWyW
         QoZofrjhVsKgoBbFZeYwXraRQ4p3Z2G3ihNI3C6SPe3fqLchw6tSD5wvStuVMV9ierfJ
         upZIdhwjp39wK+gGpAwAADDSzTJVMTYs8R2bxcA6VCTnpBT1G8NOpBwVraIfUce+RYgt
         3JkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792062156; x=1792666956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zhrogpInrHDbhterqGtAmQBWlA/ZRMWIahc1n13ojCw=;
        b=ePOrF9qbcxnMAnuD/jX1CJUzyVp0VTwDcTyQlRCyoa5GuoZZuA6T5hi0xANc0tsvQA
         SIAkd+pTDXdxFw6mB8GFmsbbQ2SXg1QlATHvdmDk4ZpXXyWm2FPyrhWGh5TDv9ce/8BD
         NnymrICKIvTyU+TmXymkljRiFUcUR+0SqdHbmnWPWNchnxPr6wQ2brNhGweX6QX8xhuR
         U8d51gs8xworK2QO+Pmk7cQuv2KAqSmx6ONnJ2Z7gioNT50SyU+VN7aAYi33IulppXAN
         mxE9qgKZX+TImBotBIIufQ+osnwa/vuUNL6C8yeoutflK+b9KYG+1pVSAyud8wc/BP7c
         gftw==
X-Gm-Message-State: AFq9FYKQK2ngNadPMuzB44uU11vHn5bBDREcXWx++KrR2dG9Y5Luu2XI
	wv55m6zvpFNrSBgve3xLXk63HcSLw0Sd/P0uRLqu18Rsn5TBsSqo3H+/
X-Gm-Gg: AYBFou2cq/eKkZkcaSo8TSRIZ7diN04K2IOodz9gRhDBYiw7K4TBSDVdLw6ZnkqVKjm
	+IPclytRENOPf6BwWVAhr++nxAHJBaUmSm8TqEsea+gXqE12bk9cGGxwOM+ZNlBnolFNQLqsBqi
	+ltj30bjdPUbxB0C50UWp7p9f3z6CbhKF5w0BVYoTn+tYvN/6AbhChLDDbuQEYB3WxXgI4D24Sl
	ZIWc5nJdVagoSHEioOROk9VZrevs0TyL4jlQiNnBKTslAT7qh3Qnrxs3LyEhudV6mpe2m3QEXcc
	2KDMQW2ftreC0qnx529QJycwjbg1GIHTly2jZsTOv6S6uGxnWc0PHreRgPmhvumIhfikUknZiKd
	nPwSbGKTF1z1bca9ek5StFZZUKgGLGxQE+DCfjkLkg3JGhBzjWm/g4fp6QU4R+HL22iac2XjqIH
	wbo87DfaCDmMZKRhiuWPteJNjL+0bVmN0rUc4eG99VxLWyViQKSrAAJodHLUoGbQGf5YShoIQ0s
	LI0Kybs7/cecvhna4MCWPtzVYpkxl/eaBpSmBFhcA+WvaFZHBw=
X-Received: by 2002:a05:6512:b1c:b0:5b8:e9cf:daa6 with SMTP id 2adb3069b0e04-5bcdd4f080cmr6760391e87.10.1792062155605;
        Thu, 15 Oct 2026 04:02:35 -0700 (PDT)
Received: from [192.168.1.135] (81-229-40-193-no2450.tbcn.telia.com. [81.229.40.193])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be3739b5d1sm905465e87.22.2026.10.15.04.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:02:34 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Thu, 15 Oct 2026 13:01:50 +0200
Subject: [PATCH v13 3/8] i2c: mux: add support for per channel bus
 frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-i2c-mux-v13-3-778a12cfe93b@gmail.com>
References: <20261015-i2c-mux-v13-0-778a12cfe93b@gmail.com>
In-Reply-To: <20261015-i2c-mux-v13-0-778a12cfe93b@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9989;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=exMpd3cjGy/5DzcDxw/bxloMWbnVNyP4rtgPVcTa9gY=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBq0LKtsBX9nyJ/cK7w2ug+K4Xj9Psgt3AuwClZJ
 CF9goOxovGJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCatCyrQAKCRCIgE5vWV1S
 MkPhD/9Z8GqI0j3myfmp2x/N7fzHDhT6d9ab/ToTLGVDwYPoVi1cxh+Nz7+/icnLfnsf/F0qyLh
 sOCw7/CboQLMyJVZHLtcyPZf8goFnrC+mOLL0/s0XOIUowhwx2C4tCFFQVRt/NiY7HrQVyfapOU
 tBw1K9JeOpjv6MevkjNi4H8pKi5wUVaWsIz9UUUzgXW9fV/Xi4I4q4DnwPZpLPrTooDOl+9S+jE
 cucxi6wU0ZzbVDJbnZQLNu/imgqPNLlsYkDnKGq86/UzDObA3YqzfZndKz6FemUAOCHSC4MvaPz
 bJZbyHa7gFt8nMa1Z34VSiTTeOe6RC1FYpstdmMcrxw8iBr58qNglv2Ky8OfYnB50wPJs0mN4yT
 eEYJiQKo9ABuQlAlnExFTO+rpniP4mc15p2n4QnkBglhOxNrCi88qNEnFffcECD0EG6FYcloV4a
 SDW+Hy/Aj9A4c0jBAACID2IERJqD1R/sq8R5bvC29E0QE/ckqEuOWCKKpoX91PcO6c5YfEdQRoP
 bVccHvVL81VAyXKD1l1mXKevm44js6uD1jI99a5LIc8UE3YytA7mSynXIY2sGJdNOwosvY2pg9f
 lRT3uaVyw3iDz6LCJhV8kmGtw0e3MC2jThqcK4KrIpyK4KM2ofyGhLFJy6Mb+vdE0rZ/Cgu5x/S
 sknk1/8b3QrRVSA==
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
If no clock-frequency property is set, the channel inherits the parent
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
 drivers/i2c/i2c-mux.c | 195 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 183 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 94cc019b222f..008257624ba8 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -37,21 +37,141 @@ struct i2c_mux_priv {
 	u32 chan_id;
 };
 
+static inline int
+__i2c_adapter_set_clk_freq(struct i2c_adapter *adapter, u32 clock_Hz)
+{
+	int ret;
+
+	/* Nothing to do if the requested frequency is already set. */
+	if (adapter->clock_Hz == clock_Hz)
+		return 0;
+
+	if (adapter->bus_ops && adapter->bus_ops->set_clk_freq) {
+		ret = adapter->bus_ops->set_clk_freq(adapter, clock_Hz);
+		if (ret < 0) {
+			dev_err(&adapter->dev, "Could not set requested frequency (%uHz)\n",
+				 clock_Hz);
+			return ret;
+		}
+
+		/* Everything is fine, update the clock_Hz to the new value. */
+		clock_Hz = ret;
+	}
+
+	/*
+	 * If the adapter is a root adapter without .set_clk_freq()
+	 * implemented, this feature is not supported.
+	 */
+	if (!i2c_parent_is_i2c_adapter(adapter))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Update the clock_Hz for non-root adapters, even if .set_clk_freq()
+	 * is not implemented, to allow the clock frequency to be propagated
+	 * to root adapters that do support it.
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
+/*
+ * Lower the parent bus frequency to what this channel tolerates and select
+ * the channel. On success, @oldclock holds the frequency to restore in
+ * i2c_mux_deselect_chan(), or zero if the frequency was left untouched.
+ */
+static int i2c_mux_select_chan(struct i2c_adapter *adap, u32 *oldclock)
+{
+	struct i2c_mux_priv *priv = adap->algo_data;
+	struct i2c_mux_core *muxc = priv->muxc;
+	struct i2c_adapter *parent = muxc->parent;
+	int ret;
+
+	if (priv->adap.clock_Hz && priv->adap.clock_Hz < parent->clock_Hz) {
+		u32 clock_Hz = parent->clock_Hz;
+
+		if (muxc->mux_locked)
+			ret = i2c_adapter_set_clk_freq(parent,
+						       priv->adap.clock_Hz);
+		else
+			ret = __i2c_adapter_set_clk_freq(parent,
+							 priv->adap.clock_Hz);
+
+		/*
+		 * Never transfer on a segment that is still running too
+		 * fast for the devices behind this channel.
+		 */
+		if (ret) {
+			dev_err(&adap->dev,
+				"Failed to set clock frequency %uHz on adapter %s: %d\n",
+				priv->adap.clock_Hz, parent->name, ret);
+			return ret;
+		}
+
+		dev_dbg(&adap->dev, "Set clock frequency %uHz on %s\n",
+			priv->adap.clock_Hz, parent->name);
+
+		*oldclock = clock_Hz;
+	}
+
+	return muxc->select(muxc, priv->chan_id);
+}
+
+static void i2c_mux_deselect_chan(struct i2c_adapter *adap, u32 oldclock)
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
+		if (ret) {
+			dev_err(&adap->dev,
+				"Failed to restore clock frequency %uHz on adapter %s: %d\n",
+				oldclock, parent->name, ret);
+			return;
+		}
+
+		dev_dbg(&adap->dev, "Restored clock frequency %uHz on %s\n",
+			oldclock, parent->name);
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
+	ret = i2c_mux_select_chan(adap, &oldclock);
 	if (ret >= 0)
 		ret = __i2c_transfer(parent, msgs, num);
-	if (muxc->deselect)
-		muxc->deselect(muxc, priv->chan_id);
+
+	i2c_mux_deselect_chan(adap, oldclock);
 
 	return ret;
 }
@@ -62,15 +182,16 @@ static int i2c_mux_master_xfer(struct i2c_adapter *adap,
 	struct i2c_mux_priv *priv = adap->algo_data;
 	struct i2c_mux_core *muxc = priv->muxc;
 	struct i2c_adapter *parent = muxc->parent;
+	u32 oldclock = 0;
 	int ret;
 
 	/* Switch to the right mux port and perform the transfer. */
 
-	ret = muxc->select(muxc, priv->chan_id);
+	ret = i2c_mux_select_chan(adap, &oldclock);
 	if (ret >= 0)
 		ret = i2c_transfer(parent, msgs, num);
-	if (muxc->deselect)
-		muxc->deselect(muxc, priv->chan_id);
+
+	i2c_mux_deselect_chan(adap, oldclock);
 
 	return ret;
 }
@@ -83,16 +204,17 @@ static int __i2c_mux_smbus_xfer(struct i2c_adapter *adap,
 	struct i2c_mux_priv *priv = adap->algo_data;
 	struct i2c_mux_core *muxc = priv->muxc;
 	struct i2c_adapter *parent = muxc->parent;
+	u32 oldclock = 0;
 	int ret;
 
 	/* Select the right mux port and perform the transfer. */
 
-	ret = muxc->select(muxc, priv->chan_id);
+	ret = i2c_mux_select_chan(adap, &oldclock);
 	if (ret >= 0)
 		ret = __i2c_smbus_xfer(parent, addr, flags,
 				       read_write, command, size, data);
-	if (muxc->deselect)
-		muxc->deselect(muxc, priv->chan_id);
+
+	i2c_mux_deselect_chan(adap, oldclock);
 
 	return ret;
 }
@@ -105,16 +227,17 @@ static int i2c_mux_smbus_xfer(struct i2c_adapter *adap,
 	struct i2c_mux_priv *priv = adap->algo_data;
 	struct i2c_mux_core *muxc = priv->muxc;
 	struct i2c_adapter *parent = muxc->parent;
+	u32 oldclock = 0;
 	int ret;
 
 	/* Select the right mux port and perform the transfer. */
 
-	ret = muxc->select(muxc, priv->chan_id);
+	ret = i2c_mux_select_chan(adap, &oldclock);
 	if (ret >= 0)
 		ret = i2c_smbus_xfer(parent, addr, flags,
 				     read_write, command, size, data);
-	if (muxc->deselect)
-		muxc->deselect(muxc, priv->chan_id);
+
+	i2c_mux_deselect_chan(adap, oldclock);
 
 	return ret;
 }
@@ -374,6 +497,54 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	priv->channel_node = i2c_mux_get_channel_node(muxc, chan_id);
 	device_set_node(&priv->adap.dev, priv->channel_node);
 
+	if (dev_fwnode(muxc->dev)) {
+		fwnode_property_read_u32(priv->channel_node, "clock-frequency",
+					 &priv->adap.clock_Hz);
+
+		/*
+		 * If the mux adapter has no clock-frequency property, the
+		 * channel inherits the parent bus speed.
+		 */
+		if (!priv->adap.clock_Hz)
+			priv->adap.clock_Hz = parent->clock_Hz;
+
+		/* We don't support mux adapters faster than their parent */
+		if (priv->adap.clock_Hz > parent->clock_Hz) {
+			dev_err(muxc->dev,
+				"channel (%u) is faster (%u) than parent (%u)\n",
+				chan_id, priv->adap.clock_Hz, parent->clock_Hz);
+
+			ret = -EINVAL;
+			goto err_free_priv;
+		}
+
+		if (priv->adap.clock_Hz < parent->clock_Hz) {
+			/*
+			 * A slow channel must not be left connected while the
+			 * mux is idle, or it is exposed to the full parent
+			 * bus speed whenever a sibling is accessed.
+			 */
+			if (muxc->idle_state == I2C_MUX_IDLE_UNKNOWN ||
+			    muxc->idle_state == I2C_MUX_IDLE_AS_IS ||
+			    muxc->idle_state == (int)chan_id) {
+				dev_err(muxc->dev,
+					"channel %u has improper idle state for this configuration\n",
+					chan_id);
+				ret = -EINVAL;
+				goto err_free_priv;
+			}
+
+			/*
+			 * Warn if the mux adapter is not parent-locked as
+			 * this may cause issues for some hardware topologies.
+			 */
+			if (muxc->mux_locked)
+				dev_warn(muxc->dev,
+					 "channel %u is slower than parent on a non parent-locked mux\n",
+					 chan_id);
+		}
+	}
+
 	/*
 	 * Associate the mux channel with an ACPI node.
 	 */

-- 
2.55.0

