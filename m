Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDAA2E0B5C;
	Thu,  9 Apr 2026 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775750261; cv=none; b=dauePb9NKV+zEUq7zgMtf+2pt7V7bGwAn5AKl/Yz8H+pcqgSv31mjrIkRFlGfTpdMx1JIZ6cJMnQ9gDxazCfOA5ZSG6YJgwlKDe8RkQERMW8wDU+crVKA4oeBJsALwhf2sXXibBgCn8peXU8byUNtsnDf7AeIvA0U8lWF/uT0LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775750261; c=relaxed/simple;
	bh=AhI23IZb0zgBjG02gZjEZzBW1Rd3ojDALosi0aOyrqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swE2OmGJ6U3qxKhEuO9PCqnzowuAtdvE3SLaQznYjMASpwDKpfYuYVoezUIxnKhjXb+3g77zuwwuezL69rp5KGBgjEBSuFrXCACmJuVP8BNZpYjG8HCc2TKgBlhHF8jwuxr656Lt0T3d6Jb0XRaUEZPaSsiv84glfIjYQYhSksU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5Ptn8LO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5Ptn8LO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C1AC4CEF7;
	Thu,  9 Apr 2026 15:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775750261;
	bh=AhI23IZb0zgBjG02gZjEZzBW1Rd3ojDALosi0aOyrqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H5Ptn8LOg9DCKYo2wHBxR9Ul/3PUc6C9ZBnAOS6PF1w/qFXo2nvuxgrGmUE4Pdbza
	 Iaf95OFd/UMLvnzUkEsYd5UdJqUZ+kPH3KdsA3mYx2m4jnkuFsfbhFCebabRRXuOVa
	 rzcTPUedZ7EP3+E1U6Uup60bx8lXgE+2NMA+jsS20UOR472u0e2hJ5Y2SQUjuSJ7nr
	 Z/lLXW/UykiA9sqc7m/x1GpjA0IYJcRtMQzU7virq0OS62bvjGSi0Y8OitKPgx3tyO
	 Rxn3YMh5q+2UMSYPu19B6xzXXlAyiw2W+TAYQxzCLLOVf1WjueJdHy/3HWw54hxp1d
	 XQkIpyYyRwO1Q==
Date: Thu, 9 Apr 2026 17:57:36 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-i2c@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [PATCH v6 2/2] i2c: ls2x-v2: Add driver for Loongson-2K0300 I2C
 controller
Message-ID: <adfMBWyDh27NRe0T@zenone.zhora.eu>
References: <cover.1773991081.git.zhoubinbin@loongson.cn>
 <4236113143cc88b45062c1b8a34a1f840f29a0ac.1773991081.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4236113143cc88b45062c1b8a34a1f840f29a0ac.1773991081.git.zhoubinbin@loongson.cn>

Hi Binbin,

> +config I2C_LS2X_V2
> +	tristate "Loongson-2 Fast Speed I2C adapter"
> +	depends on LOONGARCH || COMPILE_TEST
> +	help

I'm getting a compile error here, I guess you also need
REGMAP_MMIO here, right?

Andi
