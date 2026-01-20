Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FE4423158;
	Tue, 20 Jan 2026 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908644; cv=none; b=QlNHik/z6V493W7MNHm1wNTN1kREdPAe8oOj6M3w5iAk99YV8qSaauR328qD21Pd9VB8nO89TcOk/qYIUmn3u7g1BR4tHyEuBa3PtpbKxktDXHUvvNbolxSmXJB6lELkBBF5I/w4XyaIjAgV5ouJVa6y1QLpVqAfDHeTa9nrbbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908644; c=relaxed/simple;
	bh=9NM+oghNkkVqgepU5c12IfRc35B/z3EEEGh8HcAsK7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unQgdytIo98Q6cs2jXkTr2ofXbXfXbe45PjGFxsfjjdvrdvssu1usCneUcc3k4gDtznqITVmuRZBn8GEzrmaly2qlAIkgLXBpJMYULeGNh1OsdUIiecwNG1IVqIYe4skiHPVin4pEmvOZOemmr/RepzDflRxfwpcVZoXdUm+BH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRMSCePl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRMSCePl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C73C19422;
	Tue, 20 Jan 2026 11:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768908643;
	bh=9NM+oghNkkVqgepU5c12IfRc35B/z3EEEGh8HcAsK7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RRMSCePle9tlCGNr1cXpZDcYzt8lFk5AAnRVuYS+FTtE+bz8FSLy0yCfKq5J6y5yY
	 RkQHRjP5Rhd2PjQLOsAzAcRfMdEXMNJCY3iyphh+MWusaW69V3+vTCEl20EdkTNjJL
	 j7zC6Mq9zJx+MTbbNs+RfuOG8PuWEdYVbDcY1i02DTGqXKY43rse/XLOPfkp7SfN0P
	 WD7okPXlpjEH9u+RyvOkg6+M3XRakmZAudwHyKVu/apnE43TbduJUejT5JaJ2VXdwx
	 LGqV1zQ3jpMTmqv83Wn/IaoKQFJgluPxVBeWgpd9082AXYqJeSAWGbDMJKaVUL0TN4
	 FA5r4cjTWHXZQ==
Date: Tue, 20 Jan 2026 12:30:38 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Carlos Song <carlos.song@nxp.com>
Cc: frank.li@nxp.com, aisheng.dong@nxp.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, vz@mleia.com, 
	wsa@kernel.org, linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: imx-lpi2c: support smbus block read feature
Message-ID: <aW9jUs2-kiVIxTfn@zenone.zhora.eu>
References: <20251121110100.1909603-1-carlos.song@nxp.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121110100.1909603-1-carlos.song@nxp.com>

Hi Carlos,

On Fri, Nov 21, 2025 at 07:01:00PM +0800, Carlos Song wrote:
> The LPI2C controller automatically sends a NACK after the last byte of a
> receive command unless the next command in MTDR is also a receive command.
> If MTDR is empty when a receive completes, NACK is transmitted by default.
> 
> To comply with SMBus block read, start with a 2-byte read:
> - The first byte is the block length. Once received, update MTDR
>   immediately to keep MTDR non-empty.
> - Issue a new receive command for the remaining data before the second
>   byte arrives ensuring continuous ACK instead of NACK.

What is the real fix you are addressing here? Can you be a bit
more descriptive?

> Fixes: a55fa9d0e42e ("i2c: imx-lpi2c: add low power i2c bus driver")

Is this tag really needed?

> Signed-off-by: Carlos Song <carlos.song@nxp.com>

...

>  #define MRDR_RXEMPTY	BIT(14)
>  #define MDER_TDDE	BIT(0)
>  #define MDER_RDDE	BIT(1)
> +#define MSR_RDF_ASSERT(x) FIELD_GET(MSR_RDF, (x))

This name sounds more as an imperative action, do you mean
something like MSR_RDF_ASSERTED(x)?

>  #define SCR_SEN		BIT(0)
>  #define SCR_RST		BIT(1)

...

> +static unsigned int lpi2c_SMBus_block_read_single_byte(struct lpi2c_imx_struct *lpi2c_imx)
> +{
> +	unsigned int val, data;
> +	int ret;
> +
> +	ret = readl_poll_timeout(lpi2c_imx->base + LPI2C_MSR, val,
> +				 MSR_RDF_ASSERT(val), 1, 1000);

What is the value of val here?

> +	if (ret) {
> +		dev_err(&lpi2c_imx->adapter.dev, "SMBus read count timeout %d\n", ret);
> +		return ret;

This is an unsigned function and you are trying to return a
negative number.

Can we also add a comment saying that readl_poll_timeout() fails
only if it times out?

> +	}
> +

...

> +		/* Read the first byte as block len */
> +		block_len = lpi2c_SMBus_block_read_single_byte(lpi2c_imx);
> +		if (block_len < 0) {

both block_len and lpi2c_SMBus_block_read_single_byte() are
unsigned, but you are comparing for negative value.

> +			dev_err(&lpi2c_imx->adapter.dev, "SMBus read data length timeout\n");
> +			return;
> +		}
> +

...

> +		if (block_len == 1) {
> +			ret = lpi2c_SMBus_block_read_single_byte(lpi2c_imx);
> +			if (ret < 0)
> +				dev_err(&lpi2c_imx->adapter.dev, "SMBus read data timeout\n");
> +			return;

do we need to increment msglen here?

> +		}
> +
> +		/* Block read other length data need to update command again*/

Please fix the commenting style here.

> +		writel((RECV_DATA << 8) | (block_len - 2), lpi2c_imx->base + LPI2C_MTDR);
> +		lpi2c_imx->msglen += block_len;
> +	}

Thanks,
Andi
