Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794744890;
	b=SWtfJUwksrE9eNwXvcL/YIcMACSaIaQZa4jnpvdIzxDOfNT4jwWYXCLaInyfjFU2PmKB
	 E8z5DxviqwH5WiPTAuG5zDMigJT587kvfe77r6d12uWKzQEkRAcnYLvJDdsM1yg9kmIj2
	 y7V9HTK/7mcJ+osGVIuyxHKU3Aj97Hym/9Y5lrPbIpWIAOhWxlV0t4uN8jl4IaS2+1c9t
	 34sj6krLmb/dB/V0U2MOTPDcobiIq4vmhsidQgJOYWJmoLk2QA75sLSfFBJ+yFg3TmrMj
	 wEnPRkWlmazdFCtOWH861CAc6CcW7hs2Biaki63gTyNL501kOZ9hDtpXqGE9o3VWXYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794744890;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=uGgu6l3Ky8kvEE8GWOoo1yyQfvRZHOX/bqL3OvucLGQ=;
	b=VbpTw1hEcdb8x8VDr1JhKp8Ki9ukoVfaksTrXZnUaJlwnANkGlNDoP5li0OcZaUldZUt
	 /lgdvKqWK0RQWrgD5PtbnwqIVN0R0VK6v0m8/va9S+AIEtRtNBH73YTwesHqvRgi7JvfZ
	 Veuzb/mJt/GYMx00VEQRMqrceAMTblEuNs9R4aidbPJy6UPzZMP/xYfJM8acbo9JkF7JO
	 wKEap/bxRlYqDnjSGlNX0hF7MP2CZ353Qv7j4RRCW6jtwKqwggRKl2kPJr+KQKiLV/xmk
	 hw98cFGq8HwizMhxPeqImKOoyZhpnKdLjedHh7IBkZLBG+l2vP5+UmMbklSsy42FT+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eJL4Fmsl;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F063D606A323
	for <linux-i2c@vger.kernel.org>; Sun, 15 Nov 2026 12:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F063D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eJL4Fmsl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so14325105e9.2
        for <linux-i2c@vger.kernel.org>; Sun, 15 Nov 2026 04:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794744888; x=1795349688; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uGgu6l3Ky8kvEE8GWOoo1yyQfvRZHOX/bqL3OvucLGQ=;
        b=eJL4FmsljjmbthQTxR+1os6ehdA7HrXEazEQbHBtVieR0VPO2U/151cbAENNQpoh6i
         ghPT2cNYVo/lKqchdC0hTr2bHtSoCLidj7k1RSNtzrGC2aEcv0oQykcRlSDYypHCGxWV
         oN9107GYTlhdT2MgiIYtt8UXLvULIASeEkedrMlyX2xy2b8jmEPafnLnSNvUY5lvOeTo
         NXPWb6KvUlNbVtI1IKG8AeHSgzyPBKF3JHGZ8q3aDJQRXenTqEfz5BJ3U/dokIfbdvcf
         Slsbh7fCBGjSc7Gf77SUlg4j2wDW8AntcikkdGFAmrFijCPF0/nFgH21Qncq2ebCqEGD
         f3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794744888; x=1795349688;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uGgu6l3Ky8kvEE8GWOoo1yyQfvRZHOX/bqL3OvucLGQ=;
        b=Vyz7+ryhsnIgtUrNaQE8IQXYDdMPwadDQESuenqL6qi5tij9MRRJINceGg/P6j/stT
         IXYWit+cZti+90wYohL7SrKZwgfNoZ4wY3ByPmKpNjJWclcspb6w/VakYrevwyxA4EAr
         +gfJ/Crqs1ovGKfhg7hukSsSDmVOs38r/VtZOSFs8mMyEEwZrqJQhw1kif7pAmqHRF5F
         kyekd6weaxNlpuIRLkvgiUnOEVq6tgr9aMvvp6IXG0yorAC3ln8Hzwgyr9bQEY/DcSKP
         ZxNotVLg8W/3jD9i7137W1glRUYESpzVclBg8Upkb4XpWdWYbklxEgNsX6Ykqjpv/b0U
         2QtQ==
X-Forwarded-Encrypted: i=1; AL+hErFAhmArv4huQpi21FAo1yT4YDKnky7ZJUzl1lFNiXMftdblXVsaJzP9riy26FSIso7tI9h/c7y5SOs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Xu4sMODXqfSq8i0mKHG1II+3Ll2wUQpUbm0HAZxlNK1VtFrXW
	tl+6aXxTIQPxYMu/LfdywTlLXddMTkrdMlmUAVaGVV+mUb+YWKHUi7a0AY4EdqINUAc=
X-Gm-Gg: AYBFou2kmifHQCIAArGycRyFyG7hLEJLJzohcarRbyp2QQS/imxdBYfPhLMPzgtOT9/
	WKXNq6xf4u7iWMVTYcWdfSBheOhyPhz79NuY9cGtOajgTjqDuJ7zx2MWHEp7pgsyZQz5FcP7m9p
	qpGgVFGEgG5yrXeDD19z8L9qIhGwCdrzrXwDMYQSiVV7OJuLANtU5RDvDxBSF1SpubA8S+aFe6Q
	Em1g/ryWgpST37tGUbOFz+J9Ws9P/TDLPPXNNOEZhfZvEV2gbOQev/v0LczDhZCx8LMpelGn0Nw
	FC/ryDmqndpmZ7oLk081SOsp8UFfhSUr22eGGPdYUEXXvUbVfyNpYkFHuJPt7Fxu4Znuaem08s3
	t15Y/qxEmOgI2etRcrEX78Xbc3qxtQCevLxEnwREP/maRD96A9c7Ix91E326JvTZcHel9n7Ma9g
	yZHwyYdznXJH9jGcAM9njxT19Mksn9msHTqdXYD2Vy0ieMmq25/n8xa5nYt/BeNF0muFiYmXJWs
	KwmeQeY4e5RkDoAYaE3KVP9orI8tzkELiiLCZb+QUM+36Ce+TfujJntC6AUkyBOmgR1D56bSFKJ
	GkD9LHjlc5zVoUDgZ8wkkQBkER4dH+zXfWxVXVeSCYok
X-Received: by 2002:a05:600c:548e:b0:4bb:5c92:ce12 with SMTP id 5b1f17b1804b1-4bb5c92cedemr125712795e9.17.1794744888294;
        Sun, 15 Nov 2026 04:14:48 -0800 (PST)
Received: from [192.168.0.167] ([78.152.238.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49dc430fa15sm10124007f8f.13.2026.11.15.04.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 04:14:47 -0800 (PST)
Message-ID: <130fecb6-5372-44d9-8261-c3ac88248631@linaro.org>
Date: Sun, 15 Nov 2026 12:14:44 +0000
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/23] media: qcom: camss: csid: Add support for CSID
 980
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Frank Li <Frank.Li@nxp.com>
Cc: linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 Atiya Kailany <atiya.kailany@oss.qualcomm.com>
References: <20261114-add-support-for-camss-on-sm8750-v7-0-8ff2a11835f6@oss.qualcomm.com>
 <20261114-add-support-for-camss-on-sm8750-v7-10-8ff2a11835f6@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20261114-add-support-for-camss-on-sm8750-v7-10-8ff2a11835f6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/11/2026 11:29, Wenmeng Liu wrote:
> +			for (k = 0; k < CAMSS_INIT_BUF_COUNT; k++) {
> +				__csid_addr_update(csid, i);
> +				__csid_reg_update(csid, i);
> +			}

Why does this run twice for the same index ?

---
bod
