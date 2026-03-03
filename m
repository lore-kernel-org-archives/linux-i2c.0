Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B95E7E0FF
	for <linux-i2c@vger.kernel.org>; Tue,  3 Mar 2026 00:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772499444; cv=none; b=t5TFIt7tEWDfYzaV5IL0/6yebuEQMDH6WkOVkttiAoYArfhHbYblYgD4Zd1BHzIOJrt3GPU4GVINMcYaK0GHHleD5LoVK/D7tpGPr9LmzoLcYAfie5dylVv2NzaqqfKORSfwDPHrWZAtQiWUOkVP2B3TijbhAJuwbXJ88OP6asE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772499444; c=relaxed/simple;
	bh=KBCyFDfourMtNMGwjDFRmZB31hD2+jEkHKTpEnDx5GE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PImrjcdKkMQbIpkNn2V+hXFRi0Rj4IAeLl/WGJGse5e0HmYovBklDFjn+FyY85uU9yMPm21HxjafDk/bgm9euvhYVjoUqgkcXA9hyse+gORQX/UA+4Q55bOq3ED+VrnPeClnWHY6UX48pkXs7rSDJhjJYnkPw0QWnOvxBG0FH/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYwgVdul; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYwgVdul"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ae56f8776dso8944765ad.3
        for <linux-i2c@vger.kernel.org>; Mon, 02 Mar 2026 16:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772499442; x=1773104242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+DbRpP4pGqX3L3KGnHSAdJ16AaJ96EbWxB7jPQsFqMQ=;
        b=NYwgVdulSk/WfPGaSXH63OgfRIAVypjuzubpZ4A0eFbxWSRAAk3oz6zlqNnDPTycWb
         Wa2UdMDoL+qdEaoAFlaEI25TfaM2VSDe8mwoErFWK5NCsnLQ2IHsR23mdE0sN0aa1WZf
         kxxrfKI+mz/QVODvmOnGK/k3DL3wwpoSIggjy5WotMO2SsFZkB3VqMCYFMzixWe9i8kr
         abuoHC2fKhqkwLyGKmirtI3/oZgATVM6wgDSIw+mJ688Zv+sB3e5Z60Jyv1wzIOTjNIX
         8e3EKItkx9ZXLu2ZdQ9LgggceWH5pSXduSGoqrs1+Xalj7DBiouNeWcaPMQqo+HuZ5Cf
         870Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772499442; x=1773104242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+DbRpP4pGqX3L3KGnHSAdJ16AaJ96EbWxB7jPQsFqMQ=;
        b=ZQ3QXysq9QyO6+ARKhceEbbyq5zXu3nbkbmudGgaTmIKgiZ2+jv2qp7z736bIYuaOC
         bMGGyy15g16IV8aYvLD2IgdlJXJBEoO6UWUzW3v5PHKl+pwsKwsSMXKGnhXl/vb3othH
         daH1iu+4obD0sjpySqJnyAKCyVXbrWOYbFr2OrVQa9K95HnGK2f4BMX2fU75XP3OWVed
         axHpumqCT0GPmZnZiwqQO8gNeLCZOdlxBLjOGhTr4xpw+em1FzZloVimmD/SgGmDuwKV
         NcZbc2mtOCTZejnWDXU6u5rn7CgMoIHWUbh2wRBJX/yfzrNtiGQCMeyBHZxw2WLbsdg1
         SbWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTt9O88K6wBqyQXw5wgA5vB/cj0lstOW4oQHAeyKn81cX+87WoGhX3YxOpp65JBZ85mKf+U987X18=@vger.kernel.org
X-Gm-Message-State: AOJu0YydqInkBHoO1CgkjN+m4W/bdSfv1TJuBi7Opy0MEtWhgzGlevdm
	Vq5bdpnbPPVethmjUTCdM/v0oD4lC6OgRzUVcCJyZMzsh17hcQR+KH2s
