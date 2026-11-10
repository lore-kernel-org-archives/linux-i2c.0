Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354378;
	b=X28oySxXMCEaY2hDkVxTsC/aeoUwrbqHL08fBpNe+6ik5brmWnO46IXqZj8o/40K9faM
	 rGlgPAWdw3yVedPNLp2RPMVZYu/dX+O/DZMc+tsgqeKLh7pK5dgjMRTymVS2WwoAD9cjQ
	 MhQZe/qC7QYzQFLRGMxrOKtyub9iyhxuu2J86+/rtqQX9DiVoyK+JYHL1EPeb1NVVHwV2
	 kiYu7aDFDl5YCPUktbj14H6HacsTtXVxR34znA9fFNfpxzUUfGgrE5IeJLuytAguFGYDI
	 0jfyMhmv0z1RnamE6M8JQgVXrXbn2pbSAy0kISLRCrhsLmrBQCBeMbwfkheXP4fujKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354378;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=WCdKUUEAMgyuIUvweS/CVZqWS7quwtCy3Zzak2dFXXY=;
	b=TLu7KNUnThI3HSP9ILapfJw7RxDCtDXg7qKGPzAoRWcE2bNoVSr2BT03qyvrvPPjsGpt
	 Y+0qi7YIoQuBUMXCq2R5SVA4JB/rgYS4wzOhXtMdoQuRfeDYK1CcF0FJLZ//KeB4Gu5m0
	 Ks438SO7VZ2AF3gptXze6qB2MabnGZ9Tg5N8ULuRqL7O7blPFLF79tQ98ta+qlJiWfGY5
	 pwDrFazA270BsnfyVQ6EW9GRhZbUwNMXmmkpWIdf6XIIYhajt6lM3jhaPizfC/OWOyz9/
	 WcLCV56/a26Xk9JEn9CH4oSekv7bEb9Lbj5ISJaBiVRoXM3IcrPBz/zxIGCvF9IEx4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=andrewgigena.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF6606A320
	for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 23:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91CF6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=andrewgigena.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b335ef6441so23931857b3.3
        for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 15:46:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794354376; x=1794959176;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WCdKUUEAMgyuIUvweS/CVZqWS7quwtCy3Zzak2dFXXY=;
        b=nmHHF/+DJHmsBcAQwDoye7pHQUTaozYLonC1dttlMs3KsrLg64Z9OMjnRhcM8e+mDa
         t+ftWR2m2oSaj+8oRBU2ST4oxsk7l6pFejUmAID9sCCHXhnqV3j3nPDBP16Sl/3lwtGk
         Ffvd4e7klJxg+HF+59tsAzw/t9Kvcu2T9h4zvy/JZDqfTAhdwQEnxitMJvUnCifSteSJ
         uPsT7hEuCIfSwLJlC9+HFTtOg4+ywRJe06CwZz32KC44T8ksdhO28r/rBXEEe6bhvalr
         7CuMfIVqq9Ozbg9B0619or/494vjGm/IBeOjgL7da5DD7CWQ1jvrRjiDignmCdbkR4YM
         p9EQ==
X-Forwarded-Encrypted: i=1; AL+hErH+6QMODbnk7Ov1x8jA718qLtFLAE6WoD3rDl/Pnpl8RdEsXde6SvgdWtKaOBiqKqHAtz3cdoAvVCs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HJjqIkP4idgjepnvF3ImYHHDdtHwxaIKZOklFcP2U5Q/wCGXG
	26VXoeLhUYlZdbzfAsp9Ra03TUKPPSFeGwnHLa+Vp8+BjseNtF2WDkonOiG1VN4I
