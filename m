Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CED317173
	for <linux-i2c@vger.kernel.org>; Thu, 26 Mar 2026 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527476; cv=none; b=fVvLlKNNwNU+aWc+DtafV0YcqLFI42zd1SW5XRR0aCEbZRgrJtLH51n9MdavWwqXfZPrR8YJgvlcd7tzIufBAARR0v7ytFz9GjWnZ5E7ASkalZABF5Fv2/ORNEA6wrm5AQA1/rlBasbvqPXpTNBRiwwDcfm20l/fTCJO0R0gtVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527476; c=relaxed/simple;
	bh=11RIqE/GIXPQqschhxYiFlJAG+TR548JsD/YNqT3np4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPi0TdIGAGhOVmjTG+O02Jr/GmMJm55dngcCDJZHvO50Inc7QZTu/jeXv6Wc5V3anyV3cXTJIa11fWQVCVfRgvDCzUMXXSNDGUjHKxBOUYFf8OR34tbW1OCRMMPcUtQIVf/hJ2hO3kxprNzAJTkMxZl/XZaKk9OZlsONe1E0pF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jp71WrtV; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp71WrtV"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3870778358aso5764151fa.1
        for <linux-i2c@vger.kernel.org>; Thu, 26 Mar 2026 05:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774527473; x=1775132273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/azvFG1nnUlhxSiJLaoTFukeNHF4vMpB+fiAo39JynM=;
        b=jp71WrtVDe+yF1J6FnexBIi6PBFc0fmAfSBfbUEk9NddakrLDV1ZRqLpawp0ReVhYh
         AktOSsue7jpo4hcNjliI0cIy6pRuAJOw8MA6nQo5llzxFOqXDujlGX+uSv8ouUa52/tN
         pQuvTiWfa9EQb3mchUoEhCHpIpRuHWZEiVTa7o0UodrSp9Gz+u1SmN+exeuDhhsfCWgU
         OOeV4AnpWwCWzZHIiZimfuhUMQf5E7X4GZjmQ5WTiI/tZQCnPrTpgmtm7UqLfc7UVu/o
         fAUgYSXaBWNeIlXTVXiXwkMDBva2WLQt24EhFgrziGNKDtHZ3Fa6aymqhRGP8+Mn22ss
         mLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774527473; x=1775132273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/azvFG1nnUlhxSiJLaoTFukeNHF4vMpB+fiAo39JynM=;
        b=Ml3kYw6OFfYospnKMlfk6sI0afni8q2Tjj3Rqh3QnTQwleoH4uh7Gmc3q/Ggmo+rzd
         hK2oogV3ZdIfegkRELjmi7Q1NvGfUWDdiG7tBjq6FdWW0V+xkqrH+d5BVOskTdMtA5/P
         0ticsNehI/oliOk95WxIa2wX0Xuy5O2ocGQHwYKhcIcXHKfddjlXdVKEgxwRBlxv4GtC
         kdEuqICvSATyAcazTSXmWqjIVetf9dL5PJcInEHmDDAtg6+EJ0hzFVEjSVfmYhu0Nt29
         9XT79XAhppuala8a2D1UTe+K6a6VYl7jxQRtm9iaERjJ8wE4QXXk+7bGcXNo01JoNCuG
         0vfw==
X-Gm-Message-State: AOJu0YyQleI29Tp5kxtHS2S/63iYro9cc1QNt8aO7DWIwhCOyGZ/rm7B
	+HL0ziECpzYyrp1R/bGRKjTvd5ORzEPXfyPjdgO+H6QbibpqG9FD3rRy
X-Gm-Gg: ATEYQzyeA5UP0FGShwSfr9n/sQg+iLL/RQgnulHDjAoQXnhFgO1O8j1vAMFMipjG9N/
	qHRVTh3/Uk09Oz7u3Yc6q6wxKPeoA9zavB0+MMGxQ9vRX0L556aD6aDoiL5El27Sl+NI+WE5NE1
	wa3fclflkuqRRiWW0A1mP0sL6/p4ORGdMEw3J9/WRbGotVbDkGnNS6Pqn1xqyMNFBb9w9awJYS0
	TlqWdQMfR93ucDiDwGovLlPYsIcHrCMIRvggti3kKm9CssfkTC03GSxbLQPEFqPOoI2cESM1wiE
	PoIYmsVKLdY4v7jfAenuyZ9tePhzOMp199VcGFHbxukQpIYMpY+PfqarvNEFOi7XuLncG48BQ2n
	6SfnHM0cVJEJxjVjWgdbsky2K00AzxZBkMYF83eFhoSKicqUfJE723uD5CIwBI9fqI6Col+8mPs
	Q5rDH9ENxtvktBbVBNZ7r9ASJDW/5yENjEXhMkbDwcjY1GtebSFLJRH0K4nliQ
X-Received: by 2002:a05:651c:1114:b0:383:18fb:fdf0 with SMTP id 38308e7fff4ca-38c431f2536mr24521661fa.22.1774527472629;
        Thu, 26 Mar 2026 05:17:52 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38c6a848cddsm520711fa.13.2026.03.26.05.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 05:17:52 -0700 (PDT)
Date: Thu, 26 Mar 2026 13:17:50 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 0/5] I2C Mux per channel bus speed
Message-ID: <acUj7u5o0Pch260w@gmail.com>
References: <20260324-i2c-mux-v9-0-5292b0608243@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324-i2c-mux-v9-0-5292b0608243@gmail.com>

On Tue, Mar 24, 2026 at 02:54:14PM +0100, Marcus Folkesson wrote:
> This was a RFC on how to implement a feature to have different bus
> speeds on different channels with an I2C multiplexer/switch.
> As no major complaints on the design came up during the review, I
> decided to submit the series without the RFC tag.
> 
> The benefit with this feature is that you may group devices after
> the fastest bus speed they can handle.
> A real-world example is that you could have e.g. a display running @400kHz
> and a smart battery running @100kHz using the same I2C controller.
> 
> There are many corner cases where this may cause a problem for some
> hardware topologies. I've tried to describe those I could think of
> in the documentation, see Patch #5.
> 
> E.g. one risk is that if the mux driver does not disconnect channels
> when Idle, this may cause a higher frequency to "leak" through to
> devices that are supposed to run at lower bus speed.
> This is not only a "problem" for changing bus speed but could also be
> an issue for potential address conflicts.
> 
> This patchset has been used and tested heavily the last months
> on a custom board based on a da850 (DaVinci) platform.
> 
> The implementation is split up into several patches:
> 
> Patch #1 Introduce a callback for the i2c controller to set bus speed
> Patch #2 Introduce functionality to adjust bus speed depending on mux
>          channel.
> Patch #3 Cleanup i2c-davinci driver a bit to prepare it for set_clk_freq
> Parch #4 Implement set_clk_freq for the i2c-davinci driver
> Parch #5 Update documentation with this feature
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---

Peter,
Do you have any feedback on this new approach?

Thanks in advance,
Marcus
