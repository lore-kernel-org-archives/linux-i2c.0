Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA653E63A8
	for <linux-i2c@vger.kernel.org>; Tue,  9 Jun 2026 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780993496; cv=none; b=ZmuvCAh/uKIuwl4nqoT+0Q2zE+s1yZ9bzgVjwQZpaGqXU4bIlzf6omOZ5Kb5eaS6B1qmkgG8tjt8rITdvm5s7/5SLh2TIKC9dm4QGRDOWlD4WfZUgfw2icrEOYR6TnCOYzIOw7qoos+VK8Tjcn/cRrd3V7TN5mrZjVUQIqMKZ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780993496; c=relaxed/simple;
	bh=F8fbUki0Y8pNtRrfL9u7pQGd+81rL+DyObgBHcwENU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cppIEsVX7iyHsqke0Wagr+InN/HzcnI+D+pq2327zdlBOlIourqrpXYyTsqwLOVd5IhmALw4wqFmpxZ0eKqPOiDsu6mCTHaeJ3vOc1EmDUllBq5M7Y3FHBKJ1u2Iqalc3I73fqC11NPBlFWzATnbv6dcY7BLELMvBxJgpSSwdbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdXdwKED; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdXdwKED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD99F1F00893;
	Tue,  9 Jun 2026 08:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780993495;
	bh=0ksY7Kh8I21Yqm+o+n0PS6NjwJkZXto4eF7BQyPChDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hdXdwKEDmar/G8KO3W5J6G2IMmpdU4wCsWfTjqt6x2eVsAckkyA/TmUP6b4G+ohmK
	 kPDM4BfvmqBa7Ppb9KGPSIqmi1htTcn2jU1ZUtEYJn1EnrYi6+NgHeqnJ9DHLI8EJz
	 6NKSBPES53/qNjN9DK7GcWabDu2u7VKpgC0RFvz3oK8tnw6Pa94MyI3UsMJoz0mXvo
	 tXgvEtLdl/fS77UNiQC3I3zfDLPV0HPj/hquX6mqAxR2b/WQFOEZspD3kEnEyn03m5
	 4wQ5hma5TsoOUGWl9Y4C5BshfO7G0yrW2eY8SEXCZT4+USs9Eq7UjJDY7b5Geomo9T
	 /FEVC9Se47qOw==
Date: Tue, 9 Jun 2026 10:24:52 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Srinivas Kandagatla <srini@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-i2c@vger.kernel.org
Subject: Re: [GIT PULL] at24 updates for v7.2-rc1
Message-ID: <aifNVBWXYq_KQBWT@zenone.zhora.eu>
References: <20260601122923.3714-1-bartosz.golaszewski@oss.qualcomm.com>
 <aib6P9jvkFhmd-LI@zenone.zhora.eu>
 <CAMRc=MdVvUDa5THVNRr-O5PzEKdCDf7wW+t7N+FBoQJGOLqXkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MdVvUDa5THVNRr-O5PzEKdCDf7wW+t7N+FBoQJGOLqXkQ@mail.gmail.com>

Hi Bartosz,

> > > Please pull the following at24 changes for v7.2-rc1.
> >
> > merged to i2c/i2c-host.
> 
> Ah, did you take over from Wolfram yet? I'll make sure to Cc you from now on.

We're on the process. Pleace Cc me next time.

Thank you,
Andi
