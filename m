Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A484EF134
	for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970814; cv=none; b=kLFMcAIPnuA1LDG50iCDvH8JD593UH8wR2fZEXGedhd8KRjRQIf1HjWtOHkysFlyH2Ovy+zcwn3hMsXLEoSbRZ67xJxxyJn7S8fRbgiZtOWpEMriDLxHsanVi0RTVYrkQcqqb1JMcywuaOMM66fDgpcRZ+sg+HFA21cFdm9K1DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970814; c=relaxed/simple;
	bh=/MIV5f10+7si6CVmjQsZhF4fNwIUhkUhxJFAlQ1gCSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6UiAF/pR4RqO55okbQz8IwWSqYcT5yg3QU5JmfOuK4oqaptjSg2EJYt+sT7PNkoZs7eTM4H9bSmIUl8UYPLOJlmBi4pYl1E1Bki70c8k67FbMzI48QbIDOsJFP2RnEUfEAnNsG73qJ73IrvMxkpCN854gUanyGVZ0tT0vr9Ey4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AlsBh/T8; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AlsBh/T8"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2acc1e170cso656890866b.1
        for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 02:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791970811; x=1792575611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GJTdB+tkmfzXQ0j0gtaqlX8LAfgF2qu6ASSbm0x0pyA=;
        b=AlsBh/T8mEJYcCtJJfVVK9fzj2vAhhn4NPFD7gA/5/RXVY9wOrIfgr1kLwawS5ChCy
         YxFVOmhcdtfe4nfQVaSaYb3OBwlqSZdGhkOXAsD2fa5yTXSEV8pELOgSdlMUFNtr2A8G
         qHvHHYE47fODY8BF3ketgX81e90H6dMPmBYfpXCnRezFWjTNKYbmWTqExINue8moZKsA
         3kc8sOHBDAWpHNcJUjh2KvzAZuVuyjwGG+M63juA3GIFckoUKM3D+vaiMhEtAJcqRJAb
         MxOl++vvy/dasou6Qy3U+EMFto23P6QQgz4IOJwcYTCj6cXUSpdLGYkjUMhgKCZEBt1n
         1w+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791970811; x=1792575611;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GJTdB+tkmfzXQ0j0gtaqlX8LAfgF2qu6ASSbm0x0pyA=;
        b=RvY/QXfL2EJ7M0Blj24cRNjDMuIHuwp8fN9oKSiGA1y3Qd8O/rpj/rr8PnSSQ/IRRo
         7Prki8kmgVY7r9hjp6WM3yL7ECHKffOxloMgGnElugNxVH4/EysqyaV/k+OkZ5zLvDLE
         U0HomeplBwdezqvPsqoA//wNSCi9AohL9mxMYtjtgj7QTLpWtrnhcazB17ELRGNEJnCP
         rn4FFWqngzAkr4+lE4OBPYxhJBcnh5VC2fik0vMkvg+w6wJACUiquFEongjH2hePeQt0
         e317sJDpWWeFp+Y7hgMc3L3dINv3ccBwrrgCuZqtL6gpY3AKQM6hZtACIo7IhQElCuFG
         ua1g==
X-Forwarded-Encrypted: i=1; AKwUvBzwm6LXX0eITDZgQT0WIwI/+Y9pUhZiEZZhLpXX1Y0izkWzuoBoltEWbIVSHiqqpKCF1YzSBjDo/3o=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTwRnU+M0rWmVqMuRCunBtCzyeGejZ1aDomWKIiJuOXtSvg6lb
	7Fq+ga4mzQryIUVFKQmW59FHYW7C2/Qy5Ib9DXzJZXEBA5lLW2fjGyjVtPRc54hKgR7K4kfP3Kx
	mzhTK
X-Gm-Gg: AYBFou1K1YJpMX0WBiN97BxAOlXDGmZylhY4blllsiyVCTQ93ya5ejqLOPXrckUVjgE
	xJuTPflezKBwW8xfDKcJAMyFsq+Rz3jsL9M8yULQnPDIZkUQsXTptYXpxca1I097xDDmnuODkpO
	yjcY9vV3M/6RbcEDx7y8Wy89ilQaCcmiye5pStucwejilgU/dyV5Qu3ooMIVb9TxYCCcPBf9OD4
	Z9UYV6qq+nPAO7+TyNt1IQt+p7tWW2hmfbGeJwXig9lGn3p1YWDlLjrFWQf/vI7fM0nvxWEt2Zf
	eoXJPCO7AYs127rYKs0QJxvZ4MOKakpYcv8axZlp7kt0i8nwc8hjcrbcjVFWDl2W0MUGo8ywB80
	2/B3u/WuBWPwXvrTyNB9T2an40MNv9XNNpUBUoNy0pdWSzpaRcvdx9Ab/UiK5cBRC2L+lbrWScI
	TiyviAIwDnf3MF7gJICfW/BP2+vvxdkr0zg84zSctH/rZJvEGMCbUjo/Mf/ag8thuCux9iUObhF
	79iitUDGovv
