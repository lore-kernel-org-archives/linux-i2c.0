Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873018;
	b=UcQTtVvtvhmrPLsjt6D/eK5zS8MDaklMNf4yyFCFieNmUqt8J2U3oFw82DBC1vVDai9F
	 TuWgUnHZHGIyTYeLNv8JqbAlIOr/rCGEcBQRK+Ky3nJEpIUbNfFIBjM1lYyXF/4HQfMA9
	 uEIB2G1BHxE2f2YbsbLmStin+e5LEEuYU/PgE5jQ/7WE9BBwYjFnRbcnjq4Sy5d/cUPgN
	 rMJDPAP2untV5/PdCOU15K2JU+pmyL5+ve5rAivos4wUw1rF2TVITPi8wxhkxDXQSlIDg
	 y1zLutuHZ6CpR72Zs6xjP0ql3ME18riWAyTl0wnukHwq/eK8Xd9xD7dtzSzA8kRFoMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873018;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=uWAuV8ND4GwIwzuy6vxDMk9DTxSyH1v6Se3XQiTMBCA=;
	b=HIvevgkZg7QbK/NLFToNsKw7UaSF5v1364y457zxn7E0oj7bofJoQ1Vb6v562/O40ZZ0
	 HV2LUpAvbyQBCCGBPdnwQDD8pKo5R1zxezAGqYVBt6ET43JefdahLi7AKjaIrBYItsw6G
	 j28M1FvTfHJ5E1HtjUtpNrDf+qhg+dAQrMncDQF6AOOSPyOXuYUC6ZXSzv3dVZjV4zb/v
	 kISSKLD52BvqwX9POwTf55oQ3cQVxne0FsQ5qhjKtvPyDB1GpTV8Qr7IUeD02NrzNCe1m
	 JQmcnw7FIqP7PWw2c08fEUFwABp4hD5e16z/xWBV0SOQt8nBnh79lP5ZZPkCvyk5M9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="SKD/y0RT";
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C978606D801;
	Thu,  5 Nov 2026 10:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C978606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SKD/y0RT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793873018; x=1825409018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qnzEZMQ6JSlnLja60mD7Z+BbDzcphTOEYalD6cbk15U=;
  b=SKD/y0RTSvfTjkw4LqqqCeUgJZRbO87el5CsOAheuPA0DAL4C9IgIHwJ
   u6Wd2dH7jVFcHjyOQWcKYBEk27JAi767tT84RtpIoTNrToQFyGlhv50x7
   UPvAzu45pWIyiGuzqtPCorQlQKcVE8MrdGbUT3zubTybRsOZ9DT1ehPdi
   krWz95fZ6TAEdsybnRgfuEfYeks4frvK/9VblmiTthUNvVEo6rgZXxbO7
   Qy5E+6nu8u4GuyrOEQRA6+psoiyI/fWvnoziJsFMgHQzwhXbvvNLBuBr6
   QGZ/AAtxLBidoZqTvoyPY2/GTtl8nCEA57G5fNlMyasdSpqIkRAqmFA2+
   Q==;
X-CSE-ConnectionGUID: ddvhTOzPScOxTznPMW43QA==
X-CSE-MsgGUID: u/zDEUQLRYad9r4ABbl7ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2688290"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2688290"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 02:03:38 -0800
X-CSE-ConnectionGUID: wvFM23JMSMCxXkRprZjnaw==
X-CSE-MsgGUID: SbC45wl3SzWoPY2Nbq8/gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6983198"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 02:03:35 -0800
Date: Thu, 5 Nov 2026 12:03:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	apais@microsoft.com, rlmenge@gmail.com, hargar@linux.microsoft.com,
	Jarred White <jarredwhite@microsoft.com>,
	Jeff Kirsher <jeff.kirsher@microsoft.com>
Subject: Re: [PATCH v1 1/1] i2c: designware: Add ACPI ID MSFT0006 for
 Microsoft Cobalt SoCs
Message-ID: <auxUdHvRhWWO5ezO@ashevche-desk.local>
References: <20261104234928.86458-1-sidchintamaneni@gmail.com>
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
In-Reply-To: <20261104234928.86458-1-sidchintamaneni@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 11:49:28PM +0000, Siddharth Chintamaneni wrote:
> Add the MSFT0006 ACPI ID for the DesignWare I2C controller integrated
> on Microsoft Cobalt SoCs, along with its 300 MHz input clock description
> in acpi_apd.c.
> 
> Without an explicit MSFT0006 entry, ACPI device matching falls back to
> its _CID (APMC0D0F), which configures a 100 MHz input clock instead of
> the controller's actual 300 MHz clock.

> Cc: Jarred White <jarredwhite@microsoft.com>
> Cc: Jeff Kirsher <jeff.kirsher@microsoft.com>

Move Cc list after the '---' line below. It will reduce the noise in the commit
message and hence Git history.

> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> ---

Cc list goes here...

>  drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
>  2 files changed, 7 insertions(+)

Code wise LGTM, I assume MS allocated that HID for the specific device and
we will not see collisions in the future.

-- 
With Best Regards,
Andy Shevchenko


