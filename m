Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BED023C50A
	for <linux-i2c@vger.kernel.org>; Tue,  9 Jun 2026 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003760; cv=none; b=VF60bmdzKwOo9aznzUsZUbozQpLmpD7GzL4yO8Iyt3wyUlEQs46G92UzWj9rguRj5BOyFHsehkjmo5no4WmwwYx/IiWBdzBv9EttF6hgWQ+rkpbqbEAbB/sOYYwM376aNWQOXf1dU/ABaAV34j58FuCLMtqGfk/iDYePbiQl+xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003760; c=relaxed/simple;
	bh=F3oM0ugoxicc3GAikKhqv3kjIaBotkDWa7xY4P3hVjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umQ7dfQOrgF2syITNbLoTtWFcsldFOiwSK5wYDOe308mi/uEs9FaDRVgQPibQz8BF54eSPVjCZYvw6oibNMGCTxqlO8/z4A91UpqLyLUtQmubNPdDvB4UHhoz9op2BwzoSTu3uIalM2JrmLDQf/1gg7OvoduQzR+QAZDoEsAiGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7MfFNw+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7MfFNw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121331F00893;
	Tue,  9 Jun 2026 11:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781003758;
	bh=KmT+i4JlaGflkcsAvEOa5x2amv4MGkTTbDQVhhx1fG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l7MfFNw+3a2hVbQWZF9+elkba7maEqiBEGkN4mVVDv7j8Krxu7Oevc2UwH5mZvVL2
	 cZICBPdoR045pKZEXbs/n16VOiy3RRqj3Duo+2b6ShDn04zvx41djiynNX9sAyfhiW
	 aLJmpxuY5vifTzF63mNHicvUXgojVB1b0VWDbiM3CvPTtg+GawxQIj5pEyYuDnzXPZ
	 kLVcDV09396ov6ouQYYBCfWRiY0wnEno6a2+46tWUVE+kFwFc+DiEm1OWj/pxliiar
	 sOfb7KY6UtEC+nBPixEPLbBt8aMnIUaAnggjkKLm4tiZtXIoKYgkyJBfT9n8qfSitf
	 21c9gDm98sPug==
Date: Tue, 9 Jun 2026 13:15:53 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org
Subject: Re: [PULL REQUEST?] i2c/for-andi for v7.2
Message-ID: <aif1l5tOoKkTyIKe@zenone.zhora.eu>
References: <aicm6trmpoPZpT8v@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aicm6trmpoPZpT8v@shikoro>

Hi Wolfram,

...

> I don't know if you want to pull this branch or pick the patches
> individually. Anyhow, I want to let you know that here are some patches
> I already reviewed. I think they are good to go for v7.2.

Thanks a lot for your pull request!

...

> Abdurrahman Hussain (1):
>       i2c: mux: reg: use device property accessors
> 
> Andy Shevchenko (1):
>       i2c: acpi: Return -ENOENT when no resources found in i2c_acpi_client_count()
> 
> Herve Codina (1):
>       i2c: at91: Add MCHP_LAN966X_PCI dependency
> 
> Nihal Kumar Gupta (2):
>       dt-bindings: i2c: qcom-cci: Document Shikra compatible
>       dt-bindings: i2c: qcom-cci: Document Glymur compatible
> 
> Uwe Kleine-König (The Capable Hub) (1):
>       i2c: Use named initializers for arrays of i2c_device_data

this one was already in my tree. I pulled the rest in
i2c/i2c-host.

Thanks,
Andi
