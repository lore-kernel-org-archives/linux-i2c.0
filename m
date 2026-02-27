Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7D2346E7F
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772182502; cv=none; b=YA5Ni2G1Wttzdksb0ZO8J2Y8/u1pH6gP8l/us00sBKPss65ACxXnVPv3giKEjuNSN6XvgCc1k0+lxjvll+JWsMAEXrjrFrC728TdSmL+hiaOw4uYMOOo/puZUGW2EdHyYoPsgLVxlRlnhoj6r0FZWFgEh71/WnQBMO3mAqUOHHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772182502; c=relaxed/simple;
	bh=se1ZvWX7oY7ZgtUD3rEhZWkPd1TDPoLfBupIiWC9QLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5oO/azqrA0dIju/JOKE9IYSuKZQsu4XZWlVMp4OLWj1QRbFJAx2qhYlReVe+KmdbnLXBqIuJCz7HzBdGoaEdN4C/ww4id58dtrwkNCK1yDB5IaBGRi4KqpAzAi9CCiX7wsv9jBguU73k+UM/+GMUHtWjXdNYjSGQ640Y4gp5EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=YiK3rVbv; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="YiK3rVbv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=zQBP
	oqGuy+Nk3Y+axMWMHgErBPv1pT4vgLvjPkfdeB8=; b=YiK3rVbvnQi5HCQx+CS8
	YBNCLH3j2e3tWPs3BGg10CYQGHxHKGNHXMa/1TPBdLEFDMgqW5h0gFf2h8CUROKX
	rbX2vx3nYJ6vVGVvsS/WdbSo2ys1bOesFZj1OD6XIH8eBy+Qr3ff7kgB8/ZtwYaB
	A6Jb7bFsW3BUULyobXH9XsGVBZms9oSRl4Bz75gPLgGaksueHlrfy2k+OLYEnVCy
	wxqTqsv39VUL1TvYAwhgqxjC5M8GdIHSKQOGfv+Wyw1LCFHmq1Ohua+F0MIVazYF
	fMnbgTwlMRR/HB1KU1SABkh4vmX/1MH0P/Az+PNRzgD+7j9EcTvFqVwAO/+6mVmE
	ew==
Received: (qmail 1407771 invoked from network); 27 Feb 2026 09:54:56 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 Feb 2026 09:54:56 +0100
X-UD-Smtp-Session: l3s3148p1@7LYqZMpLnt0gAwDPXzF+ANZpdrMKUeLI
Date: Fri, 27 Feb 2026 09:54:56 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
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
	linux-media@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v2 00/13] i2c: add and start using i2c_adapter-specific
 printk helpers
Message-ID: <aaFb4DW1yob1djDW@shikoro>
References: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
 <aaCrT1SvMCIKQDmc@ninjato>
 <CAMRc=MfwR7TfAFXO4opu7a=v84MK9hY048woPg+-09wkGJgWFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MfwR7TfAFXO4opu7a=v84MK9hY048woPg+-09wkGJgWFg@mail.gmail.com>


> > I applied the series to for-current but squashed the user conversions
> > into patch 1. Changes are trivial enough and I don't want the pull
> > request to look excessive, so it can go in smoothly. Hope you are fine
> > with it.
> >
> 
> Sure, do you still want me to send these changes in separate patches for
> review?

Yes, this is totally fine with me. I think we get more tags when the
patches are broken out.

