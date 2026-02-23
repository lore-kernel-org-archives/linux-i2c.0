Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4092229B78B
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857234; cv=none; b=cK4r8cti75/Vpg5/uCOFwgMPJ5pN8W7sfYyqNLd2O/9AFx2jeUH3Y4mgeKXUnszl/75l9GjsAhZkeIiHA9v8yXclJ647lx8o7bHSu7qJJZl6z88X67WFvqCBw6mchSLczhIJQ+nmgC7K9IfvqfJbFxGoSYV2foXSCOXKcWrna+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857234; c=relaxed/simple;
	bh=T1ZRGejY53iNiPMBXm4VnJeMfnzHH7k7DvyBHsdYhe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s58W/tQNzVazkpymqfGGrFE3m3MDX27E91YpOnF+Ow/QEDL1vCXHDj6MC0gL4+vbHGhKUSr+RBi0q3wk0lcCd55vt3idZUTCFuMDUvs/kd1PwLwKqsmPOfMADCsK9m6mU/ot1IFQjVNCwUwj9iieZ0dPev/25lLz0GSEVBadbak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ed0iEA2Y; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed0iEA2Y"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59e607a3824so4917071e87.1
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 06:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771857230; x=1772462030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdwzVEey6I7USs7waZMdzZIVAgnmK4BTn29UGHk3ryw=;
        b=ed0iEA2YFSBitYXeS029S/mtcuSbSzbSMj3fHL3AiU+X+FLZEbgIJMDBw2xeJT1p2N
         rLTlGOnlLD7NZBZCr330PVcKQfnKUVAEQMJpZporWCrhR6hHe+NBxbAU5FiRGQNyjfe5
         iXBaaZ5eCEZNNZWSbdoJSOZb/DoPhLA2riqjuxsLJD9lZGfVhAtYvtZVk2zNpTjtm0kO
         8ey/jtmUV+Dmv+9Arz0XN/Fsytku0N8hO7xgRsGUgbmkMAgLRS/i9Shohc5nfaUzRKu3
         EVw7awpMbwDSrfLd8BHqzWILj7fJtLoQdZV51Fr6+70113Py3TFRvmS/6rxPh89OYnoh
         KJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771857230; x=1772462030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bdwzVEey6I7USs7waZMdzZIVAgnmK4BTn29UGHk3ryw=;
        b=BvC67MZxVOFWaLSDjGHbZu8S2CvQsyM41gX7BdUKSilVSOcgeDyiiMpjTHkgica4lO
         IPSGeA21jorxKAS8IfH48+T4gF0dXOgT4yU4H1E1uz86MYd/I3A1nHeDGCS6f8X4Uxjq
         6rJqEsmpvAZdIj+8W5VvcL3C8QxKT5buR6J1pxlXk/O+Ep2zp/7+4VcWtuVDQIjsIYtH
         Qq1QX46eGelVeawI1DpM3leS3JBSELvdDO7kodXaRxejBNsCYg43QwfqZnrg+j/Glfk+
         7DpzQI6rA57jcN5J6gmIRHBv8/P6+HbqB+yaKnaT8tipqkh/cBVKrDiFCqixnnrLV1Do
         C3eA==
X-Gm-Message-State: AOJu0YyLDjZguWpnStet11ZOusf0fz/Wn6xgzljh89uXIth4DXb6f33J
	x0JuAp2aFy+Rvbntm1EaYazDNeW5IgHRHH3F9TSxbgcZJtZ4wdydQDdN
X-Gm-Gg: AZuq6aJXHaHprFu+2wMsO0jg2yQYEylehf+gs8TTf22jYDb+uyfXmBtzQpX0tpy6C+8
	0S67bpPL0wAqNOOJKzNCFworumzKzYQ8TUZxQIZ5N5p+KN/fxG/Nduf06OfSl9UiaxKSlRABauF
	BZDgMGJ42Ff0TNYAIppG1P/trjwLv+06xtIPQrUwT5RxsdIWuXsH4QxA3/cIAHOh/Dw3ZrovvRv
	O1lU0uoTEIS70wOCcI7QS0TwRRELBkWynjoChyLARh3m31nLwgTPz10tSG8mgyWHwF/VIWeUuox
	BchJoSO+aSBn0MJrI6oKNs11TAyGR2S+jQTcflvQzDHRyxQJbL8wnp/Q7ncwhj7klCvZmyTRgqR
	GSBYnclxO7u+qvTvTp29IGUq4cf+UFWvK5BfQX3n9B8eim5B+E1AxFRNqAEQd7xfPBTtx/sq+uh
	xrmiagM970KPX44p3B+92A5Om7oNPR/JoV7xSfBuR4udbbTJAOgpakF+YJuM+covW4EssQ
X-Received: by 2002:a05:6512:3b88:b0:59e:2242:fbc with SMTP id 2adb3069b0e04-5a0ed89aaf1mr2837745e87.22.1771857230118;
        Mon, 23 Feb 2026 06:33:50 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb16344sm1631709e87.37.2026.02.23.06.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:33:49 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 23 Feb 2026 15:33:51 +0100
Subject: [PATCH v7 2/5] i2c: mux: add support for per channel bus frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-mux-v7-2-ec75b214718a@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7623;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=T1ZRGejY53iNiPMBXm4VnJeMfnzHH7k7DvyBHsdYhe0=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpnGVYCPqM91GgwZmF9aiuRWi3kupzj47baPEtT
 DDralVjMaKJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaZxlWAAKCRCIgE5vWV1S
 MofrD/9GqYIqO2Mb3oj/ExjXYNRw4CPXDesKMiydZsbTYzy/0s1Iosvhblktu/xEAiziD8mYldP
 JnntcUhFXTn1pIfGg/oZ/QHx49ZPAnVJdnzgu0U5UEoKE5pPomoIdRjs3bgIKiOUWeoPBjaHcK+
 lHmySCknIiKLafDQnlTH7MPJAcOKNCYy75nNEC4b2bT38T9ujKvFiwlNiax0qKWuSn8KGjYKZu8
 PtSFwvnNqK3GOLSdoBMCkSgvVLPzRRBHH3G7GHC6V+nNFpv57vlM93tLm3lD7+pa/fX9KCW2zvl
 sQ1g4XPoZ3hQclD7XhLRRLY2SQpCMBukenUjjysClTZzEY0bJ0jBcU1Y/2fQYKEsbMl0+er9ebJ
 GUeewjvEtKJ6gAKUgJ7TB3yy4mW7IP2It2JtfzCxjelNfl18gNpaKtnw6WXtfSbpSLLIkPFK98E
 jGkSNO06Mn4c3M94+ohA5db/O+WdOMFNZM4d6OXRfVfG5dxXrJdA6590srMDl8fS2yPuRrHYO8j
 u9dNCOiLyJ6CJ22pSXak4GBLKcEH6nwtM/93isyTZxjpYDhd7bgnFTklIHHeBYOQE3KeRAxQ/xk
 7Kxwl2SHt0ZTLDynJ3LKdEN0wvnR52pNaZBxYKQhFQOO5L2odiR1khuTMAweoU1wdnPHm01mx8V
 IRfl5jMG7k/p2+w==
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
 drivers/i2c/i2c-mux.c | 107 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 95 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index d59644e50f14..df18930d6ed4 100644
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
+		dev_dbg(&adap->dev, "Set clock frequency %dHz on %s\n",
+			priv->adap.clock_hz, parent->name);
+
+		if (ret)
+			dev_err(&adap->dev,
+				"Failed to set clock frequency %dHz on adapter %s: %d\n",
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
+		dev_dbg(&adap->dev, "Restored clock frequency %dHz on %s\n",
+			oldclock, parent->name);
+
+		if (ret)
+			dev_err(&adap->dev,
+				"Failed to set clock frequency %dHz on adapter %s: %d\n",
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
2.52.0

