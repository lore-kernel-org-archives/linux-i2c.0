Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AD03A0EA1
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772183319; cv=none; b=XWdudPUlk1cAMK2jBTK8cgotS5WzioDa+mC1hzL9IiMyRbydK4m92lfk8oNrv6Zv4tHsLWHwHStlaC2ZV9KbV4v9Ol6njF8y1hduwG6l43pjwBZb6jEgXQrRUSKYbkxiYUMiv5AryTflItFypcOpU48/PxwDPbC/rZmvk5ZfP08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772183319; c=relaxed/simple;
	bh=PKbbwoJiySWh9ee8roBwDMpkbdIyqL01vBKdnFsot5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOySAqFEoAwV0Wuf2Phy31DSkELNFfEy+JA5ntTkE5sZrSvm9dkcPtwxt8KygckBeYnHyiVsKcuUCItjf023xAR/v7BmqxeguCBEcOBVtOMVLWqXza1CQidi/sGeoG6di7Kn2UsGGdr2woTXHmp74g9+IyidzYgNCDzYEORTqjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=NNt/+kgd; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="NNt/+kgd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=PMFA
	O4csiSN1neHee9OeKdJZyaErSWGhMT/VU9fURKM=; b=NNt/+kgdJvUJ6dErCiQZ
	FsjmBZOYgAIctuPF+FsJTFm1XfUfq0bbV2r75EIzm32GJZONBIpZQb18pjKoEYfz
	v1BkfHcvRUuWFPaUKI52cD5vUZlgEh0U0jC6YnGQF4FAUS/ANpi708r2HeFeps5d
	760lZ8tMAOh2/LW5EnJwMWBybA8EisVDcz8Nt+j1enOM4kBmiEXnL2+BV8/6VZwn
	Ii6YPZvpBS1ZzqSqUimwGhUmg4M9rNqVVZs0zgGX0Fd7v92aJIi7IbX/S4NhfDB2
	rr+uysI8ngNiXM9fOjw2UQiaonzEht4kHSYcngE0oAEswp32ODspy3yP4k3v7KZn
	fg==
Received: (qmail 1412929 invoked from network); 27 Feb 2026 10:08:35 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 Feb 2026 10:08:35 +0100
X-UD-Smtp-Session: l3s3148p1@JPv0lMpLHKAgAwDPXzF+ANZpdrMKUeLI
Date: Fri, 27 Feb 2026 10:08:34 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Khalil Blaiech <kblaiech@nvidia.com>,
	Asmaa Mnebhi <asmaa@nvidia.com>, Jean Delvare <jdelvare@suse.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-actions@lists.infradead.org,
	Bartosz Golaszewski <brgl@kernel.org>, linux-media@vger.kernel.org
Subject: Re: [PATCH v2 00/13] i2c: add and start using i2c_adapter-specific
 printk helpers
Message-ID: <aaFfEsfh0xTh0b1y@shikoro>
References: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
 <aaFcs1miP88QWmtH@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaFcs1miP88QWmtH@hovoldconsulting.com>

Johan,

> Wolfram, I noticed you merged these last night. Please think again and
> let's discuss the end result here. There's no question that there are
> lifetime issues in i2c, but this is not the way to solve it.

I did think again and do not see a way how the life cycle problems can
be solved while drivers happily access the device struct of the adapter.
Whatever the solution to the core problem is (revocable, custom SRCU,
something else), I still think this step is needed in any case. If I am
wrong with this opinion, please enlighten me. Pointer to some existing
thread is OK, too. I didn't have the bandwidth to read the revocable
mail threads.

Happy hacking,

   Wolfram

