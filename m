Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E667326945
	for <linux-i2c@vger.kernel.org>; Sat, 14 Mar 2026 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773480152; cv=none; b=b+4EE5H3oAAsdJoZ9V9sGXHUWTBbdElHzfgo8BLbsBVWEbF7pH0TUIAMO1RwG19C6CC/8i32OjVU5sm45MN2t9C2X8GG4ww3ty+PI4kteO+nEKIzHWCoiP+Uk19udTqrXJW/E28flm+ILe+yQYq9dMWaeKgfPyNqZw0R3l5RdGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773480152; c=relaxed/simple;
	bh=zzwP/dH6nVUsUc4kUSRaQrWbWPe+IT1e5Ig8MAfNhhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uU+I+LxSWvsBW84Dpa4vBbH/tZc+ShH0zRoa/1ByiUpSj3wvAQ7kEcacl+VabPEssU6BEtsxih6+VHl7uDnklnlF1jJ+8Ex7MYAFco53YLkXvgM1D6t2X2yfuF43/tZVZ3EA7dAmXk3LrXTgqxeTfCeUqMxXB/rsno/OZBVZX+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxufLKx1; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxufLKx1"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38a2544b52bso26118271fa.3
        for <linux-i2c@vger.kernel.org>; Sat, 14 Mar 2026 02:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773480149; x=1774084949; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AASvAwH/C6MYHGsYw3qf0hanl2I5flhOZHJJpYjf0HE=;
        b=PxufLKx1n8IROx50vrHYBiSlBPNMIoObStaOmjQsVXwZfjKkNnQvPDjG54JDb5fGUk
         EBQK7/MkDvbABfu1HxUcS/WUAYi836abL07nEG0gaVoW3JE8DebblMwZ5/QvfJ/L5DOc
         FhCtPyElv/AvjaDAWAJhHoaF6T4pSPrZYUkB/RG6V2GPapQE/pUnL63rdk55d0OzHX+d
         gtPI8cb16z67W3mdO51QgUAGtmrhXhUZ7ok9O7uOTLI/jqXKt6VPPmJu2ksUnqe5h7KQ
         7fmrDqgAL5IjRrvWpXiOqKdbUSEPqmmW6GO/Y6YBMLANzmcdj82mzK4icNLGu7Bh723x
         dONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773480149; x=1774084949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AASvAwH/C6MYHGsYw3qf0hanl2I5flhOZHJJpYjf0HE=;
        b=cqVZSqjXKzLDF/teKh3IAYD11BQcvaQecK/G00jkakQ84olgH3C3XUeBbuOspdWeQG
         GiTj6dYg0YkdjAQKUao8hG7O+Z1g5tAxScTnd9Z9IGO9b00qTgiO2N/H8iBElnJHAOWU
         /X7quGAdUmVTi8gBDbyDTYFdwhsMPRviNoAvVflLR/qgir1/O1Bjqp4XYw93ESa0niem
         FHzaJk64e2kNXCYWCAc7TpAI75EmwpWheNB23049YOnTnPldD2C3y96baSoYLWzrYwEq
         TpWMssqq/WyH/LdzxHTIneLBoCdVmAz1r1vaazkDNJj6gOtgktZssIE+wa0kpK5XlxtF
         PJAg==
X-Gm-Message-State: AOJu0Yz1NbCQca1S8vH9oNNKJgK2pozthEDm1BVreU8m2atoTcbMdt1d
	iD3U0iAZkJoEQiIrcmnpCx5svjtwLRciaAbqReD0ulWDEWkG/9qj8+iC
X-Gm-Gg: ATEYQzzUbuvjDBAzBrLpQZaA7XgRgRrMc0wcm75e12i0UTiQKtkb0XYnshjXJt46Ila
	CsPKO9LQHeX9buvFIeQ6p2jlhDk0YB2Uyue9ybVJLpEAkYXn1FN9Ozbzp2WH1Za8VrMR2kALhF5
	EBnBj8oFPpnBZKNKrX0HBJonOj3NbtIK1/Pd6amlrt/Epy+1WOhiQ12n+yk23PYB/lD0rJhdPC7
	n+bxmp/oq+e/MLu89W8NFerchIUkffj7jCPm6rYhsuB3YLLSLwgcI1fULWVsx9xKUT5jK44HoHV
	awaEcclEB3qZxL5IbXOqpmJ5frhsc0Pppxb6iJ1lANppFATFAqckqFX/KwcMSkD6V1sU5C0Fw55
	uBJ+nx/7RDfw5IIVetj0X2LGofzZ6UXmKf89f7D65H4UHDO9oAvljYPw7geUu/qFS9GW0uiGSpv
	YBAjl44+/l9SAomKeL2s8qksbWFV4YTTgabxZJYMramkxVJrbcwTIUg9h/x/vvcRlBIxdv
X-Received: by 2002:a05:651c:255a:20b0:385:b6e7:8162 with SMTP id 38308e7fff4ca-38a897b6af9mr15582251fa.33.1773480148366;
        Sat, 14 Mar 2026 02:22:28 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e5ec94sm18454261fa.22.2026.03.14.02.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 02:22:27 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sat, 14 Mar 2026 10:22:41 +0100
Subject: [PATCH v8 2/5] i2c: mux: add support for per channel bus frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-i2c-mux-v8-2-fb1738a4df0a@gmail.com>
References: <20260314-i2c-mux-v8-0-fb1738a4df0a@gmail.com>
In-Reply-To: <20260314-i2c-mux-v8-0-fb1738a4df0a@gmail.com>
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
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBptSj1C8TDAhIQpBI60mQB5ccWeB7QNalrfr8hu
 zgjKTD2Gb6JAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCabUo9QAKCRCIgE5vWV1S
 MpavEADKxjVy45nAOEczctYlkpyhTX3jHAGphbwfKmX1mosiif+XXwdgsxS3L1pbZ+NkdilxS05
 9kMxy/9RudKnI8gerWBmYAuQJT8Q4sfCEenOZcemlH51eIq9QOFiux1OLYbzOkutLIxFuTVrWt2
 bTU0oWzEsw6HZRPmYM4yBZACWs97rLOsj1M3JCfP4/w1ZKUfSYgTXoPyNpsiMI6EY3MQL3YapAG
 lQICjE/Lhq3rfDBKdbRo6UDukrMToHKwqLOUSX66GwHYYtxfJXlBx4FUnIYc7fS/s1Chk1XuyvR
 SjmJRaZZYOJej+Ml+of4e1XmGJOXva3744VvXGsA9fitwjhcuR6qTiPp3N0X5ea+EDiX52DDJFz
 0IwslOoJ6E2em3Q52GManFlwIJYnXRpHQsE23bPlgVY/QonG7cBM2wm1RsiPJ4AdDAejkZTcY24
 uv47WLc5pn1hyf67GSbUWBmn5taiFDJDL30MWs2jV013KlxydJzugHyf0FHHfRQruo8OqViA8wf
 rejh2KvOIcX4hIw4VNmlrlBjC2aadLutioqZp+zaa7fo6As90/OXCauZdOcvS6xXgwvwnlDUV2c
 epNXl2pk7KOcheruGcUINQzse0xOGoV+hvKhlfsyn30kFr5XdLdhrt3xRSlun4u7T70Q86X88sn
 3W2M4EW8rs5B9GA==
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

