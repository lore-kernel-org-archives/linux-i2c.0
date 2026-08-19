Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0772B46EC89
	for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137859; cv=none; b=POKzuml9X/ZEWOA/s+Tn2EtVJp1tEzDHLKhIvhLo97fcDi4fGb8y8VPDtVVPQDllHHF7ONehUCVRPqebfIZuvToOdY3604d6RnMMBRUF9APlCUmVkQVxSAD21JQskVJ3wjlt/srolXi+801s8B/ybd20LOYqZ8AS08m1Xgkiigw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137859; c=relaxed/simple;
	bh=T8G0ZcWK/K84AczPHDRHSzzAJA9uLSt710Kf5KRx7gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UAMmnwJMAQB2aAH39DoNeAgf/n+aXvEWhisOX45HOYvzYySFMTyHOSY7947QFOj62dwoZB5I2wsAUSAURaWKs0i1VFkq+701MxLQuD7P4ijZN4Z0O96sHFuqEeJ36B1XKgvltlmTD4X0t6geNCZjl8mNhl5thGLZiIafmqcZhbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jrda/MTn; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jrda/MTn"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aeafa51b5cso124293e87.1
        for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 04:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787137854; x=1787742654; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MHM+2qgBqc21q4hkz2G6UjCV2/ZpXTwtrV94xxu9kWA=;
        b=Jrda/MTnlQALPEJSlfv8bjyXT0hAyNcBr2EIVHbFG1G907aMrSl+BCIvo4nhAu/6US
         SaULGUGaFI0DwNk71wkl96dB3XOIylvx4ORl2D1G1qquBebUPkrKRIjfUqhZgtma+vl+
         YH/IC5yXorE6YbsYxe7fr1U3PVgtdtJZhByxaxlsjt+PQkmuKSs5ZKHZIDn0xzySTIaf
         wQ0n92dViXPpfM4afSOfxwkvlYtI3yYKPUezpeQgnnd9u5n/XBxTiSY0GY1GjgE8U/u4
         RL2IN2aGznaypEtAx05iR0lDlKm2KZgHDFns27GgD1+chxuS4YvUVZ77w0gxvm1/xvDQ
         VQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787137854; x=1787742654;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MHM+2qgBqc21q4hkz2G6UjCV2/ZpXTwtrV94xxu9kWA=;
        b=k1zWNMLcPommxTER6kcvwNC7yNH07neavkPCd6Xoi1yc1wMiZV+7NEZR7grONTbtuc
         5ziRyAqFAHTm8SFIlcUeYjGLXPXWCDdq8Bnnob50FjGG7KfsBJwt7677bSTAcxi4JBJq
         BCbVynqlv7uaOPMpnb+u+IOb2AfHcqyKxmkPngL1VpiP2imX2yRUo+NTBkWCV5yCkDNb
         Eejf4u7x1h9owkJCa7hp0vp3ub3aXJraCa7Y+nTk5BHd7RTvK+btSdwlWyOvliqmISpu
         L0ngX8w5gT7BjcrMHJ8vFhbcIH802YM7eEyJvD7/g00q26b5lp/h98mp68XQt0yitULX
         Un/A==
X-Gm-Message-State: AOJu0YyqPyed154ndrOhIR2LHHiEXnZvmjLADA9CrFQtpt0HVXHL8Awx
	LEZJp1oTzVumwA09V2jzlD36zgQo8hLGVBn5QK4KV+Dd+6BzGaEGStaeurrq/tcYzE4=
X-Gm-Gg: AR+sD12LCacOt6YSh7wrx9d3SfttVIFJxv2ZLziXL8MLJAIGUPTtKcDTfPqV2pnCWqW
	Hy1Q1Vh8JNTd5lV+QLPDhZim7G8MQhV9dvV0432O+2fNNn+n9x9hICX4XYH2cT4G4LucrcrI0Xp
	gCQLFM6dNOcaZRRppkYCvztX29Zb4aLGzF87XatPocYhpH1r9gpVPKk9a4b5KQl6sa29dpCgVQK
	eko75QlfT349uDWHlZqPRC6dv1zpSBlXOkqtj1hcJNxOmRgfYCi5Ye+XGI8woHg73NaE2aIY0Gu
	ImQU8o/2jfXlaLugYLracVQgDhLpRtoXPxQ54k+4wqmULO+x6BflbWq1yZ20WKT0VxKKMi0y5es
	6J8tkJj7eC1f7a2oP72Cu9rdq+JQg4NuyutJVIlE0rIbVb0oLqHlzxtccahJAccfDPy+cKutFNP
	/cE1b752AU/gwmdnJaSzqZgXM0cSKt4RvbiLwUlRuZhglu753KqvcnvnQGwLAsi2m5VGIgMtcd6
	j+oiKNbyJ+9BXVFqkyH0QCFbPd86ejUGyTwdLrvaQ==
X-Received: by 2002:a05:6512:68f:b0:5b4:59a3:c67 with SMTP id 2adb3069b0e04-5b478d15f12mr694543e87.3.1787137854067;
        Wed, 19 Aug 2026 04:10:54 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4788fa30bsm433544e87.82.2026.08.19.04.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 04:10:53 -0700 (PDT)
Message-ID: <62bf3468-a485-4255-80e5-76997398431f@linaro.org>
Date: Wed, 19 Aug 2026 14:10:52 +0300
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] i2c: qcom-cci: Switch msm8953 to the CCI v2
 timing/rate config
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, konradybcio@kernel.org,
 stephan.gerhold@linaro.org
References: <20260801-cci-clk-fix-v4-0-e1d80da54e01@oss.qualcomm.com>
 <20260801-cci-clk-fix-v4-1-e1d80da54e01@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260801-cci-clk-fix-v4-1-e1d80da54e01@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/26 23:10, Loic Poulain wrote:
> The msm8953 CCI timing table is internally inconsistent. Its Standard
> and Fast timings match v1/v1.5, which are calibrated for a 19.2 MHz CCI
> clock, but its Fast+ timings are essentially the v2 values, which are
> calibrated for 37.5 MHz. Since all masters share a single CCI clock,
> no single rate can satisfy all three modes with the current table, and
> the DT assigns 19.2 MHz, so Fast+ timings are wrong.
> 
> The msm8953 CCI is the same hardware version as msm8996/sdm630, which
> already use the cci_v2_data config (37.5 MHz). 37.5 MHz is supported by
> the msm8953 CCI RCG, so reuse cci_v2_data for msm8953 as well and drop
> the redundant, inconsistent standalone table. This makes all three I2C
> modes self-consistent under a single clock rate.
> 
> Note this requires the CCI clock to run at 37.5 MHz, the driver selects
> and enforces the proper rate in following patches.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir
