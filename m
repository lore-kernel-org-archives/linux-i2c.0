Received: from mail-m1973175.qiye.163.com (mail-m1973175.qiye.163.com [220.197.31.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8147330C157;
	Tue, 11 Aug 2026 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786431520; cv=none; b=bsM63GXzw34LcoP0TmfMLxXUq+vGzGoTlQ1hdWSDQn04MNiV0++50axaAx9Lsa6K1DbrTV10znKsR1ly1MzI3u8ZfYCqFpolerX9wxRrjXXQzsC4ztjw5sqyIN3wtby6kivnGxmKGf0NGD2n079XD9RCj6zQ3PvhwvH5aQVBOWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786431520; c=relaxed/simple;
	bh=adMLUAY0dxKNLIZG5jtn1IcB1Idln7VdnPHy5XqNFYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXVYayj3/EUbxBZQikTWuL88WN0nrMJo1XycuhlU1T/kJkEQh2Y94ETaFdZl3xfxPiNR1M5qDesCoYHQI2cjqGSEB6mz67zZen7N+a2Mf5EKMX90cSLMNsuIqtlM6i4HYcdWiXZ5JBPe8Ji7i3RmXfFHtYjbMWeWwjx5ktph4eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com; spf=pass smtp.mailfrom=hj-micro.com; dkim=pass (1024-bit key) header.d=hj-micro.com header.i=@hj-micro.com header.b=j83JQwvQ; arc=none smtp.client-ip=220.197.31.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hj-micro.com header.i=@hj-micro.com header.b="j83JQwvQ"
Received: from 1clarkelill.hj-micro.com (unknown [122.224.241.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 498815963;
	Tue, 11 Aug 2026 14:22:56 +0800 (GMT+08:00)
From: "clarke.li" <clarke.li@hj-micro.com>
To: andriy.shevchenko@linux.intel.com
Cc: andi.shyti@kernel.org,
	andy.xu@hj-micro.com,
	clarke.li@hj-micro.com,
	jarkko.nikula@linux.intel.com,
	jsd@semihalf.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	peter.du@hj-micro.com,
	rafael@kernel.org
Subject: Re: [PATCH v3] ACPI: APD: Add clock frequency for HJMC01 I2C controller
Date: Tue, 11 Aug 2026 14:22:34 +0800
Message-ID: <20260811062234.74676-1-clarke.li@hj-micro.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <anTvBaRZNDhCz60e@ashevche-desk.local>
References: <anTvBaRZNDhCz60e@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fef7d081609d6kunm0b4f2cbe268487
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHkNDVkkZGE4aSk5LQ0JKHlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSUlVSUlPVUlPSlVIT1lXWRYaDxIVHRRZQVlPS0hVQk
	JJTktVSktLVUpCS0JZBg++
DKIM-Signature: a=rsa-sha256;
	b=j83JQwvQlxQHqjISdRqjdfDidyWoZLYn1Hj2e7ME3V7iKYzRsbI22YJOY7U1nzwTcWX9C7XcnS51YSne5V+m7HwkcZYF6qmPPR6wAP+yBuG8d3Q7ZSlsciY7rGifCQJ2A/FzK6WIn/v2opJzDYOsJ7xJpy1O5w4iYGCd6mMrdUo=; s=default; c=relaxed/relaxed; d=hj-micro.com; v=1;
	bh=mGF/urkIDDD2MMxbnXFOmgL1YfXDsUMK69/3yb2oOmM=;
	h=date:mime-version:subject:message-id:from;

On Thu, Aug 06, 2026 at 11:31:01PM +0300, Andy Shevchenko wrote:

> On Wed, Jul 22, 2026 at 03:30:31PM +0800, clarke.li wrote:
>
> > I2C clock frequency for HJMC01 is 200MHz, define a new ACPI
> > HID for it.
>
> ...

> > +	.fixed_clk_rate = 200000000,
>
> Can you at some point update these constants to use
>
> 	.fixed_clk_rate = 200 * HZ_PER_MHZ,
>
> and so on?

Thanks for the suggestion, I will use 200 * HZ_PER_MHZ in the
next version.

By the way, do you also want me to convert the other
fixed_clk_rate constants in acpi_apd.c to use HZ_PER_MHZ?
If so, I can send it as a separate cleanup patch.

> ...
>
> >  	{ "HISI0173", APD_ADDR(hip08_spi_desc) },
> >  	{ "LECA0002", APD_ADDR(leca_spi_desc) },
> >  	{ "LECA0003", APD_ADDR(leca_i2c_desc) },
> > +	{ "HJMC3001", APD_ADDR(hjmc_i2c_desc) },
> >  	{ "NXP0001", APD_ADDR(nxp_i2c_desc) },
>
> Keep it sorted.

You are right, HJMC3001 should be placed before LECA0002
alphabetically. I will fix the order in the next version.

--
Thanks,
Hongnan Li
