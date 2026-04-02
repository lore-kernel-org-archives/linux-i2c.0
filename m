Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D5A37F000
	for <linux-i2c@vger.kernel.org>; Thu,  2 Apr 2026 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113311; cv=pass; b=LcduKPb5+DbzNkHijnwtlNqsxrVOqyA7+AyzJFVZlcCFfzN55BJNO/oa3y3ofUfiR9drUy9hThjRbVZQuO49XXrI0ymNf64B14x8F4JcZUoAfr0IL2eQlZT4KL59G+t/ZaUrltGHzSfT/w048HNgLezQuq/PLBckCt9hrdBH1qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113311; c=relaxed/simple;
	bh=lT7Ailcfdo5kd2YVlswaj5ZYH6UyjxsxTfhu+tarC9s=;
	h=Mime-Version:From:References:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJfRM2xCnkCdLWVCATPgO/iqiKw6sz8GIHNcmiWaJi8e+cud233ZsD3aPPOwx8QI4foQz24qvDF9s88KWmBUuvZAaoll9SMpK5UB7q1/1AhqYvibIO6PFFohRA6RGWUNw4h26wHtJTFNAgzDrn8f2BjRFKoT4I8IdgrenIIjmb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=cAUf5yhR; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="cAUf5yhR"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-797ab169454so8211367b3.3
        for <linux-i2c@vger.kernel.org>; Thu, 02 Apr 2026 00:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775113309; cv=none;
        d=google.com; s=arc-20240605;
        b=BdQNrFJZb8+rUWz/XwzKTYnVbX3j+h/t2PS41wUe+Y1LfrC+mC/G+C3r0915zobdvj
         kWx09jVzMT9zrFB8DNL0ODmmu5FnLpexXO62wIwTm/LBm2wq7EdVNEia41M6ja9o9zJR
         Owo4q7d/moU8ggOXy8IkuBjQSPObKwu1SlHmXnrRquIatCoFiWsrh+wVGg9IRRNHIO2k
         Ol7l58/5Ko8pvCG2AyGuMhYnXoNf41MRxudAja+Yk0/mQdlXkpbiSeDElpM52Vw7JDrJ
         s5xU7SMyBraoFZFZft3G88m/57WhGahZ1FTVZwNjtVmx+/ZxjEUPDNlMSrTCSZWvXajO
         +Tgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:dkim-signature;
        bh=j/nnvjn0yilI1+9JqC+f0dBa4pcKrV1vrwVGTdHhUA8=;
        fh=OkcY+PgBV/5gdFtm31IjdbIcILVq+E4BFasTL+2ugws=;
        b=BwWAxCODElfAqSqI+MiQTYEdIVyKtQkGF9sXkPBELZ9iTo5qBrSHtw4C8xVzoouHvi
         IqHinTcJtm9TCbg2HNBiw6oBxuTl+FYzr5Y4Ag8gKd2agmWeJ7aoHd0qmPQilbV/rCcz
         SY5p3Ir4pzSud/zvX3nfVMlNI/YeMt/zNFH5zfbW42BhxLl+eCmx/MKjNqbxH5XT/E5J
         jUyYdDVvcds2k+wC8CH6AR2P12ShXQzT3okYeCzcFCgDH3VRB2n8medLhgGX8iNEo8yX
         MzKvLf00Ey66eNiMBINr3/9HcdJrwd+ZtLizPgLRr2v7RiQ0BRm7J9zecZjbGzgVRfAO
         pquQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1775113309; x=1775718109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j/nnvjn0yilI1+9JqC+f0dBa4pcKrV1vrwVGTdHhUA8=;
        b=cAUf5yhRxsv8e6B5eSa15Ln7PIRxj84Ju5f5GhfG46aBt+41kLylo4F3629LXYWDSn
         y9AtJ7paGjC3P4BkJ8353/DJc/qPiZF9lxWhqv7aEP/BI7wOSfvPKqsM2HxxIShV/CgO
         lJd2u+L06Mjdj2gpCK1Ik+ZGL88sXIx7ZbfwAdrGytPvLG9NC8O6dd483KwqEnfKtJxt
         CKbjgxp17p90Y7e8ExZk2lQqih0/EFGlvKJlg7pn2TscG17dlxgYxey710esqB4HCcGi
         mZEknxbc+8HJZqEAgWVB8wx0SIgqhA+6U1XPZTTg6sk/AUIzBdsJt2BBzIiRDgw7ENZg
         G1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775113309; x=1775718109;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/nnvjn0yilI1+9JqC+f0dBa4pcKrV1vrwVGTdHhUA8=;
        b=fRDuZ1AKlFGuAonnDK/UNO5Wz9XZg/waq1J0nBxi0or9DPLtBWFnIU5hVuVGELapqI
         v9EFbZZv5f2DecySmvV64lrCtBKOXbdxwq3k2uoCreOtKY/GCGRDXJZd+P88FVDZvizd
         WyJmaaWW0xbFQzl3aGiiH1Bx7wZEatrOXL16cvwFTp8H9tJfnRhbTB3s/H6+gvKYS6GA
         pZiad50ta+x0HscABq8vh7pe84rfF/Hscj/1RInEiqP/YvWD2caIRq+jhHYGFTWRgf7r
         5KhDK3a5GLJ9wYp1RbWINFCJOvhzfuYTPIYlzETYRupjryJqvAeqKRJ05KKUcsPLByV4
         2pfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDQhXvmqUkl5wGtvMnRA5QBgD6hveGFpye7XvFp2m7Q1q3BCHPl6HszqAVpzabhGvUT3xPdUsOdvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe4d+MGwTb/9Qj3itzCMLHx89yxIKpPfyFWj9Mq3/wvAM9clgY
	BYrmhwPQZ60VCVtTfxSHiMJK9Bri91jnfyCgFfrrFpFn6HUXoaT8UF1y0rtwDZIWg5ZR2byf7GC
	Zx+qPMm2bUlo/6sgc0IWt3ZUWKuxFmhXVpMThzEMwGA==
