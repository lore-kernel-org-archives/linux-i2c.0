Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86F337E5E7
	for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971034; cv=none; b=jAXNEQdyR7BEmF53/Mj3dV/VctdhTUQNXMGVrA8lnM/wQhhUirxH/U9DOQ4tWJ0AbH/I6CFpaIDGfytlgPekgXjjgCiL85dnN6KhI/TvSvHF04GIVm0ufzr7AQflboRymzB4TLZo6rKcVBS6hCbWFX9gwgGonQY8NM5+QduhwS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971034; c=relaxed/simple;
	bh=p8bij+xPIuY1F2wzTxNxuEiDx2tLRjfxK2DOQb5YmqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDIV/yP9wxj79OoLOUKhKjB85E7Hn3BkE+zN+tijROU1t/L5oJc9eX/eOHtAGdsRiZQoMn7apWF2oi4ZeMn/XDPDWZhG2Yktp42Kg/xcwD/tHNCL5UHXKGu/Ues/bJ+s/lkg5pOqWzITeJSyP6PgweQ3r7A0g7/EPBi8JwT+Als=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uOYw7f4O; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uOYw7f4O"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso4145241a12.1
        for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 02:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791971032; x=1792575832; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tOCQwbGkL9XqwqZkq5Sc8MdH9xmRzvz/HA/PLReDL08=;
        b=uOYw7f4OPvpwLDJBsDw0RiocCBQFaY7L6IVYwf251T6PDD/vlDPeINPkrEszp7xxIo
         tMYI1dkwiYFQdtHXwQGsFlUNJ4uJ0SQS44kUbPEWNkUWv1Q9jdW1kBeAYxXb5KANJ2Y4
         RFGHRPgeCRucwsmvJuUSu/C2l+aKDhToYAInFS9joJW/uXFa9aQzXkwAaB30tdikQUCG
         j22Dkuet1XeZ6Lpk1ZX5Qa9jTLcXR7j7c4VIxP19NtPtgOIJBLb5GpVFh1taqWS0ZlGs
         KLCOIPOhEozBod3CsqIF6OHYwDVKE+PHKh1svgXSSUWWG8F0RFuGODxfna50qSVRfp5Q
         kZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791971032; x=1792575832;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tOCQwbGkL9XqwqZkq5Sc8MdH9xmRzvz/HA/PLReDL08=;
        b=XLC5HpBWPea1gWiKzD9rMBJb3jOYf31ZrxInst2NE0v7i4uDOH4BamUVhoaRfe50ct
         5s87BvLNDTLnz41JdbqLx+S90xJ8NjPNtJKCax//YIXKTAVFdb8BWkFmxX5bAs0C4frz
         xCyLcNaLNlr4G3Xqp4msKp54jYnM4m8iLNKb3bHj6rVeOFgEDPmHXFPGPNNLEm4C6Pnh
         ljmCRMF1/R3Da6vBlBFS5vNr+dt37Se002483HIWcVygVqNYmaFjQD5WxMZX5PEyXu54
         NmvJxpZ0YApCqpKCsIRrcZRaxh0wh4S65qs+ziEuOBQkeqBRZFcnZtSmytc4isLhxco5
         zJbQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9uSVfyE5qqvANHb3v4cRb1Th7AHx9DRMuwXmnlfaMc4ligFIEIlZvbaDsLq3XM/Sppo5p7dhKXN0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbmF/jTY+E9Bg2ALI0aFDO/VREz0AlvPEONUttKI1MsFpiZe9n
	bTQ+UfWG7eNFWrcwCz94noP1AaXUh77yJuot7lvFsJB7r5hJPwYxPbsLaddIQWlj/LI=
X-Gm-Gg: AYBFou0NlL8Ztw0Ebs6sYLmPcgBLykp0kGq/b20tklluX50gNulYN1FQQR1N5TqJXkF
	oNUteolpdR/I8Ji43iev5O8WgbDPtL/ZAvNXQvwlZlPtWkgbKjWqkR9HApUvMPmf8L6DoSYMyon
	ufsIJnT1RgUNMS+BQNO3EXzIjG91taBZW5sb2WwNM/stuJ4UsyeLKhoT4PplJdDKspmNHtnjwPj
	CJfVAP+Ge07k+SMwU5+FmlNzR/0ngJda5xSN4pBuklW0aKNZKBTMnRIqr3jMTTYs3avaMulNAQY
	96gXIeyKuxt+Okoei8rFEi5mvqihKo4MvwIWP+MZyzyb7QnKXvPenZio0xgnMshzjeT8IBY888A
	7IypNT+aWhb+j6hb+SP4FlX00mcZmiD+on1PltnA/bjVDXByfO/FV433qfEsoddWwPY4wD3bNhn
	NMapfxNNuv0wYsYi/2S93xsXTyH790UtBFdgX37sVOj6erxuDBeZjg08UYDlF3WTc5MEmyklkkq
	xNGrQhdLo+J
X-Received: by 2002:a17:907:6093:b0:c2d:d929:95e2 with SMTP id a640c23a62f3a-c31a7067739mr1466697066b.21.1791971031904;
        Wed, 14 Oct 2026 02:43:51 -0700 (PDT)
Received: from [192.168.0.167] ([109.76.126.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9ac702fsm690779866b.65.2026.10.14.02.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 02:43:51 -0700 (PDT)
Message-ID: <4fe3f636-2352-4f3d-9634-637622b2cd40@linaro.org>
Date: Wed, 14 Oct 2026 10:43:50 +0100
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

Wait a second - no IFE or CSID in this table, with both added in 
follow-on patches.

Lets just collapse the last three patches into one. I mean this can't 
bisect in a meaningful way as three distinct patches really.

---
bod
