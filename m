Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88EF2BE7BA;
	Wed, 28 Jan 2026 22:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769638788; cv=none; b=uyB3lc0xsZzw4k8gV45po9cM88lzJxxpFYocGUAXRa1big2koei1eI7DkPoSg7A6f/hN9ues6Wmh6UQm4nGKiV2BIHV5AMBYQAvyqABCb2bqeLEQgoGIoA/8YFiCL0/Q2DvZEOb9ee4HYBGEeh7XfIxJnQxHOj4hiQ71PgaDSw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769638788; c=relaxed/simple;
	bh=t9x66D0KYT9q052pysiu6d/Z2LJzxP385DPcblnwOfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AokaxfgZrm396DLNqAWTX9pir1rHAZos6T+WnERH4wp3WpO6TTJVxivKXGHxfKxgRjOtuBtGszrDIe61XTsRdWtZTcrtPl1jjPNDKhcYS2nomygbYXtJO9xd/tfYyRzDEl2lWf8QKCIbCbz0WU9Gtbdew6nKzXZxsXNpog2u2Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXQgTE+R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXQgTE+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AFAC4CEF1;
	Wed, 28 Jan 2026 22:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769638788;
	bh=t9x66D0KYT9q052pysiu6d/Z2LJzxP385DPcblnwOfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OXQgTE+RsdLgh7WtV6Huq2XBZpCYwlg4+YmQ1dQBu3Ue8nig7Hmm6se/v3Zn9O6u+
	 Vm5lUdGigPM/lwQ4t1mS0/rucFdKEbvuNJrbwWe0mk1JrIcTk0DYMTxZyLWxzVIh8u
	 j6RDW6rEehF/EyZzXm9pqQuBDXaO0sYLKuWgPZCRKyRG9lHDF0VT4ExBF4clz+ZDO4
	 GlDtvnDcINxglosGIYXDyl0Gu9oZh60OAyHE3PG41t0psWxxlkebLjFRnFAbak6h82
	 VxAx0fOFHZDpb5vUsUaj1DcmUvEOSj9/whlJgRG3Zr954LHR92qkUdn3bLvwQt2iFE
	 bZI/ec7KqHkvQ==
Date: Wed, 28 Jan 2026 23:19:44 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc: o.rempel@pengutronix.de, kernel@pengutronix.de, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, festevam@gmail.com, linux-i2c@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH V3 0/2] i2c: imx: Fix block read handling for invalid
 length
Message-ID: <aXqLI-tYnaP_P41u@zenone.zhora.eu>
References: <20260116111906.3413346-1-Qing-wu.Li@leica-geosystems.com.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116111906.3413346-1-Qing-wu.Li@leica-geosystems.com.cn>

Hi Li,

> LI Qingwu (2):
>   i2c: imx: preserve error state in block data length handler

I merged this patch in i2c/i2c-host-fixes.

>   i2c: imx: add abort path for invalid block length

For this patch I want the review from Oleksij. Oleksij? :-)

Thanks,
Andi
