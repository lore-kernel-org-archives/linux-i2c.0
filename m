Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD60254AFF;
	Tue, 25 Aug 2026 05:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787637060; cv=none; b=NbzS37qQHyO9qZS8FzNHC6Bn5lsrwfV4dLVAloSHvNnBfrZNyTJ19C5JD/JaBydZVo2X6/APCNa5f+dAJSHdauYGgTWOxlghsE8Y0sIgeDNClqLDpVraier43aTIH9g6yjPJJq4B6/XK7e6hjAE8W8l19M4Ns0d2kpyLTEHOS8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787637060; c=relaxed/simple;
	bh=+kqgKdHXTUtelJvlPdHF20w+WsZ/8w83HVh2udHxZOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3+N8n0rDW2eUxpNZAlC63OVzw0WepKoAVIFONGXZtRfzgcxFA/WPUj2TGRFGLAENwsRCPDS3vPMQnTlX6XOFXTNk8VzUv5KPMlqDf+9g2ufLsR2kceSJJp9zOamymBbgijWCOoS1pkTMJw1sL25ymskCb5sK66ugSIBhhoH/RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=nf9sS4Pn; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=StAHie+G; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="nf9sS4Pn";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="StAHie+G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1787637056;
	bh=+kqgKdHXTUtelJvlPdHF20w+WsZ/8w83HVh2udHxZOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nf9sS4PnciImCFa0j4+l2RUmoNUp+HjjHZNA+VYjocSK3NznWAYUB5a3atXpqFFf/
	 3ruZ7h1Z82bzWy3Xz1d/rb7hcC1gvf771pEPKAXGDS3ilau2SmnhtYmo81tKzK5jd/
	 cZT+bqLvk2tXrECm/+PuPo0JOioUrLhyZzUxfAmU7ZzMNRLQ3LIKRIXKIOi7KlNH+h
	 PQyP9VdgHeWuY36Syzn5ypqTcV8PcwRrtCmmcQvA67heBZeO3GS6aKCle8XZFntb6U
	 +/bp801SVPg1+OD3vH5hyJ0ienoGUUXi6g1b4pxcaqApoxVc1YmaU0gx7ZWC7+2YRG
	 e70Lgwrl88DZA==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 153DD14DC7;
	Tue, 25 Aug 2026 07:50:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1787637055;
	bh=+kqgKdHXTUtelJvlPdHF20w+WsZ/8w83HVh2udHxZOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=StAHie+GEz00PoTmz8+bphrPV/5k+1FdoPjWNkzPxzu+eoa1hIT2xte5975swUmkW
	 lCOsS3CJuT2KYxbuMEV+LfeKJndkUkr6ou5jHv+SaDdSf+LzM1G5/K8pbh1hNppFso
	 nHvl8HuADPm4WZLvC6Tnxf/SrV8DtEw0B0U5sT8mRlxtSX7kjwgDuOZaHp3V2S7SlV
	 rMb1kbg4Rx5LcG6PdFxUsbTADGAyMu5RqZ+U6q+Z0dbdkMWKjVF9xlg7Cqm8+XGXaW
	 /dvXH11A7Fo3iqBLyIGUT5Tg5pMDeH8jcPc5F5a/N7kEmsjNUUMiisJeuR7fTO8msA
	 Fnqz0AIpi1uXQ==
Received: from gryt (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id CC17C14F0E;
	Tue, 25 Aug 2026 07:50:55 +0200 (CEST)
Date: Tue, 25 Aug 2026 07:50:54 +0200
From: Peter Rosin <peda@lysator.liu.se>
To: Ahmad Byagowi <ahmadexp@gmail.com>, Andy Shevchenko <andy@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/3] i2c: mux: Propagate software nodes to channel
 adapters
Message-ID: <ao0tPhBvK1Er_Vs0@gryt>
References: <cover.1787502619.git.ahmadexp@gmail.com>
 <a4abcd31c3a6758e219f5edcdd4acd307e674f18.1787502619.git.ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4abcd31c3a6758e219f5edcdd4acd307e674f18.1787502619.git.ahmadexp@gmail.com>
X-Virus-Scanned: ClamAV using ClamSMTP

Hi!

[Adding Andy]

