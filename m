Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964390;
	b=DzIRKVkihOZBcAji9+lSo2mwLLSB2WOOAGzt9GfF9RrQ2uPe/8fhLoI3/05S1NkgGNNt
	 EDn4pm94Yo0JkNB1+I1BobKbTwC80SItC0Stj9wdH68zNCkXIeUUtYsqLcjq3qD1QPAVv
	 M+ALx/Dx0QqiXPnUENt0Xouqj0t5+Grh9D8Y8FT3KB9pUJRslAKkjxmOi/D9KWBTrbO7b
	 BHh5AnkvULlLZxCXvrWuRUJQdHTFUWUWsZT+dGHDImNSQWPdf0YBVQDvEcyopR28j45J9
	 po4qSRIcO86VYDI6MlO7+pD7wRfNbJhucoeNYLH5v7pBIIDUCpyzFYBmn9Ia/gXueRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=JIN8oEdosMaUM7J7IKPgHIHkvQbHyBxozoGEFLEDHOg=;
	b=AHVTG2Vb0xNtdevfzw1fzJSOVAsWWOUHQ8TG5mAF4ewrurub5UM1YDWDzTjc0r2fcvre
	 h4Ibv32FW1IX0mfbdHsi8cykst4yohDwMMdFiuyfG4m6TtRv3Z7wqzmLunSgUAyKL4qVc
	 fDorz/P5pYpmGjmk6KkS/3lOPooBRFZyMKnC+3fkb9Ox0/+OXKaaK6YJ7le1Mr+OW5A8y
	 DXWAgEkwBJutU/nSe9axLryk22HFhOX/6B3FiObAaAvZkRRriimBKgvCKXOVnj08zcBiW
	 eogO4tOraLNZG9C6PtoFc88tzoh3YrwgYPSynT68G+B1TeCgMwnYlkMg2WADxgiLxlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=opUqJAWA;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1794606A336
	for <linux-i2c@vger.kernel.org>; Fri,  6 Nov 2026 11:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1794606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=opUqJAWA
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-492f0a1b685so272493f8f.0
        for <linux-i2c@vger.kernel.org>; Fri, 06 Nov 2026 03:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793964388; x=1794569188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JIN8oEdosMaUM7J7IKPgHIHkvQbHyBxozoGEFLEDHOg=;
        b=opUqJAWAOya7CeKLUFeRUpto0xhDsHDE0HohVtyIZnuUT+wiPe4cORcwLddq3v5huy
         i9pGZ4OqYg6HndDaZqJmJeiHMZxsorpAMu860/wKTG7jmUDZwZFMb21qzEfUqDhPRHdB
         wjgK5PPTSFqeFOVI/OkI0pg1Hf6EEUS+XwWDB7brg/tpwo4MRp2+2iu8CpUB2WynFEex
         NSNn5adlK+HYH8TtofdR2pDp8iRQ9QCMWtk3fFoKfJkzsbo2JN86EjBX51QXAZfEJqKS
         B36XSyIS3N15WdMNs5DmDNZNNYh5w6CaTX7o76QRuGcUTqhk9zNOqmfNd81CkTGX/w+4
         HhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793964388; x=1794569188;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JIN8oEdosMaUM7J7IKPgHIHkvQbHyBxozoGEFLEDHOg=;
        b=mXYsJJgXPtb5J4P2XvYvJwH10IMmvFbX9bKBRA2tXGXkjv9/8tmC7+uDOvWkJjRm48
         HN64wHZTXeIJ5xZoqTm1O2We+EujsD1sBABvHryiGR9fucFV+vuBa/pgdwUNRbpu4WvH
         0h+F6yt//eEQA4+pNP2A57mCoKNdJXyQy1pQMxACy/UkltESUBmNHBbbYU9HJi17K5hB
         VzOCFZvDWNV0dNTEHCumwo7QU8drpHyquR7D8pbkubhI0SGtub0oixHmhQVvbxZ2D/AR
         k2bpoUzzgmftGD5hDx8RftjsMYwUS0o2cJlLATcdN1limzGt8SeB2N4ZAMCbPBMRNVU3
         Gfog==
