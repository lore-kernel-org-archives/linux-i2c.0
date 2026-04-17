Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC19E31F9A2;
	Fri, 17 Apr 2026 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776413938; cv=none; b=uaJhYwfya2KHNMMA8GWkCu3gk+IhQWVRN8OD6jSTk5pMljmaTPGbnwfSHMGwQbQfv5TIbmZqimXkZJkhpOnCwy6LJblSRdojlI+13GlYmfcUGm0XbPXjhnuXaQqht7dJ4jftEuMR2cPfjOqEXYKMhxGxdUntdVaYN8JHpg2Dutw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776413938; c=relaxed/simple;
	bh=8vHhhlYx6EpxdUTHTWuLK9FDMCG14clDo9GgfoUBNP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfRaE27h2QV2St48wFhMb7miB8UjFxf25GphuHQiH8ohBwhXQ8O+aGAom0lwZPmiJvbJSTveEMbAS+j70zMe+piXmcZ8pC0UzMTHloekitM2ELtYf02gWC5Dvo/1VNqyt0VbNUdfR6uH7sz0VKFKdh8Gbd7xpuoroZyZZqcdZag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DOvt+20i; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DOvt+20i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776413935; x=1807949935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8vHhhlYx6EpxdUTHTWuLK9FDMCG14clDo9GgfoUBNP4=;
  b=DOvt+20ijLfNgyuaVoUDJEGcOzukym73G9Lt8IPPi7+ajUMuOIKHEzRJ
   5AqGmZkwbiF6guCH1mTD/okZx9Ea+XCDzDJCdxzmB1ZxV63IJjDTCidie
   8EbhYLP0vsgQQwDrStG1GysiPyaQRe/BTMUTAg+CY4LtYqf/BUrjTFGU1
   CdSPkYsrF820d/01XNHu3d4evmzq2stz0PH/vmhSuF4k9uMnK2GIg7Qoa
   WR3DtvgyDYGGeE84XA4P3JQhlNnr5gb6sJHOWbCnItddQGCz+DCNnZNc0
   ox03s1z8OaGwXS45oRDG1iOEcULguWPTXEpvSx/vAMbtefrUZKahF4zc7
   Q==;
X-CSE-ConnectionGUID: 40RO3YQ+SQOhrWfD5hgqtA==
X-CSE-MsgGUID: 7ih4eMlNSH+JKQfPuF662w==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="81306071"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="81306071"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 01:18:48 -0700
X-CSE-ConnectionGUID: 5M7IoRE6T722gM9d5pTouw==
X-CSE-MsgGUID: 4UDo6hc1RF6EYrVPVIoV5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="230856725"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 17 Apr 2026 01:18:46 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 209DC95; Fri, 17 Apr 2026 10:18:45 +0200 (CEST)
Date: Fri, 17 Apr 2026 10:18:45 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: andriy.shevchenko@linux.intel.com, jsd@semihalf.com,
	andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: designware: Use
 PM_RUNTIME_ACQUIRE()/PM_RUNTIME_ACQUIRE_ERR()
Message-ID: <20260417081845.GY3552@black.igk.intel.com>
References: <20260417075451.5435-1-luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260417075451.5435-1-luoxueqin@kylinos.cn>

On Fri, Apr 17, 2026 at 03:54:51PM +0800, Xueqin Luo wrote:
> Use new PM_RUNTIME_ACQUIRE() and PM_RUNTIME_ACQUIRE_ERR() wrapper macros
> to make the code look more straightforward.
> 
> No intentional functional impact.
> 
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>

Acked-by: Mika Westerberg <mika.westerberg@linx.intel.com>
