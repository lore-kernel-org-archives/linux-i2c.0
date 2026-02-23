Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDA01DFE22;
	Mon, 23 Feb 2026 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838047; cv=none; b=oOBvhMpOjloae6HCxhF9un+xu5rmTNJSx5aKq6SMS7KKHlVv7CdeyAuot/1sSnxDVaVtOhPDI+IYfAhNPf5PEqZeEVxVE0o0W71LzGP9JWulPWOz5s/q23NqA+4qC4UMBo7bluIrjGmbC+tG6rVEQ/w98xJpWgHfKE07Ogvir/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838047; c=relaxed/simple;
	bh=AhN8A68dG+bNtvgReQKNN90U5+381kQQAiFAB1YNBhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzBZG2Xc4/KvjdKUXSZrIdlE0An68/qZ83J5NaeA2DN3R4lB8v7WIPelKLaHclf05wJ49CXTpMdAhKR+Fh9zD4yf3dMJi9ad0ZoiK92aWl398zue1BwgEvl0n9k9WIHCPhUJQuB8pyxF9z/Ly4+YKpaAPEJP36dmsC06szJiJlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hnzFXySu; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hnzFXySu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771838046; x=1803374046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AhN8A68dG+bNtvgReQKNN90U5+381kQQAiFAB1YNBhc=;
  b=hnzFXySu/6QuABMjbZKhRU+t68cB4SoDY921yquSJR0EL0LsRWMqKXm1
   rkHWwV59Ft59v5K8jfqBAN+2R1K56dCX/Id+9QKw7LU12ceZei/dfGYXn
   JRB4O+apv5PLfX/YzPaSLnKUFNZlrW6V3ylMj3YJveiKC2/hHIYnqdLyu
   tjtH4QO+L7vnbQ9pmBVS7tTsBhLa0WRyqOmpde7EVBM9GZUYVU7kk/z54
   PLl3ZKV9NkTvdnW+oo8rpt5yERcbOa27vTKVpmEuHbFOcPN+ECmsRytQn
   jtPIXe7rpM7HWVxjSj+2A4lUtDrDT7hqjsrnplBCpVwiP4N9ITWaxAAcx
   g==;
X-CSE-ConnectionGUID: 7WACwfxCTjyyBn8KXa0Drg==
X-CSE-MsgGUID: ZbK+qVClTBi+i0m4PA3FMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="72735412"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="72735412"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 01:14:05 -0800
X-CSE-ConnectionGUID: Lg5UH2WhTg2/4dd0uS+rpw==
X-CSE-MsgGUID: QBTwSRgyQN2VZrubhrEbzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="215640358"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 01:14:01 -0800
Date: Mon, 23 Feb 2026 11:13:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jean Delvare <jdelvare@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
	Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Hans Hu <hanshu@zhaoxin.com>, Bartosz Golaszewski <brgl@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] i2c: mv64xxx: use i2c_adapter_dev()
Message-ID: <aZwaV8LdexyU5jil@smile.fi.intel.com>
References: <20260223-i2c-adapter-dev-wrapper-v2-0-d02946569773@oss.qualcomm.com>
 <20260223-i2c-adapter-dev-wrapper-v2-4-d02946569773@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-i2c-adapter-dev-wrapper-v2-4-d02946569773@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 10:02:52AM +0100, Bartosz Golaszewski wrote:
> Use i2c_adapter_dev() where applicable in order to avoid direct
> dereferencing of struct device embedded within struct i2c_adapter.

...

> mv64xxx_i2c_xfer_core(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)

>  	struct mv64xxx_i2c_data *drv_data = i2c_get_adapdata(adap);
>  	int rc, ret = num;
>  
> -	rc = pm_runtime_resume_and_get(&adap->dev);
> +	rc = pm_runtime_resume_and_get(i2c_adapter_dev(adap));
>  	if (rc)
>  		return rc;

...

>  	drv_data->num_msgs = 0;
>  	drv_data->msgs = NULL;
>  
> -	pm_runtime_put_autosuspend(&adap->dev);
> +	pm_runtime_put_autosuspend(i2c_adapter_dev(adap));
>  
>  	return ret;

These two changes are in the same function, perhaps temporary variable
would be better?

-- 
With Best Regards,
Andy Shevchenko