X-Received: by 2002:a17:906:f586:b0:c2e:4742:4c91 with SMTP id a640c23a62f3a-c31aa08e8a5mr1307707966b.35.1791970810963;
        Wed, 14 Oct 2026 02:40:10 -0700 (PDT)
Received: from [192.168.0.167] ([109.76.126.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9ae6f8asm691140366b.85.2026.10.14.02.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 02:40:10 -0700 (PDT)
Message-ID: <570f378f-3798-4a20-947c-d97d946f94cb@linaro.org>
Date: Wed, 14 Oct 2026 10:40:09 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] media: qcom: camss: Add Hawi compatible camss
 driver
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
 <20261013-hawi-maili-camss-v2-6-fc93222da89c@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20261013-hawi-maili-camss-v2-6-fc93222da89c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/10/2026 12:02, Nihal Kumar Gupta wrote:
> From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> 
> Add support for Hawi in the camss driver. Hawi reuses the CSIPHY
> resource table from Kaanapali and the TPG resource table from
> X1E80100.
> 
> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/camss/camss.c | 25 +++++++++++++++++++++++++
>   drivers/media/platform/qcom/camss/camss.h |  1 +
>   2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index 5db7e12a6f86973df372c0428c15c286d9f7e60a..664237ad5ce60be64806c5386ce88ed2133f0552 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -4381,6 +4381,19 @@ static const struct resources_icc icc_res_sa8775p[] = {
>   	},
>   };
>   
> +static const struct resources_icc icc_res_hawi[] = {
> +	{
> +		.name = "ahb",
> +		.icc_bw_tbl.avg = 38400,
> +		.icc_bw_tbl.peak = 76800,
> +	},
> +	{
> +		.name = "hf_mnoc",
> +		.icc_bw_tbl.avg = 2097152,
> +		.icc_bw_tbl.peak = 2097152,
> +	},
> +};
> +
>   static const struct camss_subdev_resources csiphy_res_x1e80100[] = {
>   	/* CSIPHY0 */
>   	{
> @@ -6086,6 +6099,17 @@ static const struct camss_resources sm8650_resources = {
>   	.vfe_num = ARRAY_SIZE(vfe_res_sm8650),
>   };
>   
> +static const struct camss_resources hawi_resources = {
> +	.version = CAMSS_HAWI,
> +	.pd_name = "top",
> +	.csiphy_res = csiphy_res_kaanapali,
> +	.tpg_res = tpg_res_x1e80100,
> +	.icc_res = icc_res_hawi,
> +	.icc_path_num = ARRAY_SIZE(icc_res_hawi),
> +	.csiphy_num = ARRAY_SIZE(csiphy_res_kaanapali),
> +	.tpg_num = ARRAY_SIZE(tpg_res_x1e80100),
> +};
> +
>   static const struct camss_resources x1e80100_resources = {
>   	.version = CAMSS_X1E80100,
>   	.pd_name = "top",
> @@ -6121,6 +6145,7 @@ static const struct of_device_id camss_dt_match[] = {
>   	{ .compatible = "qcom,sm8250-camss", .data = &sm8250_resources },
>   	{ .compatible = "qcom,sm8550-camss", .data = &sm8550_resources },
>   	{ .compatible = "qcom,sm8650-camss", .data = &sm8650_resources },
> +	{ .compatible = "qcom,hawi-camss", .data = &hawi_resources },
>   	{ .compatible = "qcom,x1e80100-camss", .data = &x1e80100_resources },
>   	{ .compatible = "qcom,glymur-camss", .data = &x1e80100_resources },
>   	{ }
> diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
> index 0551211f7948190a7cc2a2e7971e6c549f92ff60..2b0990b95a1fbca8cbc06628223437c24bceb792 100644
> --- a/drivers/media/platform/qcom/camss/camss.h
> +++ b/drivers/media/platform/qcom/camss/camss.h
> @@ -96,6 +96,7 @@ enum camss_version {
>   	CAMSS_8550,
>   	CAMSS_8650,
>   	CAMSS_8775P,
> +	CAMSS_HAWI,
>   	CAMSS_KAANAPALI,
>   	CAMSS_X1E80100,
>   };
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
