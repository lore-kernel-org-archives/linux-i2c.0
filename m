Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187009;
	b=g+pOwrrH/4kwlQaOC7QDJ3jq0RHdPnm/WCWzDodaVJNfSqV1IaCOIG/eqcXFWifmC4V3
	 n4VMJqy3gbG2Bu1HgVFfhRWMsTNMFye1Bj83RSAigbh9KuM0jodxpYHwubA6UyWx0Xkeh
	 KiSJmHLc2K/juxnglo0KiBCHkd1LeUv2tKIklZdgJa3/mE6nOJfF+ZvSQT5GQo3NYcJa6
	 VZbA4zjauYdtbUt+kTGqaNIfj14xYb1YhZHxnjbK4XUE/SHszUeF0hKDSc6OeyP6GhjNn
	 cX4k/emM509/YeCg0sUOqr7cWpSG1+lVfM3pxcPkk0VImKFUkIbO7/RlsbpUySQHYGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187009;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=LOdQCpdYHv/ZEG8CmhsIXYhKAMqd2yj/QPAkVoFANjo=;
	b=0KweBl0pyTfGDTXRomoo5BkAr35dz63PL/HAFc9mns1aWGVvnn3egXVI2EU4uTJpvAJq
	 +gk90r9HG0DGyee5uMbLgaSibVfo+YkXMdXhjCmF2+IwWo0ITj/wMWdtoWyqzGhCxDJys
	 sfOkyIkf3+i81NzcrkBUGMRiuLPTHVY7nk6KrhFhQ2mXZEcazhc9t5R8nTpWuE3E+C+fM
	 6NB7Bi9gOstDV187xOiJyc+MJq3uzazljFFZSo3KtuBwQQL+NnHUsIbObjwh014MPz7pO
	 yFKmpvK+P7av1/8F9tJyD34SAnujMyYkRL5o9PaKwdA22ww7geaKsx0pSGrIoSjKF8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iknmJhZu;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB1D606A320;
	Fri, 20 Nov 2026 15:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCB1D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iknmJhZu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795187009; x=1826723009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ii/yOitZMGKF6mJiHd/2m+iaLKfzg+iuKclyRUvh6Zs=;
  b=iknmJhZuzGxaMb3yYYgdoBnjwWSOp4EoNgjuPFG5G8+bUxmv7veHpXTv
   8h1/zwxDCOPbH8eZMByMYFbxhprKD7dhA/PPZVF1wp6b/uuWKgz7diMZ1
   DUGoz5J4O2efqz3XE5toWeJXoRPFsDLz4R56lzNmUv4u2sV+j3Tu8YZWx
   XjjXXuc1NDgIWW6dM+XWSWYxCbz1VA4JlgF49DIkVNNk38Q0/rZUAy7W1
   QVNu9OXx+FnOVCk7XSaJo/6o1V9Nu17BFBvNhnAiYO4mVIjVMtfWTBVFm
   P/nOCpT/rpxBjNlLN1pNolXGTWgNMdM7W2kOjoIUGMCysYIQC5szrFeI3
   w==;
X-CSE-ConnectionGUID: B5lX3evTQBanNQpZFkecKA==
X-CSE-MsgGUID: Gx56MtjsQOm2eaFZCZTyXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3957801"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="3957801"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 07:03:29 -0800
X-CSE-ConnectionGUID: KxFQ1O3QTXC1UE7o4JMBzg==
X-CSE-MsgGUID: GNVhUSYkQK2mYgXlqn1EmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10612582"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 20 Nov 2026 07:03:27 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 8457499; Fri, 20 Nov 2026 16:03:25 +0100 (CET)
Date: Fri, 20 Nov 2026 16:03:25 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: NanamiKite <nanami@yosoro.hk>
Cc: Jean Delvare <jdelvare@suse.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: i801: Add support for Intel Lunar Lake-M
Message-ID: <awBhPXzSbfpJyCyJ@black.igk.intel.com>
References: <tencent_6874806C455DB42610399513A0A95083C805@qq.com>
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
In-Reply-To: <tencent_6874806C455DB42610399513A0A95083C805@qq.com>

