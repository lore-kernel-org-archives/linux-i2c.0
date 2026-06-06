Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9A43C5832
	for <linux-i2c@vger.kernel.org>; Sat,  6 Jun 2026 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780781369; cv=none; b=gLq2clnBBjmQKHLKIu39JEWecKC6f7pbWPhilfsJx2u9IudZpLpXZJr1R0vxEpYbMc5NO9aeMCi/rHITpw/vMtTtwj/6oXvaT0y0j8FMxzn+VoWF80TH8py2xrnL4kjNykO9gjBiY7C11owJQ2av+uZ2pPxs7M33NzJdIVhB93Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780781369; c=relaxed/simple;
	bh=FTmX/zHdSjmapZ9MehuNKN4nMRgIsqXaDnS609ZCza8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rdl18e430btnNS3CwvZO6jo7WE+n44h1uC8AaLPrkdhpK0sAwo4ijEPxG+qyn2tvdBu/xH5WTiTL6V8LkPJAMkGU+EJ/qOHsrcjiC5w66vKzbEnuZy5jniM2KVzmlMonc4NSHNj8jvIvmH9LhvyFFhJP2Uk9clgqgHyneNU9ojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UOrk+TTC; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UOrk+TTC"
Date: Sat, 6 Jun 2026 23:29:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780781356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VbBZ+IaEUawcL/PoReTCmRBgP4y4OIsbSC0U0HiGDbg=;
	b=UOrk+TTCrgWYZ8PnaBKxp9ncECQb1EXNtZyMET6YapFgWc/Bsc81e5F4CbUxVHuwm+NVkn
	xrTrBuEKUluKZzNtnVR+W6C+D2k2wrFZC6gd/ZfSuaFkWT8BC7SRNLAbucKw8lO35ZWIXw
	N6KTFJXUlrvSOwMSQuWmiPQFGw0fHeE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] i2c: change return type to bool for
 i2c_check_functionality
Message-ID: <aiSRJups6bcEtb3U@linux.dev>
References: <20260421161607.61314-3-thorsten.blum@linux.dev>
 <afhjp_ib0padlv5z@ninjato>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afhjp_ib0padlv5z@ninjato>
X-Migadu-Flow: FLOW_OUT

Hi Wolfram,

On Mon, May 04, 2026 at 11:15:19AM +0200, Wolfram Sang wrote:
> On Tue, Apr 21, 2026 at 06:16:09PM +0200, Thorsten Blum wrote:
> > i2c_check_functionality() returns a bool - change the return type from
> > int to bool and update the comment accordingly.
> > 
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> Basically OK but you need to fix the in-tree user first using the 'int'
> behaviour [1]. I'd think you can send it with this patch as one series
> and have it go in via the I2C tree, but Lee has to agree then.
> 
> [1] $ git grep 'i2c_check_functionality.*='

In linux-next [1] shows no more results and I believe all have been
converted.

Thanks,
Thorsten
