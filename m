Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4740D3839B7;
	Sun, 23 Aug 2026 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787481096; cv=none; b=UXbLu42sBjJ7rUxf1/DJXvhngTbYIJFhDrPc//lzD/i65cJHPfEQ6lDw69lsYzX8zOEEvVJqJO76SvC0cUcAg93+HuhKQH9DnzYolUZ5nZRCiIRHQ8rBeVnOaproXhBdJ2ZZ/3EnAX0LcLbsdrugdkBWGf5KgX9HF8ywBPBYq6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787481096; c=relaxed/simple;
	bh=MctZ850sy5NKdSWQabi/ECxlRuFyCEJNBAPpK8jcwAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=enE4Qw5KOPdJK1Ntmo3te2N4rXoJdoVNGxCDW5I0ffV56iRD5HDKZ97RQwsL2A5+blePhH2uR5CRNQz4XcmWfqyxsjvB7SnIa4ms8qsSweVgRzeGWdC3FOv4PAW0PhkIXe2qb6xdWZydCCv09b+nUj1wd/qxZzsJjLX5o05n8nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=gB3TycWs; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=gB3TycWs; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=T6IVFL02; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="gB3TycWs";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="gB3TycWs";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="T6IVFL02"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1787480490;
	bh=MctZ850sy5NKdSWQabi/ECxlRuFyCEJNBAPpK8jcwAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gB3TycWs781Nbkm9VM6+TfA4+kXnYpko2BfmPNyug/Yx/OQrXjatdxIG78nm8GQbe
	 EiVQP6aMgMkFdKjCrqI1LzJhy0NgMBrZWLlGF6h9yauYh55ujiubGxSkH5evc2w2Ro
	 PVnvch+ZlhGhK/n0c5HuqSTnRuCaBQ9tZZLLwPCEfW4CCXnUmqtlTKsVy64LaIAbQd
	 gbHQ1vRPTDa02DgFKi0NnCBzW0TFqqbidyFF2OwzrGeTR/xAcvSwi/zE7jHQYsPVTp
	 sWGkkCdz120OyQjUaujo/wQGG8KzqCAbY4+wVvAr2twx0092fDbS+jtTJtbe5R4ePk
	 YijcFRU36L1aw==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 7EC8CD851;
	Sun, 23 Aug 2026 12:21:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1787480490;
	bh=MctZ850sy5NKdSWQabi/ECxlRuFyCEJNBAPpK8jcwAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gB3TycWs781Nbkm9VM6+TfA4+kXnYpko2BfmPNyug/Yx/OQrXjatdxIG78nm8GQbe
	 EiVQP6aMgMkFdKjCrqI1LzJhy0NgMBrZWLlGF6h9yauYh55ujiubGxSkH5evc2w2Ro
	 PVnvch+ZlhGhK/n0c5HuqSTnRuCaBQ9tZZLLwPCEfW4CCXnUmqtlTKsVy64LaIAbQd
	 gbHQ1vRPTDa02DgFKi0NnCBzW0TFqqbidyFF2OwzrGeTR/xAcvSwi/zE7jHQYsPVTp
	 sWGkkCdz120OyQjUaujo/wQGG8KzqCAbY4+wVvAr2twx0092fDbS+jtTJtbe5R4ePk
	 YijcFRU36L1aw==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 6477CD937; Sun, 23 Aug 2026 12:21:30 +0200 (CEST)
X-Spam-Level: 
X-Spam-Score: -1.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1787480487;
	bh=MctZ850sy5NKdSWQabi/ECxlRuFyCEJNBAPpK8jcwAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T6IVFL025Q/rP7UiMgmt/6eqelgOT6K78MQ9Y2VpXUtlYhTMQGK20khGjVYrA7CDj
	 /bup/3P/RS06Exok/TVONVOyDXXoHpQCTjP+ONGbDLwBftSV32Ni+OW/osJksJJ2bc
	 wLx2M8NOXsoVlQim2gYaVze+f53Cm6qpWywq9eIBHy5AGju+Ih/a5gqV6+fZpCQ283
	 2TP6q24wfqumICyCDDnBgSDHLTqtm6xSHan5cvSP2mGfm0jUnxRDGiHOmjSShq/uWh
	 JNkJdAN1h1TGFvECEm8aC3JpDDFsNKnFDXWfhNsDbpWLZFDy+A3eVFq3nRQEozJBMg
	 gVZdgiicEv+Uw==
