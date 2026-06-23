Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27836274B2A;
	Tue, 23 Jun 2026 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225075; cv=none; b=s3XFt6sTnzzMPJijFSm5nMxPE1NDoo+VP61LGm4Rmx1hEk1lAM2sK9r0+XmcBBoYjotJLoxw+BXhhmsHbA9ZpUb/lg/TVgR9V71BYsrHw6+4VLqX/jLAz8R9SPKcWXXfliYedh1cTLA/4Oa9J0Iq9wdlZklfuPK5tOqY+0WhPYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225075; c=relaxed/simple;
	bh=ZFfBlKwX8ZqvZpEtlLYJUYcDgLHRIibJhSxhYGMrPAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAdD/ryQXqkBinissURzoF0DkEfgeQdyHtOn5fQC67qN5PUMe0oOoSM6AbVpGM4BERp4yfGj1pWHYOLRgHhzYlAAozsJlktdBH1cl0IH2nxHGGfyE1O38XJDXdnfZPzElkDYlHzz8zAxCpK3fQCcqxXl1fpvBo9qIUG/+GG+OqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVqRYFGg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVqRYFGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D9C1F000E9;
	Tue, 23 Jun 2026 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782225074;
	bh=H5f/v1lZwNOFD2bVqdfqwqlEANIV/E1gYRDSn8KYAME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BVqRYFGgSzbSZKIbQOwhPSgvGqXgY7baRZfTQhkT4g3XlyJ3XfJG0nhu8hsk92Ra5
	 08I3RCIcbqJSjcy4ZlVydwyLt8H94GC+s8bkrqFlUSEZKE1bSlxPMhSh+hO65vZUHx
	 6sEOhwUeOhm2CBlhsnF+SiK1ipK9hrGxoh4rj/TdUl52psp57XDhA0Qc7sU9M8hvCa
	 nHtXindEbNC6Ly0zPDgwl5+yZchtDPxjgYhH497n7O3y9thgYryAvXk2yfGLAUlJgn
	 iuFIuotQiZu+o1FZ0r3svFEhbgLq0enuVSlCfFXhWN6F2Pxn/kSlrg8eEih8uh34e/
	 49iSOw5xKqo/w==
Date: Tue, 23 Jun 2026 16:31:08 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] i2c: k1: Use generic definitions for bus
 frequencies
Message-ID: <ajqYHXuaibeBdiEL@zenone.zhora.eu>
References: <20260618141125.3241048-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618141125.3241048-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

On Thu, Jun 18, 2026 at 04:11:25PM +0200, Andy Shevchenko wrote:
> Since we have generic definitions for bus frequencies, let's use them.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This had some merge conflicts that I fixed. If you want to double
check here's the commit id(*).

Merged to i2c/i2c.

Thanks,
Andi

(*) fda74eaaf4cf ("i2c: k1: Use generic definitions for bus frequencies")
