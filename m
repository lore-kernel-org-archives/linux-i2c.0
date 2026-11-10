Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308413;
	b=dzE/mpTRyvZVgJXTKQ8q8taG0wL92ARkDhPBjUobl76bnTNd5TiLHqNStltMDWKv5Cak
	 v7Ftr7Y48p1Ybs/VTDw0j8W+aAemg4kmZ7DZiy/18/5Rq63Wvd11iKH0YB+1cTuIAW4zu
	 ++ZS3G1MlPtcl+3IcCW0D6Id6PET9TdqLlfe+d0PnKxXCIqwiO/bclaqZjBgtxxjGhXCR
	 ovYRvt0QpGj8aW4u7874m0tDUAIl243zpetFM8SF3ir1HpR+9T5rDdz798uzxlnD6BFXa
	 x87pQdItHYPxysy7fTRx7dVoRP6RfD9MhQZLifMCyUeGq09ih+gQOfz2/t8+hMAu4Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308413;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=NSMWvcFYZOKCCVb88n3Kk+fuLMMhBMnxQ6T8kLpc8mU=;
	b=oDtxAXzHgH3ZwkBLsMvSE7SgYMkjNFknxK05EG+0g7tFUTNTWyk9zJHzhLMiUSHwwM7N
	 +vuEAH6F3LCPSeE+3H3d9X7Pi6ftwTn5WsKAZVTMtfoMwi7pDuDApFiPiC/g+ChenQtPx
	 SJo2FwxdmmbvrFYHVFinmqcpYPUUtZGO+6dmRI2i6R5YRKnCwxfkkxKhEsUpCYjy89f4Z
	 cAc1zr9dr5ng+7d1qJUdIzlFwhvaAAJLVOZi6kQeVfmwwssu3X0RMU5MVD9tA5hcuweC2
	 Kc9baC7odiDTjCgFqDzVz8XdASnjiQRm9gaHq0ZAKY+triyh1w3DVKO4OgydJQY2hEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="So/tpC08";
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FD6606A326;
	Tue, 10 Nov 2026 11:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42FD6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=So/tpC08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794308412; x=1825844412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C0dN857QLoSjlsNDKcXgPMvaBouD493jYOg6YhUdHQ0=;
  b=So/tpC08dueICPP/QWxuNtiVY+aIeH/VYQGuktKiqP52gUyiSuEJazC3
   6dr3/8hMvfNj/z6qKDEdSl7o62gXeucEU0sWScuRzLDaD4UNW1TCCLYST
   pCQ8tnPip02aLQ+WAq53K9QRHSlf3Nn4Cdqm4c77EJFXv+bWN46s5HvnS
   zF/AIRwdcEW1VeLXeJPnt8EJ4voZPyuyFf+1bACKznmhyEjoYMfwi6bjH
   D+Yul7MnHctax4TXFXzR1PXuH6J2oMy3bxa/9wcpGQzuzjaPpZWg5h4oc
   uWwvVt5sX/R4QxY0+UXRlSJF6WC73sladWsdBUVX90XtqQDJcSb4YbtxX
   g==;
X-CSE-ConnectionGUID: kpjR/OFcRVapO/3EuM38bw==
X-CSE-MsgGUID: K9aPUIU9QpuEyRZWf9AeIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2956099"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2956099"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 03:00:09 -0800
X-CSE-ConnectionGUID: PLhLbyz9QpWp/ASP6Ma7HA==
X-CSE-MsgGUID: Tw88b5p8QHyzqzzoYDR/GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8272163"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 03:00:06 -0800
Date: Tue, 10 Nov 2026 13:00:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] swnode: fix device_add_of_node() kernel doc
Message-ID: <avL5Mz5BiDRHUkMt@ashevche-desk.local>
References: <20261110085125.2535508-1-johan@kernel.org>
 <20261110085125.2535508-4-johan@kernel.org>
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
In-Reply-To: <20261110085125.2535508-4-johan@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 09:51:19AM +0100, Johan Hovold wrote:
> Software nodes added to a device by device_add_software_node() are
> always secondary firmware nodes even if they may be stored in the
> dev->fwnode pointer.
> 
> Fix the kernel doc which incorrectly claims that a software node added
> using this interface "could become the primary node".
> 
> Also clarify that device_remove_software_node() should only be used to
> remove software nodes added by device_add_software_node().

...

>   * @dev: The device the software node is meant for.
>   * @node: The software node.
>   *
> - * This function will make @node the secondary firmware node pointer of @dev. If
> - * @dev has no primary node, then @node will become the primary node. The
> - * function will register @node automatically if it wasn't already registered.
> + * Register @node if it was not already registered and make it the secondary
> + * firmware node of @dev.

While at it, please add a missing Return section (as kernel-doc complains about).

>   */
>  int device_add_software_node(struct device *dev, const struct software_node *node)
>  {

-- 
With Best Regards,
Andy Shevchenko


