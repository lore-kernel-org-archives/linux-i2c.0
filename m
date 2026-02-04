Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DBB29BD91;
	Wed,  4 Feb 2026 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770242781; cv=none; b=PVGJ1IhSvss92nYUbL18sqAnF6uY4YWXs24aARKuizGIWcdvKt7WN7QM362izbpgvrVw614xh21+HLqEORMoVIYKtMIzw2VZqpDDXI+h/qD5o/rIUIqU1kYuUsjlmyh5Nh4wKP1beD0aklw2p41DdikOCx0ubOLm6HfRqyFuCZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770242781; c=relaxed/simple;
	bh=g9cKB/JPMkJ6eg2QERQMaedy0lxv5I4wKWD/GoA2nVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nB6/6TOM04Pm0VOzVoszAMwv3CDXb20f2mWWK+M+b2ke75NLDZltWrYC6delAl4rYLU+cWoJngnlfOkqZZ0GqKvRN056KMnMdlg0wvUouYycL7fkxAAxuIOGrLnoeWmBHg3+xu2dXyKaqCanBIqBSrPLmmPJvgCIqVzg8fbnk68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNoOxkkG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNoOxkkG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81685C4CEF7;
	Wed,  4 Feb 2026 22:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770242781;
	bh=g9cKB/JPMkJ6eg2QERQMaedy0lxv5I4wKWD/GoA2nVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uNoOxkkGGhZm9XuLr0J99a+AAa4rI8B11dT293xcYMc2bWnYSvZm5FDwmfnPs3ciJ
	 nt0p8LegVMgkUR20+A/zV679QTb0hK7IJ0ieQYMIo2obkaOhM1d9LVc7xx0aHM2+3n
	 eH8bZvHTmGUsq2iioBjhzLDqDO2cmk4YJF2AgpDpKN1U7nAy5EARlbuEb25fFTUemB
	 eaJZwrYcN/e9XTCjWU0FUqs5rhL+sJFmySyxLIzy5nLszYJW8BbUgjYInAZL+w9/GU
	 KS0LfGqh8dRWFlC7HcFUTVP0mDgbZZgFOTZyR5Q0ZtY3Gjy4CAEP2ergH16E3Rw+lq
	 stJTacKptxapw==
Date: Wed, 4 Feb 2026 23:06:17 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v3] i2c: Add FTDI FT4222H USB I2C adapter
Message-ID: <aYPBXTrREaaXZIdM@zenone.zhora.eu>
References: <20260129155230.3054708-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129155230.3054708-1-flavra@baylibre.com>

Hi Francesco,

...

> +static int ft4222_i2c_write(struct ft4222_i2c *ftdi, u8 flags, u8 slave_addr,
> +			    u8 *data, int len)
> +{
> +	struct usb_device *udev = ftdi->udev;
> +	unsigned int pipe = usb_sndbulkpipe(udev, FT4222_EP_TX);
> +	u8 *buf = ftdi->ubuf;
> +	int written = 0;
> +
> +	dev_dbg(&ftdi->adapter.dev, "write to 0x%02x, flags 0x%02x, len %d",
> +		slave_addr, flags, len);

Here and in every dev_dbg/dev_err, you are missing the "\n" at
the end of the message.

> +	buf[0] = slave_addr << 1;
> +	buf[2] = buf[3] = 0;
> +	do {
> +		int pkt_len = min(FT4222_TX_HDRLEN + len - written,
> +				  FT4222_BULK_MAXLEN);
> +		bool first_pkt = (written == 0);
> +		bool last_pkt = (written + pkt_len == FT4222_TX_HDRLEN + len);
> +		int ret, actual_len;
> +
> +		buf[1] = 0;
> +		if (first_pkt)
> +			buf[1] |= flags & FT4222_FLAG_RESTART;

Aren't we losing the _START case here?

Andi

> +		if (last_pkt)
> +			buf[1] |= flags & FT4222_FLAG_STOP;
> +		if (buf[1] == 0)
> +			buf[1] = FT4222_FLAG_NONE;
> +		memcpy(buf + FT4222_TX_HDRLEN, data + written,
> +		       pkt_len - FT4222_TX_HDRLEN);
> +		ret = usb_bulk_msg(udev, pipe, buf, pkt_len, &actual_len,
> +				   FT4222_IO_TIMEOUT);
> +		if (ret < 0)
> +			return ret;
> +		if (actual_len < pkt_len)
> +			return -EIO;
> +		ret = ft4222_i2c_get_status(ftdi);
> +		if (ret < 0)
> +			return ret;
> +		written += pkt_len - FT4222_TX_HDRLEN;
> +	} while (written < len);
> +	return 0;
> +}
