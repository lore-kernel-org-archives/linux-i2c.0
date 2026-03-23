Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAED62D7398;
	Mon, 23 Mar 2026 06:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774247087; cv=none; b=ddtzbqFCOGYsD9kND2xy8HL1VImfaNisozwt7p6GEZhkx9yC1OX10t734Rx7FNEMNbHxKetGlKxkkOCLMAzfmx3JH2J0jJpYi1pZRrJvo4ntW/xXHz4NDIdNmRw/EyfGM3+scfbpODHkbIM3YmBPCouFu//6W4t5ywSbjcbm6y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774247087; c=relaxed/simple;
	bh=STPRck4DvWqWc0bjQyRCMK7GIE2XVVL/Wdap4X1ujL8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KTYf+kB6UnDc4oZgh4O2bbKAPaNQcq9up+3jUnFIdsWsSlrF8rKCCfbaOEc5CJlkveHLy3NRBcGT4td41Wj8BToR2t7nAJqa9zLwLyimoA7fALLgpuomaP0Hosg3VKxkCfg/gxGKSbdMmo+b2dAgCHfr/ueayay+edlq0f5qOs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=XAk/0o5+; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="XAk/0o5+"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5989526729;
	Mon, 23 Mar 2026 07:24:44 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PRkixwbiZoxA; Mon, 23 Mar 2026 07:24:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1774247083; bh=STPRck4DvWqWc0bjQyRCMK7GIE2XVVL/Wdap4X1ujL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XAk/0o5+Z5BTR6vpjd14nMCEJXZyPUmuFvuWS+SeBZyzM/j8N9e8Us58kCW4jEzOa
	 VWNZ4nhR0lihVMUNuGPvd5kEfhNQ52XOzxrc7XyOHuH2IVCacP7rPhQm/uUeIPUFww
	 yu9fd4MivtNYiGhKcSS7bB2yf1sE6j2s54fJDUpdT1iMVy/vXUweitX3Qap+wB4F6+
	 /PiTyteOhNhrhVXAzvQpyP9CGJyvA5DB8gD7a+lEKCkpw3CT+Q04eox+JsqQRR/NIQ
	 D7MpHtNeIif2C2iKsO6d5om3gWKP2Tr1XeMRkU5PHHSCTeHKXhOwUKrfW36SQA+yZl
	 cXlbUcg5UVg2A==
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Mar 2026 06:24:43 +0000
From: Rustam Adilov <adilov@disroot.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, Andi Shyti
 <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] i2c: rtl9300: introduce clk struct for upcoming
 rtl9607 support
In-Reply-To: <c1c9b1e2-9add-42ea-b87a-c8d2c4f465f1@kernel.org>
References: <20260322123411.32102-1-adilov@disroot.org>
 <20260322123411.32102-6-adilov@disroot.org>
 <c1c9b1e2-9add-42ea-b87a-c8d2c4f465f1@kernel.org>
Message-ID: <f7b43e8b7ea11cd222eabc2b61ee1888@disroot.org>
X-Sender: adilov@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2026-03-22 21:01, Krzysztof Kozlowski wrote:
> On 22/03/2026 13:34, Rustam Adilov wrote:
>>  DEFINE_GUARD(rtl9300_i2c, struct rtl9300_i2c *, mutex_lock(&_T->lock), mutex_unlock(&_T->lock))
>> @@ -432,6 +436,10 @@ static int rtl9300_i2c_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		return ret;
>>  
>> +	i2c->clk = devm_clk_get_optional_enabled(dev, NULL);
> 
> Undocumented ABI at this point.
> 
> Order your patches in correct order. First go bindings.

Will move the patch 7 to be before patch 5 in v4 of this patch series.

>> +	if (IS_ERR(i2c->clk))
>> +		return dev_err_probe(dev, PTR_ERR(i2c->clk), "Failed to enable i2c clock\n");
>> +
>>  	i = 0;
> Best regards,
> Krzysztof

Thanks,
Rustam