X-Forwarded-Encrypted: i=1; AL+hErGyecgmmnztybGKlGkGSWmioJKLI9njEUcAp9/fqVnbf/G51tVbvoLHINwzR7xDcTh2buX22P+3yK4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8At2TzjOt1XU2zBtwwIroYFvRicqLLaAqE8qb0yPfOUQrOEqhS
	DG9hkGZlpaHqDio754CcAnt8iR9XWb8NUOJyUpXyFKiXPH4V7GjN0WzV8GkyqWKQz/4=
X-Gm-Gg: AYBFou1rOvvFsH0QdoN+EqRG0TcnVAyVSu9rBQLY1GG8clcer6BL4AdM1FIpMZ4vMrT
	gRAAWwNRGajNcFovmzZt+GMik3nzWC/7y8ecAjLBnCkei0UT0recrXmOkGPwY09Fn+R8YyvPync
	E+m5QJFH2UDbRtSnN1yf3rbDQIi15Wca/5R5inq1ZJwJUwOD7hhDcgGHpQWce61NcwEoKh3p/bf
	42eVvv42OiG84yELZwhhxvfPTBWeaHW5c8Ex9zGNOXy1Y4BZ2t6VKTXbucNdVmMX6o8IFhuhDps
	UkWz+aQU2JFJC5T7staFTkxWIepsnu1WRlcWTKVmgMrGb2a5V2aivUey0/htwBvFX+iqXh5gnyp
	Eydb0P61mxCmX5ZUAIwUlThmHKbl37PjgeE3m2nOekjs07RtWakXh7xFZ06r2o63AkvM+vHQ+SX
	lDoGtQq1wEu+zJl22XHAH2gXhc+ObrkIX5xVDlnVWp/URTz+cBRL/NKn0PBcFJmM9ywn7lOFWBd
	N1uIOXeNdCxb/nIXb5+17IQ8SSqxKfRMe4+7HqkmZp3e/fXDl3W2n94/Pgn2cbq9n6tqUtZJdfR
	6sA4qhWpPviIBx8wq8P4j+mlmQ5zALg4gl0lAccMnQ==
X-Received: by 2002:a05:6000:4685:b0:48e:5e1f:9a36 with SMTP id ffacd0b85a97d-492778d1fb7mr3239346f8f.42.1793964387965;
        Fri, 06 Nov 2026 03:26:27 -0800 (PST)
Received: from [192.168.0.167] ([109.77.115.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492ff85585esm2390286f8f.5.2026.11.06.03.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 03:26:27 -0800 (PST)
Message-ID: <ac2e970b-1f3a-4aef-9a84-034d7e460c0f@linaro.org>
Date: Fri, 6 Nov 2026 11:26:26 +0000
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
Subject: Re: [PATCH v2 3/5] media: qcom: camss: Match VFE lite clocks by name
 prefix
To: mail@andrewgigena.dev, Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
References: <20261106-sm8150-v7.4-rc1-camss-v2-0-39ee37787b00@andrewgigena.dev>
 <20261106-sm8150-v7.4-rc1-camss-v2-3-39ee37787b00@andrewgigena.dev>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20261106-sm8150-v7.4-rc1-camss-v2-3-39ee37787b00@andrewgigena.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/11/2026 03:24, Andrew Gigena via B4 Relay wrote:
>   		!strcmp(clock->name, vfe_lite_name) ||
>   		!strcmp(clock->name, "vfe_lite") ||
> +		(vfe->res->is_lite && !strncmp(clock->name, "vfe_lite", 8)) ||

Shouldn't this be the case for existing clocks ? i.e. only check lite 
clocks on lite VFEs ?

---
bod
