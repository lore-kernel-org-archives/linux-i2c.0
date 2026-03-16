Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1DE6FC5;
	Mon, 16 Mar 2026 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773670066; cv=none; b=LgLcUww8zyKzvAKiAFbNaJiE3xwJQezT8xL8nGiXv4706F6mJCrJV1s7mFBaf9VUQE0ikNRcd0UQlnMz8LNCm6bMretjnssTObCD67pbOk7rj99Oc5Y/ITU9GvKHecTARhQi6nU+Krm+71YumeRGD4j5l0ZmbFU+2ImyCnQbi8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773670066; c=relaxed/simple;
	bh=Y+V9+zbKfrDyL4a5iacNwH2u07h1sCoC3a1ixh5Uhs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiLCIjsjAd+SrMZa5x/TUHX7wDKZ3z5IzAUzcLAp6OGmHBZKAs1sles008v4b4lTllpTedjAf4v6K7rHW3ijeLgY5Ke/yKP4GsrpZhzUUGh1b7byRyra4bvNYRYIleqwRzN8wULJg9HQmdI/y92mzbvchnuCkj60uTUC9xNq1dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lMn3Yi4d; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lMn3Yi4d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773670065; x=1805206065;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y+V9+zbKfrDyL4a5iacNwH2u07h1sCoC3a1ixh5Uhs0=;
  b=lMn3Yi4dn2JLt8UnjjjktV9e71POPloauT3ekA5deU5o/QvkgdgqAIqM
   bsFO3PzVA0TKJBtaWeC00NmNKpAwabW3CtBkPcCjOsKTwAiFAyt6YebDa
   UmBlqDRWSDQ/df49xz+gTZfV1luHbaXJ4imIFn17uGehiDKkywwuZ1UGx
   Widf47cWaB+sO1eXTe8sQCqdyMYfLosL8Yzr7C5Z4xFU6pU5m1lrFdAV0
   or/tK6lbr4WF4V8s6JoJZzyZhrV0Tm3b2G3rhqZxqFJQ2QW33xc28QuBy
   H9Xrn+e2WuxuGbI7EDjFBMx8O2sY7qXyshn+io68K8/JodL1YNjaC4IZb
   w==;
X-CSE-ConnectionGUID: oy1GVYcOS+KTcl0FVvbFvw==
X-CSE-MsgGUID: YenDiutjSOSEqg7eTZhHUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="62252946"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="62252946"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:07:44 -0700
X-CSE-ConnectionGUID: l6Le8XKQQAWDfVYOcMSIeA==
X-CSE-MsgGUID: LOf5DD+oSOOa3rF5kObdtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="219502454"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 16 Mar 2026 07:07:43 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id B2CC798; Mon, 16 Mar 2026 15:07:41 +0100 (CET)
Date: Mon, 16 Mar 2026 16:07:00 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Edward Blair <edward.blair@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org, wsa+renesas@sang-engineering.com,
	westeri@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: acpi: skip generic I2C device when
 vendor-specific sibling exists
Message-ID: <abgOhNVOKMaeAGSx@kuha>
References: <20260314013157.7181-1-edward.blair@gmail.com>
 <20260314013157.7181-2-edward.blair@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314013157.7181-2-edward.blair@gmail.com>

Sat, Mar 14, 2026 at 01:31:55AM +0000, Edward Blair wrote:
> Some BIOS implementations (notably ASUS Z690/Z790/X670E motherboards)
> declare both a generic UCSI device (MSFT8000) and a vendor-specific
> device (e.g., ITE8853) as ACPI children of the same I2C controller,
> both referencing the same I2C slave address.
> 
> During ACPI I2C enumeration, whichever device is walked first claims
> the address, causing the second to fail with -EBUSY. When the generic
> MSFT8000 device registers first, the vendor-specific driver cannot
> bind, losing access to device-specific features like GPIO interrupt
> resources that are only declared on the vendor-specific ACPI device.
> 
> Fix this by checking, before registering a known generic I2C device,
> whether a sibling ACPI device exists at the same address on the same
> adapter. If so, skip the generic device to let the vendor-specific
> one register instead.
> 
> Signed-off-by: Edward Blair <edward.blair@gmail.com>
> ---
>  drivers/i2c/i2c-core-acpi.c | 88 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index 2cbd31f77..87582eac7 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -137,6 +137,17 @@ static const struct acpi_device_id i2c_acpi_ignored_device_ids[] = {
>  	{}
>  };
>  
> +/*
> + * Generic I2C device IDs that may be duplicated by vendor-specific devices.
> + * When a vendor-specific sibling exists at the same address, the generic
> + * device is skipped to avoid -EBUSY address conflicts.
> + */
> +static const struct acpi_device_id i2c_acpi_generic_device_ids[] = {
> +	/* Microsoft UCSI - often paired with vendor-specific UCSI device */
> +	{ "MSFT8000" },
> +	{}
> +};

That's not a generic UCSI device. That's the "RhProxy" device unless
I'm completely mistaken, and it's meant to be used in Windows to give
the user mode access to GPIOs, SPI, I2C and UART:
https://learn.microsoft.com/en-us/windows/uwp/devices-sensors/enable-usermode-access

I think we need to handle that one in drivers/acpi/x86/utils.c like
Mika said.

thanks,

-- 
heikki
