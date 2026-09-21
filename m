Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AA83537F8;
	Mon, 21 Sep 2026 05:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967943; cv=none; b=KrklLSvms/BcVOMuvAwh7fYuXk3SB0Fai2vAhuHgs/Vg1mHUII+cvXcEEaOfb/c0ScKS6cCM/49/POexyVQnWktzcxK9Iqkqn1Npad4MD11MbifA9ZmWSKqQc6mI7xQx8EUOiZeR5JDW+zQU3dXJQrVMfcqtiUzpHP7xC1rELNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967943; c=relaxed/simple;
	bh=8u7wVb8eqcT/8CqT90NFKey6Lq12JB2Xmy5c9MxjMm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDLrthPdEGnTbq6aoi4/ORZLl22kXmOGhOHXuOwjZJh6Oljz4n8Ewk5vNLrGv60vkT6zXAOT3WOKEpznZHVCr3gpiV2arhtQhh1lrcLMKWwxbWtGEdHLZpLKcTLw7l1GGyDQCVhqJy/I/9mpHcwfaR/VrsJj3CEgkM0491+OZTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bWmf0iRr; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bWmf0iRr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789967942; x=1821503942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8u7wVb8eqcT/8CqT90NFKey6Lq12JB2Xmy5c9MxjMm8=;
  b=bWmf0iRr0KYnoDb9el5nJpiMNDsqHu1EzvPhQLIV0I0tyXOT3M3kiz6X
   akcJ7QG9lF+UPaAFSiXPoDUeSrgRTvl5Q181Cpw4uX+WxAIsJ0Tc9Wnpl
   pWsekfzx1Q+LlfMhjpU7iQrbgyJfJEojkFwNDk12m1sHavN9G1fiqmJRk
   /F0JMm6XYkUGC11LZSYLz5DMWxcFEaAHNEXShHfEsncJjto8By87uXWn8
   X+KAnCkfGuYLkEwdwTRiOQVs6H2uhV9/+Sw8buq4y3jR391L5y4Xr3CSn
   EFiFjNOBqXZ9xOKFwre6vuefL3m9ZTaZ2EncQnccJ+aCjMFZq7+9Pse46
   Q==;
X-CSE-ConnectionGUID: Z5RN7KLrRY6NWS/jRcIhTg==
X-CSE-MsgGUID: mN36HD9ZRe6FLeL04zJowQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="965785"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="965785"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 22:19:01 -0700
X-CSE-ConnectionGUID: E45H9p5hQeWXIt49Pq6cIQ==
X-CSE-MsgGUID: ImqydzKLQVa/sCz5Fosf/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="271964259"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 20 Sep 2026 22:19:00 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id A85F499; Mon, 21 Sep 2026 07:18:46 +0200 (CEST)
Date: Mon, 21 Sep 2026 07:18:46 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: acpi: Add AttribRawBytes accessor-type support
 to OpRegion handler
Message-ID: <20260921051846.GO106095@black.igk.intel.com>
References: <20260919193642.43058-1-johannes.goede@oss.qualcomm.com>
 <20260919193642.43058-2-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919193642.43058-2-johannes.goede@oss.qualcomm.com>

On Sat, Sep 19, 2026 at 09:36:42PM +0200, Hans de Goede wrote:
> Add AttribRawBytes accessor-type support to OpRegion handler, this is used
> by the ACPI tables on a ThinkPad T14s gen6 Snapdragon laptop.
> 
> Looking at the AML it seems the expected behavior is to simply read or
> write accessor-length bytes and this implementation allows successful
> communication with the EC on a T14s gen6 Snapdragon laptop.
> 
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Acked-by: Mika Westerberg <westeri@kernel.org>
