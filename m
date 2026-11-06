Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964455;
	b=brYC6BB+P0D7Q3F5LlH9C+bUOirM5AlQQ3MWavEEffx790ZRBZ1e72nttfkECkRDauuB
	 4+h9rt/y4hk6m0Gl9PMwKi0/NKM1fz9HwMgAhqPdtC5chSr/RGXBrpg5URnzZeJtxkgsT
	 gQh58kBVjX0+8uTEhXAyZ6tYcT5JtukCelUacB2ItOe706o5TZApDhfohCxnWvbu7cgJe
	 FtziiEuqVl7u6HEGBeDX6cs5yWDRQVmyVJ0A/3FQIEBauhznF+vc36/J2/wauz0ldHCFD
	 AuEmkyni0mScFdSYS7mPW4K7cqFCRLt8H4zpkwl+5cu00SSntSoWrpCzU/0IOfMXTZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=GqsfXmArDx1BFEFrYigXSG4u66Q+cf083qtsOl4mkRI=;
	b=zS9QpoYdRieYG4ueZD7CueqE88AOz7uneubIWNtbAcnoMIbWD05Wy16exrEbsfMnpfam
	 nT2IxUcHpMLOPgTEb/E0kmYwOgcet1vrHYtRD9IMVttVbp6cP3HGUybV40Z543QHxkU58
	 ovSr/CYOMvu7g4aSvF4FkbGIJQFcDawP6OzAinDAE6J0nJQXznipF04qSR5yRjOv8X1vr
	 vxMwQefDLBK2voi7H9KbS125ki3jVpaTbneUXXR354BMkjd/HBWfBiJCpdozoAPUjEbWb
	 YjJoif/0TTT/ogj0fOS1LNe7UE9ceT1+qtEbvjESIVsepxWLy6Yu1imo8OTXmh3gDHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="zXO+/C32";
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18398606A33C
	for <linux-i2c@vger.kernel.org>; Fri,  6 Nov 2026 11:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18398606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zXO+/C32
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-490d59c3edaso364126f8f.1
        for <linux-i2c@vger.kernel.org>; Fri, 06 Nov 2026 03:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793964453; x=1794569253; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GqsfXmArDx1BFEFrYigXSG4u66Q+cf083qtsOl4mkRI=;
        b=zXO+/C32AlStvgI0+EYAWE2/Lakk51WyJPlKb6utiwbTK9+74CTcnXu12Wf+J/7NuB
         BdOoD4ctlP0nDHnnTAP14y2UXjeKB14fwhpho2iJ6q3ClTWXfFk6Cj7nJ3WNYSFpcTMg
         jbCSpb8ga0BL23ipmALQoFILzAVZewCiMgRMMW2zkFbS9UT+Qybk7Io3KpC7M1GZdodh
         a4QITzKhwTU1iA4HYSCnhVhpR2eMx2R+icRk2lyGDB+DtlyGJoVlMLPk2lzYyA7Btcjt
         I/jJS3hmHNXqxs01UtHPwjiHIwg+VofbkfZQOarqN7o6L2TO6HQavWc368QZ0IZdGvhP
         iBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793964453; x=1794569253;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GqsfXmArDx1BFEFrYigXSG4u66Q+cf083qtsOl4mkRI=;
        b=HZnL4EEdE3Ama8mrYzLikcGO0m+gTMVY1Z0ombEOL6OiLt4hjrBmu8B3Smxvak0x+9
         BCUH/bebF6p3lpngkVezDZcx2hIctseBAwEOJFa0Dwk/PfRcb6zLPtAoT+xiOoiLsOiI
         1qornyZ8Wa5hLRz7YOgnXhiEabMiMk9FP4p8LgaixxXPwowiggoFlyuEQAeRHxsG9awp
         /hzPh8BxSKR+ejT1qmcZKDpKFWwo/gAROC4amN3BURcREPesdGAe56m3wPNMgHdrRU5U
         /LdDs763ZI2dxHwFl6rjhF7TXk4br4Sh2GIgEm7s+sPHmab1gzIGHF+Y5LCTlGYFqEA3
         8Qjw==
