Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64DF3812D2;
	Fri, 21 Aug 2026 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787301831; cv=none; b=tZeBv0sfXJVzJ0dGn5FDphz/F67n5vNa9ux1bR+oDw2Zn+jKqJRLYxMv2DwRvx3OVFx4q6Lo1bLxIOxgMKf5OqG6C/VE0CJ/3vy4VX/Q8z1FArNvPrNmI22s7uLR3lrPr6NMu3jwS71y/GxmiTuksxUj4Sqs2m5u3Z7ersGwH88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787301831; c=relaxed/simple;
	bh=FkKIprTjaWzfAPqk+8k2dKXBsngIouJ6ZSUvbMFf9zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAMYq6A96AdKNm5rH01LvyE25brB1/wZiD3tnkUi9IjMK08eC1imDKBBWccZHglKx/x20JJGJNkENq1utpn5Ae3olwBUHsq+HLSK2jyswNzxqJfr2O7D/l+OhSHdAMx1KpVyrrZt/ufBOJvzjeU1TUddwNIBkGlbOpEPFvFGeLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lA0coZHF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lA0coZHF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9741F00A3A;
	Fri, 21 Aug 2026 08:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787301830;
	bh=yzlMWC1ictdBkNxusATV3BS8D6ZSX+S0s8cW35UQlwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lA0coZHF6cUgWwmk+SfmPxkJjV28bwWN0j2O4WQhN3LfCT1PZmP+AtyY5rUlihHcC
	 d0F1F8u34a1oLMvQF53TKl1hIJFZzFCPcyV2MnatxdqGEi1GOJEKFX2EdPlU7qr1db
	 pABc43gUKGW9VBJmqycCdrUP+AkXaN6Ey5fDlxq0Kku24D6DXPkpQu4WnM+YFuBkDF
	 m2MEoUsslVZCcKhLR6sZYyEdf1BYbqQijEfsD3JQm1CMlWMejbjCbMWL/+DZvyRDTN
	 a0YF7m0f/qf/VQrI3dDM1FIem6pX5urtx0+832CExPg+0MT7Ovel+FCZ6l3UPMwkz8
	 riAgy3x/HKwqw==
Date: Fri, 21 Aug 2026 10:43:46 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: bence98@sch.bme.hu, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] i2c: cp2615: Validate read length before copying
Message-ID: <aogN_ikDeI_OmSyE@zenone.zhora.eu>
References: <aoYYzhB7Ia6cTTY0@zenone.zhora.eu>
 <20260820154041.5911-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820154041.5911-1-triet.hoang.dev@gmail.com>

Hi Triet,

On Thu, Aug 20, 2026 at 03:40:41PM +0000, Triet Hoang wrote:
> On Thu, 20 Aug 2026 10:28:22 -0500, Andi wrote
> > have you experienced any issue yourself or are you just
> > speculating based on the code?
> 
> Thanks for replying. I just speculating based on the code.

I'm sorry, but I'm going to drop this as I don't see it as
necessary.

As Markus pointed out, if this failure could actually happen, it
would result in a driver failure and the patch should then be
treated as a bug fix. However, I don't want to fix hypothetical
bugs based on speculation or an AI-generated guess.

Thanks,
Andi
