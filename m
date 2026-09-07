Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21E744062B;
	Mon,  7 Sep 2026 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770413; cv=none; b=DWndvngPQTOrrJ6W6scBP4MupADl/UBe3KJNFwjNZDDcBjKN6IDYtB59yp/7rXn/pZuHQFITvKgSzVOV5Bc6/u1rdkRC4La+6aCOGG8mklzrO4QwkyS29L0kalsdvFb+cnVi6YR1jXFfkTS5IKn6AAr69YI+rffoZV9yt2P76Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770413; c=relaxed/simple;
	bh=EusWo5awvOA9Km2fX+0+LN45/nYa5GR9Yr8O5YEwCcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SO8EyrVqqAfwH0RbjxxnLWB05DOF7EXqgisHX8i8WGWVREFjwhh6mPxaT0sRLOH8fuCjIJ5mQLNJz2jZyxBRBoGUUqDWLuaBWCGZaza2BtShnAywLHoeQQJ+AXvCNDR4zO8e0IZSLmJlvfDf3JgxHxsE4fk57CmySnazdvhTAw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xb7XlH/f; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xb7XlH/f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788770411; x=1820306411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EusWo5awvOA9Km2fX+0+LN45/nYa5GR9Yr8O5YEwCcY=;
  b=Xb7XlH/fn8P90UCtd9cRCNzQjT0MfhhyVL/iPpe28FDqoAwyza+KFg0+
   nd8+sXXWM5VC4z1WH1prSkBiLLIe3lzEqUyaHYl8O77gY+QLK5SlGeagW
   Cb85ZYujdfuNtsmaDjBU27lawcyKFXckMIkI2QvrpXewFEGR/AI2vKJKW
   gZMaCqRorkKs63EKTCMuRV4EQea1i6b/O6TML6Cn9FUQh7wopdXu4JZgh
   W9hA2Q5aDc5hMd9PaOkS6Z7vDPc6fRulc/HULgm0bIylRW4GAA4S2MuUx
   tZA5Zz9biU0Q1XbipGAgdg5E2sYDqvm5p31MQcJM3+HvnjNKzUZkd+NqN
   w==;
X-CSE-ConnectionGUID: Gl+PyPguRZ2Ie3RYRyhD5g==
X-CSE-MsgGUID: lbyMSVRSQ4yVbLxDp5/zcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89044645"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="89044645"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 01:40:10 -0700
X-CSE-ConnectionGUID: k2wEgyw5RO6nWPQzUw+HHA==
X-CSE-MsgGUID: Y9YfNTlbS2K7A2YO38D7KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="272584497"
Received: from abityuts-desk1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.230])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 01:40:09 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id E77FD11F944;
	Mon, 07 Sep 2026 11:40:10 +0300 (EEST)
Date: Mon, 7 Sep 2026 11:40:10 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Lixu Zhang <lixu.zhang@intel.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: ljca: drop redundant explicit adapter deletion
Message-ID: <ap54aks_RJrCsHlB@kekkonen.localdomain>
References: <20260905-ljca-v1-1-9109616ff1c6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905-ljca-v1-1-9109616ff1c6@gmail.com>

On Sat, Sep 05, 2026 at 09:25:15PM +0800, Felix Gu wrote:
> This driver uses devm_i2c_add_adapter(), so manual i2c_del_adapter()
> in remove() is unnecessary.
> 
> Remove ljca_i2c_remove() along with the now unneeded
> auxiliary_setdrvdata().
> 
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

Thanks!

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

I think you should also have:

Fixes: bfd3824c8808 ("i2c: Add support for Intel LJCA USB I2C driver")
Cc: stable@vger.kernel.org

> ---
>  drivers/i2c/busses/i2c-ljca.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-ljca.c b/drivers/i2c/busses/i2c-ljca.c
> index 93274f0c2d72..da3370968c8e 100644
> --- a/drivers/i2c/busses/i2c-ljca.c
> +++ b/drivers/i2c/busses/i2c-ljca.c
> @@ -297,7 +297,6 @@ static int ljca_i2c_probe(struct auxiliary_device *auxdev,
>  	device_set_node(&ljca_i2c->adap.dev, dev_fwnode(&auxdev->dev));
>  
>  	i2c_set_adapdata(&ljca_i2c->adap, ljca_i2c);
> -	auxiliary_set_drvdata(auxdev, ljca_i2c);
>  
>  	ret = ljca_i2c_init(ljca_i2c, ljca_i2c->i2c_info->id);
>  	if (ret)
> @@ -315,13 +314,6 @@ static int ljca_i2c_probe(struct auxiliary_device *auxdev,
>  	return 0;
>  }
>  
> -static void ljca_i2c_remove(struct auxiliary_device *auxdev)
> -{
> -	struct ljca_i2c_dev *ljca_i2c = auxiliary_get_drvdata(auxdev);
> -
> -	i2c_del_adapter(&ljca_i2c->adap);
> -}
> -
>  static const struct auxiliary_device_id ljca_i2c_id_table[] = {
>  	{ "usb_ljca.ljca-i2c", 0 },
>  	{ /* sentinel */ }
> @@ -330,7 +322,6 @@ MODULE_DEVICE_TABLE(auxiliary, ljca_i2c_id_table);
>  
>  static struct auxiliary_driver ljca_i2c_driver = {
>  	.probe = ljca_i2c_probe,
> -	.remove = ljca_i2c_remove,
>  	.id_table = ljca_i2c_id_table,
>  };
>  module_auxiliary_driver(ljca_i2c_driver);
> 

-- 
Kind regards,

Sakari Ailus
