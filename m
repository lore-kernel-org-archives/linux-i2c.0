Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E3025D216;
	Sat, 31 Jan 2026 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769856959; cv=none; b=WctslfDRTTAONZdnERmZHYbWT5ivvPTv/ZYldqDNAkWrMWufd4SoSQKyw16V2TI5OYOc5/WCEKBj6CIA90gUCFi7YwVxVp5hMwVPkeC0QdvBqHqPulUG4tsdznh2zgecbYd5DGriHsmm/WYS/rKkXtK9omAnv0zow9RW0EM4SV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769856959; c=relaxed/simple;
	bh=i8OKyiXWF1B5bWDrtl9oWmy/hdR4q3YhBRSRvOtR66Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoFa9TmBPstVH4EfSlhG201dieOg6E9qnn4+LqAi3khQoDdqbBFBcPUikrHF5zp76re47912xU7JTlPrFMmea/baTuyxT+obIsu3LKKCSk+KLqbIv9y72BzhtL0DYQBlx7K56Lx+9zKieTdm9onZjShRdZT8kbiSK6kqcZP/fjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3ycjN1+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3ycjN1+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769856957; x=1801392957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i8OKyiXWF1B5bWDrtl9oWmy/hdR4q3YhBRSRvOtR66Y=;
  b=M3ycjN1+DVPlnYtAfy03paSF14DtbMEHPwC2YnCBQiZBqWoLVqg1hErQ
   eVitcNaym8t6jf6hHrE+iId6Eekenbq4ti838NPcfvu6RtSkUzO+Y02BP
   +FoIEtUZkmQKIdr57Pf5xD8yXijFTu1wrX77KM4pGf00wdNq1tXl6Lvxk
   Xi0Lh+zvYFGLvzwvm4noM/JMr88UiuXpFTPwfjz8QHHQyMk+oSUj3GxOG
   8DfElv3GOaWXBavRjF5AmRBs9G4kv8qPu963l/ByU4qMdpqwGkczL5G3R
   fDBJiiQ6oF8Y+LqetP7xaI41VtoJ1E1nQLkgDc1JgX8vQgW/dJ8m1r94W
   w==;
X-CSE-ConnectionGUID: LM6eVVjHTJik9WL4+nwtvg==
X-CSE-MsgGUID: aH+HDwvtTjahDsTxaSro/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="70811783"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="70811783"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2026 02:55:56 -0800
X-CSE-ConnectionGUID: BtYc0yn3QLOyesdykEGhUw==
X-CSE-MsgGUID: SPcmrXqkSh62GsT3WTbrmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="208646621"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.97])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2026 02:55:53 -0800
Date: Sat, 31 Jan 2026 12:55:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 6/6] i2c xiic: cosmetic: use resource format specifier
 in debug log
Message-ID: <aX3ft2nKrUkQ7Xg5@smile.fi.intel.com>
References: <20260129-i2c-xiic-v7-0-727e434897ef@nexthop.ai>
 <20260129-i2c-xiic-v7-6-727e434897ef@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129-i2c-xiic-v7-6-727e434897ef@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 29, 2026 at 09:43:18PM +0000, Abdurrahman Hussain via B4 Relay wrote:

> Use standard resource format specifier %pR in debug log.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


