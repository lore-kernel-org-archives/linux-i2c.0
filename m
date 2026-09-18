Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22922853FD;
	Fri, 18 Sep 2026 05:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789711022; cv=none; b=db1o7K0S3nIsI3w7CjthYKNsdZJef+hZDZdJiTvHoYOgyWmeEMC+DjG9+0P2DLe5pj7kyH+DLpMzLKU4TVlZyW2OGWRGPWR5vSuq0r902M4kRYP3/FCxjCkq21f+C3jsXEbpu0OyvfdhXzZCMeezYc1YcDU5WA3XukFkFYNszd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789711022; c=relaxed/simple;
	bh=Ug1YYs1QoG5a0cLyLRgAfW0LHixvwk05lM/CTrnNHHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4jFWDQaNwJW8nRBbezkEFk3kFQ/TdompJYoyv949b89F6XmhhWZ08sKb1Izi/04hhXbXPGWP4yRwiA7DUwG0rrY+2xrjy5QAF+Wj0O47ItgaA7U64X/SHHPOk4V6aYOrkupF5zMbFZUMlVp5LrH3FYmxZQvJm0PJNswdC6PY2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7bgDJZs; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7bgDJZs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789711020; x=1821247020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ug1YYs1QoG5a0cLyLRgAfW0LHixvwk05lM/CTrnNHHk=;
  b=i7bgDJZsO16TSpV8KQP3gKpnOovYgsBUyRlpLqBWWhAowmjOQZDRF/6t
   K9VG9bYjquf/9aHeVaQHmsXfmOM88M1CyRoL+Yo1HUo5EKyaiZi5I6e5f
   luzAaxLwqSbFq1FuFivz44jxGxhErE8rXEaRxyQ+zaNk+7dE+MX15bv9V
   owBuACV0WZshQgBRMQ0Gll2XSeihX1CEEeaN1+ANy1pk6j1atGK3j/sCg
   cN1JpNKa0qOYTvLWzcku/bPr/3feH47YA2Al3F7mpsfhc81g1X1QMiWrF
   beMmOo5paP8L7uO6jwD2kGOMenhmm4uw8hRF/D7YzP1RaEyD9+fFBPAGO
   A==;
X-CSE-ConnectionGUID: WagMAFepQMytKC6pOKfyuw==
X-CSE-MsgGUID: kxbWuQRNQY+3fMezksnUMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90326751"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90326751"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 22:57:00 -0700
X-CSE-ConnectionGUID: U3QRh2jRRqWdopq5s0ua8Q==
X-CSE-MsgGUID: 55OnJffxSEancRpCOmUhyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2629668"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa013.fm.intel.com with ESMTP; 17 Sep 2026 22:56:59 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 6136D99; Fri, 18 Sep 2026 07:56:53 +0200 (CEST)
Date: Fri, 18 Sep 2026 07:56:53 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Yuqi Xu <xuyuqiabc@gmail.com>
Cc: westeri@kernel.org, andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Add ELAN0662 to
 i2c_acpi_force_100khz_device_ids
Message-ID: <20260918055653.GD106095@black.igk.intel.com>
References: <20260918054109.23550-1-xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260918054109.23550-1-xuyuqiabc@gmail.com>

On Fri, Sep 18, 2026 at 01:41:09PM +0800, Yuqi Xu wrote:
> The ELAN0662 touchpad (04F3:317C) in the Lenovo ThinkBook 14 G4+ ARA
> (21D0) intermittently stutters and drops touches. libinput discards
> invalid touch coordinates and logs (rate limited to five messages per
> 24 hours):
> 
>   libinput error: event6 - ELAN0662:00 04F3:317C Touchpad: kernel
>   bug: Touch jump detected and discarded.
> 
> The ACPI DSDT describes the touchpad's I2cSerialBus resource on an
> AMDI0010 controller with a connection speed of 0x00061A80 (400 kHz),
> and the kernel does not lower it for this device, so the touchpad runs
> at 400 kHz. This is the same issue previously fixed for ELAN06FA and
> ELAN0678.
> 
> Forcing the bus to 100 kHz was tested with a DSDT override on the
> affected machine, and the kernel confirmed the override:
> 
>   ACPI: Table Upgrade: override [DSDT-LENOVO-CB-01]
> 
> Before the change libinput discarded three touch jumps within about a
> minute of touchpad use; after the change no touch jumps were logged
> during more than an hour of normal use. The patch itself was not build
> tested; the behaviour was validated through the ACPI table override
> above.
> 
> Assisted-by: DeepSeek:deepseek-v4.1-flash
> Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>

Acked-by: Mika Westerberg (Intel) <westeri@kernel.org>
