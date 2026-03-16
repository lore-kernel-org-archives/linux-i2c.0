Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB55A382362;
	Mon, 16 Mar 2026 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773666744; cv=none; b=MlODgqJ8D1E2af7Q1GNAwRFMWOhk8IPiGSZpTBmcJ9z0rFDnnnqxRMhc4ZTwPVc3Vu4M0hwcqv2HmWA8C46leKoXkmflxZPakl+ZMRcJupsRBjaUQ1g1QSdNCdMW4DFuBVZy1cNDNaKZDhyxsmuZGtaus6r/E+cYbCvniMjdrPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773666744; c=relaxed/simple;
	bh=lTabpCjBeJaGNQ4Rm4dBCUuNvEcTFzKMAs3b6NmGIFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQyBQ13idvVgq7/zjS/DrwksJrf/PdRvsr0hP9oFDRb0AbuNLGtsqJy6F3u13mlkhMND2TAignOSqbBjn8V5p/ub5sMOMuUJD31nN/fD5QGjG1L4871xwCAxEw1OynAai/2Ri/v5NjPIF4j8er0Z13hM190CG+glr3DOhjq0XLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MGV8Q87a; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MGV8Q87a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773666743; x=1805202743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lTabpCjBeJaGNQ4Rm4dBCUuNvEcTFzKMAs3b6NmGIFE=;
  b=MGV8Q87a9gVN3iGWL8U7m9ocdJ547t+1CJt7MVfTw06FX3BB0qIGXWcA
   FglcCvsfRD5OX3zTmEpFT4gouXt0nY4QH2iK6btzRL7vUAwTlY+4+g7nQ
   WXcNjTUWYkTYl7arZUY4mSa5ttODqLpAXUKZ8+8lKfEa06B3gzduOhXEA
   RJaCoqAY0XBL/s3Csvb9EoVXJqqdPG6bf8EJ3zhesEK7PVgwH5T+SEhQb
   Cnr9MLTNcBppdid765A2x2UeSIeX1T/ynuc9DBZYwtN7DryGeFITIvaSt
   HzmA+cpcJaqfTXibxFpxk2lhCBbgayYJo9I+BKV9yPT7qleLMG45ufujn
   A==;
X-CSE-ConnectionGUID: VVQ+XAvMTvqB+3I79q0++A==
X-CSE-MsgGUID: 4zOxRV+sRben+5G5O3PP0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="97289838"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="97289838"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 06:12:22 -0700
X-CSE-ConnectionGUID: RdEDXrOGSIuEDuaXQjLJOw==
X-CSE-MsgGUID: G+IyBQQyRImK9X1PBtyWEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="226372232"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 16 Mar 2026 06:12:21 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 1CD2F95; Mon, 16 Mar 2026 14:12:19 +0100 (CET)
Date: Mon, 16 Mar 2026 14:12:19 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Edward Blair <edward.blair@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-usb@vger.kernel.org,
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
	wsa+renesas@sang-engineering.com, westeri@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: acpi: skip generic I2C device when
 vendor-specific sibling exists
Message-ID: <20260316131219.GD2275908@black.igk.intel.com>
References: <20260314013157.7181-1-edward.blair@gmail.com>
 <20260314013157.7181-2-edward.blair@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260314013157.7181-2-edward.blair@gmail.com>

On Sat, Mar 14, 2026 at 01:31:55AM +0000, Edward Blair wrote:
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

Are they both "present"? I mean their _STA() returns 0xF for both?

We have a quirk table already in drivers/acpi/x86/utils.c that I think could
be used to mark the other one being not present.
