Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025E43F926D
	for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 09:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970688; cv=none; b=EiOdmseHVq25IAjdBUUKip9kzjZC5rJRzUIAWoGxcjcvgbZcYz63YiB/CZhbVEzps0/KnHIa8PRFuxzo4s6H7JgQ5ohleNXefhMs3xEn5ObmmTDMTRFZcp2mb/VIkDzeB9IAapVAxj5iSb3LzEo2lTtrAALD5vU+v/CjfP6/z34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970688; c=relaxed/simple;
	bh=JAZDEVVWBpCzIsROIvJ7aOp+s0L8O8CrbhuQdamS+9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A844MPYkMsNUg7VEc2EePZOqpBrjyOErm93ARSxgNfKVDA7RipFpwrd1GATJAahO5z+V2+w8Fhg5eFRJKCNQM8kICCTX8VDInPF6Hk7I4P1xmELM9Lbn1aCegLGEn+ubtGSipemt7301/5lxCUiLaVSbIRke3JdMVYvAkZIyo5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D9TLTe3L; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D9TLTe3L"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a02718da81so30945935e9.1
        for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 02:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791970681; x=1792575481; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gnTWC5fZozzSwkHK4q+Oqe31gSO1RQ9RdzCpCj2F8RY=;
        b=D9TLTe3LV0X5U6WrodIJZ4Js9dABg9SPiO5halhg4sMS7y5xRqIJi15y/LSCfW/gff
         3PPz0AbVI8KlZQMI+JMJ0zom3Z184cvYzFHfbRWzVs9fuw3xO47o+Fp/XoJq/BLEWRa8
         GuhozyslteyFWi0slZ1rKsak4hUUaOGJTEdFluoNTO/4Yl+p3OYnm4dkMI/5HKoc+0qY
         El/6gNKTJY3hyOBZIoIiE7jZvHXsvu7fHJVmHWedsjwzyI5M0+WRIVkGmvBDHLuUw78N
         www8t0s04MAsGaGS+3oYPfFZwAZYYVBrW1XTiLUN6m23lwL9Tp+7Zkf6AAPHK1hOBCFK
         BVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791970681; x=1792575481;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gnTWC5fZozzSwkHK4q+Oqe31gSO1RQ9RdzCpCj2F8RY=;
        b=OcaTe8WSyJNybuYN5ztz3pCXZ0LOrdtYtMf/BonBTZLZaP5ZzY56it9ZBuK6TjQFq1
         yZsMnNqu0ca4reijRzDA7EZgYuSsC9eV8cyOH+KvCw/RpefQsmIUVIbpGjEM6W5BklLD
         UH9hy6pWdXYLivPxVFVQ8u4HsV2wf53/Slh0in/A1J6lQpIZuN48730oLhQ3E+itMkHj
         wCtxczHOBp6LHrNiy9KAwNnEph/TYZdLighOFFCew3z8zm6tlMPcL0+aBcDCn/qz3aHf
         klgGSSXXYpxt1Em6TF85QoMRandJyGK6qPCpWXJOcNADbqTKW5R4a61OC/AYC1ej3Dww
         7TZw==
X-Forwarded-Encrypted: i=1; AKwUvBwSLbQ4u3fIovIbLLebDKnpQdMLQA2vsXeANuFQYaGnYLRp7oEKgGbifxcOmTc7PehwbK6pn+WBjgE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKa7q2C8/GQITFMc2sK+9JoCuv5Ij5zdmTEoIu5rgqNweT2Xwtw
	zeR3ZaJAibfROUxbyMDBO+owPTN4xslAGK4ne4FohRcmFShnYPRXlXUYP3aPHuCwjzc=
X-Gm-Gg: AYBFou3YZYQFtH0nSqkKbej8DtjCgkIYK+iKKs3+aYjqoxb3jvPkJ041ceROakhqh2s
	XpusNg68rvyrEpnRgQXxU7oRXHhPnLQC/j+C55Ve0FlA+CjeDF8S9/ZWP8f+T5QZtzXrlJ3oBie
	Q/kRsaEOmFb46Ic0u74SZxZYCEDck5RwnPLs9RVjkXnTL6CmcswkIXtwNtlCxZJBxuJ1dzSeVzs
	ug7wDbBVrW43TQJ3lyto4OPOmjk+SIYoXGe3S59sUDtA9Bf0GilI9GNBtrK9pokvd3oU/9gLeYB
	6qZesXQvy7wkQnCHBw2HiNqn4MDXZjzx7VQtaP56+OUJLs3aLoQw6kM/5WOjAzdXEIYhj8IUej1
	eMKGnQkI5Kb2zhL+n/cXtMmlRaYxPemOE49zvZRoWpc4VW7H72hA+uDRRTMTBitSvWOxKCsldKD
	jaVr0b9qZh2d03yv+E529Vj62QTC/odlXXRRTqyOVDLpKyyENv5LWthxZfTz0q4uDGrFH4tLw5f
	9dKfdlL7XSz
X-Received: by 2002:a05:600c:3e0f:b0:4a0:1b21:2628 with SMTP id 5b1f17b1804b1-4a18e4b60d8mr299229875e9.23.1791970680941;
        Wed, 14 Oct 2026 02:38:00 -0700 (PDT)
Received: from [192.168.0.167] ([109.76.126.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7273a0esm6026436f8f.29.2026.10.14.02.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 02:38:00 -0700 (PDT)
Message-ID: <db980e07-adf9-464c-9fee-401581986508@linaro.org>
Date: Wed, 14 Oct 2026 10:37:58 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] dt-bindings: media: Add CAMSS device for Hawi
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
 <20261013-hawi-maili-camss-v2-3-fc93222da89c@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20261013-hawi-maili-camss-v2-3-fc93222da89c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/10/2026 12:02, Nihal Kumar Gupta wrote:
> +
> +  iommus:
> +    maxItems: 1

Just the one iommu entry ?

Please:

- Make sure its just the one
- Include a comment to name the one in this file

---
bod
