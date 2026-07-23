Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14910459AEF;
	Thu, 23 Jul 2026 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804714; cv=none; b=RmidzXGvj9RPGykZsF/DXRzDPmO+4e7WbBrNXcMy2nMCESRZ5ncfN3ewuUwMIkC7TW8kx4FtwZ7NFQPCZ2Tg3QaMcmgVx4Ov6/t8N3TRM+oLKx/Oh/OaEQJOwm6FIHxdMJRD79NxZx3Bpw49oxldAuGP6JliM1CC12UYABT3JTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804714; c=relaxed/simple;
	bh=PMMLowy+9nbpC+5vjfS+xHkoqPlnv6tY6J1fkYEq/OY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QUinGCpb41tHYNVbHK+WecpvRlNG+iZ3QTixXtEykUu+0m0CZxGrV97JS18qcxxRQa1ow6hEr2kUcp4GYlhor1cd52Omo2cEhHO+q2koPDxMP+hteGo1oBYPIBmNKJm4pKjGhbG0OUu/Mi7Y+NWuoa3Hs53qpyvfxJ33SqQ6hqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=No5OH6X2; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=No5OH6X2; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=A4N9c8t2; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="No5OH6X2";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="No5OH6X2";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="A4N9c8t2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784804709;
	bh=PMMLowy+9nbpC+5vjfS+xHkoqPlnv6tY6J1fkYEq/OY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=No5OH6X247+cMNXlGvBPUsRYzBy5GzPJXF/wxi2Uw8Ts+0bIpfzmQ2uFWsF9ojEa5
	 03NcsAm0BTJ3IpDpsio4YN1bYx0fLrFm64MSyMFPB3VCeWw8VT7VlVTsmeyJu+ux9s
	 dUBnBrWuyxB3bhqXXeZtdn1s+kTdX9lZJ+hl4DXghesmR2f58p9Ko6I+/wU8vc25gJ
	 Hq83QCKrmjD/aTeNugBELxIn8rx0Qci/RMBhF0/suvRU+I4F6vHuk2nVUaJmgRrpNm
	 4NJA3Br7NJrhR8cEVhhdHeM/no1WLzMFKjH5/LscWqGES7WHhSzDI3TXARmLCBAuk9
	 BNDWATgMXaL8g==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id CBF641BAA9;
	Thu, 23 Jul 2026 13:05:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784804709;
	bh=PMMLowy+9nbpC+5vjfS+xHkoqPlnv6tY6J1fkYEq/OY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=No5OH6X247+cMNXlGvBPUsRYzBy5GzPJXF/wxi2Uw8Ts+0bIpfzmQ2uFWsF9ojEa5
	 03NcsAm0BTJ3IpDpsio4YN1bYx0fLrFm64MSyMFPB3VCeWw8VT7VlVTsmeyJu+ux9s
	 dUBnBrWuyxB3bhqXXeZtdn1s+kTdX9lZJ+hl4DXghesmR2f58p9Ko6I+/wU8vc25gJ
	 Hq83QCKrmjD/aTeNugBELxIn8rx0Qci/RMBhF0/suvRU+I4F6vHuk2nVUaJmgRrpNm
	 4NJA3Br7NJrhR8cEVhhdHeM/no1WLzMFKjH5/LscWqGES7WHhSzDI3TXARmLCBAuk9
	 BNDWATgMXaL8g==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id B078E1BA30; Thu, 23 Jul 2026 13:05:09 +0200 (CEST)
X-Spam-Level: 
X-Spam-Score: -1.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784804703;
	bh=PMMLowy+9nbpC+5vjfS+xHkoqPlnv6tY6J1fkYEq/OY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=A4N9c8t2etTImh1k1TF+AtonkC56F/Y2WvBOsmsOR12HNTRbEhGM5ijSG4OAdRQ8j
	 vlDDXNf4Q/b3ssVUT6epOVl9dtVwEK4CFneErAqc5eyiv/6olLMnzhhUhipp1ScKae
	 Y9Tq2IPPEIaxUnc3pbPHtHNL2SIowamSmGTy9Zzudb8rqF+ZaKnWcV875/nro4kaHV
	 pLb1jeUyISLpvmzlRYD1fvWNKEHBE4d5Q2rrH5GEBYeew6U/Y7/f4hHbG+ntdaYOJs
	 6OOPVskxuzqb3tFdGrRCyqL6Oxotxdl59bD84FSKtas8/Df7LvGUX7MA3BI3HS3n3D
	 uJgr0efmqW0Dg==
