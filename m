Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C3248A2B6;
	Mon, 18 May 2026 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112763; cv=none; b=RLQ3E4+nMrSu4MjHGV2nCLWUJqaPGP2ggHXjGh7yeKp7o0YD3btRe+cgOwBJdK5MHuiKmzL3n47+arM30oSaU18ihgj5/Un4MNctNEf+IsVXX4ORqtNcJVBOdzFUsdnqE6DyRxFDbvLBBqwSJeJ/+Ot/Bkf2TmLtoa49lxg7gFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112763; c=relaxed/simple;
	bh=EhIC93euX0nYoZUnw4fyaCXfXwt6ACo9oWEAQL0WEz4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HBUp0Gpk7sbkC1ggSqbqs/2EIYmkf0/Et+oNdHmbX2LIAkucG305FgbE80fBUPY5Btpe/HOVp9cb5FePwCdfCXTOqpf3phEEtJXYRIo3ORsONQGfcJC5ytK1YEVazLAquKv6Nxb2Vfxddfuqy0e87PfotVt386IGrzKWqcRGBNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 24F7024D01;
	Mon, 18 May 2026 15:59:12 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 18CBA24CBF; Mon, 18 May 2026 15:59:12 +0200 (CEST)
X-Spam-Level: 
X-Spam-Score: -1.0
Received: from [192.168.2.172] (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 4E4DC24B7F;
	Mon, 18 May 2026 15:59:09 +0200 (CEST)
Message-ID: <f2688bbf-ab8a-484d-98d4-2a502f2ee36a@lysator.liu.se>
Date: Mon, 18 May 2026 15:59:08 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Peter Rosin <peda@lysator.liu.se>
Subject: Re: [PATCH v3] i2c: mux: reg: use device property accessors
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260513-i2c-mux-reg-v3-1-0fa7242605bc@nexthop.ai>
Content-Language: en-US, sv-SE
In-Reply-To: <20260513-i2c-mux-reg-v3-1-0fa7242605bc@nexthop.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP

[retrying the change to peda@lysator.liu.se]

On 2026-05-14 02:54, Abdurrahman Hussain wrote:
> Convert the device-tree parsing path to the generic fwnode/device
> property accessors so the driver can be probed on ACPI and swnode
> platforms as well as OF. The helper is renamed from
> i2c_mux_reg_probe_dt() to i2c_mux_reg_probe_fw() to reflect that.
> 
> Accessor translation:
> 
>    of_parse_phandle("i2c-parent") +
>      of_find_i2c_adapter_by_node()    -> fwnode_find_reference() +
>                                           i2c_get_adapter_by_fwnode()
>    of_get_child_count()               -> device_get_child_node_count()
>    of_property_read_bool()            -> device_property_read_bool()
>    for_each_child_of_node()           -> device_for_each_child_node()
>      of_property_read_u32("reg")        on OF:   fwnode_property_read_u32()
>                                         on ACPI: acpi_get_local_address()
>    of_property_read_u32("idle-state") -> device_property_read_u32()
> 
> Behavioural preservations (deliberate, to avoid regressing existing
> users):
> 
>    - The three-way endian fallback is kept verbatim: an explicit
>      "little-endian" property wins, then "big-endian", and otherwise
>      the host's compile-time byte order. device_is_big_endian() is
>      not used here because it ignores "little-endian" and introduces
>      "native-endian" semantics, which would diverge from the binding.
> 
>    - The platform-resource fallback for an un-mapped reg keeps its
>      "if (!mux->data.reg)" guard so a platdata user that supplies a
>      pre-ioremapped reg through struct i2c_mux_reg_platform_data is
>      not clobbered.

Hi!

After reading v2/v3, I finally got why you removed if (!mux->data.reg).
I.e., since you removed the io-remapping from i2c_mux_reg_probe_fw()
that part can now be unconditional in i2c_mux_reg_probe(). But,
keeping the if just to accomodate potential out-of-tree code that uses
the platform data hooking is not needed so v1 feels better than v2/v3.
Sorry for being dense. However, see below.

> The OF-only of_address_to_resource() translation in the old
> probe_dt() is dropped because the same address is available from
> the platform_device resource table on both OF and ACPI, and the
> existing fallback in probe() ioremaps it.
> 
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> ---
>   drivers/i2c/muxes/i2c-mux-reg.c | 75 ++++++++++++++++++-----------------------
>   1 file changed, 32 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
> index 1e566ea92bc9..8b35a50e2841 100644
> --- a/drivers/i2c/muxes/i2c-mux-reg.c
> +++ b/drivers/i2c/muxes/i2c-mux-reg.c
> @@ -11,7 +11,6 @@
>   #include <linux/init.h>
>   #include <linux/io.h>
>   #include <linux/module.h>
> -#include <linux/of_address.h>
>   #include <linux/platform_data/i2c-mux-reg.h>
>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
> @@ -75,37 +74,34 @@ static int i2c_mux_reg_deselect(struct i2c_mux_core *muxc, u32 chan)
>   	return 0;
>   }
>   
> -#ifdef CONFIG_OF
> -static int i2c_mux_reg_probe_dt(struct regmux *mux,
> -				struct platform_device *pdev)
> +static int i2c_mux_reg_probe_fw(struct regmux *mux, struct device *dev)
>   {
> -	struct device_node *np = pdev->dev.of_node;
> -	struct device_node *adapter_np, *child;
> +	struct fwnode_handle *fwnode, *child;
>   	struct i2c_adapter *adapter;
> -	struct resource res;
>   	unsigned *values;
> -	int i = 0;
> +	int ret, i = 0;
>   
> -	if (!np)
> +	if (!dev_fwnode(dev))
>   		return -ENODEV;
>   
> -	adapter_np = of_parse_phandle(np, "i2c-parent", 0);
> -	if (!adapter_np) {
> -		dev_err(&pdev->dev, "Cannot parse i2c-parent\n");
> +	fwnode = fwnode_find_reference(dev_fwnode(dev), "i2c-parent", 0);
> +	if (IS_ERR(fwnode)) {
> +		dev_err(dev, "missing 'i2c-parent' property\n");
>   		return -ENODEV;
>   	}
> -	adapter = of_find_i2c_adapter_by_node(adapter_np);
> -	of_node_put(adapter_np);
> +
> +	adapter = i2c_get_adapter_by_fwnode(fwnode);
> +	fwnode_handle_put(fwnode);

Why did you not change to i2c_find_adapter_by_fwnode()? It would be
closer to the original, but maybe that doesn't work for ACPI for some
reason?

>   	if (!adapter)
>   		return -EPROBE_DEFER;
>   
>   	mux->data.parent = i2c_adapter_id(adapter);
> -	put_device(&adapter->dev);
> +	i2c_put_adapter(adapter);
>   
> -	mux->data.n_values = of_get_child_count(np);
> -	if (of_property_read_bool(np, "little-endian")) {
> +	mux->data.n_values = device_get_child_node_count(dev);
> +	if (device_property_read_bool(dev, "little-endian")) {
>   		mux->data.little_endian = true;
> -	} else if (of_property_read_bool(np, "big-endian")) {
> +	} else if (device_property_read_bool(dev, "big-endian")) {
>   		mux->data.little_endian = false;
>   	} else {
>   #if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : \
> @@ -118,40 +114,35 @@ static int i2c_mux_reg_probe_dt(struct regmux *mux,
>   #error Endianness not defined?
>   #endif
>   	}
> -	mux->data.write_only = of_property_read_bool(np, "write-only");
> +	mux->data.write_only = device_property_read_bool(dev, "write-only");
>   
> -	values = devm_kcalloc(&pdev->dev,
> -			      mux->data.n_values, sizeof(*mux->data.values),
> +	values = devm_kcalloc(dev, mux->data.n_values, sizeof(*mux->data.values),
>   			      GFP_KERNEL);
>   	if (!values)
>   		return -ENOMEM;
>   
> -	for_each_child_of_node(np, child) {
> -		of_property_read_u32(child, "reg", values + i);
> +	device_for_each_child_node(dev, child) {
> +		if (is_acpi_node(child)) {
> +			ret = acpi_get_local_address(ACPI_HANDLE_FWNODE(child),
> +						     &values[i]);
> +			if (ret) {
> +				fwnode_handle_put(child);
> +				return dev_err_probe(dev, ret,
> +						     "Cannot get address\n");
> +			}
> +		} else {
> +			fwnode_property_read_u32(child, "reg", &values[i]);
> +		}
> +
>   		i++;
>   	}
>   	mux->data.values = values;
>   
> -	if (!of_property_read_u32(np, "idle-state", &mux->data.idle))
> +	if (!device_property_read_u32(dev, "idle-state", &mux->data.idle))
>   		mux->data.idle_in_use = true;
>   
> -	/* map address from "reg" if exists */
> -	if (of_address_to_resource(np, 0, &res) == 0) {
> -		mux->data.reg_size = resource_size(&res);
> -		mux->data.reg = devm_ioremap_resource(&pdev->dev, &res);
> -		if (IS_ERR(mux->data.reg))
> -			return PTR_ERR(mux->data.reg);
> -	}
> -

By not doing the io-remapping here, the ordering is now subtly altered.
Previously we had io-remapping before the call to i2c_get_adapter().
With this change we instead have the call to i2c_get_adapter() before
the io-remapping.

Since it is apparently difficult the get this patch tested for the
existing use cases, we should avoid as many of these innocent looking
but subtle changes as possible.

Cheers,
Peter

>   	return 0;
>   }
> -#else
> -static int i2c_mux_reg_probe_dt(struct regmux *mux,
> -				struct platform_device *pdev)
> -{
> -	return 0;
> -}
> -#endif
>   
>   static int i2c_mux_reg_probe(struct platform_device *pdev)
>   {
> @@ -169,10 +160,10 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
>   		memcpy(&mux->data, dev_get_platdata(&pdev->dev),
>   			sizeof(mux->data));
>   	} else {
> -		ret = i2c_mux_reg_probe_dt(mux, pdev);
> +		ret = i2c_mux_reg_probe_fw(mux, &pdev->dev);
>   		if (ret < 0)
>   			return dev_err_probe(&pdev->dev, ret,
> -					     "Error parsing device tree");
> +					     "Error parsing firmware description\n");
>   	}
>   
>   	parent = i2c_get_adapter(mux->data.parent);
> @@ -180,8 +171,6 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
>   		return -EPROBE_DEFER;
>   
>   	if (!mux->data.reg) {
> -		dev_info(&pdev->dev,
> -			"Register not set, using platform resource\n");
>   		mux->data.reg = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>   		if (IS_ERR(mux->data.reg)) {
>   			ret = PTR_ERR(mux->data.reg);
> 
> ---
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> change-id: 20260305-i2c-mux-reg-552203da8564