X-Gm-Gg: ATEYQzxdOies99c2jsocErv1ZjbvUvHrOKZUrw8S5pq6Tf1mbdi4VnrrWnlSiLv5Whf
	eKVEgklN/q4Y0qcioK5V6f0d7jwwLHWMQEPI75WbEQtQfVeRBU5p7K4aJoYZki7L/7o37cIBA8X
	+3xZVpKDs40AwoyzJ7stZRtWQkYPZBhbJoDk9qB8F1yv0yj/IhA5axVaPJEqRzBE17OlccbrYbO
	SeHUMAAQ4ZSdbGaFX/hC7FemJD/fKC00ExjhCDl6aAXvZC31MwMkk6hIC50tHeGjgGLfuTl4DRW
	W64xCSOVdo8FoksVbal3w3XiTeDUek3RRDTDmFwvgyNspCRjIDkvsG3Gcd/gt9LmuWzg/+CAJHC
	uDw7PW5PPlA1oImdzmiDkTI8TkSGDbn+pr2TNJA0LRPVnuIEfdI0kNiR4goTOn4BKqq07u9hGX+
	xX6l1RA7fm7Nq/sTNNLE35E2T88jQJeEF5USaZutmbdxV4byx53BLTwR39QqYZc3wpy/YhUmQ=
X-Received: by 2002:a17:902:d484:b0:29e:c2de:4ad with SMTP id d9443c01a7336-2ae2e42233dmr126907975ad.24.1772499442458;
        Mon, 02 Mar 2026 16:57:22 -0800 (PST)
Received: from [172.19.1.48] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b22fesm207547505ad.2.2026.03.02.16.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 16:57:22 -0800 (PST)
Message-ID: <1a6cbd56-2e07-42e0-b7e7-959fa2bf6315@gmail.com>
Date: Tue, 3 Mar 2026 08:57:18 +0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: i2c: nuvoton,ma35d1-i2c: Add MA35D1 I2C
 controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: andi.shyti@kernel.org, ychuang3@nuvoton.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260302020822.13936-1-zychennvt@gmail.com>
 <20260302020822.13936-2-zychennvt@gmail.com>
 <20260302-agile-mighty-cassowary-ed972e@quoll>
Content-Language: en-US
From: zychen <zychennvt@gmail.com>
In-Reply-To: <20260302-agile-mighty-cassowary-ed972e@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Krzysztof Kozlowski 於 2026/3/2 下午 03:20 寫道:
> On Mon, Mar 02, 2026 at 02:08:20AM +0000, Zi-Yu Chen wrote:
>> Add device tree binding documentation for the I2C controller
>> found in the Nuvoton MA35D1 SoC.
>>
>> Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
>> ---
>>  .../bindings/i2c/nuvoton,ma35d1-i2c.yaml      | 65 +++++++++++++++++++
>>  1 file changed, 65 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml b/Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml
>> new file mode 100644
>> index 000000000000..fa8b01e2c5b1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml
>> @@ -0,0 +1,65 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/i2c/nuvoton,ma35d1-i2c.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton MA35D1 I2C Controller
>> +
>> +maintainers:
>> +  - Zi-Yu Chen <zychennvt@gmail.com>
>> +
>> +description: |
> 
> Do not need '|' unless you need to preserve formatting.
will fix in v2.
> 
>> +  The Nuvoton MA35D1 I2C controller supports master mode and optional
>> +  slave mode operation. The controller is configured via Device Tree
> 
> Use modern naming, not master/slave.
> 
>> +  and supports interrupt-driven I2C transfers.
> 
> Drop "The controller is configured via Device Tree", because it is
> completely irrelevant. Why telling in DT binding that you use DT? Can
> you use ACPI here?
> 
> And with dropping this it could be one simple sentence.
> 
Acknowledged. I plan to simplify the description in v2 as follows:

'The Nuvoton MA35D1 I2C controller supports controller and optional target mode.'
> With these changes:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> Best regards,
> Krzysztof
> 
Thanks!
