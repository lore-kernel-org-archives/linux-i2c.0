Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5202757D214;
	Wed,  9 Sep 2026 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973096; cv=none; b=coTALh9fKqhf/k1xD7J82v6h6/MvhQZwG1c1VKsS/6DSgQaljXbLivmU/ioA0HFVAnc8zyXnuwT7SZnIm5+oHxjeufZ/J1w1mINxxrhtIQe+FVNa+aRcm3iptjuylT1hqkIQs+X7xA0Xsp8Ut3o/tYLSigFQFJ3DUHg1n7srCLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973096; c=relaxed/simple;
	bh=m0KZDH84kKVNO7dEQO+dPOwzf7z3sOgOt5hNmcPiJwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGRaaV8/I8/o691bQd51U4wqROC2cPl9j4sOfSI8qUZZwSfI9iSMpSE2fDgC5S36vQUr1SQhFmxiK+snXN+CXUPyE8m7kWmirYkNM+oCdV5DZFwHzxB9Uldx4TclefZRBm83IyPauQG3TSzaUK2aHNCMOyzoBxpkLaSa1TbrbPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpR2RekK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpR2RekK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CF31F000FF;
	Wed,  9 Sep 2026 16:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973094;
	bh=rtEdhU2qAOHLcX/3voiQfyN6yRG2qNKNQLLd8VTYYrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cpR2RekK/YE1CN8s9Nm9NO+Qq0D4sOpJRKvwQxycnZRfAaxItCsgRNhi2gyDZd1/G
	 m9VqHXgDWgz9vhTTKVKYAiIYRh1uMD1a45f6ZT+eljwRHMkxd5lW6eBQdIWnqCvP3E
	 IiZS8atF48n/FI01Gf2ApdCI9WvJzfpMbQWTV1lZzMnEqt7O3/TU6eRKnToA/+Dymt
	 nVoTuIzA7v0u4pSkLLAXGgrBuNAcQn0Ildcv6XQufc0UgQkb/Lt3YM/P0XU8k5hoVk
	 CJsGmDBMrw5LiKL7boqRjkNe0sUNM6OovkVj9uUMnBmzk/2QZsTCRZ2s/+i4AEwgY8
	 vRl5lIKjIsCrg==
Date: Wed, 9 Sep 2026 18:58:09 +0200
From: Thorsten Blum <blum@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-media@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Subject: Re: [PATCH RESEND 2/2] i2c: Change return type to bool for
 i2c_check_functionality()
Message-ID: <aqGQIaeORQjPkuLj@kernel.org>
References: <20260909082053.410739-4-blum@kernel.org>
 <20260909082053.410739-5-blum@kernel.org>
 <aqGJd9ph6Kz279GV@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqGJd9ph6Kz279GV@zenone.zhora.eu>

On Wed, Sep 09, 2026 at 06:31:14PM +0200, Andi Shyti wrote:
> Hi Thorsten,
> 
> On Wed, Sep 09, 2026 at 10:20:56AM +0200, Thorsten Blum wrote:
> > i2c_check_functionality() returns a bool - change the return type from
> > int to bool and update the comment accordingly.
> > 
> > Signed-off-by: Thorsten Blum <blum@kernel.org>
> > Acked-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> 
> both patches merged to i2c/i2c.
> 
> For some reason I don't see anywhere in my mailbox your patch
> 1/1, I had to fish it out from patchwork.

I might have messed up the git send-email recipients and my config ended
up adding you only to patch 2/2. Apologies!

Thanks,
Thorsten