Received: from [192.168.2.172] (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 99C711BA9E;
	Thu, 23 Jul 2026 13:05:03 +0200 (CEST)
Message-ID: <547ce6b9-8028-4737-bb0f-3c134582ba7e@lysator.liu.se>
Date: Thu, 23 Jul 2026 13:05:03 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Peter Rosin <peda@lysator.liu.se>
Subject: Re: [PATCH v12 3/7] i2c: mux: add support for per channel bus
 frequency
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260719-i2c-mux-v12-0-a5010d623a57@gmail.com>
 <20260719-i2c-mux-v12-3-a5010d623a57@gmail.com>
Content-Language: en-US, sv-SE
In-Reply-To: <20260719-i2c-mux-v12-3-a5010d623a57@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP

Hi!

On 2026-07-19 16:59, Marcus Folkesson wrote:
> There may be several reasons why you may need to use a certain speed
> on an I2C bus. E.g.
> 
> - When several devices are attached to the bus, the speed must be
>    selected according to the slowest device.
> 
> - Electrical conditions may limit the usable speed on the bus for
>    different reasons.
> 
> With an I2C multiplexer, it is possible to group the attached devices
> after their preferred speed by e.g. putting all "slow" devices on a
> separate channel on the multiplexer.
> 
> Consider the following topology:
> 
>                        .----------. 100kHz .--------.
>      .--------. 400kHz |          |--------| dev D1 |
>      |  root  |--+-----| I2C MUX  |        '--------'
>      '--------'  |     |          |--. 400kHz .--------.
>                  |     '----------'  '-------| dev D2 |
>                  |  .--------.               '--------'
>                  '--| dev D3 |
>                     '--------'
> 
> One requirement with this design is that a multiplexer may only use the
> same or lower bus speed as its parent.
> Otherwise, if the multiplexer would have to increase the bus frequency,
> then all siblings (D3 in this case) would run into a clock speed it may
> not support.
> 
> The bus frequency for each channel is set in the devicetree. As the
> i2c-mux bindings import the i2c-controller schema, the clock-frequency
> property is already allowed.
> If no clock-frequency property is set, the channel inherits their parent

channels inherit their parent
the channel inherits its parent
or
the channel inherits the parent

> bus speed.
> 
> The following example uses dt bindings to illustrate the topology above:
> 
>      i2c {
> 	clock-frequency = <400000>;

Indenting with a tab on this line, spaces everywhere else in the
block.

> 
>          i2c-mux {
>              i2c@0 {
>                  clock-frequency = <100000>;
> 
>                  D1 {
>                      ...
>                  };
>              };
> 
>              i2c@1 {
>                  D2 {
>                    ...
>                  };
>              };
>          };
> 
>          D3 {
>              ...
>          }
>      };
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>   drivers/i2c/i2c-mux.c | 161 ++++++++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 149 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index b126ce7338c2..00de5f124132 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -36,21 +36,118 @@ struct i2c_mux_priv {
>   	u32 chan_id;
>   };
>   
> +static inline int
> +__i2c_adapter_set_clk_freq(struct i2c_adapter *adapter, u32 clock_Hz)
> +{
> +	/* If the clock frequency is already set to the requested value, do nothing. */

Long lines of text are hard to read. Please keep code and
especially text and comments below 80 columns. Sometimes it
can certainly be useful and clearer if you break that "rule",
but make that exceptional.

See "2) Breaking long lines and strings" in coding-style.

> +	if (adapter->clock_Hz == clock_Hz)
> +		return 0;
> +
> +	if (adapter->set_clk_freq) {
> +		adapter->clock_Hz = adapter->set_clk_freq(adapter, clock_Hz);
> +		if (adapter->clock_Hz != clock_Hz)
> +			dev_warn(&adapter->dev, "Could not set requested frequency. Requested %uHz, got %uHz\n",
> +				 clock_Hz, adapter->clock_Hz);
> +
> +		return 0;

Why is this not an error?

> +	}
> +
> +	/*
> +	 * If the adapter is a root adapter without .set_clk_freq() implemented, this feature is not
> +	 * supported.
> +	 */
> +	if (!i2c_parent_is_i2c_adapter(adapter))
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * Update the clock_Hz for non-root adapters, even if .set_clk_freq() is not implemented,
> +	 * to allow the clock frequency to be propagated to root adapters that do support it.
> +	 */
> +	adapter->clock_Hz = clock_Hz;
> +	return 0;
> +}
> +
> +static inline int
> +i2c_adapter_set_clk_freq(struct i2c_adapter *adapter, u32 clock_Hz)
> +{
> +	int ret;
> +
> +	i2c_lock_bus(adapter, I2C_LOCK_SEGMENT);
> +	ret = __i2c_adapter_set_clk_freq(adapter, clock_Hz);
> +	i2c_unlock_bus(adapter, I2C_LOCK_SEGMENT);
> +
> +	return ret;
> +}
> +
> +static int i2c_mux_select_chan(struct i2c_adapter *adap, u32 chan_id, u32 *oldclock)
> +{
> +	struct i2c_mux_priv *priv = adap->algo_data;
> +	struct i2c_mux_core *muxc = priv->muxc;
> +	struct i2c_adapter *parent = muxc->parent;
> +	int ret;
> +
> +	if (priv->adap.clock_Hz && priv->adap.clock_Hz < parent->clock_Hz) {
> +		*oldclock = parent->clock_Hz;
> +
> +		if (muxc->mux_locked)
> +			ret = i2c_adapter_set_clk_freq(parent, priv->adap.clock_Hz);
> +		else
> +			ret = __i2c_adapter_set_clk_freq(parent, priv->adap.clock_Hz);
> +
> +		dev_dbg(&adap->dev, "Set clock frequency %uHz on %s\n",
> +			priv->adap.clock_Hz, parent->name);
> +
> +		if (ret)
> +			dev_err(&adap->dev,
> +				"Failed to set clock frequency %uHz on adapter %s: %d\n",
> +				*oldclock, parent->name, ret);

I think the whole select operation should fail and abort if
the attempt to lower the bus speed fails. Having unexpected
high speed transfers on a segment is not good.

Also, *oldclock seems to be the wrong frequency to print?

> +	}
> +
> +	return muxc->select(muxc, priv->chan_id);
> +}
> +
> +static void i2c_mux_deselect_chan(struct i2c_adapter *adap, u32 chan_id, u32 oldclock)
> +{
> +	struct i2c_mux_priv *priv = adap->algo_data;
> +	struct i2c_mux_core *muxc = priv->muxc;
> +	struct i2c_adapter *parent = muxc->parent;
> +	int ret;
> +
> +	if (muxc->deselect)
> +		muxc->deselect(muxc, priv->chan_id);
> +
> +	if (oldclock && oldclock != priv->adap.clock_Hz) {
> +		if (muxc->mux_locked)
> +			ret = i2c_adapter_set_clk_freq(parent, oldclock);
> +		else
> +			ret = __i2c_adapter_set_clk_freq(parent, oldclock);
> +
> +		dev_dbg(&adap->dev, "Restored clock frequency %uHz on %s\n",
> +			oldclock, parent->name);
> +
> +		if (ret)
> +			dev_err(&adap->dev,
> +				"Failed to set clock frequency %uHz on adapter %s: %d\n",
> +				oldclock, parent->name, ret);
> +	}
> +}
> +
>   static int __i2c_mux_master_xfer(struct i2c_adapter *adap,
>   				 struct i2c_msg msgs[], int num)
>   {
>   	struct i2c_mux_priv *priv = adap->algo_data;
>   	struct i2c_mux_core *muxc = priv->muxc;
>   	struct i2c_adapter *parent = muxc->parent;
> +	u32 oldclock = 0;
>   	int ret;
>   
>   	/* Switch to the right mux port and perform the transfer. */
>   
> -	ret = muxc->select(muxc, priv->chan_id);
> +	ret = i2c_mux_select_chan(adap, priv->chan_id, &oldclock);
>   	if (ret >= 0)
>   		ret = __i2c_transfer(parent, msgs, num);
> -	if (muxc->deselect)
> -		muxc->deselect(muxc, priv->chan_id);
> +
> +	i2c_mux_deselect_chan(adap, priv->chan_id, oldclock);
>   
>   	return ret;
>   }
> @@ -61,15 +158,16 @@ static int i2c_mux_master_xfer(struct i2c_adapter *adap,
>   	struct i2c_mux_priv *priv = adap->algo_data;
>   	struct i2c_mux_core *muxc = priv->muxc;
>   	struct i2c_adapter *parent = muxc->parent;
> +	u32 oldclock = 0;
>   	int ret;
>   
>   	/* Switch to the right mux port and perform the transfer. */
>   
> -	ret = muxc->select(muxc, priv->chan_id);
> +	ret = i2c_mux_select_chan(adap, priv->chan_id, &oldclock);
>   	if (ret >= 0)
>   		ret = i2c_transfer(parent, msgs, num);
> -	if (muxc->deselect)
> -		muxc->deselect(muxc, priv->chan_id);
> +
> +	i2c_mux_deselect_chan(adap, priv->chan_id, oldclock);
>   
>   	return ret;
>   }
> @@ -82,16 +180,17 @@ static int __i2c_mux_smbus_xfer(struct i2c_adapter *adap,
>   	struct i2c_mux_priv *priv = adap->algo_data;
>   	struct i2c_mux_core *muxc = priv->muxc;
>   	struct i2c_adapter *parent = muxc->parent;
> +	u32 oldclock = 0;
>   	int ret;
>   
>   	/* Select the right mux port and perform the transfer. */
>   
> -	ret = muxc->select(muxc, priv->chan_id);
> +	ret = i2c_mux_select_chan(adap, priv->chan_id, &oldclock);
>   	if (ret >= 0)
>   		ret = __i2c_smbus_xfer(parent, addr, flags,
>   				       read_write, command, size, data);
> -	if (muxc->deselect)
> -		muxc->deselect(muxc, priv->chan_id);
> +
> +	i2c_mux_deselect_chan(adap, priv->chan_id, oldclock);
>   
>   	return ret;
>   }
> @@ -104,16 +203,17 @@ static int i2c_mux_smbus_xfer(struct i2c_adapter *adap,
>   	struct i2c_mux_priv *priv = adap->algo_data;
>   	struct i2c_mux_core *muxc = priv->muxc;
>   	struct i2c_adapter *parent = muxc->parent;
> +	u32 oldclock = 0;
>   	int ret;
>   
>   	/* Select the right mux port and perform the transfer. */
>   
> -	ret = muxc->select(muxc, priv->chan_id);
> +	ret = i2c_mux_select_chan(adap, priv->chan_id, &oldclock);
>   	if (ret >= 0)
>   		ret = i2c_smbus_xfer(parent, addr, flags,
>   				     read_write, command, size, data);
> -	if (muxc->deselect)
> -		muxc->deselect(muxc, priv->chan_id);
> +
> +	i2c_mux_deselect_chan(adap, priv->chan_id, oldclock);
>   
>   	return ret;
>   }
> @@ -363,6 +463,43 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
>   			}
>   		}
>   
> +		of_property_read_u32(child, "clock-frequency", &priv->adap.clock_Hz);
> +
> +		/* If the mux adapter has no clock-frequency property, inherit from parent */
> +		if (!priv->adap.clock_Hz)
> +			priv->adap.clock_Hz = parent->clock_Hz;
> +
> +		if (priv->adap.clock_Hz < parent->clock_Hz)
> +			if (muxc->idle_state != I2C_MUX_IDLE_DISCONNECT ||
> +			    muxc->idle_state == chan_id) {

This logic is botched.

If idle_state isn't IDLE_DISCONNECT, then it doesn't matter if if is
or isn't equal to chan_id. If it is IDLE_DISCONNECT, then it certainly
isn't equal to chan_id.

Did you perhaps mean:

	if ((muxc->idle_state < 0 &&
	     muxc->idle_state != I2C_MUX_IDLE_DISCONNECT) ||
	    muxc->idle_state == chan_id) {

or

	if (muxc->idle_state == I2C_MUX_IDLE_UNKNOWN ||
	    muxc->idle_state == I2C_MUX_IDLE_AS_IS ||
	    muxc->idle_state == chan_id) {

> +				dev_err(muxc->dev,
> +					 "channel %u has improper idle state for this configuration\n",
> +					 chan_id);
> +				of_node_put(mux_node);
> +				ret = -EINVAL;
> +				goto err_free_priv;

You potentially leak child here...

> +			}
> +
> +		/*
> +		 * Warn if the mux adapter is not parent-locked as
> +		 * this may cause issues for some hardware topologies.
> +		 */
> +		if ((priv->adap.clock_Hz < parent->clock_Hz) && muxc->mux_locked)
> +			dev_warn(muxc->dev,
> +				 "channel %u is slower than parent on a non parent-locked mux\n",
> +				 chan_id);
> +
> +		/* We don't support mux adapters faster than their parent */
> +		if (priv->adap.clock_Hz > parent->clock_Hz) {
> +			dev_err(muxc->dev,
> +				"channel (%u) is faster (%u) than parent (%u)\n",
> +				chan_id, priv->adap.clock_Hz, parent->clock_Hz);
> +
> +			of_node_put(mux_node);
> +			ret = -EINVAL;
> +			goto err_free_priv;

...and here.

Cheers,
Peter

> +		}
> +
>   		priv->adap.dev.of_node = child;
>   		of_node_put(mux_node);
>   	}
> 