Received: from [192.168.2.172] (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 30165D9A7;
	Sun, 23 Aug 2026 12:21:27 +0200 (CEST)
Message-ID: <2e5328d0-c1d3-4a2e-ac17-2b5f8da5150a@lysator.liu.se>
Date: Sun, 23 Aug 2026 12:21:26 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] i2c: mux: Propagate software nodes to channel adapters
To: Ahmad Byagowi <ahmadexp@gmail.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <eb4a8ab1eedd8a01ca34c6a7e0685639d0498423.1787247467.git.ahmadexp@gmail.com>
Content-Language: en-US, sv-SE
From: Peter Rosin <peda@lysator.liu.se>
In-Reply-To: <eb4a8ab1eedd8a01ca34c6a7e0685639d0498423.1787247467.git.ahmadexp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP

Hi Ahmad,

Thanks for your patch!

On 2026-08-20 19:41, Ahmad Byagowi wrote:
> Device Tree channel nodes are associated with the adapters created by
> i2c-mux, but equivalent software-node descriptions are not.
> 
> When the mux device has a primary software node, find the child whose
> reg value matches the channel and use it as the new adapter firmware node.
> Keep the node reference through child-client removal and release it after
> adapter deletion.
> 
> Also balance the Device Tree channel-node reference when adapter
> registration fails.
> 
> Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
> ---
> Changes since v5:
>   - Send the I2C prerequisite as a standalone patch for the I2C tree.
>   - Limit propagation to mux devices with a primary software node.
>   - Avoid secondary-fwnode access and changes to generic adapter lookup.
>   - Follow the i2c-atr reference-lifetime pattern for channel nodes.
>   - Balance the Device Tree channel reference on adapter-add failure.
>   - Rebase onto the I2C i2c-next branch.
> 
> v5: https://lore.kernel.org/r/cover.1786746757.git.ahmadexp@gmail.com/
> ---
>  drivers/i2c/i2c-mux.c | 61 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 59 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index 681a201c239ba..76fa89dc6a222 100644
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
> @@ -33,6 +34,7 @@ struct i2c_mux_priv {
>  	struct i2c_adapter adap;
>  	struct i2c_algorithm algo;
>  	struct i2c_mux_core *muxc;
> +	struct fwnode_handle *swnode;
>  	u32 chan_id;
>  };
>  
> @@ -264,6 +266,49 @@ static const struct i2c_lock_operations i2c_parent_lock_ops = {
>  	.unlock_bus =  i2c_parent_unlock_bus,
>  };
>  
> +static struct fwnode_handle *
> +i2c_mux_get_channel_swnode(struct i2c_mux_core *muxc, u32 chan_id)
> +{
> +	struct fwnode_handle *dev_node = dev_fwnode(muxc->dev);
> +	struct fwnode_handle *mux_node, *child = NULL;
> +	u32 reg;
> +
> +	if (!is_software_node(dev_node))
> +		return NULL;
> +
> +	if (muxc->arbitrator)
> +		mux_node = fwnode_get_named_child_node(dev_node, "i2c-arb");
> +	else if (muxc->gate)
> +		mux_node = fwnode_get_named_child_node(dev_node, "i2c-gate");
> +	else
> +		mux_node = fwnode_get_named_child_node(dev_node, "i2c-mux");
> +
> +	if (mux_node) {
> +		/* A "reg" property indicates an old-style firmware entry. */
> +		if (!fwnode_property_read_u32(mux_node, "reg", &reg)) {
> +			fwnode_handle_put(mux_node);
> +			mux_node = NULL;
> +		}
> +	}
> +
> +	if (!mux_node)
> +		mux_node = fwnode_handle_get(dev_node);
> +	else if (muxc->arbitrator || muxc->gate)
> +		child = fwnode_handle_get(mux_node);
> +
> +	if (!child) {
> +		fwnode_for_each_child_node(mux_node, child) {
> +			if (fwnode_property_read_u32(child, "reg", &reg))
> +				continue;
> +			if (chan_id == reg)
> +				break;
> +		}
> +	}
> +
> +	fwnode_handle_put(mux_node);
> +	return child;
> +}
> +

