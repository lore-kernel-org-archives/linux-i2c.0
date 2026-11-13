Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565320;
	b=YS9wscmXn2tERKwXauFGoNre5hAt8hUvDvveYec85i+ogC5G08DA34rckkr6eUA8v5CA
	 enFFox+Hfzh5nxg9eufGhPF+i2V6nLPDWo2rlnyEyjnRfq2vsodvp2x5836v/H+nDpBl2
	 BNyPYSyqzhokzpmt0YipcPWRwL3/WiZqvVUB0qHq3WsFcyTocUXVibvPFB8RuFC8p4Cgb
	 Og8zxpdgPYwGMONfWPwsWfyevwRFRjAMVZKbbQSp23fGOfJ8O0j/uadXkiLOHucd3Qbut
	 W1+IODP6a7ltCEbQ1TLTaI8xXbv4QWLyUUlCWNPRRBDpU4p0chocPbJ+A0K485d8MyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565320;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zxzEdBeY63DTXC51lPS/dShr0mdq/ohbGMQhsyL/SBY=;
	b=iij0GGY0yrUOygiA3y38rQTjzTPrCMvfYDJm7y96eELbqzOzms+HFXSJNAe6zVMO/rwC
	 +QiF/TJes1H6RmN+kL+B9G8WwdJMqMP1EpH4zdtMl2tYsWAHJa+WgzZPIL7/H7ik/2Uq0
	 O7Bl9/cyKZFANEEyDUkCDkDf+ceZ4wWz/QOv+gWJOKym99850jis5Zu4O5CInW/WBwXL1
	 h0Ddgt5Siy2CZOns2d8yL+RWbJaYhZy/VeJjskDnQankMfJP5SXLyz1nKyEhqAr1vdQT3
	 0lmmnO7Fyjl4hxZyMkFuyCJL2T2TUZF9exRbNXUJ1Zs9ToAWkRfZFC6pmFBpaYoWEOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6fAo8Pt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31942606A31C;
	Fri, 13 Nov 2026 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6fAo8Pt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21421F000C7;
	Fri, 13 Nov 2026 10:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794565319;
	bh=zxzEdBeY63DTXC51lPS/dShr0mdq/ohbGMQhsyL/SBY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=T6fAo8PtK4rkJZfNv5ZKNLtl2rxvFu/Ljsju3+ow1D43oeqI53NF61ubm75dZBvem
	 cQuGU8uBKmcXXV0Go7hMPN/TTI0yKsF9HFgs0LAGTNe3RKvePkl8oX2+BqOLGo/zFC
	 Pe+ff7OD9I/1gYKeoN0Z6Xvc0GffgpNtCLZWr0ayQAQ5w1MmNOjcTcja0M93k9ITH9
	 zpdGADVsZftv8pIK2MpKvD1JKhh4qxH2RzbqxwZTS6cGWw9w9061y6nZUyMJWzDhsR
	 P8yzNVlJbms/3k3u4cEZQiLojbF6WgMSiMqwAyUDtLo+/4bwl+NqLhSGYqpy7gRh51
	 aCW5WFiqEBxPg==
Subject: Re: [PATCH net-next 1/3] i2c: xiic: allow platforms to require 32-bit
 register accesses
From: netdev-bot+sashiko@kernel.org
To: ahmadexp@gmail.com
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, andi.shyti@kernel.org,
 linux-i2c@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 13 Nov 2026 10:21:58 +0000
Message-ID: <179456531820.2199510.7014507677375597007@kernel.org>
In-Reply-To: <20261111041904.48916-2-ahmadexp@gmail.com>
References: <20261111041904.48916-2-ahmadexp@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Commit "i2c: xiic: allow platforms to require 32-bit register
  accesses" adds xiic_i2c_platform_data::force_32bit_access and the…

--

i2c: xiic: allow platforms to require 32-bit register accesses

This commit adds a force_32bit_access flag to xiic_i2c_platform_data.
When the flag is set, xiic_setreg8(), xiic_getreg8() and xiic_setreg16()
perform aligned 32-bit accesses in the detected endianness. The target is
the LitePCIe bridge on the WiWi Time Card, which cannot handle subword
MMIO accesses.

> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> index ba560462d4513..d13cfb0127a20 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c

[ ... ]

> @@ -1480,6 +1498,8 @@ static int xiic_i2c_probe(struct platform_device *pdev)
>  		return irq;
>  
>  	pdata = dev_get_platdata(dev);
> +	if (pdata)
> +		i2c->force_32bit_access = pdata->force_32bit_access;

[Severity: Low]
This isn't a bug, but nothing in the tree sets force_32bit_access at this
commit. The ptp_ocp xiic tables and timberdale both leave it false, so the
new paths in xiic_setreg8(), xiic_getreg8() and xiic_setreg16() can't be
reached yet.

The later patch in this series, "ptp: ocp: add WiWi Time Card production
image support", adds the user in ptp_ocp_i2c_bus():

    if (bp->wiwi) {
        wiwi_data = *(struct xiic_i2c_platform_data *)info->data;
        wiwi_data.force_32bit_access = true;
        data = &wiwi_data;
    }

That copy is then passed to platform_device_register_resndata(), so the
flag has an in-tree user once the series is applied.

Could the commit message say that the user of this flag comes in that
follow-up patch?

>  
>  	/* hook up driver to tree */
>  	platform_set_drvdata(pdev, i2c);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111041904.48916-1-ahmadexp%40gmail.com
