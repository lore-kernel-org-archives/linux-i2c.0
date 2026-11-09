Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221614;
	b=W+pP4VYtWnuZB1s1ZwWmMIUuZl+/CNNjt8gst/3ArhNavelU7QnQVZfh8FqHtxxYz9rt
	 YeTK7hAaCBq7cJ8ke38EVLB52jcwZv8WV1DtCoOFKiGiBFHnt+SqsiW+XbL0Bt6v6SLv3
	 9GrQ7bIJtsq0upIPCPbZPFNPkbSm8tV/jxvoIVRIbJVn4p8j94ocApokytoIxeeUUfiVW
	 sA0OpmrHQLZBjGl80mLiNGXvApiKfQZmqxJaLJ+52b9TTs4kyixITr5i1OmsFtUDhZGhH
	 +uGbzKuoBifozfVEWRuPxJ1irbT6UFMJ2P6k2yWlt94BXV0STuakGifC7PUL6Hoyz0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221614;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=qjvYzF+3HH9TB2V4IKW7k3z7HidMUhtd+X86vmSVh5I=;
	b=PxCr5xnoDG/7cUoP+Mxqh5YyNYb1tDpxCZT2io09HqoMLOsUah9Y46djosFYDO/sX9r7
	 MtTUfL5zIUWl0zRirr/Fj3QdSixdBEYg3YoGPHyO5IFr4GkfBl2k8Z7/7BVkTEqUu8gKX
	 9i3ZHv8KVrEwiG7hBjaTJFYL7iDFrTqRxK1nlCnBDHw6FGlAFMwTLrO9oNmoYcCtfyKNn
	 mNFsNmemyAK0hYt4BXhlHIlYA5YQIHb174/Po0GuI5mkllonGZvAXFrxy4/W95C/YkKvx
	 T4Gq+7Th6oICOaysjbkHroL4DZAnESUZvHbUW61s9l1QKbWy/qhZuYjBMxV9vboJ17w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZzHNs9oG;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21008606A322;
	Mon,  9 Nov 2026 10:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21008606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZzHNs9oG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794221613; x=1825757613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cR6aNMY/LQzTiG6SPnOMHk7TLzR2tfHdz0Cydg33JE8=;
  b=ZzHNs9oGdS0zrrD2MKZY2M85//Rh3oTKnV9Le0Qt2pf+iCi2SkIxZHuD
   MA7CpKI43Gb4wj5OWRwlbBwUMnpP1OdnPXsXwFjzegyl+7WBhm9Mf/8Z6
   SLV5bhcmE60ORmW+d0E1MU92AsEwf5U+xtIdkaABXSww4U/+dzLV30yeM
   BwIT59t+UaQbT3q4IXg1Z0mpFjjPRrbs5dAZGrtab8YiFaYjQG8NZXkGD
   b8g2xJHWBiyo/LzMUd8QH7McLAOvgs8/VzTxgMCgA6m2tW9p6xUBAmFW7
   fgmnVZkJ62OHRoSoHi3strZSnfM0j/GGVgCjBxfg5wYTWocfJ3AyMVjL3
   g==;
X-CSE-ConnectionGUID: g4/97BBLTzeuNBQf9a7VFA==
X-CSE-MsgGUID: HFcXl2qyTLm7M6XuoW6NjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2941013"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2941013"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 02:53:33 -0800
X-CSE-ConnectionGUID: iPLNRGGzRz+s7voUjlPVJw==
X-CSE-MsgGUID: kaLG7q+bQa2nUSUuTxkqQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7866654"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 09 Nov 2026 02:53:31 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 515FA99; Mon, 09 Nov 2026 11:53:30 +0100 (CET)
Date: Mon, 9 Nov 2026 11:53:30 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: designware: preserve invalid SMBus block count
Message-ID: <20261109105330.GN176724@black.igk.intel.com>
References: <20261107081108.1046163-1-pocj8ur4in@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261107081108.1046163-1-pocj8ur4in@gmail.com>

On Sat, Nov 07, 2026 at 05:11:08PM +0900, Baek Kyu, Kim wrote:
> When a slave reports an invalid SMBus block count, i2c_dw_read() uses
> one extra read to reach STOP. It currently replaces the received count
> with 1 for scheduling and also stores 1 in the message buffer. A count
> above 32 is therefore exposed as a valid one-byte response.
> 
> Keep the received byte in the buffer and limit only the count passed to
> i2c_dw_recv_len(). This preserves the extra read for STOP while retaining
> the invalid count for the caller to reject.
> 
> The DesignWare receive functions were exercised with stubbed register
> input for block counts 0, 1, 32, 33 and 255, with PEC both off and on.
> The original code replaced invalid counts in the message buffer with 1;
> v2 retains the received byte while scheduling the same extra read.
> The arm64 i2c-designware-master.o build passed with W=1.
> No physical controller or end-to-end SMBus result was measured.
> 
> Fixes: 69f035c480d7 ("i2c: designware: Handle invalid SMBus block data response length value")
> Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