X-Gm-Gg: AYBFou24q7n8e+G031Ymsbq4miDpLh5Rr5i4LswWmVmh5I30tIxcB0drs01ZSFRYzyN
	a/1GTyK7mGU96MHIlrNIogfwDkFeaf6hwEEo7INhhtHVTu8MeWxmNiL2qgHeeJb9K1wbQXull9y
	Q6H6VZWPOt6548iAiF95P+QdWLR1cwaSluhe+em/gC88TVsQanZP6PUBPc1ELz4AexRYhSMrNQv
	o9WJ98FvurvyMaKxHt6g9gqsyl96RE3+5ZRTz3Wb5fMSH6v5fvk674pJLQHIk+yerrdRxx+Hj0M
	UYAmxVY/tI6TKSn9K5wqLXxjGszX6BUro7rISiFe2CfQLp4qbWrh8+eYMH5eHf7ybfQO2deivVo
	DHkwlLO6HOpE5rf8oRgI6T22KMpeY5IR5S6zdDHo9J7eXyyYNZM8CA0PG0NkU0SYIkLMQMRGJ+d
	GTrEv9VN9+sY5ejVSGxSsVmDCFDvhUId5ra8TuTqc8P9GlsvoG7phuV/JKEqPM8qe3g46Aj3ceZ
	IlTCzVMp+lPQNktCMPRyPCLbkYS5qKuob/I8zShI0tXN8EZi9yCSSN9fS9yKDb75XXMEpifO6+Z
	jeWH3za56Z9wDGbEpwvDaluLROdUyRPfR5ce9NuHbeioLx/uXFD05xMzqwTOvUD5i92/qU+8
X-Received: by 2002:a05:690c:e3ea:b0:8b3:15c2:24a6 with SMTP id 00721157ae682-8b3a7ff3419mr7031107b3.17.1794354376630;
        Tue, 10 Nov 2026 15:46:16 -0800 (PST)
Received: from ?IPV6:2800:a4:806:ef00:2f77:7097:372d:6d14? ([2800:a4:806:ef00:2f77:7097:372d:6d14])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3933c59cfsm31871827b3.17.2026.11.10.15.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 15:46:16 -0800 (PST)
Message-ID: <ab79818e-4b4c-4b58-bd2f-57d9ae4cddc3@andrewgigena.dev>
Date: Tue, 10 Nov 2026 23:46:06 +0000
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
Subject: Re: [PATCH v3 2/7] dt-bindings: media: qcom,sm8150-camss: Add SM8150
 CAMSS
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-phy@lists.infradead.org
References: <20261106-sm8150-v7.4-rc1-camss-v3-0-0103e8a0bbcd@andrewgigena.dev>
 <20261106-sm8150-v7.4-rc1-camss-v3-2-0103e8a0bbcd@andrewgigena.dev>
 <21be3761-9da9-48c6-aaa1-b56f8625167a@linaro.org>
Content-Language: en-US
From: Andrew Gigena <mail@andrewgigena.dev>
In-Reply-To: <21be3761-9da9-48c6-aaa1-b56f8625167a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vladimir,

> That's an intermix of names, and you will get a review comment from
> Krzysztof about it, I stand aside.
>
> Here too.

Krzysztof did comment. I kept the vfe0/csid0/vfe1/csid1 order from
sc8280xp-camss.yaml in reg-names and interrupt-names, and asked him if
he prefers another grouping.

> Drop 'gcc_axi_sf'.

Downstream sm8150-camera.dtsi feeds GCC_CAMERA_SF_AXI_CLK to CPAS and
x1e80100-camss.yaml has gcc_axi_sf, so it is used. Can you explain why it
should go?

> Drop 'cam_' prefix and 'cam_sf_0_mnoc' also.

Prefix dropped. I kept sf_0_mnoc because SM8150 has a CAMNOC SF path.
Should I remove it too?

> Or C-PHY, right?..
> In fact you shall drop bus-type from here, because the link between
> CAMSS and PHY's output is not a CSI-2 bus, it makes it inapplicable.

Agreed, bus-type is gone from the CAMSS ports. It only exists on the PHY
sensor input now.

Best regards,
Andrew
