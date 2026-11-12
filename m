Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794473329;
	b=jqZuafR9/iKuV2Jlwyzsblpj3LXcTBiPlKZy8x2k6NdNEN1BnSDYklBKKsDMBT8fWfMu
	 JF+fZbxhiBAuqkA/S0m3v6A5E/hjSggRQENDx4Bnnv84kwOyx9P03TiRQrHv8rcJE6zlw
	 pbKWLxONAwrncuR+CIzgFD+tx2Lkt7PJAXTJJktFnDseSqKTecUAYLFGPUuO0ur8yGN60
	 WQriu+LcdXDkLNaW+GsFue+YiUln27rwXb5OEmguIfIkSvv/QBN+184RYfJ2wC02jyiJ8
	 O1brmWrxr3a7fS6QHoRQiN4Ny4geYJbn++2aCh8HO59YuAlPTOXZVrRaxqLOh54lwbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473329;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=rMeOu3D5UIUffOK5QEWtJFsJJmygCEj1l8jz1HMcCDg=;
	b=u3yiJECkwm57+ak7EbaS94XZ9d3GdYqVjbhDU7DLmzhakNu8gnC4BJMuZ+jKAbUHPwxF
	 TbouOaHWl74Xs1E7rXFio9W/LXnamibUZS0wgZkKx2aApb0Qhvs5Hk4JWuYaFSb2CIm57
	 YxthUUQz0unZu8yrbrfVb+1+sUUe768VFxVbYmDr91Q4us4183nL+T4GdQttCxp0hZ2ea
	 GTtibiyK7UGJg5EzGBGoiR00LgBtjihUdZjVBxybJhjESVBHV+LBrr+/h9NYUGB7Pm8a3
	 LcFBpEtmxAV958592r/Tv3bqrUhY92V8iXN+Uj1pm2YzTnyzuQFaUlL+kxWMhWPDt9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ye2PRitO;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E017C606B724;
	Thu, 12 Nov 2026 08:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E017C606B724
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ye2PRitO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794473328; x=1826009328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TWyaHMDVhhjb9ykYBpeMB8jZeSr1eOXOZGxooPVYyqM=;
  b=Ye2PRitOPNaxDh5U3CBHtNrIArq6v/4cG52MfDRfQfbhKGF7AciFRmN4
   AAheVpk/pEjiFWNAV9hH/YQscQBBiqEmODfAdUKW9w9sSAdBsbJVdpH0P
   t6YtLcGSqxe00EFB8uiE5KvONkiBOUeMCbKfIlBiZzUDoCic9RiMAj6Co
   w3Id29bVE440bMpTyFjRFo8d3hAQT2E4qVcYvF3aA7zUX3stKs9SIjdyt
   POJ33rLDwur4hKORZYHib/dDWTqCDyfG39ePM2LVEZUR9zTHREUQ63sCU
   9f0PTELB9bM9MW8m8Y9dmAo6dHzJT+H9j4M66Um9lQYzLdAxZ7tvE/1ED
   A==;
X-CSE-ConnectionGUID: osX9SXbRQnWTe9TOJtTgUg==
X-CSE-MsgGUID: qzTzN/UJTU6ABt8qI/IyTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3282100"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3282100"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 00:48:48 -0800
X-CSE-ConnectionGUID: AuCZfg+0QyGiUbwpEgwsfg==
X-CSE-MsgGUID: PD8x8q1LS7yz4y5HbPARZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8474108"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 12 Nov 2026 00:48:47 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id E62DD99; Thu, 12 Nov 2026 09:48:45 +0100 (CET)
Date: Thu, 12 Nov 2026 09:48:45 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update I2C Designware driver maintainer
Message-ID: <avV9bVJxKOlDUWXy@black.igk.intel.com>
References: <20261111122808.1302491-1-mika.westerberg@linux.intel.com>
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
In-Reply-To: <20261111122808.1302491-1-mika.westerberg@linux.intel.com>

On Wed, Nov 11, 2026 at 01:28:08PM +0100, Mika Westerberg wrote:
> My @linux.intel.com address will be going away soon and I won't have
> access to the Synopsys datasheets anymore. Heikki kindly agreed to take
> over this driver.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml | 2 +-
>  MAINTAINERS                                                    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
> index a73e2a6e0833..56430a35e5d5 100644
> --- a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Synopsys DesignWare APB I2C Controller
>  
>  maintainers:
> -  - Mika Westerberg <mika.westerberg@linux.intel.com>
> +  - Heikki Krogerus <heikki.krogerus@linux.intel.com>
>  
>  allOf:
>    - $ref: /schemas/i2c/i2c-controller.yaml#
> diff --git a/MAINTAINERS b/MAINTAINERS
> index efbef2cad7fd..c2a273dd2310 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27261,7 +27261,7 @@ F:	Documentation/devicetree/bindings/media/snps,dw-hdmi-rx.yaml
>  F:	drivers/media/platform/synopsys/hdmirx/*
>  
>  SYNOPSYS DESIGNWARE I2C DRIVER
> -M:	Mika Westerberg <mika.westerberg@linux.intel.com>
> +M:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
>  R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>  L:	linux-i2c@vger.kernel.org
>  S:	Supported
> -- 
> 2.50.1

-- 
heikki
