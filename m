Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8055E3FE37A
	for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774360487; cv=none; b=nCBnXih/JPETY7jS5w0fhr6vKPR2WeKu3A1WFp+87+rwI4y0ZyfDTFqpz6zmTAolA8Cdv3kyOb/Q0ESdHAUN9/B6JHPbMkJbChkZlRHjgSNoI3lXLeD8Q/v1C1vSrdaE3ooJsJ1t2XLPXMi53AHM3wamRbFoFTGHSe9Cv4igo+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774360487; c=relaxed/simple;
	bh=zzwP/dH6nVUsUc4kUSRaQrWbWPe+IT1e5Ig8MAfNhhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kXn5CNuT+6z92pab55e9npxyqwYMXx48u2ZmhTZimtn7IzrlfdiOD6waAzuCsxNXq/TfF2rz4ZKBvwCJ5DCWTAp1gF4wJn/zU44Hp06H/alE8duKyyzPZEaS/ih03fpL6rt+m2yDquwIQyaElHldcNHM+GrC0PFa2klbldMkn10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9OcnoKW; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9OcnoKW"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a27c021b58so1400914e87.2
        for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 06:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774360484; x=1774965284; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AASvAwH/C6MYHGsYw3qf0hanl2I5flhOZHJJpYjf0HE=;
        b=h9OcnoKW/fiH3G2XGi7sFeyBsdBAFPthiCItWbhrXtrYmglsRlQrjNnJ242/PoJWSk
         YA8WnjbQuR5daMe/YOEvmkuT5Yd+CEYcoqYk5XihcDFkTmQ10+8/Y3ILPEQMq4B3+HQ/
         0z6PJM8JD4anmWolFjQPTDixChFDsO58CZy7umZhVnyiedHvaPYeZGR9MHtOiX/kYM1d
         9oDiLp1OodCPrq2tEE8kAdJeGDPRezjFqbsZxY39ciNd3TSeBOulI8Yhc9cgpuG5qgRU
         HG5Z8qivW+zf+M539ETNeRVhZjr+Smd7P7z2DVv/AB918eW8LY0xLL3PpAl2hQuJco3k
         rJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774360484; x=1774965284;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AASvAwH/C6MYHGsYw3qf0hanl2I5flhOZHJJpYjf0HE=;
        b=Sm5sj3NIOV6Ypnks8dDKaGdwlAO4ETG/VoE2wvpSfA7X1MNFrE8vngM/ez/RCRAThY
         JN9Hpu9OuMPVNuLCg4kJK/XktlnFKf9g2BuuutVrGOlU8JsGI95OmnDDnIFKJemNMTBU
         /6Z6XMwxRueEjBkZAH1ZW4UoNJuFdn3L5I7HnkmgPDMuPJwAXaDypTCOfBwSTQAQ2M7b
         338/hrqH5KMEf/ZlSyfOyg8Ep0DXxXnpqSjbvvXLRQwSQC8WKiWOLLVc22k5R/N+C2jW
         N6dSr9A7S2V+REpCaHiar4IWFx8Qx+vNaCLy/o2wEWL18eyLzKm9ZCxYaxq0HZbQBt3C
         hyqA==
X-Gm-Message-State: AOJu0YxNGxt+DnHCIQIxDsWRfdG/mqF2zH6Js+l02VDMmfg+WqsrOBNG
	2cLAIL5PHWgi/3sehrWfmHH6pylKhqPoAk1S0cKnuRkppjAbg6o0rNdD
