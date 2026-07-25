Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEED2F5474
	for <linux-i2c@vger.kernel.org>; Sat, 25 Jul 2026 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784968617; cv=none; b=cLRQYNj7CUz048USBw1nvckQoA3h2x6Y2WyLBMT/2I00/UFu+QmyT5+pzSmeLSNlkXH66a6/WU/PU5Wxopg5Ey/QLeAWHJE3BNBmX7yr2vLSTOhi2IpxrevJh/AsiqouoTbJHnEhzDGRPUhmp/SLuWBmz9SsIx4qJmFA6tvk1Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784968617; c=relaxed/simple;
	bh=0OFXzeMQ9EYhP3eXqAO9VV9ArjutGPKah0evCu9E7Ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rOD/+MVacOgjwr2TSiv1cCVFrSww8ap+kLzxXcjsZRh+Cd1fvy5yaKsXp1q4RTstPb92bgv18KvFg2ON5kJ6RxzSnRVJeXCDMR33NDdq4g65VUNW/o2601a09aJgxzPf73w3JDpFg2tOoWv4A/moKOd/yYUoH8dGrx7Z4QZ4Fao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bRb81t0g; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bRb81t0g"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aec090da14so90596e87.2
        for <linux-i2c@vger.kernel.org>; Sat, 25 Jul 2026 01:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784968614; x=1785573414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YE9HQKDmtvVCl0AgZyo95qIV0Glat3h/Ev3Q50mZfxk=;
        b=bRb81t0gplgx+wXktxJDEJ2Ox4MB2kkgU77ju6qBVpGS+aKfCqtDD1vpSffNMDmjBo
         wP0cVGFOtVSXcwUOdb+aVMDX1IdWJhZZmy5ZfEqGq01XVATvwc5O22uotUfXxj86cs69
         8C6ePv0nE66n9j6AQlSrjOKiLkkexX3Y473n9RP5utoEEZMjmbd7U7/fr5626Qsmlhqh
         I+lzvJpfJdR9VaudNE4BAWyrweHm3L7TqDJoRKuYZF/A2RGzEkT/5sgHEf9I1nYgAZ9u
         iWzVuv3gcnWL23Mez66KAq04cDkzRpegvW8m37YxWi8Lj2OitWzC7xgMBn9LFiETHGNu
         i/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784968614; x=1785573414;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YE9HQKDmtvVCl0AgZyo95qIV0Glat3h/Ev3Q50mZfxk=;
        b=kbB4QwEquUysKd1gEYDKe8GrXOvHhN8Z9ifiKZfqWCgPYmL9CZaOPDNvp1LkKv0eA6
         UbbqK934J8S8fJ2VjbVWezUP3VyxpjRBDUwETzhJaZlfkbJKOnPA/r7gLTdYYjHmWoGb
         HncbyJh+7mTHWM7NPM/n4vmP20BDLOBsP1Lt71aBZFVzJLeInSutsc5t0ejCSf7EBze9
         9P6whSU0bYtJ5Fpz/qQL8zBErJGXjAkRSj+9Vv+Tw8HR4DYKk4OVDbgmKCqZu2Ij3P2i
         6RHBhBj2OKd9u1vF6hzqt1mLGzM21+ZgJpR3CoM4RBFW1SMueHKFRPTWJ2WPupbrTkRb
         tJMg==
X-Gm-Message-State: AOJu0Yyy00BBfr0fxs9aFmnMUQUKkXrbYB/YxqH2Ki/wGkpI3oXV7RJ8
	AFMfsNAfoRt/io7l2JHUOL1Nw/zAuGfqPEIrJXtqO9kZEQT8PfsxO+/uDZhQWTS/UvJ7Fq8R0fV
	7ehvXHKU=