On Thu, Nov 19, 2026 at 11:37:46AM +0800, NanamiKite wrote:
> Add the SMBus PCI ID (0xa822) for Intel Lunar Lake-M (Core Ultra 200V
> series).
> 
> Tested on an Intel Core Ultra 5 226V (Lunar Lake-M) laptop via dynamic
> new_id binding with FEATURES_ICH5 | FEATURE_TCO_CNL: the controller
> binds with PCI interrupt support, handles SMBus transactions cleanly
> (verified with i2cdetect), and initializes the version 6 iTCO_wdt
> watchdog at TCOBASE 0x0400 (verified with wdctl).
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: NanamiKite <nanami@yosoro.hk>

Thanks! I'm a bit surprised that this ID has not been added to the
driver before. FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogeurs@linux.intel.com>

> ---
>  Documentation/i2c/busses/i2c-i801.rst | 1 +
>  drivers/i2c/busses/Kconfig            | 1 +
>  drivers/i2c/busses/i2c-i801.c         | 3 +++
>  3 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/i2c/busses/i2c-i801.rst b/Documentation/i2c/busses/i2c-i801.rst
> index bbbce90..2e7f3f0 100644
> --- a/Documentation/i2c/busses/i2c-i801.rst
> +++ b/Documentation/i2c/busses/i2c-i801.rst
> @@ -53,6 +53,7 @@ Supported adapters:
>    * Intel Wildcat Lake (SOC)
>    * Intel Diamond Rapids (SOC)
>    * Intel Nova Lake (PCH)
> +  * Intel Lunar Lake (SOC)
>  
>     Datasheets: Publicly available at the Intel website
>  
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 275aaa7..83d3f14 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -168,6 +168,7 @@ config I2C_I801
>  	    Wildcat Lake (SOC)
>  	    Diamond Rapids (SOC)
>  	    Nova Lake (PCH)
> +	    Lunar Lake (SOC)
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-i801.
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 9d3cc70..63ac29c 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -86,6 +86,7 @@
>   * Wildcat Lake-U (SOC)		0x4d22	32	hard	yes	yes	yes
>   * Diamond Rapids (SOC)		0x5827	32	hard	yes	yes	yes
>   * Nova Lake-S (PCH)		0x6e23	32	hard	yes	yes	yes
> + * Lunar Lake-M (SOC)		0xa822	32	hard	yes	yes	yes
>   *
>   * Features supported by this driver:
>   * Software PEC				no
> @@ -269,6 +270,7 @@
>  #define PCI_DEVICE_ID_INTEL_KABYLAKE_PCH_H_SMBUS	0xa2a3
>  #define PCI_DEVICE_ID_INTEL_CANNONLAKE_H_SMBUS		0xa323
>  #define PCI_DEVICE_ID_INTEL_COMETLAKE_V_SMBUS		0xa3a3
> +#define PCI_DEVICE_ID_INTEL_LUNAR_LAKE_M_SMBUS		0xa822
>  #define PCI_DEVICE_ID_INTEL_METEOR_LAKE_SOC_S_SMBUS	0xae22
>  #define PCI_DEVICE_ID_INTEL_PANTHER_LAKE_H_SMBUS	0xe322
>  #define PCI_DEVICE_ID_INTEL_PANTHER_LAKE_P_SMBUS	0xe422
> @@ -1069,6 +1071,7 @@ static const struct pci_device_id i801_ids[] = {
>  	{ PCI_DEVICE_DATA(INTEL, PANTHER_LAKE_P_SMBUS,		FEATURES_ICH5 | FEATURE_TCO_CNL) },
>  	{ PCI_DEVICE_DATA(INTEL, WILDCAT_LAKE_U_SMBUS,		FEATURES_ICH5 | FEATURE_TCO_CNL) },
>  	{ PCI_DEVICE_DATA(INTEL, NOVA_LAKE_S_SMBUS,		FEATURES_ICH5 | FEATURE_TCO_CNL) },
> +	{ PCI_DEVICE_DATA(INTEL, LUNAR_LAKE_M_SMBUS,		FEATURES_ICH5 | FEATURE_TCO_CNL) },
>  	{ 0, }
>  };
>  
> -- 
> 2.56.1

-- 
heikki
