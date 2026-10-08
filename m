Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FF749A3A0;
	Thu,  8 Oct 2026 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466639; cv=none; b=sl6hBzIHW43ecb200+toQ8so02b7CwqMMAvOvhhX7meaKZGZW/3nWj6bVXiJ3RMS5xr+miUIgcVCTmox5bx3Sr/vpFsyywJNTD618XO3sJ31xHb2Du2V6+GCNWREmRU75d8F4ogW2k9cSs1MctVvCcdzwxSYNeWlIBpG/IELBZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466639; c=relaxed/simple;
	bh=bXuDHAESQYveM+ddfeipUXC2d0GypSSSZh+yw2r9iUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvEO0d4kNfUqDl6qxE/i2pxcWLqVl+PHqgIpXO8aEwddHtb1tmmiY3VCdsHyKQxWAIi0I+Otj0/bFklKI2ySEV8wR125gJLajtsvOfN/7dAni/jNtoR5GBfrypMcEfeasHGOV/HR5BEBBxijm9aoiQlxafkzkfhGrcAAOnD/ByQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2OwjCO+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2OwjCO+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA59A1F000FF;
	Thu,  8 Oct 2026 13:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791466638;
	bh=UO9BIEliwCrka/QBUERN6qrORL7los73DuQd/M2lROw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y2OwjCO+Sh8htYbtD0lk4Y5GxK8D6VbRxVflBa3bC8x+rKoQQyZfwSGMf6Y3sjz8a
	 ngalOvo5K84tgm2nH9kGhtifBtjOnIbyWTInlF+5EoQ0VmLnbiqT3m5W6YrJ9y8Yzb
	 8hQwBAH90GpF7JpdivDfuLzjjr5xnBWYhuCi/HOVI6vQf2497APRirJWj+nDqtWl9o
	 9TE7XcDihuv/jXcMjRvYwqjCXRPyJ2ay8nXro/an/ywJWVm8SjirDDqrCZcC7WLK7D
	 7nc19k+JOWTMFsDYFjOfGgpYqtB3mSokY70rDm6AZJKVlNG4z0/mgQgcw7CJ3EVH2E
	 ztsKGEApMfd2A==
Date: Thu, 8 Oct 2026 15:37:14 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: nina_kuo@novatek.com.tw
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ben_huang@novatek.com.tw, toby_chui@novatek.com.tw, shihpei_hsu@novatek.com.tw
Subject: Re: [PATCH v9 0/3] i2c: Add Novatek NT72676 SoC I2C controller
Message-ID: <asecW-z2RwOR3OxQ@zenone.zhora.eu>
References: <20260910030123.215609-1-nina_kuo@novatek.com.tw>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910030123.215609-1-nina_kuo@novatek.com.tw>

Hi Nina,

> Ben Huang (3):
>   dt-bindings: i2c: Add Novatek NT72676 I2C controller
>   i2c: nt72676: Add Novatek NT72676 I2C controller driver
>   MAINTAINERS: Add entry for Novatek NT72676 I2C controller driver

pushed to i2c/i2c.

Thanks,
Andi
