Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3964A384D;
	Mon, 21 Sep 2026 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999261; cv=none; b=vDjUqY2QVGHYrRT3vlwlnFnK5LRTozIBW9zmX86tRw4wOD5OfHK6u4eB/z1/d3FbO8Nocb/J+zrAxtlAAjj6zkhUx+aNdJfIETcSvFWzVhDnevNPsv8t042ElVHYDp1fSeirCCJOAlAicmUaXwlZxkdhFBEJStJbDfz6ECaS5D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999261; c=relaxed/simple;
	bh=7XtlfrK40huuj6vpmOrrjxcwYCnfO4Zm2EaDXg0igmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/D8966ipnQ+R+xHeB6bu3HF6rDQppKjQAvfUoGxUZ46VwM7Pk2FcnBtSV/k6i1LK01astgdYFYvALy5pl8GwvgwSEB1kEtHS638FE8HDNrEFQsGoe50LeoAX3QBWXnSFXmjPR3bm4onbqvIvzo9J6u1HTltZ5fFkHIiwMY0Usg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mddYD6vf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mddYD6vf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76311F000FF;
	Mon, 21 Sep 2026 14:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789999260;
	bh=2xm53hiaZiodtPVHAP6+ZFPUINfjYH/ykzpiGziyEJc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mddYD6vf55soVZqs3dAWnXzK3EaIiB4+NjlJxyaKr0zBAyk0if8qRwBuBaxI5xB80
	 +oeW0PAObK5bNsA3nb6bNfP8CttusEVK2/wTVu5rfKSBrUeE98nT3qtN1mbXXYGB7e
	 O1bW+vzHFJrMqQJx0DOaZ+ltuS5l0AiS625/txfdYfDuGp2eTEqlJ2sqBITWgVigrx
	 DJedp0Gt1yJLuEQOAOs1SUkxdVqBSxMFHbixQfxsHlzVima7S/+01he0QjvuGZItCa
	 G9nrbvO9Q9rjOZbrXOu+FDXJ23nwemvw4WJYiUCtJBEd+YJ4kKxkt4w7pWroraFroA
	 gBN2qs3eIW1bA==
Message-ID: <6fa3b1a7-33bb-4619-a0a5-42d99c076d2f@kernel.org>
Date: Mon, 21 Sep 2026 16:00:52 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: i2c: dw: Add DWC_i2c compatible
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Aniket Limaye <a-limaye@ti.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nirujogi Pratap <pratap.nirujogi@amd.com>,
 Bin Du <bin.du@amd.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vigneshr@ti.com,
 nm@ti.com, u-kumar1@ti.com, lianfeng.ouyang@starfivetech.com,
 Ritwick.Sharma@arm.com
References: <20260919-tda54-upstream-i2c-v1-0-b0b9f77be18b@ti.com>
 <20260919-tda54-upstream-i2c-v1-1-b0b9f77be18b@ti.com>
 <20260920-warm-lurking-poodle-dd73ee@quoll>
 <de66ac18-6bc3-4693-bd76-df8113bdb914@ti.com>
 <20260921111407.GU106095@black.igk.intel.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260921111407.GU106095@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/09/2026 13:14, Mika Westerberg wrote:
> Hi,
> 
> On Mon, Sep 21, 2026 at 01:55:23PM +0530, Aniket Limaye wrote:
>>
>> On 20/09/26 23:54, Krzysztof Kozlowski wrote:
>>> On Sat, Sep 19, 2026 at 02:36:06PM +0530, Aniket Limaye wrote:
>>>> Add the "snps,dwc-i2c" compatible for Synopsys Advanced I2C Controller
>>>> referred as DWC_i2c. Compared to the existing "snps,designware-i2c"
>>> dwc is designware, so snps,dwc-i2c = snps,designware-i2c
>>>
>>> I think this is *the* argument why generic compatibles are wrong.
>>
>> These are 2 different controllers with some different registers and
>> vastly different register offsets.
>>
>> So, the official product name (short format) for the SNPS Advanced I2C
>> controller is "DWC_i2c", as per SNPS' own reference document [0].
>> Whereas the original "snps,designware-i2c" corresponds to the product
>> name "DW_apb_i2c" as per its own databook [1].
>>
>> So based on this I though it'd be best to keep "dwc-i2c" close to SNPS'
>> own naming, despite the fact that it does seem very similar to the
>> generic "snps,designware-i2c".
>>
>> If you'd prefer to make it more explicit, I could change this to something
>> like "snps,dwc-adv-i2c"? Although, again, this does deviate from the
>> convention that SNPS uses in it's own documents.
> 
> What about just "snps,ai2c" or "snps,advanced-i2c"?

Can we just drop generic compatible completely instead? The block cannot
work alone, needs SoC integration.


Best regards,
Krzysztof
