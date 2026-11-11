Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794360444;
	b=TjjaCjnSEbtf7z/K+bZrtOVh0/8rfjcylQ/DMSW8K2r3DQxD1NvacTrpurKo8YR6BFEY
	 vF4mtGI9L9omW5RzsSyuXzhQXhvRk5gcPilp68X4Gj4g01yod62H9YW9Mp1bwd5I+fNi4
	 UkFT2FQ+kesKguCHIgAN2sp6aHPdfdkTffvsNZ1+/QpNry2AJuNE2vAmiE5wHzYszZ4rt
	 CPOs7B1OSw5/vJqlQjOjepWCmJSOSeyzGYWoZTA55H6Yzxwn4HLV+HY5hi7e4z1oT//PU
	 stO9JzzRNiKAOLtKzGXtHHIqo/mZv+QluMUmurQoZ/VlaEat0dl+YxAm58z8tLBhUuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794360444;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=BLSB0jc+PDfoGDhBATE5rNyu65P6DKBdBa7UuDK+sb4=;
	b=E8Vuuux6SUdB7w3Aj1ZtWGsWBFyhwl/ZUKW9jiTNO2ujbReb9GXHQLhtXKRcHSDMgkZD
	 v4I+qGpXK7P4dAqzc2HNxgFg5e3FuoLxu5EWVkuPRk9i0VskWPLyNCvS2b02pXM/Q2ocY
	 eMis/KYZaI6bJtNRaejhh9NyB4WMLDm+jF/yBA1D2HyhdghwhH6s5QF6c74VBUDzZ/rC7
	 js1uvWRbEUqh3TlGrXic8ApscM/KaJF+FwdI7Pj1DQsyKszCL8t6IRCccY3JMVE/i8+D6
	 +Wsl5naWPoHMmo2ec001R7DNSvVtfJ6ZS9c1Yj2o7vGaSpVT2GZglcbovz5/IUort9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=andrewgigena.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C3D606A31C
	for <linux-i2c@vger.kernel.org>; Wed, 11 Nov 2026 01:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4C3D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=andrewgigena.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36f6295304dso3518254eec.1
        for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 17:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794360443; x=1794965243;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BLSB0jc+PDfoGDhBATE5rNyu65P6DKBdBa7UuDK+sb4=;
        b=1uXHA7/2obSPKJ3kcDIe5CURbgkNM830I/wywkLnTyaaEUmUvr04GeNTcVKkw3zoyh
         b/uyhDvu6DIT0/Az/xqLIoiCZ4dXI44EpUli5LNrGBLJ2oaqOhqGHgpzEg7J8E+O8pm6
         sO85QXr7zGM8nvW/nPls2svUROe+CnJ3MhfXQC/STqibHuvPGzUMUCU/z1sDTwxFZhdE
         2ld4s6DADM+g79KyotIHc2HIoNoocfHurXSCk0xMQi+BxtExNL0zw7e9HOdK6YnnsleF
         pJDCpppfu72muRAi300Or7FXAFYZ28nz0ec3ej0IShH/T+AhekQcCJhCtG+El7xdypzg
         //iA==
X-Forwarded-Encrypted: i=1; AL+hErFg5gGMojJICSdz3PSGFDYqu8yZOxjrI9WnjFNwSoIuU/cvMdobmKJ3TcDeKdYAfLWOgTTw3y0w+QI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qyTB8SbRzlgb6X/TYdvXNN/X4R3l6EUUehoV0GuZz3juFHyIl
	46W1OeCXVaYZQQcgMXJv4QY2uxYuFPhhSYZdqRO+RH51fOSROD2qGJn6
X-Gm-Gg: AYBFou31krLU0vFmSNm1PVkPCdSon41AEwvvi7cW8ovrt9WLGFNblraV8qSrX9KANTx
	QvBffC0Xf0ywkiHIIW0z+aCWzvutAr8Dma8PRAUjIqh+ZRvKy6ED1RNzdOuarYSmb4T6MaDG3FY
	kVgea//6jM3ufKq0BmdZboyE3prVIIvaZz+C++FMKq6BQ3J6uwKRrncI/f1tMwKpr42ZmKAeRSB
	ZXCE8TIwFoF7ij6Kxl3Hoeh/7OkXZJMvIWAOVvji8yRal6O3UlIiFE7dEcAQSWOV8w6Gwwq3fs7
	HJr+QGtYTSOqxJkVUVU4q85wMuimkCptWm2JV8egmq/WwYl2BfMC1Sx6mww4KVRacnf5R+lwKH/
	wBHZXz/1kiCeEytc/AxvMb5GeI3u60Wbdj/XaG34K1aRT2CKfPc5piK7eEVYdL6FDEfYteOB3FW
	k6nHD8c2JQrx7rwWMrB8+xA+qkEchSWGPJxoRQFAeUMVbhGNVMLmb+6RkDCoiCDdIHplfPSpswF
	6zkah8bHi4WFBzjjS7CInx6IdnWLUwtUQ0aPpUiZGtnrdyQglqBc1I/9tPrioTdCJpJPpq5guKr
	KgkATwbGwS+k/TzaK9OX1fkNqCvofTRuoBGbzUyan/T0J24vRwiUkRhXnt3wmxzMEsAjR+Hy
X-Received: by 2002:a05:693c:8219:b0:36a:1008:5815 with SMTP id 5a478bee46e88-3768385dee6mr1611656eec.5.1794360442766;
        Tue, 10 Nov 2026 17:27:22 -0800 (PST)
Received: from ?IPV6:2800:a4:806:ef00:2f77:7097:372d:6d14? ([2800:a4:806:ef00:2f77:7097:372d:6d14])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e7d24sm16548467eec.22.2026.11.10.17.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 17:27:22 -0800 (PST)
Message-ID: <9988b8c2-547e-405a-9c76-a4e6a59c7dbb@andrewgigena.dev>
Date: Wed, 11 Nov 2026 01:27:15 +0000
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
Subject: Re: [PATCH v3 5/7] media: qcom: camss: Add support for SM8150
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
 <20261106-sm8150-v7.4-rc1-camss-v3-5-0103e8a0bbcd@andrewgigena.dev>
 <160aa94c-c726-4cfe-b8cc-b1f974b32f13@linaro.org>
Content-Language: en-US
From: Andrew Gigena <mail@andrewgigena.dev>
In-Reply-To: <160aa94c-c726-4cfe-b8cc-b1f974b32f13@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vladimir,

> Drop csiphy_res_sm8150[], and pull this:
>
> * https://lore.kernel.org/all/20261026224957.1115370-4-vz@kernel.org/

Done in v4: csiphy_res_sm8150[] is gone and sm8150_resources.csiphy_res
is NULL, so SM8150 goes through the PHY-API path and clocks, regulators,
registers and interrupts are owned by the dedicated CSI2 PHY driver.

I folded your change into this patch instead of carrying it as a
separate commit, and credited you with

  Co-developed-by: Vladimir Zapolskiy <vz@kernel.org>
  Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>

ahead of my own Signed-off-by, plus a line in the changelog saying the
fallback comes from your patch. If you would rather have it as a
separate commit, or want the attribution worded differently, tell me and
I will adjust before resending. I am not enterely sure if this is the
correct way to cherry-pick commits since this is my first kernel contribution.


Best regards,
Andrew