Den Sun, Aug 23, 2026 at 09:34:38AM -0700, skrev Ahmad Byagowi:
> Device Tree channel nodes are associated with the adapters created by
> i2c-mux, but equivalent software-node descriptions are not.
> 
> Use generic firmware-node operations for the existing channel lookup and
> accept either an OF node or a software node. Associate the returned node
> with the adapter so child I2C devices can be instantiated from
> software-node properties.
> 
> Save the adapter firmware node before adapter deletion and release the
> reference afterwards, following the lifetime pattern in i2c-atr.
> 
> Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
> ---
>  drivers/i2c/i2c-mux.c | 45 +++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index a8b94b97a725..b37d36d3b121 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -25,6 +25,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/property.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
>  
> @@ -264,40 +265,40 @@ static const struct i2c_lock_operations i2c_parent_lock_ops = {
>  	.unlock_bus =  i2c_parent_unlock_bus,
>  };
>  
> -static struct device_node *
> +static struct fwnode_handle *
>  i2c_mux_get_channel_node(struct i2c_mux_core *muxc, u32 chan_id)
>  {
> -	struct device_node *dev_node = muxc->dev->of_node;
> -	struct device_node *mux_node, *child = NULL;
> +	struct fwnode_handle *dev_node = dev_fwnode(muxc->dev);
> +	struct fwnode_handle *mux_node, *child = NULL;
>  	u32 reg;
>  	int ret;
>  
> -	if (!dev_node)
> +	if (!is_of_node(dev_node) && !is_software_node(dev_node))
>  		return NULL;

I wonder if this is needed? Andy, I seem to recall that you were
involved with adding ACPI support? Do you have anything to add?

Cheers,
Peter

>  
>  	if (muxc->arbitrator)
> -		mux_node = of_get_child_by_name(dev_node, "i2c-arb");
> +		mux_node = fwnode_get_named_child_node(dev_node, "i2c-arb");
>  	else if (muxc->gate)
> -		mux_node = of_get_child_by_name(dev_node, "i2c-gate");
> +		mux_node = fwnode_get_named_child_node(dev_node, "i2c-gate");
>  	else
> -		mux_node = of_get_child_by_name(dev_node, "i2c-mux");
> +		mux_node = fwnode_get_named_child_node(dev_node, "i2c-mux");
>  
>  	if (mux_node) {
> -		/* A "reg" property indicates an old-style DT entry */
> -		if (!of_property_read_u32(mux_node, "reg", &reg)) {
> -			of_node_put(mux_node);
> +		/* A "reg" property indicates an old-style firmware entry. */
> +		if (!fwnode_property_read_u32(mux_node, "reg", &reg)) {
> +			fwnode_handle_put(mux_node);
>  			mux_node = NULL;
>  		}
>  	}
>  
>  	if (!mux_node)
> -		mux_node = of_node_get(dev_node);
> +		mux_node = fwnode_handle_get(dev_node);
>  	else if (muxc->arbitrator || muxc->gate)
> -		child = of_node_get(mux_node);
> +		child = fwnode_handle_get(mux_node);
>  
>  	if (!child) {
> -		for_each_child_of_node(mux_node, child) {
> -			ret = of_property_read_u32(child, "reg", &reg);
> +		fwnode_for_each_child_node(mux_node, child) {
> +			ret = fwnode_property_read_u32(child, "reg", &reg);
>  			if (ret)
>  				continue;
>  			if (chan_id == reg)
> @@ -305,7 +306,7 @@ i2c_mux_get_channel_node(struct i2c_mux_core *muxc, u32 chan_id)
>  		}
>  	}
>  
> -	of_node_put(mux_node);
> +	fwnode_handle_put(mux_node);
>  	return child;
>  }
>  
> @@ -368,11 +369,9 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
>  	else
>  		priv->adap.lock_ops = &i2c_parent_lock_ops;
>  
> -	/*
> -	 * Try to populate the mux adapter's of_node, expands to
> -	 * nothing if !CONFIG_OF.
> -	 */
> -	priv->adap.dev.of_node = i2c_mux_get_channel_node(muxc, chan_id);
> +	/* Associate the mux adapter with its OF or software-node channel. */
> +	device_set_node(&priv->adap.dev,
> +			i2c_mux_get_channel_node(muxc, chan_id));
>  
>  	/*
>  	 * Associate the mux channel with an ACPI node.
> @@ -416,7 +415,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
>  	return 0;
>  
>  err_free_priv:
> -	of_node_put(priv->adap.dev.of_node);
> +	fwnode_handle_put(dev_fwnode(&priv->adap.dev));
>  	kfree(priv);
>  	return ret;
>  }
> @@ -429,7 +428,7 @@ void i2c_mux_del_adapters(struct i2c_mux_core *muxc)
>  	while (muxc->num_adapters) {
>  		struct i2c_adapter *adap = muxc->adapter[--muxc->num_adapters];
>  		struct i2c_mux_priv *priv = adap->algo_data;
> -		struct device_node *np = adap->dev.of_node;
> +		struct fwnode_handle *fwnode = dev_fwnode(&adap->dev);
>  
>  		muxc->adapter[muxc->num_adapters] = NULL;
>  
> @@ -439,7 +438,7 @@ void i2c_mux_del_adapters(struct i2c_mux_core *muxc)
>  
>  		sysfs_remove_link(&priv->adap.dev.kobj, "mux_device");
>  		i2c_del_adapter(adap);
> -		of_node_put(np);
> +		fwnode_handle_put(fwnode);
>  		kfree(priv);
>  	}
>  }
> -- 
> 2.50.1 (Apple Git-155)
> 
