Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D8B12B94
	for <linux-i2c@vger.kernel.org>; Fri, 13 Mar 2026 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398592; cv=none; b=F3A0/vzNg3rKz9/HwxK9u/qBqXTEP/TvP97WpC+biUB/7R5o7sQfRiNoXIywursCR2fGq/FjjPkjlZOr2SC83D2bu7P+G1NhgLgVO+9eG/u31HBoYH+DeXvcNdqb8y2J2NU6jR0/I9Zxy3+LrBi4wvETRKoZtNOOm7RdsmuiUbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398592; c=relaxed/simple;
	bh=IzAPagSly1lyh9lc2NNBcj3O8Liafw3xfmgTZPjhZww=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=GfsTqEwb7Xj9DjJlOjxqNshb/raMx8s5WRPzFoUy7OVQvupuYVuictz+iA+4x9y60YGmj9Y3mfzVYRMQX4p4xpe78KyeIOKLl2M2eUp928cAuvuWVtbkuQUltryt7WarzlnvXsKSR9sqCQTqFCEFIpnQKpvb9Psa4t3RxExDc8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=GiOl+Bor; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="GiOl+Bor"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b96dc65b886so556651366b.0
        for <linux-i2c@vger.kernel.org>; Fri, 13 Mar 2026 03:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1773398589; x=1774003389; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BN3CDzAiugNuzgkTXnjRsfjvoHTP1T2R94z8o6gBDmg=;
        b=GiOl+BorMU4NYKec777SB8jvhM27wzL0k6NzIJDpl5ynwBXl6Xq4sr0hTOoWvxScSq
         zRsnbV1+1F/+Ighq/YkRgMExVaQ0Ey67VJsMbHN+LDxvCfWv3O818Grhfnus3TD9Mfpi
         +0RuyVDrYa3+3cPc+l2px/a33o1K2t6Q+Lv9iTSW9hK4XuLQYaYyE6Nj06UHoFozZdUh
         eWh6fdgW6wDWeWp3/YO1Yf3XJUH/ctTzE80a13khOOox9sAGOBqXyg8tI2h97USQk3qX
         r0WF5Ej/sYH2o2TotRlHmz7TTfWvkNLA0waxIyhdGzjTlVZdz/nVCa0r+Uwppz94M0tz
         50hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773398589; x=1774003389;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BN3CDzAiugNuzgkTXnjRsfjvoHTP1T2R94z8o6gBDmg=;
        b=oFIPO24Q+LBJjRYIsdwzrZYJRHMLWTMoox+EJ7OSxedpgXDAhur1PsQlkxSB1qzGET
         0Yi58CPISi9yW5BYSa3B/qNHsAbHWOB3QzM24h0pCErUvWHA2KSMqgbHp+/4iNuc46VA
         hcRsE8OvtyZojJCxRCs49v9mheKKYynowsupdChgm+64tqSN/q0rO/8BL1Hn3zvmBVqw
         MXWPxBs70oVrsbhY0FKRT3SbzkyxH2+hi9QmaHHKzBDBUQZXpFJtp2PAd3CcgH6mdYXY
         RG2jxqsCc92+qgecDDWcfws4kw0c1OzcDds7BqpnZnRNww6Wo6mfUeucP+hQy0UKcycS
         lPdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUFJRes7DkXHB44xqcjV1wfkWclY2zXPoKxP6Q/WXPO2ylnPMYMhdJ+pLMABxp/slTMFk69EFh7OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrtLUYGKI/m12/Dv4Qtnx5+1bfne8Ri5p1Ow+U37JdQ5V1Js7N
	pK+HsgKy6HEJpxigdu9wb7XDI1ynghexZPIZzIFmMZrOhME6cVSxssuSYF0DzAAENW8=
X-Gm-Gg: ATEYQzz8pluyEeAwOH/152y2c3Rf0WgdLnD/62zUyCxjOHiFw+R70ltX39cBhWwR5hg
	8gSKMR/37la7jbKx5UlY0lz1JgxVwsxYfASunocOGuCqg+cTVx1xrJWixa5FxJbHJmUUyt3JX23
	bq//L4lDNxOMqcqFa7vTitPuKId40XBWfqqjsblf6yHoEJuZjtEZI4sw4i6Nd+N+CHo4A+iudu6
	kfENyOzQ4VT+w+LrWE1zbsP8e/Vp2U6Ax32Jesb7IHiZvagkUsO1toEVQQ5TmxiGQsKgB9SiKCB
	flu+0mWVoEJqv3tNduyHSzdRhPq/taoW/0SrnYsHm/5Tkc0gVgBJXGuaDvLgyH8Rrid3o5NU1h7
	lG2FJIfc5Ky3UTMsi4GmEWzwLgmjDiXRGf61KrkJAGTZFsmiw1Jw4e9FWd6o+Nnon3AKfw99iRe
	bqwPDplgkmGhUartboZ/kJlok80vQd2vS91Z1GuvW7ykhx9acby3zXkjidrkdqIU8SEPM/
