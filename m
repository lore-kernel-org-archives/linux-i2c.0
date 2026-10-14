Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29404E4C32
	for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970784; cv=none; b=L2VmnvIcyj3SraYDtHgN0HdhzKjIXp1itAK3zHMmCjZBQLZObBTtXtm9F1NACQbMg97RvokpPke1YsHIkUuDXsH4mNEhjyi5ZVP+qPG8QhZ0ddAdn20OCBC03D4bGwyBAlPIVWBCYDMwdNF6WIVW8GEpythOXika2wSqXU9FH3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970784; c=relaxed/simple;
	bh=okzaYTuseeajn/y9/bMRisEYExitpZUhSZUqWkpEvcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvQ3EpsZNrqatVWYAbgBH9Gjfsaqq+ilDQQR4vNhEVi8EG+z7IddG3cfanhosRShj/kDoJL6SE28eiP0XEGH+tCuZbqawtGB6FTdAaikUnsR9SanUKoHi1+gNV6EHUDzbi3BUgb6z7IC3+9didqsp4xtK5BKTDOMub65WZGAlnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lgYSlXmk; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lgYSlXmk"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c247f6687dcso594012666b.2
        for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 02:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791970781; x=1792575581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i1GZw3cNFikclMDGa5RfJqbcmWgweDgc3stMA6cogOA=;
        b=lgYSlXmke3NhGXgHOPHA5I/ODRDwVTY5w3VnVAo81ZF3piDNIh4XsBoU3F1iz85PkI
         MJPqAvklJACU2gpmfPp0bDi3ftPc2S1Jokv5afqZqDrddeeLU6yg5u0LIZMjrpADrc1N
         onBTXCA0w65ZLXeQQNQKl8w+ebMwLaeR5v+FDs2l8+xScqBXny0GK0jMDpASiBiMiJaM
         lMv3DXgCMB3swRdoZZbcFYcBfWygGMUKeWYEsz9X8IOMACwEMYccR+UV+LSjSUVZuKuF
         MMJM070xA+/vncqYacXgO07gjHyxC6in/VCb6VWENb131SGyDpWngnu01nYwWEMxibmW
         9ZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791970781; x=1792575581;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i1GZw3cNFikclMDGa5RfJqbcmWgweDgc3stMA6cogOA=;
        b=OPUhnk8gIaLHcVbML4ZDhtLTBZ3XOzr2xzr9Bdi9Fq99fXR8miRGXfHTPuEfoc0XBL
         +7RBdKiPqaUDjp2w+PRlmWnTNfMtRuYDptvxNK+ORN4pPvLHKCGLt+3Tj3A3hK95ECYr
         cpXg8xtmfO8kszu47US1lAAglxcTOWPEpJ2PDCzmO0Did1ZRHKAEmS/L16bBOYTGbns3
         KPVPVxoqF9fPB6ITPNOMgJgzsL3rHo3Z7+xA3ZDwGyL9g7qOGSSdjTu+N9U2HjwPJsb9
         13WmI5Y4b7K28mE/WlwZpTqoAqz3qv9KpHB5kZqea/ww8WMw+3W0FrpYGOCI/V+4/S0V
         BCtg==
X-Forwarded-Encrypted: i=1; AKwUvBz4W/WbsDdpnDh2FDnq466FlLumFG5fl42bNqdXOvaDzLbu3cU4mlkSOq9riRqOm9QuwhAIK8262ME=@vger.kernel.org
X-Gm-Message-State: AFq9FYL3+RNY3Vy49xCRLb6h6NuefrysSl1OhSUH0an2Ftmoy3NyP/G3
	Pk5R9UeozC5uvePtLfSRmNkJDFGmBopclUuW2ogaW6Assv1ywXrXhktbbPVZdGAqTwo=
X-Gm-Gg: AYBFou1zWW2ACLM2SQKf8r8pyd4nkv9IrzNR0OhCUtGJAGtP35sSPqjjemKEaX/WcAE
	RsEJ2TQV5lsyfkmBM6/8Vw+o/n4Eyo8UgH1rEll/XtKTsRPYbmZmtsRzvnnNubqpeDINWznYNEv
	z/JsPVruaYS/a47iaVh3iE3cNqMbkXyi/kSDcZIwcfRuHvFQXev0e1w1tCqSOLnOj6yLaRjeTb1
	foMP67pFcgJi6JugnJ7EDo7WFhgPOj2Ri44mTCACBJD6y2ZrC//a0ydJ41Xgq/OjF0V9SZA86Mv
	qUzum/X/PUQGOsU5Zr+PRrxkcuZzwZZqYAOFcyccH8sQpuUh77JKeRMd4FNlKBslLttiRRChimp
	zN6EB7BTfSYP9ijoW+TXJ1zT1wuDJM8J31S+W8YDzQPFwg8xHEROrCONgBzJXuc91SPOu7Zm29M
	qqlueCFeDxsfyz5jBWxtLoPowXqcvCDdCGhorAt++xdqHXiu0REUEsGf5ckEMjCkUndFnxvfboy
	hh0mMvyKBgf
X-Received: by 2002:a17:906:c116:b0:c31:8441:35ff with SMTP id a640c23a62f3a-c31aa0e9367mr1389779166b.48.1791970780874;
        Wed, 14 Oct 2026 02:39:40 -0700 (PDT)
Received: from [192.168.0.167] ([109.76.126.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9ae59f9sm681485866b.80.2026.10.14.02.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 02:39:40 -0700 (PDT)
Message-ID: <d08f3f62-713f-43e5-bec8-dd58997c2249@linaro.org>
Date: Wed, 14 Oct 2026 10:39:38 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] phy: qcom-mipi-csi2: Add Hawi support
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Cc: Suresh Vankadara <svankada@qti.qualcomm.com>,
 Vikram Sharma <vikram.sharma@oss.qualcomm.com>, linux-i2c@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-media@vger.kernel.org
References: <20261013-hawi-maili-camss-v2-0-fc93222da89c@oss.qualcomm.com>
 <20261013-hawi-maili-camss-v2-5-fc93222da89c@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20261013-hawi-maili-camss-v2-5-fc93222da89c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/10/2026 12:02, Nihal Kumar Gupta wrote:
> From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> 
> Add support for the Hawi 2nm CSI-2 D-PHY.
> 
> Reuse the Kaanapali lane table and adjust the data-lane CTRL0 value
> from 0x8e to 0x8c for Hawi-specific tuning. This prevents potential
> stream stalls and SMMU faults.
> 
> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
