Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3E934DB44
	for <linux-i2c@vger.kernel.org>; Wed, 28 Jan 2026 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594111; cv=none; b=YRS7ZYrOF19u/SZYc/Enndy4JDEuULg2o3cCM5tyH4rxzXjUf9mYCcsevq7VKbERvuSfLgpsy7Q34rK1nFxMfS9TFVwNydCwuPLQmiMUgx5s5KXiXBooWRvxEYxdXbOVolutbupiAGdXFzgfxQUN8erkEOPm83p1hin/7tnO01Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594111; c=relaxed/simple;
	bh=zGbz+pVrLmaMtnSNrlYn54fESL7esdXmRLMMNcwIf6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aqQA1rB5Kdy4nYvM06kFpWqtJ/3/pOtSzsm9KjAb+13qnuPQQKWGFl9wTVNImE9Hf+VqIK9RVlYSDkMgjMlWiKhvYoAjTHKCpqtzYMMx8mk93ja4C6CBmWotUQ1gzhPcXcFVLSpBbpFNxhhuke5vBwwaCsauhSheS+MP9S0fYI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8k2P5sI; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8k2P5sI"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59dd22b9895so891453e87.0
        for <linux-i2c@vger.kernel.org>; Wed, 28 Jan 2026 01:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769594108; x=1770198908; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=REfkVDw73DUSzPUXEtYPoiRdrz+NhebKMlsheaDJL7k=;
        b=O8k2P5sIJg35BYl833FdY29MXp4ykon4fwL3nnhCLwvZhyUmGAMElDN0fuu5xFzTT2
         DCM78+IzPiQhpFDz8zYzm0rIsmNRiNzlqLwNPvFj3a+ccmx7we6ZRs9StyONSTdgxJNe
         yADp07llGIckJu2N06d/9FWKYY9CXIKgh5x7ShV1w5yXh3deSdvTytRYbOMNI3JyNbwy
         g/eYDp6IOdqcxTOn6RQ8YCiDoQ7dBjjsgHHG9qXQkM3cadqN72gO8kZYJ4eHg/FjA03g
         yzMBp7ja404t8ZUuCyCDfdupAAjI1XbRCBJMGRL3RhRKL2YXoBqVHUuWIez517VGzzpf
         AQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769594108; x=1770198908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=REfkVDw73DUSzPUXEtYPoiRdrz+NhebKMlsheaDJL7k=;
        b=pMJunEm2hQQhTM5IoTn824lxYe3AAQmmdBuSq6tFJGg5SfdCBAZCezU/kWGPZByj7X
         02darjUpfV+XWGQA+XujOG/lAnFXbqbSfZZBMvDPqvnl3hGcD3HFxcLqf/4ZLvzeyFg5
         IXKeWKHFW3G35RMTRDsnec8XT5tU+Hc/fdnZ7v5jtQEZ1ocslVdweVYTz+RKzvidjCGl
         UrkjKM7zIU+NMIJTkaFvHx7wqe26hxLbJqdOpF93ExfT0kDOf6FVxqJgaUJfmPQgn2B3
         GlNp2zPmg3SVz5uhBTXt7Cvz+Bh4qXI1w6RQLje4/4aBOKujgc8x8i2V1qOU+KjkBcZT
         mDzg==
X-Gm-Message-State: AOJu0YzLzM4avojLHmwyEIOp25Q3GpJho8/a5e3h9NI2znQJr+bSNP+q
	nv0eEkqaEhZUH9cXeC8dTrZmzQE8tPZ+SVeE0VRWxyHztDe4tfGJvZoN
X-Gm-Gg: AZuq6aKG5hTIiRWI/2aANgdkpgYaJKioZj6A+xJUMbBAHidQVTM93IyQ9zzaXq9+Bh/
	XhOvmVjIISZsNlgrAHPyi0u1zdHlUprpdtVm66j7GW2xs1m8zOxAn3Y+dVafrCOqnukKx6NRO+V
	mKK3h+nrv0ZAIVGlrAfJBPdq4u7AN6fEI43PHMddYzyjl1Q2Soc1iShwMQk//2cud3bMIM4d2wj
	VLPdpXsvbOjIpy1CUE+1Mo/QnzdFb8Vgo9rQ+ZC5GaGCGQ8eMup+2p8tKS1p55MFb91LIvA9MPg
	x5KMRzZh1ZWvKtbX9LTy1f73CmNq1NIAFqtif2F7HzjwAAYI+7+kglmgC2iAWEDt6II9PACoG35
	E9qryBoyFiMvxInykOOxTPmoSL3sm0eF7qrvANV+WAP82UeOqOPZOmigPbRdGlNq//4oOcUOAxV
	dlD7Q71AP33ZkWz2+66/Yz0sOYNEic+u3Dgfl/VwEB2Udxz6HH6bzDjurs
X-Received: by 2002:ac2:4e10:0:b0:59d:db30:8848 with SMTP id 2adb3069b0e04-59e0413824fmr2086926e87.16.1769594107272;
        Wed, 28 Jan 2026 01:55:07 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074bfe83sm459483e87.97.2026.01.28.01.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:55:05 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 28 Jan 2026 10:54:28 +0100
