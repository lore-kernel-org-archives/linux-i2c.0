Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794744454;
	b=GKmLw6Ubx3bNeBrKEreBUvBqVxBMnpiREo0GavUmqouUqoM94xe6PI7vCXjewrrg7sDb
	 0JgMaoyX0mkA6pJfWnGevCnhal+eayDyx7O9yvLm3c+NWRDNbcpmEofRN3L3m0D7HzFF4
	 DKaUQDLn/ICVW7naDRA7bf3d8nvfkoMuqXGNCHxVhKHiADRv+fC0zMrVstqRHTD0xG2zB
	 aENY4SorMe2yNataC0i7iyncmEak4xsjdzVjer5yp0lcT8w7j/+Hlt7UdzWUIhRc1UJoy
	 LxeDi/hAB+ihjA1wCHcocd5Qc4UsRL4POnIPiGjzEE77iHBYpzau96aadB99+GYXsiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794744454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=r6K5yPNLQHHB0Nog8TnybL0n8K+O6sS9uh6jOz0Z75E=;
	b=EK6gkRhhONbUNKouIHGn6XNfrp9ZFa69DB24uV8izHP67PSgw38TcF5O445CCsruY20v
	 Z+XXVx8802dx0EYKvniBzoKsZAbS5c4xKPCdNi5f3X5uWdVTVcqlwDDrvHHcLRq3rWWBa
	 mT6R4S+JBGzB22ygGQS7wv3gojWb5/d68yJJdfPmnUbuzZ6457T4748k+WarkMXqgIChm
	 2HDq2kpTGJgRB6mPyz2xbMQPs474MfSevbF+jOvNk6TLHTQxXr5StPtATjxPhAQKcSflq
	 3jdWwi6WZyAw8AqnL7dBdNy+2rnhiUMA7iqqC3w8JKcxsST1e2J3855CQ4MeCbN5gDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ivnCHnZa;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72061606A327
	for <linux-i2c@vger.kernel.org>; Sun, 15 Nov 2026 12:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72061606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ivnCHnZa
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso18147435e9.1
        for <linux-i2c@vger.kernel.org>; Sun, 15 Nov 2026 04:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794744453; x=1795349253; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r6K5yPNLQHHB0Nog8TnybL0n8K+O6sS9uh6jOz0Z75E=;
        b=ivnCHnZaftDoBq4Gu8kkVFXEzJgGlSRM+LgtFJVDlwfFAb/n3HudZkR736adgQgnJo
         ytYa2blxe4Py/DJASfqDUlFkMCck4XodHVmszliN+mxK1P1sXE5p+NVwnf90ghioz0ct
         5X45X8tkFPDaTUmpOO3RLQ1RZTBvOCS93yaN2xwsw5751TvRzY4y2XhuaPT1zW9IvuIJ
         cLviT9GDTLT5Yr6iPOmFHAScweTYW3K4zm3ouhq1mL9m9vmuznAgU499um/26kIZJLdo
         OvYCeppsIzJ7QBnAVNOfhlt8PxTcbnxf5+SWgLmRGkm26V3e7O2aqmyGCum+rO8SW1A+
         k7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794744453; x=1795349253;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r6K5yPNLQHHB0Nog8TnybL0n8K+O6sS9uh6jOz0Z75E=;
        b=OhoXPhvbgvBycGmpTNEyUPI4OXY6L5dLqfZsLGOZ8UeMXSC15PbX1f3jigaC4IYn75
         HnUq034TyQiicTirKlnNcK3pmtmA531ZgxP3cm3WXk5NVxzC5tMLjkH8vCf6Z9G+ZMOb
         eIyl+fI/6/7JEIBbHozoT0fTHKXweRRhV3+dvzfQp4JUSKdLpndRZb1oNt9ecZI3rPwt
         Pmgjayc+x0mJKbOkh4M/37gXnK+SuFNpUCT4jwYOqyJ6Hh+fa4wYyebBh36/5liyhbmN
         G0ap/TSw8FmwprzwQzzQIleova6q4gkSQ2T7JrFpR6h61YkuO8tWbzj5JlLN4WInp2fK
         gYUQ==
X-Forwarded-Encrypted: i=1; AL+hErHAeor9jhn4n/unMf6+1if33q/iU7e39sTereHppWkek/sPnMQI+Jlwdg7PS21FZuLTF9pWpmMjzrI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CldR9lHdgiPQtDeFomLhpL2lKUvQIBpq/ShRsR9MnB0y7MnOd
	+zjREaSaxbvFCoOfNsUrUgOOyP+NgD/sLhbbMmyR7+wBvAghTdaZ7W+gZPh6CPCLheU=
X-Gm-Gg: AYBFou2cJu545fyTHxlrqG1xwzF882W0ypnK8uGVLcnonItWc16AzvOs7XYJWyilVJq
	V5yyW5G8XC2CMqHQWpLiCZ9KT5NuK9mxiOrCCm1dJcigZ0h+a0s3bYKR3i1naOEfzSK4jecigZw
	62PhxGZvxadtKANTnlDbUlSPSDMePbxBwkVGQZ4tnIuInc3STYxCjUZi1cwV58fUTsHvhuW782W
	HJ57jNXV/LMAJP2xOLLLSf75zj9IoaH2PWpJkE+xLSZHyUFCLq1MIwsj/eQu8rnh1BEpH4OxApH
	1hJYfDYLDx+2EeaIzoiP/WRYap176MEOhE79aXYHFwRD0xCNGPZ3EOjOM22TsZVKtZSIPV2wFXQ
	hZMTc0dgz8YOX4sqS7do2OlUkAEtd4mrL4vwqmqU2zNoDkRLkm8c14dFtYUJTkbsGc27sCRyoRL
	anqdvrCqzrgZn0Jp00C2us+sdFOmYZSrIEZL57WQrNiTNsp3gQG+NNAGae6hZUwCdBeEPaPI1nl
	7vJRpp+h38sXvCQ7mJtGWaVl7w3JXjfAej6MSnIcH+32QaXI1ZnIA1Pnd/kkxYSkpa4XKOdp15G
	k3Np7zJKuVcIjk6YguECwIH2P/AQDSkC7KmgCYtLCRoDE77c4Df6vGHZ01h1sKLa
X-Received: by 2002:a05:600c:3d92:b0:4bb:6c01:de81 with SMTP id 5b1f17b1804b1-4bb6c01e02fmr25950745e9.19.1794744452736;
        Sun, 15 Nov 2026 04:07:32 -0800 (PST)
Received: from [192.168.0.167] ([78.152.238.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ac1159sm189440575e9.4.2026.11.15.04.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 04:07:32 -0800 (PST)
Message-ID: <d4fcf0ac-571e-4d3e-ada6-a732d68dc18c@linaro.org>
Date: Sun, 15 Nov 2026 12:07:31 +0000
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
Subject: Re: [PATCH v7 17/23] arm64: dts: qcom: sm8750-qrd: Enable S5KJN1
 camera sensor
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
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20261114-add-support-for-camss-on-sm8750-v7-0-8ff2a11835f6@oss.qualcomm.com>
 <20261114-add-support-for-camss-on-sm8750-v7-17-8ff2a11835f6@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20261114-add-support-for-camss-on-sm8750-v7-17-8ff2a11835f6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/11/2026 11:29, Wenmeng Liu wrote:
> Enable CAMSS, CCI1 and CSIPHY3 on the SM8750 QRD board. The S5KJN1
> camera sensor is connected to CCI1 I2C bus 0, uses MCLK3 at 24 MHz and
> connects to CSIPHY3 over a 4-lane D-PHY link.
> 
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
