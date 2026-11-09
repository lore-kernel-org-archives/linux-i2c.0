Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259850;
	b=RPeyS8pwzQCElAPsNq6o9TFkSej0rpZzrikYdYKbowPtzfpQLQB5y+rS9clRfC/1XMgm
	 aXGkHLLCdKT3Uf3xPRkL6BI00J7nne4ZmoPtGjjkNcSAeNmhFzsJju6Crq9oAUiZqpLvn
	 kwcuGug6j1xheDi7Rv+XDx+33/3XovZcipFMPUK9noughfr/We3wg8hvFk0MZiEfs0vJJ
	 +IyNAgFVu1HMwjP4vudjqZukT9VxebzTYccfNjRBaTYdguW+m/QR0IoXmPrkjiVgsWHAa
	 aue+XX8MV86qLIozol/u+KXEQChQErrCF2EN8eJbHE6XqvRfZqU3YX2+SoD+PYPq2OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259850;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=1IVG3uKpAsj/xorSCQ1OWWpUkei7GWHbwAaBlwZZmJA=;
	b=QseGdBznGEU/Uj/2xVTUbRRf3dw1R4EciJFfSl6xLNOYbr1UZdq22az4vA6RjYbz4AlX
	 3DABuRtBQJVfvJUjnJgprsh/YjRRG8XASFwlFDlFV0KVLYf/wEJqz0xmmVsRjpjTV/Jho
	 yuWENsaZX4PiYXu/clNS8atpW1zQjGbr4oHiRTulRodKJNt5HHF/atXy0XtRdp4v4iaku
	 a3R89qstBBxkb15wJ0DjDlb5IEn6F0i5flrGQSaVk7eG4x9fFM5eZIzBf+UpdzLgZXIoE
	 0x356zEVgzb0sGzdpQv4KBIbUYZ/TKd8YxKBldy35VZM26jI8/Wxps8d2ltd7hTapVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HqJPXWkR;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20150606A31C;
	Mon,  9 Nov 2026 21:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20150606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HqJPXWkR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794259849; x=1825795849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y6aMCxx3TcjAWi6PVldvIOfhi2EzWAhReeZaR4ZUd4E=;
  b=HqJPXWkRnOU9kUYCmFJcZE0h9pGsfMjceR5n+ATKtxcUu6vX+hDhjtX9
   QoUVwjZIOcRxW7wwDNED5JEGRJuT28aS+Gk/A2aY9uI+kscUFvqAPz2Ss
   3rLdMuToxYsCmJR832y0yB0kj+kot3mt0tTiD7fxKxhq3JNB/b89zLS7K
   ALHuGrXvueBvmrRtM9BkuJZHEznpv3slUwphoLrgi+O6gY5Fe8EUibs3w
   gaGU4cRcu6/J4suLEqZQt8GokoQXVcw+JikzvTETynomuCBavbEp44O9B
   QCfIsXHoSo6XbbuO3PtttnevvMyGs5EZY9G9SZ93NYdyIk5koyopONyhG
   g==;
X-CSE-ConnectionGUID: nebYwsuSRd+bPM+IQExZIg==
X-CSE-MsgGUID: P5D3WgdiRQSIZJyB2VQk4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2988306"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2988306"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:30:48 -0800
X-CSE-ConnectionGUID: OreXhy1UQG6X/bbq2NGlCw==
X-CSE-MsgGUID: j74BoPckRre+bn4wZasqEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8286207"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:30:46 -0800
Date: Mon, 9 Nov 2026 23:30:43 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	apais@microsoft.com, rlmenge@gmail.com, hargar@linux.microsoft.com,
	Jarred White <jarredwhite@linux.microsoft.com>,
	Jeff Kirsher <jeff.kirsher@microsoft.com>
Subject: Re: [PATCH v2 1/1] i2c: designware: Add ACPI ID MSFT0006 for
 Microsoft Cobalt SoCs
Message-ID: <avI7g14oGpFKlJnV@ashevche-desk.local>
References: <20261109210146.57766-1-sidchintamaneni@gmail.com>
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
In-Reply-To: <20261109210146.57766-1-sidchintamaneni@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 09, 2026 at 09:01:46PM +0000, Siddharth Chintamaneni wrote:
> Add the MSFT0006 ACPI ID for the DesignWare I2C controller integrated
> on Microsoft Cobalt SoCs, along with its 300 MHz input clock description
> in acpi_apd.c.
> 
> Without an explicit MSFT0006 entry, ACPI device matching falls back to
> its _CID (APMC0D0F), which configures a 100 MHz input clock instead of
> the controller's actual 300 MHz clock.
> 
> Acked-by: Jarred White <jarredwhite@linux.microsoft.com>
> Acked-by: Jeff Kirsher <jeff.kirsher@microsoft.com>
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> ---

Where is the changelog?
Haven't I given a tag already?

-- 
With Best Regards,
Andy Shevchenko


