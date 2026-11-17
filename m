Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924117;
	b=x3bBqXRVSZtlzs643rUwRZ2yOHz8Fm9WMGd44i9x7lDDLg3E69z9WB2L6ynHXWFkkeDN
	 vbRPywT9VppMpXHHYD+0Qx4dHL/yo3grpGSB78Op4vq1SCgxtrpYprrppNJu/Hhd6V6av
	 7NlnYpsE40o1WxlHxQ7057aAFwnUN7sHzZULCivbjB6DURn6Y+JyXwrAeM9SowlQDAlzg
	 E2MfeiLnZzmBEzZnDixszGEs1lCNguquSlYSTBMiIGRqZ4bIX2pMmTgCVkfJMnTamWjo1
	 i6K8kFRLFYIK1iU8wtqvldMpPpZ6jy1S8BcwlA24TjyEeHuG98b0TG/wV9w0+oE05rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924117;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=wklAdo9fsmG1vi/8V3+fsdO+VswPQOF0aXlmPk0xS70=;
	b=dc56iw6yxsIOeJg46bThaKTjrhJH3E33LbUFiUhgC+QHOi+m52JjqrB9K8aAhi+046ru
	 h46VK3HbFsNvxYLcDb+1qoo1qubMxl4MEe3su5/ld5lX92IvU6JuV8etfcVGA6qLD/5pk
	 M7epDSFoLLR55v+2pVlX+RLnxBR9PH1OK/xNUDX5ShWIMCgPBhs4oRxoNeP+5D95F2VHt
	 giy1N8S94yjz3hLQFHK16bXfMzGpBKiMcqsNldtRDp22lCFmRDHZzxkuy5wIznsm65RH1
	 hljMcZmMEln5RuaVkwCUm/X2bFsrDLlrgEtEgd2eVJDuaRZ8UqtzLxuWo7ThimXmxow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VWUHkgOw;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754D5606A31C;
	Tue, 17 Nov 2026 14:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 754D5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VWUHkgOw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794924117; x=1826460117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hQtNoJIvapJzSVlZr2rMSsBksKgND1LoTr8mQ5HNUgc=;
  b=VWUHkgOwwcJl+MOgBfbwM+n6Ucxblz6Njb6eblPFFKQrJiRbGtFKQc+V
   M9YpfN/ufZdCJRCqox7qLX0qjX5lvD6lpuZwUTGKUES6uC5JiMGTv1aqB
   307aROSD+lw+HU9NTXmLrS26D8gF+TIgja8BGKt2ey2N6hZDuXP3omTE5
   0dc6Xl4fxMB9KJz+4BXQfpsHyOdxw9wMcIMoMAtAW1WPd9AlrsGgypVzI
   wugil+gYydhuI/LZnpHyciyvFQrFzDPLzJdjA3PRTk0lk2vH2zpK29vCa
   FIJkuvytk4tEeJGB8gv5UuaEGhPbj2rHJ3Clys8zkbHA2tY7jqi3FAij6
   w==;
X-CSE-ConnectionGUID: 2pzK0p+GTZGdh5dpXWThog==
X-CSE-MsgGUID: 5hVpBumpSWeZG4wKQ83cHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3608214"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3608214"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 06:01:56 -0800
X-CSE-ConnectionGUID: ebJxEv4mSSuqYQ28KYTkIA==
X-CSE-MsgGUID: B6s3qoPjS2enZdGv4KQpPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10021245"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 06:01:52 -0800
Date: Tue, 17 Nov 2026 16:01:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	driver-core@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] software node: ignore primary nodes in
 device_remove_software_node()
Message-ID: <avxeTnaEG_FnBhck@ashevche-desk.local>
References: <20261117101336.980216-1-johan@kernel.org>
 <20261117101336.980216-5-johan@kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117101336.980216-5-johan@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 17, 2026 at 11:13:32AM +0100, Johan Hovold wrote:
> device_remove_software_node() should only be used to remove secondary
> firmware nodes added by device_add_software_node() but will currently
> drop a reference also if a device has a primary software node.
> 
> Bail out early if device_remove_software_node() is called for a device
> whose primary firmware node is a software node and fix up the two
> callers that currently work around this themselves.

...

> +++ b/drivers/i2c/i2c-core-base.c

>  void i2c_unregister_device(struct i2c_client *client)
>  {
>  	struct fwnode_handle *fwnode;
> -	bool fwnode_is_software_node;
>  
>  	if (IS_ERR_OR_NULL(client))
>  		return;

> -	fwnode_is_software_node = is_software_node(fwnode);
>  	device_remove_software_node(&client->dev);
>  	/*
> -	 * If the firmware node is a software node, its reference count
> -	 * was decremented by device_remove_software_node().
> +	 * Must be done after device_remove_software_node() which may have
> +	 * freed a secondary firmware node and cleared the fwnode pointer.
>  	 */
> -	if (!fwnode_is_software_node)
> -		fwnode_handle_put(fwnode);
> +	fwnode_handle_put(client->dev.fwnode);

We have fwnode getter, so better use it

	fwnode_handle_put(dev_fwnode(&client->dev));

Same can be applied to the platform device case above (in this patch).

>  	device_unregister(&client->dev);
>  }

-- 
With Best Regards,
Andy Shevchenko


