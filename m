Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266FA303C97;
	Fri, 28 Aug 2026 01:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881502; cv=none; b=RRoOCZiEGv8+pdfM7tXBvCS4jMBoFBz31T0CEou/ksRC7Lxx07Ky+eYYa4W1dJF0/OrjtliNTv1r3hzrdTRhbC0+jzoRtST/DoRzaNuKYZivxf9QAq8PGx1hqRjiHnO5X3N7w8B2in/gBS3alMUcE+Svxo9A8NRxiGMbGkGsOrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881502; c=relaxed/simple;
	bh=mA1UdZsdIPGKttvBIms9Hz9N+yeZIac4VjZbWuuiBew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJ3ylIq4e4TP0pOtS9ikOUzUdBiKcfRsSV2M1oVb+QCxCYKhwo9pwrCZw4po/KoV6ZqOcJipNvbZGbXRE5IiXFu2d81IH+/Ax//d37oLLgIZFAltO5R6nzs5PbrcIAVP9rtiJ9zgNbdnvMgyCAJCMOLitqTfOcPL1U9qkvRRB30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNmcR4na; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNmcR4na"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374201F000E9;
	Fri, 28 Aug 2026 01:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787881500;
	bh=Xx83I5vERrH8wSt84jVfmAtQB1F3XW5c7ltEzNOILvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SNmcR4na7T12tJBJhogY/ID+Khtm7/gRnG+IEVFaCycv0ZlRfnIgjPkj9G/gl5954
	 KuK1Sqsx6eCN+Y6jMXfyKuz1xpHAXP0tgr8Dbf9A4t97wcPvonvJ6Wj+4rv06VwRrF
	 ndIKKEMt/06ieremEYFdy+Yz5AmGlmPFSSszHhb+aW2jqXZadYT+1MU7KA1BzGk66G
	 RbfKVHd4kCMyh6sWortp4phP0TkpzUHP9eTZ7zqyAKSTUMcbMAMLMlfuk2VCMIN1Sq
	 KJ7Jtql5+2alBSSKrt4wSFTm0Dy3VkeFXmKzjVzu4Ey4t7qRXzq8K2064/UNSZdMwU
	 ZHFEIFiNxlqSQ==
Date: Fri, 28 Aug 2026 03:44:58 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-i2c@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] i2c: ibm_iic: get the irq early in probe
Message-ID: <apDmUOYSraWnTQK-@zenone.zhora.eu>
References: <20260821230217.319418-1-rosenp@gmail.com>
 <20260821230217.319418-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821230217.319418-3-rosenp@gmail.com>

Hi Rosen,

On Fri, Aug 21, 2026 at 04:02:15PM -0700, Rosen Penev wrote:
> platform_get_irq() can return -EPROBE_DEFER, unlike
> irq_of_map_and_parse(), which helps reduce work done during probe.

same comment for the commit log goes here.

> Signed-off-by: Rosen Penev <rosenp@gmail.com>

...

> @@ -686,12 +677,19 @@ static int iic_probe(struct platform_device *ofdev)
>  	struct i2c_adapter *adap;
>  	void __iomem *vaddr;
>  	const u32 *freq;
> +	int irq;
>  	int ret;
>  
>  	vaddr = devm_platform_ioremap_resource(ofdev, 0);
>  	if (IS_ERR(vaddr))
>  		return PTR_ERR(vaddr);
>  
> +	irq = platform_get_irq(ofdev, 0);
> +	if (irq == -EPROBE_DEFER)
> +		return irq;

if iic_force_poll is set true, there is no reason to return if
platform_get_irq() fails with EPROBE_DEFER. Check for
iic_force_poll first.

Andi

> +	if (irq < 0)
> +		dev_warn(&ofdev->dev, "using polling mode\n");
> +