X-Forwarded-Encrypted: i=1; AL+hErGFZv2Xs98ETjDmCgJcgjzoyrrgHNSt9m30oiF/jiYwf3MMaiggPnkpv/C5K4CPkLXokulpBUeXKS8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GfpkX7nmntU2ohIq0wjT+cZP52lXM5kx7O32e7WFnrSyn7wBS
	8ILrxwgSTh9HaPs2g2VdTJVjIoPFKZXVRkP8Jw8DWlDRT9nivq8oTY6a730CCeaSyVE=
X-Gm-Gg: AYBFou31Fqch8dBIOMv30tbO4V+IQdJn2NqflUzWQPcm4S7yCbCgDGsW/ZBNq3hDcWU
	mq3bEN4XEa9wxHK1D3YNYjAPNA5E+vYjVRHLvdAsS53BG8xjPfkxxUdrHCsLyfwIuJL6Xwrr2zQ
	5hnz72UfJ/UHJQqrb2WMQspVBQO4i+2nhGeTisHEzR4NCWWknZiOAq4oBtaXHtApBeAaq8OMzup
	VeUl9PJophxWCUDTMVAA1RNWYr0qk0qaui+0rVW1KnnzYR6eeCM6EZsBzqFnSr+dHyxfs6VcagO
	9Al41J1dv0VdefFEriIpdocOEju3RDSIsiELGaao716WLi+PbZNZKyOY924aRBR7s9w2bfe7IKW
	8iMoukCUvvYi765t94voNH23TXOCIihRhJiMEjaozCtMWT0D7WMTZsgPdlLTxsO5+atkEgx21qj
	ZyemeYwmBTGmNFj4jqykh/kx6TOimjpqcMI1Eo9hw5fo43GJ6sSiag0skm5iaolTe4UlZ9l62Xm
	B8Fue1XYlTc0OGsvtX1ugCE2Ji9to0U1+FpQbHvehYRdbXqvT4rI2XlPuuZ5MES4iZ8ys10PdD8
	B5UotAz8CwJ0Er1Px+j29lA5wYZhuIaTeEaYLAwsEPdwhPxSHfzhbdSZx6VXe+g=
X-Received: by 2002:a05:6000:3c7:b0:48e:7475:fe7b with SMTP id ffacd0b85a97d-4911906d185mr9499122f8f.6.1793964453377;
        Fri, 06 Nov 2026 03:27:33 -0800 (PST)
Received: from [192.168.0.167] ([109.77.115.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d73286cdsm2941196f8f.28.2026.11.06.03.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 03:27:32 -0800 (PST)
Message-ID: <e210c5f1-6a93-4387-ad1f-66d4ed35e00b@linaro.org>
Date: Fri, 6 Nov 2026 11:27:31 +0000
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
Subject: Re: [PATCH v2 4/5] media: qcom: camss: Add support for SM8150
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
 <20261106-sm8150-v7.4-rc1-camss-v2-4-39ee37787b00@andrewgigena.dev>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20261106-sm8150-v7.4-rc1-camss-v2-4-39ee37787b00@andrewgigena.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/11/2026 03:24, Andrew Gigena via B4 Relay wrote:
> From: Andrew Gigena <mail@andrewgigena.dev>
> 
> Add CAMSS platform data for the Qualcomm SM8150 SoC. The camera
> subsystem contains four CSIPHY, four CSID (two full and two lite), two
> VFE and two VFE-Lite instances.
> 
> The hardware reuses the existing 3-phase 1.0 CSIPHY, Gen2 CSID and
> VFE 17x implementations; the CSIPHY uses the SC8280XP lane register
> layout. Add CAMSS_8150 to the version enum and to the shared code
> paths, then add the per-block clock, regulator, power domain,
> interrupt and interconnect resources.
> 
> Signed-off-by: Andrew Gigena <mail@andrewgigena.dev>

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
