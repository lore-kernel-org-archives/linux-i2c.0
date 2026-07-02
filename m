Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5AA375AC6;
	Thu,  2 Jul 2026 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783019228; cv=none; b=aD0ufwPu78yty/yerFFW1ejygE4A42xHIodTGYxfKMBLapBYEB+6qYlxm7FSEkjRQbSYeC/8qoTg3mwL40T8MNV5Z53m5nHMi4oFbKT0zgJtDMt8BfUwxfqsFWmCaXH+yiQG1QA6m8d10jIK+rHyn6hD6BpjMMbHwvocjmgYIdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783019228; c=relaxed/simple;
	bh=lNhgXepedNRJMp2/BjgNhArne6DEi8uuv2qxUuvNpNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhOnyfdIbiNekKxVrPh+NtUgyeA9uP4xM5vN8RA3zVQZIS2Bfdm2vSv2jB8sYMU8O/sE/TD6zW5JG4hSNc7SAKNqw7tFGH6h6ez4hcdbkCVtMcgKLloMvxqNGIJTmVdT+YT3biRNNXJFfJ/wlpul0FvG3WbFgFMqe2IkspO+cpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrYp/Rd1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrYp/Rd1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2751F000E9;
	Thu,  2 Jul 2026 19:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783019227;
	bh=VMa+yWSdWJQunWxjdzIFUy8a9j8A28yI1e8zGw9lFZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jrYp/Rd1494TtcTgoMetSh/EUlapjipCtyr163gYQc+qMTxWxzDBoEjIM96A4QP2v
	 RcnpvrlNLMcYLQdpdK1F8ajGw/F2gVXygH9mN9tpXJjBkvAggV+IdyIFnHd/Y8LHzX
	 0bEivdhoTV/bMYdB+ks6ZG2YX6qSy6hkQIm7iZ8QmSrCNIqpYrco8p+Z4cNM+UhK66
	 nszgIhB2eBIkCA1iaJK1vcQDey6pLQeoVSJ+lDvil7/kxriWugY5/hJ7YvKCZcx2Dk
	 yg0ByoilA+yrMgviZksKqvHsJSmtZLAPAd1GzHzyeCYSe2CGdHNznJvOJeBen5L8c9
	 zgqGh66fVRuMg==
Date: Thu, 2 Jul 2026 21:07:01 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Maoyi Xie <maoyixie.tju@gmail.com>, Jan Kandziora <jjj@gmx.de>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: ds28e17: reject an oversize length on an I2C block
 read
Message-ID: <aka2gCbXkDJ0DQRe@zenone.zhora.eu>
References: <20260629121043.199487-1-maoyixie.tju@gmail.com>
 <akaMJVyqy2nXKHAI@zenone.zhora.eu>
 <1e5e95ef-fa14-4c52-809d-4029ba043c1a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e5e95ef-fa14-4c52-809d-4029ba043c1a@kernel.org>

Hi Krzysztof,

> >> Reject a length above I2C_SMBUS_BLOCK_MAX at both RECV_LEN sites, the
> >> same way i2c-algo-bit does.
> >>
> >> Fixes: ebc4768ac497 ("add w1_ds28e17 driver for the DS28E17 Onewire to I2C master bridge")
> >> Cc: stable@vger.kernel.org
> > 
> > Cc: <stable@vger.kernel.org> # v4.15+
> 
> This is not needed. CC stable is enough with Fixes tag. Unless this
> should not be backported to the kernel which introduced this issue, but
> then why?

yes, you're right, but reading the documentation it suggests to
use this form, it's easy to get, so why not? I always use it.

Andi