X-Gm-Gg: AR+sD11Cb3OxVFvNZE0RR1M4z9JZMj0CHVbSEXmEps6BcrrApy5YtYixvfs7NfoGSdr
	iSy3QcIxiD4BoQHlnXGTAIVmRlDDipJMFMnbznUYcGIHFlmEIiXKPQVXWnrJqQPxKD9WhydnRLh
	vMTvwQ0SVUihixoAFH/mzlk0yUd6KxUfdSYfpuljA8TJgEGvlAB5svBAOAJ5EMtrDxV49PVq/au
	Pd//bmtLP8Kd0OLfOwW5kd4E9GPcxemW3JSQhs3pvbBuYOEVtI15Hyh7dxWgPy7IEYVapGnrBd4
	JC/XDIOqtnU4F2Z0HKVkrIKfd4phjycMCtKSa3SjdXj5TCrcXnLG7dXlTd5rdOoLfvP+thvWeav
	Ygep1lFMICpWQ2rWINjCPmpbrKVoGdywH3xhsp2XkiUYXbxcTx1hti8huIQMNFDzW5tnhAvJj78
	sfo8kow1EOiCILceEdwozC+chCxIDbCGsfP7odZhA+Ip0VAHg26GSskRkX
X-Received: by 2002:a05:6512:3a84:b0:5b2:b008:f90f with SMTP id 2adb3069b0e04-5b2c1b65accmr154957e87.6.1784968613674;
        Sat, 25 Jul 2026 01:36:53 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2be1d8c57sm315085e87.43.2026.07.25.01.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2026 01:36:52 -0700 (PDT)
Message-ID: <8d20f3ab-696e-40a4-a05a-688779299071@linaro.org>
Date: Sat, 25 Jul 2026 11:36:52 +0300
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] i2c: qcom-cci: Add missing cci_clk_rate for msm8953
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260721-cci-clk-fix-v1-0-5eae78700da8@oss.qualcomm.com>
 <20260721-cci-clk-fix-v1-2-5eae78700da8@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260721-cci-clk-fix-v1-2-5eae78700da8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Loic, Luca,

On 7/21/26 17:58, Loic Poulain wrote:
> The msm8953 CCI data was added after cci_clk_rate was removed from the
> driver, so it never got a clock rate entry. The DT assigns 19.2 MHz to
> GCC_CAMSS_CCI_CLK and the hw_params values match those of v1/v1.5 which
> were also calibrated for 19.2 MHz.
> 
> Fixes: d202341d9b0c ("i2c: qcom-cci: Add msm8953 compatible")
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-cci.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
> index 19e4719f13b29b2cf60e113565b1b63f19d0e669..5f74edde8558382e63e2c3d0fbe19489f325e8ce 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -783,6 +783,7 @@ static const struct cci_data cci_msm8953_data = {
>   		.max_write_len = 11,
>   		.max_read_len = 12,
>   	},
> +	.cci_clk_rate = 19200000,
>   	.params[I2C_MODE_STANDARD] = {
>   		.thigh = 78,
>   		.tlow = 114,
> 

this simple change is wrong, but commit d202341d9b0c ("i2c: qcom-cci: Add
msm8953 compatible") causes it, but please note that the commit d202341d9b0c
has no explicit issues per se (if proper frequencies are set in dt), but
this particular commit 2/3 breaks the whole picture.

Let's see, MSM8953 I2C_MODE_STANDARD/I2C_MODE_FAST settings repeat the ones
for v1/v1.5 and 19.2MHz supply clock frequency, but I2C_MODE_FAST_PLUS
speed setting very close to v2 parameters and assumes 37.MHz supply clock
frequency.

So, at least one clock rate setting for all modes is invalid in this case.
Automatically it means the reverted commit 1/3 in the series does not
directly lead to the wanted and well-managed data, and the logic in 3/3
becomes invalid.

I would suggest to grasp the statement above carefully, design a bit
better solution, meanwhile postpone applying any commits from the
series, especially if a breaking change holds a Fixes tag.

-- 
Best wishes,
Vladimir