X-Received: by 2002:a17:907:e8d:b0:b97:3376:7b5 with SMTP id a640c23a62f3a-b973ffcf3b4mr383143666b.21.1773398588543;
        Fri, 13 Mar 2026 03:43:08 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b976cba2e01sm36929266b.9.2026.03.13.03.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 03:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Mar 2026 11:43:07 +0100
Message-Id: <DH1LC0C4QD0Y.1XKV1PWFCBQRN@fairphone.com>
Subject: Re: [PATCH 2/4] dt-bindings: i2c: qcom-cci: Document Milos
 compatible
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Konrad Dybcio"
 <konrad.dybcio@oss.qualcomm.com>, "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: "Bartosz Golaszewski" <brgl@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Loic Poulain"
 <loic.poulain@oss.qualcomm.com>, "Robert Foss" <rfoss@kernel.org>, "Andi
 Shyti" <andi.shyti@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260116-milos-cci-v1-0-28e01128da9c@fairphone.com>
 <20260116-milos-cci-v1-2-28e01128da9c@fairphone.com>
 <20260117-obedient-galago-from-eldorado-8e0ba4@quoll>
 <cb2430f2-8601-4c72-af6b-10f1ff16c188@oss.qualcomm.com>
 <DGDV2EMXHDS3.2377AQBNDDHAV@fairphone.com>
In-Reply-To: <DGDV2EMXHDS3.2377AQBNDDHAV@fairphone.com>

On Fri Feb 13, 2026 at 2:16 PM CET, Luca Weiss wrote:
> Hi all,
>
> On Tue Jan 20, 2026 at 2:18 PM CET, Konrad Dybcio wrote:
>> On 1/17/26 12:54 PM, Krzysztof Kozlowski wrote:
>>> On Fri, Jan 16, 2026 at 02:38:56PM +0100, Luca Weiss wrote:
>>>> Add Milos compatible for the CAMSS CCI interfaces.
>>>>
>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>> ---
>>>>  .../devicetree/bindings/i2c/qcom,i2c-cci.yaml          | 18 +++++++++=
+++++++++
>>>>  1 file changed, 18 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b=
/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>>> index a3fe1eea6aec..c57d81258fba 100644
>>>> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>>> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>>> @@ -27,6 +27,7 @@ properties:
>>>>        - items:
>>>>            - enum:
>>>>                - qcom,kaanapali-cci
>>>> +              - qcom,milos-cci
>>>>                - qcom,qcm2290-cci
>>>>                - qcom,sa8775p-cci
>>>>                - qcom,sc7280-cci
>>>> @@ -263,6 +264,23 @@ allOf:
>>>>              - const: cpas_ahb
>>>>              - const: cci
>>>> =20
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            enum:
>>>> +              - qcom,milos-cci
>>>> +    then:
>>>> +      properties:
>>>> +        clocks:
>>>> +          minItems: 3
>>>> +          maxItems: 3
>>>> +        clock-names:
>>>> +          items:
>>>> +            - const: soc_ahb
>>>> +            - const: cpas_ahb
>>>> +            - const: cci
>>>=20
>>> Same comments as other discussion these days - I guess that soc_ahb
>>> serves the same purpose as camnoc_axi, so this is just last entri in th=
e
>>> if:then: blocks.
>>>=20
>>> I really find this binding terrible - around six names for AHB - so I d=
o
>>> not want another combination...
>>
>> I dug up the CCI doc, it talks about the CCI having a CC_CCI_CLK clock (=
"cci"
>> here) and a CC_PBUS_CLK (AHB interface to the rest of the SoC).
>>
>> The CAMSS TOP doc (for Milos specifically, but I would assume there's a
>> pattern) says that for access to CCI_0, I need to enable CAM_CC_CPAS_AHB=
_CLK
>> and CAM_CC_CCI_0_CLK. CPAS is a wrapper inside CAMSS that contains most =
of
>> the programmable IPs on there (notably not the CSIPHYs, at least not on =
this
>> platform)
>>
>> It further mentions that GCC_SOC_AHB_CLK is required for *any* register
>> access within CAMSS. Perhaps it sits right in front of the xNoC-to-CAMNo=
C
>> interface.
>>
>> This only enforces my imagination of CAMSS being a fully contained "bus"
>> (perhaps somewhat like AxNOC on 8996 represented with a simple-pm-bus)..
>>
>> +Dmitry, myself and a number of our colleagues were deliberating how to
>> best represent the hardware going forward and I think we at some point w=
aved
>> the idea of putting every camera subdevice under a "camss: bus@ {}"-type=
 node,
>> which would hold the reference to the TITAN_TOP_GDSC. This seems fitting=
 for
>> housing the SOC_AHB clock as well and therefore concluding this discussi=
on.
>
> How can we continue here? What change can I do to unblock this? I can't
> tell whether soc_ahb =3D=3D camnoc_axi for this platform so I need some h=
elp
> here.

Any feedback on this?

Regards
Luca
