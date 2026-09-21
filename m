Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1224E3264C2;
	Mon, 21 Sep 2026 05:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967881; cv=none; b=jLLUYuJoAERjdGvD4TGOtdI51sWK7bD3lpNal+dVbJAQQkprFL0j1B/1Gknf7oODFbn7MNFgCF+4r3VNtGLLOsmiU3vp6JQNTebjCfUAvcDhu0gYcL7oZF4p/fRBWkl15oVBoIMxtA7arBtxmT7J+6ok+ggaLQ/LbMby4dKgWCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967881; c=relaxed/simple;
	bh=jsjTM2XZlkrtehIfrb/bALST2lPPLWt2mNncUxMvkWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQj8V2fG3/KP6CT2aVpo84rlLOu6uaucTkyVw/+PIzMNkKzuD1waCDX+O8C5PvjQBEFU0HMgqwZ7FyW4+YSQ6ERY7JFTwBTO/tHPLuEdKErlrnuH6mLpm9m6CxuOBLCW5joRd+3kpyjgdbPK0OwfMhVDqO3mkG94CFwioTlGz1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bm+1KkLC; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bm+1KkLC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789967880; x=1821503880;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jsjTM2XZlkrtehIfrb/bALST2lPPLWt2mNncUxMvkWk=;
  b=Bm+1KkLCeQvvdr/8Kn6exRM5QmVtI0wUYppuDZP8f+o0I45V2jCCp9P/
   oDeZwius03cy9KhNyeVQ3LyNYPPKCqfpjwKZVU6aihdC/aRsvC0c/Rxf6
   AFrkenRMjDehUa2ywa9Y9awJy50Z7zRXagUlUkmEAao28jzxTHurMhcN0
   cca0jZv7gw6EdDf/opsEI6z+Owa62s3diIOQ5aCJEAyiF8cBeU1Lo2e39
   OV2H8j+6TZlWNidd/CnL4rgnjfcpxpkERWEtB7890eZ91CrtgHuf5rd9y
   gYi9wwbKGkL7POQiGb/1SP9zAE65dES/yJ3UdqIs5SdBocT+9ApUYpL9m
   w==;
X-CSE-ConnectionGUID: oto+q54IT6uVzsWny9dhhQ==
X-CSE-MsgGUID: jLq8femVQxuETnSMCctVWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="101807032"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="101807032"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 22:17:59 -0700
X-CSE-ConnectionGUID: jiDRPCpOQ6WngwMXqLbmZA==
X-CSE-MsgGUID: fvfqXfaGQAulBS6MINfZgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3807107"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa013.fm.intel.com with ESMTP; 20 Sep 2026 22:17:59 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 4BB7F99; Mon, 21 Sep 2026 07:17:50 +0200 (CEST)
Date: Mon, 21 Sep 2026 07:17:50 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: acpi: Use I2C_M_DMA_SAFE in
 acpi_gsb_i2c_[read|write]_bytes()
Message-ID: <20260921051750.GN106095@black.igk.intel.com>
References: <20260919193642.43058-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919193642.43058-1-johannes.goede@oss.qualcomm.com>

On Sat, Sep 19, 2026 at 09:36:41PM +0200, Hans de Goede wrote:
> The main read / write "buffer" is kzalloc()ed and as such is safe to
> directly use for DMA (unlike stack mem). Add the I2C_M_DMA_SAFE flag
> to the transfers using these buffers.
> 
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Acked-by: Mika Westerberg <westeri@kernel.org>
