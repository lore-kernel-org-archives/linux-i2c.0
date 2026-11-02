Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613933;
	b=ZHp1qe2GKlwHkDkc6Z+T+n48qIhs2jcm/3tXVAkAEikLjCNxrONXhg67qHSChgBnaLyp
	 R1oF40+bKzD28MWRvrtxKEAJ5GJlobs31IcGZKMhNmYhWqDUD0cTaXFOOhQ5nQ+yMSmpR
	 +tdr3ZWpEp16Z2LA/RZE4UPz7pVOaj2bLBmh2s8UJ8jHIN/qj7kMcxBEzEVKNnJYaGM08
	 PmpPVMDa4k4M87F/uqyDJNfqcvb/CRT/A7kHs/4oP54MCjLvaDSflZf/vFNkUF8/U0sKc
	 FkNG9C3qmvyi+Ok3F8z6QgcYBZDlnvu0NDkzH0QneYceEsx9GPW3dQAKyGvGTdci4Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613933;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hraIj5eFlOlhzKylQQ8/efz7x5fIFgzaCgbnxap7ESQ=;
	b=ivCtJx/JB0s6Qw4forF/5wSTbgEz/jprI4tUpkFZG5Uek1kCWfjbzkz9lrbeeZWBaCaG
	 ISorg7zwvj3dTsPphabqwpJcKiD35jKGm6I1t72XcfqdTqLdOJbzRTUuyQsNiFqABB8vw
	 O3/rzZffqrPN1DrU7us1CHt/Ij7VxYWEjBsV6TLRs5C4upMzLHsucjhiTssYguyYKCFpt
	 qTiRNwlnzMOVKc8yshtPn/cAdi3AOUJeBO5X53Cx3ekd3eYHsHIVU5vIlhecaj6kP4KR2
	 k/y5J59xwZzgiubYtqpoxZW6HSbbUGVjUd3MU9oN5JWmM7afZKWyUkjbQBaTkbZO+uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFJBS1+u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795E4606A326;
	Mon,  2 Nov 2026 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFJBS1+u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285091F000C1;
	Mon,  2 Nov 2026 10:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793613933;
	bh=hraIj5eFlOlhzKylQQ8/efz7x5fIFgzaCgbnxap7ESQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mFJBS1+u1VM91TZWQ5lKgMiqtNJFvAKkHKz0EUpEUbIF5zNnl4OE9WgauZBV2fCCf
	 Ih0/F6Fh1mQW+ieJ5r+rkXSxxW7BQPm1xSi/gc0C6YJ5/8Nguu1EVxoe3LhJQLumxt
	 nEnC4PabPxa3vnaQAVnUEMT6u40t9aD0dA81GIEENYiE8P4lo9M8Ek04ecfo2QX++L
	 QGwgXX1d90QBPfrdJvN8F9B0ZYFwFSYtPjO00Yn6V08xAgP8Yc3F2HsysHFR4AL62W
	 Bg4tTmNc2Nlxdd5kFX5pAsg91vfpofRlH1nKXa9mf2kOGsIqfk7zPqZm9uN6NUHyR9
	 hya0S08K57Zjw==
Date: Mon, 2 Nov 2026 11:05:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Suresh Vankadara <svankada@qti.qualcomm.com>, Vikram Sharma <vikram.sharma@oss.qualcomm.com>, 
	linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: i2c: qcom,i2c-cci: Add Hawi
 compatible
Message-ID: <20261102-macaw-of-exotic-justice-8c11fe@quoll>
References: <20261030-hawi-maili-camss-v3-0-9742bca8cef2@oss.qualcomm.com>
 <20261030-hawi-maili-camss-v3-1-9742bca8cef2@oss.qualcomm.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261030-hawi-maili-camss-v3-1-9742bca8cef2@oss.qualcomm.com>

On Fri, Oct 30, 2026 at 06:13:01PM +0530, Nihal Kumar Gupta wrote:
> From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> 
> Document the Camera Control Interface (CCI) compatible for the Qualcomm
> Hawi platform. Like other recent platforms it requires two clocks, so
> add it to the corresponding clocks constraint as well.
> 
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

