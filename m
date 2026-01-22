Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA9E24E4D4;
	Thu, 22 Jan 2026 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067152; cv=none; b=k/FayBqSCX609Q0VM0MEj3RtLFEmSWNSDhWN0D0x6X+naZzlN2xgYKlsIP1STcTJRct1ek6U9yqIYv1PLvUeAfrlP+y9T3dBu0cRvSMb6XYW/35ccQXNFRo7/Gt2LAgvm8UoaxdnF6370ECc41RJhjPZyzViOhR7TqlYCB81rr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067152; c=relaxed/simple;
	bh=4c13PYVKBuj93wLp9HTpARpZW9JIi8Nd3PvLJryjPVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7JPyD2pVbZi+60uhgl8/Mu+rbj9aFBACLpSidUVBfghgKg8qRFpif1clnR7z9F4rQsaMI9S01amAK0VvOEFAx6H7qXXMkZ4OM7BlsVf2lNTf6n3kLGGWzLM3Ls0QsdQzRyYDvPU4fGQk8/SPiZOIJzzl/KFAF6H+O4qMEHGT0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3WH1jLn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3WH1jLn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E56C2BCB9;
	Thu, 22 Jan 2026 07:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769067150;
	bh=4c13PYVKBuj93wLp9HTpARpZW9JIi8Nd3PvLJryjPVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3WH1jLn8JpqVyJqVSKcSP8ft/yqpIauoZPAbLZsqke25QzA4aRXAZqBHgexc4nsv
	 NPykm/mGYzjN54Ax1JBsgwMSVhs9uANczkjvOW32ksNcH1ftrin/37ZE3ZwQYcuSRB
	 fuqUILYiFwVZiTbAqzToDmVD/844LHRBCv8Rp1+D3JotfjrG3stS9xZxi8cMk4sU7n
	 jzAcGiJOY6eja/8HqLE/mQ/Z4/cbSTHn9DEz8sI78f67LUbOAkdnagHmSXzgAcGAN/
	 1bZhi0qb9QctfjidfK3gM2m98YJqAD1/ktmoCUmP8XDNRkx7IMcB4XhH6aV00eLcZO
	 0qJ669HgNnahA==
Date: Thu, 22 Jan 2026 08:32:24 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Ben Zong-You Xie <ben717@andestech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/4] drivers: i2c: add the driver for Andes I2C controller
Message-ID: <aXC6rkiG5lI6n3JF@zenone.zhora.eu>
References: <20260115145244.435890-1-ben717@andestech.com>
 <20260115145244.435890-3-ben717@andestech.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115145244.435890-3-ben717@andestech.com>

Hi Ben,

...

> +/* I2C may be needed to bring up other drivers */
> +static int __init atciic100_init_driver(void)
> +{
> +	return platform_driver_register(&atciic100_platform_driver);
> +}
> +subsys_initcall(atciic100_init_driver);
> +
> +static void __exit atciic100_exit_driver(void)
> +{
> +	platform_driver_unregister(&atciic100_platform_driver);
> +}
> +module_exit(atciic100_exit_driver);

Please, check how other drivers initialize.

Thanks,
Andi
