Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E991A9F94;
	Mon, 23 Feb 2026 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847226; cv=none; b=hhBqN8jsZq9J6/U/TJ4SXfYJ9rqfs7FUM86AAMVBEdNEeEHl8GlE7sSJYJkKFqCjkVmAKho2lhLQOScykfMI6FJpXUa3pj0qgluXBnleTCJwm41P8uNzQsvFhTQdgLkOB8jqUKwqRIRmmlga0f0Z6BDqM9LPT+RPmz03BeVZurc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847226; c=relaxed/simple;
	bh=4Zo1/bJzC95O4jc9MhiIvhXtE7qUUzH1FAM8Szi2jck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0/LhPc8sH05fDkh+aTXQedYqRjMIkwMEW7Ks6E9KYn32lQVWQx+Nm+4VDyYIH6yT4g5Kne0WwrId580omCkHTBKOdUQI2MiiZ11qyynIum27VFuPpKcX89yGFoXIBzpzDMsXle1tDqzljSfnpUJ9OoxopYpNVBguMMgUFybjBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHRyGkXc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHRyGkXc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771847224; x=1803383224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4Zo1/bJzC95O4jc9MhiIvhXtE7qUUzH1FAM8Szi2jck=;
  b=hHRyGkXc/rHmFavbNggttcU1aGOP1UwO8Cc/JVUshDCAoYlQKCCFwCyx
   MoZDbp2uZqTBWgn9hfI9wjszjTh7HmWRyfi92YqKdDZvVKM8Tj7+Dgwts
   odA8tkNK2Ys0CgVGXHRsJjdwIQxlZ5T4sglC0clchYkGoi5uRYRwjqS8V
   GU6QvML++N4bkaTSjPXwo6xP4YTqa1OW6cCD1yH7jnYxRICLSsnHOK9W9
   qwy97rf10jXJfu7whb9lWT29kfLuGw3RUJAjLy/HiNKF5AmjzHNuJFC61
   mqN+EXd4JZ+VPT6t4pyvTup/0xeww56kS/XdLiUHSNGuwLdY7iYiLOpkn
   Q==;
X-CSE-ConnectionGUID: hpgJIF8mTz61fbY068OLyg==
X-CSE-MsgGUID: AdFuwpC8SJqYap/JNLxJsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="76702551"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="76702551"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 03:47:03 -0800
X-CSE-ConnectionGUID: q8QU/2qNTJeleoLpfAsP3w==
X-CSE-MsgGUID: AwlaiU2AQU6hite5JHHVOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="253260733"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 03:47:00 -0800
Date: Mon, 23 Feb 2026 13:46:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Israel Cepeda <israel.a.cepeda.lopez@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
	Hans Hu <hanshu@zhaoxin.com>, Bartosz Golaszewski <brgl@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 8/9] i2c: designware-amdisp: use i2c_adapter_set_node()
Message-ID: <aZw-MX4NvafqUVsy@smile.fi.intel.com>
References: <20260223-i2c-ada-dev-set-node-v2-0-77018c536610@oss.qualcomm.com>
 <20260223-i2c-ada-dev-set-node-v2-8-77018c536610@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-i2c-ada-dev-set-node-v2-8-77018c536610@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 10:08:26AM +0100, Bartosz Golaszewski wrote:
> Use the dedicated wrapper for setting the fwnode of the i2c_adapter.
> This allows us to hide the dereferencing of the embedded struct device.

This should be united with patch 2.
For this kind of patches I would not make the split like this.

But if Andi is okay to take as is, I won't object (this is minor thing).

-- 
With Best Regards,
Andy Shevchenko


