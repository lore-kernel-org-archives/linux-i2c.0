Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81391DD877;
	Fri, 10 Apr 2026 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775825319; cv=none; b=hGoBj8olhxgCYbSSpZui+xQockhZ3V6tZZlWFUvOojhTjfvUx7+ms23bc1BWiaz0QZyWXe5/kktGJdw6x6n4CM+MCaXzG/kdb+jCUoyAWTTiBKVDTwhFBpsVPvUoMAXRIHbPv6Q250NIRlYtzNQqYvwcYhq55+mJCy+YNpRkTYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775825319; c=relaxed/simple;
	bh=1UbclgnxCjQXB9DtAVUDAGQ14aIXZcqP00v7bAK2vMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umlOd7bJdjRslnlhBfYM0HTe7BvyV1Rlv4aMMM2SR1/gdq23+IJh1jlmweekfxjbMqCBC37x/WqmIof6NSbXxKccGXUj7kSQ8+zwEhLpxFXMfpOuRL7M28oUFLUxkMQnqqmLr53oTXuToKuf5zApiqkD2VypCMRvHZgi515waws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bxX1OL7F; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bxX1OL7F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775825318; x=1807361318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1UbclgnxCjQXB9DtAVUDAGQ14aIXZcqP00v7bAK2vMM=;
  b=bxX1OL7FSkuIa/GaoWnTh7XxFahsvYmNcVpDkEJ09XepRlirW+4jnMQF
   P6KaQ25KWgJRqhxc/jK9j0hGua78nBEYBAk6MrsD0PO82XGmT2/CjGhUj
   8lZItGQ0TZ1J8Lu4NnCG/iS2qj9GIz12eGGZRGOaZuu/ssH7iy8BYg6NA
   KtxohyopLhF3r7/FRco6E/F0Z90aMr9hGmFuNMmx0oPyoBSto0EiQduQD
   PATu7UyKWEOUGUmoK0xGTS7aNI6Ge/KkHrDlKD5RT7WbviuP9tYQBzRXy
   quVfJ0WqJI4ysApQfHoUPz3c0pine80yZMG/aQgBA9cC4T6fMcaX57Wgo
   Q==;
X-CSE-ConnectionGUID: 1xQvIubdQyuR67vRG8YDmA==
X-CSE-MsgGUID: svTGt7F8Sle5Wcpb8nWWsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="80704000"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="80704000"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 05:48:38 -0700
X-CSE-ConnectionGUID: Bo7Q8UbvS82MPo8IjzKT4A==
X-CSE-MsgGUID: kwqaAPOmT5ip/lEUdCW20Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="225919873"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.73])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 05:48:35 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 6AE9711FA4F;
	Fri, 10 Apr 2026 15:48:50 +0300 (EEST)
Date: Fri, 10 Apr 2026 15:48:50 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Arun T <arun.t@intel.com>
Cc: israel.a.cepeda.lopez@intel.com, hansg@kernel.org,
	andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, miguel.vadillo@intel.com
Subject: Re: [PATCH 2/2] i2c: usbio: Add ACPI device-id for NVL platforms
Message-ID: <adjxslosYBIgjano@kekkonen.localdomain>
References: <20260410080408.562311-1-arun.t@intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410080408.562311-1-arun.t@intel.com>

Hi Arun,

On Fri, Apr 10, 2026 at 01:34:08PM +0530, Arun T wrote:
> Add device IDs of Nova Lake into i2c-usbio support list

Same here; sentences end in a period.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> 
> Signed-off-by: Arun T <arun.t@intel.com>
> Reviewed-by: Vadillo Miguel <miguel.vadillo@intel.com>
> ---
>  drivers/i2c/busses/i2c-usbio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-usbio.c b/drivers/i2c/busses/i2c-usbio.c
> index e7799abf6787..259754e5fd05 100644
> --- a/drivers/i2c/busses/i2c-usbio.c
> +++ b/drivers/i2c/busses/i2c-usbio.c
> @@ -29,6 +29,7 @@ static const struct acpi_device_id usbio_i2c_acpi_hids[] = {
>  	{ "INTC10B6" }, /* LNL */
>  	{ "INTC10D2" }, /* MTL-CVF */
>  	{ "INTC10E3" }, /* PTL */
> +	{ "INTC1118" }, /* NVL */
>  	{ }
>  };
>  

-- 
Regards,

Sakari Ailus
