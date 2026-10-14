Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F8B4E0219
	for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970715; cv=none; b=vBBb+JOsR+UnkT3TwA9S4C5fCpwlo2szdZdIMVGerKQPuDekJzBGYg2gEGgkKvPdEgzSimYxasyxdSD5Wj/LniU2drDmJvn4dZrR3xFUw9wfQ4/zi3foClK26mi5aK3KVUu2vBVa3417ggCxCAAL+QaQ+8mqnaPBirVRmFnbLVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970715; c=relaxed/simple;
	bh=ieAQq8W05Ldh6ypvnca0o/oiaSqWrWwDpTTeoe4YWdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdLb0t8tE1U6x6+wYHanOWhdkQwhCl5weatI74WNTBUQqYFeWbRjnso2hkXaHNGBPBViXGKi28A92CaBzHU+l+HOZEqfiRyiUjD9BL98bYkmD3/xN+yCSJ6oRckwAfD6gN6s0B2USOo5SNGAmzkFG9Y55caG/gA+b5Y7C4ZVAFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vE4seWoj; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vE4seWoj"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2e8c710847so483153366b.0
        for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 02:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791970712; x=1792575512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g+phdlrYB/RD28JPtIDO6lYJBfhoxurBJxdEKdj89FI=;
        b=vE4seWojajhrXAXU3xkwRJahawNuJ33pEC0+n+TRATlgWD9pK4vOTKM1Nl41iSYS6U
         NVaLwS3CuoaOhOk47H8rHOk9ctsVFASx6ad2sXWx2MDFEtPIvFTS1r21sZyRcR/lNQaf
         J5r4Flv4V2CoXYuuWIKCX8QdWLero6zPviAcFLQ2Xc/EOa+iXWaFmeIEaV8MdYtSgtuI
         m6K4eA/mM5/hIaGSBnkVE/DkR1SZmWUWcs8gTQ4TQ/s8TFg8aQssW6bVe/grxJUrsn+2
         nHIYaQTqeJ4t2pLmiWHdx42xejEQpS6jU4J48SCTFCfgEcG+Ntc2yFjk2lMSfUdTxpfl
         J2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791970712; x=1792575512;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g+phdlrYB/RD28JPtIDO6lYJBfhoxurBJxdEKdj89FI=;
        b=WWxMkqcJPr0AgSyVqHauFQvvr+wP/o3je0eczU24iNxNWRqyRqECYOzPDVaM3Yfo2c
         u6fd4M8ehLZlwanf2R/hVxz3noknoPh5DMSjhdcCR5WGkB11Z2Z2aG7XKDS6BoE+vb66
         bpsa8PsF6U5gsyioTXa9nI3I7Dno/b0fCfMbMt2t4xrny2CYYDoungQXmHKeJpE/yzK+
         jpGq7nzO1TMZ+IrqxwGIVxfXD0l6NHnvuzZGxQBf7hRqlsDQ9N0EfTKg8rGB72JkgA9B
         vFZCEBjdf0sXPZeXfUlFtsEm+p1dXdrC2NIabmo/QGl0atkOu6ydpp/86PBBRiU1Nyme
         VSXA==
X-Forwarded-Encrypted: i=1; AKwUvBwv/pVJ8SiwVb6N8yjXF99RhUDXkyUwfAzY78n4Ev959FxvOtSEwKlLgbD79wndnVgwB48sluiNydM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIs2/m60QYrDllqbGdTXK4cjYPPsgRWR5x2FiWCan3lZhcjXEoq
	1cP1D8y8JBG0gtf995OppA1mIjrJ3yJqpBZrVwZWjnomJHUQ3z7bWsgwLLHdp3TbnSw=
X-Gm-Gg: AYBFou3Cj9sLJ8YXjQtCywQGPelVOxIQpHqT4kE0kMRDLZ7l3D7Nfh12gSCXOW5KYOD
	Bn9cfvIKfynitmElkLqyM7EG8Dz6WLK1R0KfnVJNHyo7bDmw3JykJ6h5e5dfW2n1/pZ7BGmdFt0
	wkI5kJcptnEODmJ7rt5JTNEb+66yn8g/QjWQGcrp/Hl9Ix2dO9tCKx28CeZWmRO+q8sQ03D6mUy
	odTDhvXPAeyfTOTaigTcvfwpio7YcAk/vzl3IgRKMZ0p4bsYcRKo4FMIm7Ko2PZL246OOS02ajp
	/gZPTKGKLD6F6PrwLgygGCaPdLzi51pR+tUIlOXjg8/K823VNg8E9CC5sguA0BIFdVPj0E9xpts
	Ed+QzIdaD5z/79cwIVuw/IszaUy+vLWysh6kMzxHuh0Ti/4FPmdj0loT40zxkW9Rc7DqmP3cu+S
	K66XGic2UFWBLOx2yHes5hpi9QgBO3QsjYpKvrp0rCQMzutPskMrqIQBQx5dq02LszSGt6t7Hw1
	1zkz/5+j9m7
X-Received: by 2002:a17:907:2d88:b0:c25:541:fd3a with SMTP id a640c23a62f3a-c31a9a07db1mr1358197766b.7.1791970711490;
        Wed, 14 Oct 2026 02:38:31 -0700 (PDT)
Received: from [192.168.0.167] ([109.76.126.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa5953sm693842466b.58.2026.10.14.02.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 02:38:31 -0700 (PDT)
Message-ID: <47c2af33-05f1-41a2-958f-11ca13568acf@linaro.org>
Date: Wed, 14 Oct 2026 10:38:29 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] dt-bindings: media: Add CAMSS device for Maili
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
 <20261013-hawi-maili-camss-v2-4-fc93222da89c@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20261013-hawi-maili-camss-v2-4-fc93222da89c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/10/2026 12:02, Nihal Kumar Gupta wrote:
> Maili shares the same IP as Hawi. The only difference is
> Hawi has six CSIPHY while Maili has five.
> 
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---
>   Documentation/devicetree/bindings/media/qcom,hawi-camss.yaml | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,hawi-camss.yaml b/Documentation/devicetree/bindings/media/qcom,hawi-camss.yaml
> index 5bf0dca3d24621bfc4a09feb8e5037a925869751..d1d53d6f024cbf7d2a0f2525aa4040260353b200 100644
> --- a/Documentation/devicetree/bindings/media/qcom,hawi-camss.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,hawi-camss.yaml
> @@ -4,17 +4,22 @@
>   $id: http://devicetree.org/schemas/media/qcom,hawi-camss.yaml#
>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>   
> -title: Qualcomm Hawi Camera Subsystem (CAMSS)
> +title: Qualcomm Hawi and Maili Camera Subsystem (CAMSS)
>   
>   maintainers:
>     - Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> +  - Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
>   
>   description:
>     The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
>   
>   properties:
>     compatible:
> -    const: qcom,hawi-camss
> +    oneOf:
> +      - const: qcom,hawi-camss
> +      - items:
> +          - const: qcom,maili-camss
> +          - const: qcom,hawi-camss
>   
>     reg:
>       maxItems: 13
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