X-Gm-Gg: AeBDieuwbHRehuL60itbcaoE8GrHhfD1MNxxiECEgiazAEc8FRmktimrj3LP15gJugr
	vnOoxnpycrzN8M0lNakNm4Cx09QmuaGqSQQmtHQKKtNkOlsh3z4tlIdXRGEETMD1H7Hx1ggV1nG
	9MaKO+rTndbSDzcOfCLRL1YWTFz0zmP9CRxDcXpmA9avnB/KldHCKP4AsCwtocghDzRDSHXPq2y
	1BDHyLyDBXFZV33HoV1BxAu8cxkdYxN6o1eFW8nog//AzBgWGEq3RL8JRo/oeYVJlw2RYszGNrf
	/LryR962
X-Received: by 2002:a81:8a47:0:b0:79f:b903:88c4 with SMTP id
 00721157ae682-7a21214d9f4mr54532207b3.46.1775113309147; Thu, 02 Apr 2026
 00:01:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Apr 2026 07:01:48 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Apr 2026 07:01:48 +0000
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: aerc 0.21.0
References: <20260223-i2c-xiic-v12-0-b6c9ce4e4f3c@nexthop.ai> <ac2r9m9mSMZxgHwN@zenone.zhora.eu>
In-Reply-To: <ac2r9m9mSMZxgHwN@zenone.zhora.eu>
Date: Thu, 2 Apr 2026 07:01:48 +0000
X-Gm-Features: AQROBzCvBf6oUImmXQaI0PNI48VmeBhc1PCRPeIfMVg9ZE_RxL6HflqfM9gE5no
Message-ID: <CAGYn4vxjR2Unf9AeORv8x5GsYzfgxZEJhgR6QwkAvPS+nmRxAQ@mail.gmail.com>
Subject: Re: [PATCH v12 0/7] i2c: xiic: use generic device property accessors
To: Andi Shyti <andi.shyti@kernel.org>, abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Wed Apr 1, 2026 at 4:41 PM PDT, Andi Shyti wrote:
>> Abdurrahman Hussain (7):
>>       i2c: xiic: switch to devres managed APIs
>>       i2c: xiic: remove duplicate error message
>>       i2c: xiic: switch to generic device property accessors
>>       i2c: xiic: cosmetic cleanup
>>       i2c: xiic: cosmetic: use resource format specifier in debug log
>>       i2c: xiic: use numbered adapter registration
>>       i2c: xiic: skip input clock setup on non-OF systems
>
> Good job Abdurrahman, thanks for following up in all the rounds
> of reviews. I finally merged your patch in i2c/i2c-host.
>
> Thanks,
> Andi

Thank you for merging the changes, Andi. I would also like to express my
appreciation to all reviewers for their valuable feedback and patience
throughout the review process.

Best regards,
Abdurrahman