I like how this is factored out from i2c_mux_add_adapter(), but
I do not like the duplication. There has got to be some nice way
to de-duplicate this since a fwnode_handle can represent an OF
node just fine.

I suggest a preparatory commit that only factors out the node
logic to a new helper i2c_mux_get_channel_node(). Initially it
should only handle the OF case (with a struct device_node arg),
but that is then changed to be generic with a struct fwnode_handle
arg in a followup commit.

>  int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
>  			u32 force_nr, u32 chan_id)
>  {
> @@ -324,8 +369,8 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
>  		priv->adap.lock_ops = &i2c_parent_lock_ops;
>  
>  	/*
> -	 * Try to populate the mux adapter's of_node, expands to
> -	 * nothing if !CONFIG_OF.
> +	 * Associate the mux adapter with its DT or software-node channel.
> +	 * DT support expands to nothing if !CONFIG_OF.
>  	 */
>  	if (muxc->dev->of_node) {
>  		struct device_node *dev_node = muxc->dev->of_node;
> @@ -364,6 +409,10 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
>  
>  		priv->adap.dev.of_node = child;
>  		of_node_put(mux_node);
> +	} else {
> +		priv->swnode = i2c_mux_get_channel_swnode(muxc, chan_id);
> +		if (priv->swnode)
> +			device_set_node(&priv->adap.dev, priv->swnode);
>  	}
Why do you need priv->swnode? device_set_node() stores the relevant
pointer as adap.dev.fwnode, and the fwnode can be put away based on
that pointer (similar to how the current code is making use of the
adap.dev.of_node pointer). Also, device_set_node() handles NULL just
fine.

I.e. this should be fine:

	device_set_node(&priv->adap.dev,
			i2c_mux_get_channel_swnode(muxc, chan_id));

if the below error handling...

>  
>  	/*
> @@ -408,6 +457,8 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
>  	return 0;
>  
>  err_free_priv:
> +	fwnode_handle_put(priv->swnode);

...is changed to
	fwnode_handle_put(dev_fwnode(&chan->adap.dev));

just like how it is done in i2c-atr.c.

You need to also adjust i2c_mux_del_adapters() to save a fwnode similar
to how it currently saves the of_node. Again, see i2c-atr.c.

> +	of_node_put(priv->adap.dev.of_node);

This one-liner fix should be a separate commit. Put this commit
first in the series please.

Cheers,
Peter

>  	kfree(priv);
>  	return ret;
>  }
> @@ -429,7 +480,13 @@ void i2c_mux_del_adapters(struct i2c_mux_core *muxc)
>  		sysfs_remove_link(&muxc->dev->kobj, symlink_name);
>  
>  		sysfs_remove_link(&priv->adap.dev.kobj, "mux_device");
> +		/*
> +		 * Keep the software node through child removal. The adapter
> +		 * device is cleared on deletion, so release the saved reference
> +		 * afterwards.
> +		 */
>  		i2c_del_adapter(adap);
> +		fwnode_handle_put(priv->swnode);
>  		of_node_put(np);
>  		kfree(priv);
>  	}
> 
> base-commit: b0e590bb83a9e40dc1e77a2c82d7f3e670fb74b3