Subject: [PATCH v4 2/5] i2c: mux: add support for per channel bus frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-i2c-mux-v4-2-dee49ce276c0@gmail.com>
References: <20260128-i2c-mux-v4-0-dee49ce276c0@gmail.com>
In-Reply-To: <20260128-i2c-mux-v4-0-dee49ce276c0@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Peter Rosin <peda@axentia.se>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7463;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=zGbz+pVrLmaMtnSNrlYn54fESL7esdXmRLMMNcwIf6k=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpedzm0S4PL15YJnIkLNwLSsRAPOQD+Ms7LXZSU
 Nq5cqqtauqJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaXnc5gAKCRCIgE5vWV1S
 MhOeEADTIxXYKIPxrPfFpvluokTAsbhQb0ncWTgS4dNJ+H4iFQUPs6mVvw2aLi6tRkFd12IN38z
 kD7v3jJ2b8w2IwM6Qd4CCeAqiSUklrQSiA4beaQt2Akh6pOlsWXejatmLZdta84hSsDQSEs7Dr/
 efMnf6gyV+NuLovi1qWP9KeTlHBb80vQvbmH5oJobUwuemVP7GR/UowDN9JyUhzEGAftHOdtlEn
 4vH1tmnf1DsxR5JwMjszsCrnK4ykPdoJY4FRnnCni/hhr1rtFXSpFptHCSa0Ncr0kL6ptJXkYZc
 3Fw7I8lOSCRYxhJtpDd2QxQ/oJGa6moQF95VOI2Nix3LT6vZPppt4ijI72KB2a26FQiBOgae4uj
 xSVBaNbBD3hu/0qznCpYwSW6MYv+oGWCCu8a9zCVeyQfX7sakTladFxBLvUk7xwTHNfdv1D60lV
 wew3trRfE9mvIODbRz+IC9lIxbsOSwSjSSDqXMdo34akdh6yTybk503NdcFwrfIJJCNzkdrbXNC
 Gk9+8LEJCaYspLKV/nCfW7nR/isiMUWV5zKe7WtcJQGfRyBi1O23Rn7pi9ecEPaGP5wH//NPfoF
 9I/GppOi3KiGlQYw3crh7BAK1oJ5SObwylvujkYA6M0xav0cA+UDPTJSvr+55z7Qe5FxUsu9Bk8
 pkE2rqQU7+EviHg==
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
 drivers/i2c/i2c-mux.c | 116 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 104 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index d59644e50f14..b7974161be4a 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -36,6 +36,72 @@ struct i2c_mux_priv {
 	u32 chan_id;
 };
 
+static int i2c_mux_select_chan(struct i2c_adapter *adap, u32 chan_id)
+{
+	struct i2c_mux_priv *priv = adap->algo_data;
+	struct i2c_mux_core *muxc = priv->muxc;
+	struct i2c_adapter *parent = muxc->parent;
+	struct i2c_adapter *root;
+	int ret;
+
+	if (priv->adap.clock_hz && priv->adap.clock_hz != parent->clock_hz) {
+		root = i2c_root_adapter(&adap->dev);
+
+		/* if we are parent-locked and the root adapter is our parent,
+		 * we already have the lock we need. Otherwise take the bus lock for the root
+		 * adapter before changing bus clock.
+		 */
+		if ((root != parent && !muxc->mux_locked) || muxc->mux_locked)
+			i2c_lock_bus(parent, I2C_LOCK_ROOT_ADAPTER);
+
+		ret = i2c_adapter_set_clk_freq(root, priv->adap.clock_hz);
+
+		if ((root != parent && !muxc->mux_locked) || muxc->mux_locked)
+			i2c_unlock_bus(parent, I2C_LOCK_ROOT_ADAPTER);
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
+	struct i2c_adapter *root;
+	int ret;
+
+	if (parent->clock_hz && parent->clock_hz != priv->adap.clock_hz) {
+		root = i2c_root_adapter(&parent->dev);
+
+		/* if we are parent-locked and the root adapter is our parent,
+		 * we already have the lock we need. Otherwise take the bus lock for the root
+		 * adapter before changing bus clock.
+		 */
+		if ((root != parent && !muxc->mux_locked) || muxc->mux_locked)
+			i2c_lock_bus(parent, I2C_LOCK_ROOT_ADAPTER);
+
+		ret = i2c_adapter_set_clk_freq(root, parent->clock_hz);
+
+		if ((root != parent && !muxc->mux_locked) || muxc->mux_locked)
+			i2c_unlock_bus(parent, I2C_LOCK_ROOT_ADAPTER);
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
@@ -46,11 +112,11 @@ static int __i2c_mux_master_xfer(struct i2c_adapter *adap,
 
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
@@ -65,11 +131,11 @@ static int i2c_mux_master_xfer(struct i2c_adapter *adap,
 
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
@@ -86,12 +152,12 @@ static int __i2c_mux_smbus_xfer(struct i2c_adapter *adap,
 
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
@@ -108,12 +174,12 @@ static int i2c_mux_smbus_xfer(struct i2c_adapter *adap,
 
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
@@ -362,6 +428,32 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
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