X-Gm-Gg: ATEYQzzewJMP0t9N3rSo+N88OXgY3Cv5DoqjtbpkRA5S3YLu+hhRklCLggvW1L0pDtw
	bQ1eRHHFKr4bEcZIe/bOvSfUPnSVDcmtCuZ8fW7vQmObbv3htcb7TA01PjvzyDdOupPTN7gdX2O
	0WDo13HLvKU3PYc8SbD/ZmLp+/v4r3FBDyzzoSqZkSdDHHe87CZKm3KG8PhxdV8u7B3LmGeCKDS
	ImNXaCMAqmnrdqtUKBEFqSCxUPqFX0BsZp6NAJxgnzpz4T8d94HOyq/D6+I13oqnDjc+G0uWgEd
	Kd94bM6CHiy9faRMDvC5tcb2L1yTagO1OKIgya9AwWgbxZsnsc79Mwv38guQoJhxr4Q70vEXEYa
	p8VeKfS89EOYq40HiGghOilM3MKERDB+y1x0RsmSxzZrMo7F+/dPwoEo9n7cfe86R6+F3v5kC3a
	C78WuxnetOD6RAF4c0oxzSEc/vMOqyQjV6kJpGc6oSnWnR0AQpwl5FJc5wyyqMcTA6sbub
X-Received: by 2002:a05:6512:10d3:b0:5a1:7458:c17e with SMTP id 2adb3069b0e04-5a285b55dd3mr5528724e87.37.1774360483376;
        Tue, 24 Mar 2026 06:54:43 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a285207454sm3162823e87.48.2026.03.24.06.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 06:54:41 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Tue, 24 Mar 2026 14:54:16 +0100
Subject: [PATCH v9 2/5] i2c: mux: add support for per channel bus frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-i2c-mux-v9-2-5292b0608243@gmail.com>
References: <20260324-i2c-mux-v9-0-5292b0608243@gmail.com>
In-Reply-To: <20260324-i2c-mux-v9-0-5292b0608243@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7627;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=zzwP/dH6nVUsUc4kUSRaQrWbWPe+IT1e5Ig8MAfNhhE=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpwpeS17UHmxhJ8CGOEdifxF/PD0KJwhBW/q8sM
 6oYa9EFnq2JAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCacKXkgAKCRCIgE5vWV1S
 Mq4kD/wOYxLZGglFGcP1qoL6GdhHXQO/bjAa/srPJEh7UjC7KC/0tc0ayxEKJfdrGAgrSXGcP8C
 hA4gclNC7vYdcQu2W280HT+hQjL7KRrJ16cPdK6zqO1IEAksvJyiLaYh3VDux74cUyMRUcHTAIp
 X+nhE/eJLLtQU45xEx/FB4GaxBO1ociPSjkMPRJjsgflDRQNL4UgB+1xKQyS533qnsr18hrfnMz
 R08DRT1IyxAzQzZu6Z9prSkmYJhQSKLKw8+zGV3hGaSBfdpkwGWGwbIJnzTJ1I2eO2/cf/iGD7k
 QBVg/3/Fx9w7mVBnmOQe0MqTzL/wkxwrq5+3l1gKHrqfHuQ4llJHKFopPpQV6oRQB5F0ylxe2Sp
 OD0KISytWmYJhMHCTSldawhC9eeEYopuEplmQEXExGtnjcQcYt6GWkx3rPYBEb09xLoNW+Q4sIo
 iWPMZiprIlkJTijf/JQ85Z9Kq6oQv+H0vqdmbHTZEXO5f35rQN8qwORuziDKvvPsX5197F9qI1F
 Wr20d9i8SejoK0uT7ewowtxPGuTX+O+4a2StViFktLGrpAWLc0Sz1bLu54P32cztNLh4HQtVqv+
 5e0Y/fBmUpqzxFOt6PwfGFh8p+1+swNWcWxLomOcdTE8BELjSjEHkTgefMFwp3vSF4JVUymba2l
 +dkAzDbOX/npvjQ==
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
 drivers/i2c/i2c-mux.c | 107 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 95 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index d59644e50f14..6b5c9ae1efde 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -36,21 +36,75 @@ struct i2c_mux_priv {
 	u32 chan_id;
 };
 
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
@@ -61,15 +115,16 @@ static int i2c_mux_master_xfer(struct i2c_adapter *adap,
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
@@ -82,16 +137,17 @@ static int __i2c_mux_smbus_xfer(struct i2c_adapter *adap,
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
@@ -104,16 +160,17 @@ static int i2c_mux_smbus_xfer(struct i2c_adapter *adap,
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
@@ -362,6 +419,32 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
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
2.53.0

