Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BBF2E6CB8
	for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770988611; cv=none; b=U9OYuPezdTTLuNfvaPl2FoQ/pr9fZzGreDC3B8VdSTnKKsDQwjkYWk+R1qg3l1mSdIB0Ir1Rhf/rzPu88WxncoVGWqcl8mxx7GWqOlLILhWnua1Tf1rA81Fzo0O3PUCMlEhVBhlBm2ddJ7+12P90idGmKUwNxkaj/3uOgcqfFPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770988611; c=relaxed/simple;
	bh=sLl6FMj5rcoJoJnJtPsIJyDKQD5EE4IZ2V8G73qLWwo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=stI4KoHF5gP4cLG1DW28g6DulY4v7vk7F1xlI7RIqkMq1NxpGBNh9jrxyZ7IUfvTQzF0AMES5vh2lk/hrVpx/B1JVnecRuE52OARtVNL6lleus12XskcZ725hf0yYDjr6cAaO3IHCbo8p8oUG8lpIdfrq0lqigdqg4QSsTH0XT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=2lcMPkFV; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="2lcMPkFV"
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b88593aa4dcso102090166b.3
        for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 05:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1770988609; x=1771593409; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJBbVjH419c062Z3IzKiz9l8/ItT4jJ4UMp42HsCYlE=;
        b=2lcMPkFV33UOPujXvQB8/qXtwhz7YdGEKbgOQVxXgH0d6ZNVOsIQhqQ4tvbikHLe/u
         I0dMoFB+hukeRCXyUJGGyJvVbZYrdFSISeb/4JfoT0ChivOxfaq7u99fW/NYy2brNSpU
         8++8YHsjFfuvYoDZBeui60rES3qHWfddE57a9pYK2H0yQHNNmIB90Uy5HXv3IUnDpS/1
         OklOdaQZP4zeLXohClBbxo/0uqmYwMrpLDdsJEjmgUAovvSFDLIFB2xdnEvLocvaMRL1
         CtiHa6I1n3QIIb8kwBETNtnmHipuzr79CnutUiysGcPCevEi22SyFUHN4kjsI7t3+EQS
         I1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770988609; x=1771593409;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJBbVjH419c062Z3IzKiz9l8/ItT4jJ4UMp42HsCYlE=;
        b=EutnhGsiWONeqgtP1g4ygMrMSX7Aj0uhU2wvzGfsZ0HguytsM6RRNpVUCx0T08mtyQ
         5Z7WvAMnVt5Rrhd4BWnSodIKXSwrMtHzYp1M+223oIxakJhspQharkSRnFMlutvxk+Pr
         VBo3C2Rca+CAZj+X8sK+SOrYUjSrkPk7RZ8UrbCljmmdvOnPTNplNaoMNeLrQVNqVHrK
         W5Sju8n3HAl+fGRDa4yxkzUeKxKk2TSo/CRZM2d92I/ZrixyNLB3Bs0lbApnf76UViau
         J25qN3YrHKibJkrvgV5EhIkAPF45JByv6dHfzyCkcBUYQT7xb8xtkmqghAMipErJOo/w
         57dg==
X-Forwarded-Encrypted: i=1; AJvYcCVZWdS8aNJ7dLhn/r4Xij7HmOl0NzlBWre4xslHZl7qjsWtcPTY+9Q0MAl+85A9nGlbIUDcgzVm/qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMtph+qbyrWDNR8mMBDjV1bUw2q4ayQI6K+3e6mkq6RBynIhw6
	czFHCoQW2vYg+m/R3XQonvB/d+wXewHtewa3sclYZZT3ngb/h3rtpnAPjDJXQPlDdq8=
X-Gm-Gg: AZuq6aLsgcAbLGfI/Vigi5h4TvFzgwmx+dcVeP4jGRb7ePE4MdOIAwdBnnvvJLDlrxd
	mDOWCKUI9tB4lF5+y1BZdFsEbb4wuO9hq1Ys/pNiEhs8RPL25tvCPw+mKuoDG+f5nMGALUbgQsj
	JNpXdju34tXEgGGpNNWGI5sMz7ri7W5r+aIJFAWj7MIW3K93/9r+XgHit9eFzdpg4p24UtL+FOE
	Br3dw4NwXxiPVb7ZjRR57XOEBn1d9nmvb8szlogdUnBsICcRjGHdD0kS9I5Zeyp0zgpAJIeM1YD
	iN8B6pXMva43Y2KOMcFC+iYMvSvtdOgDpxUWxvqCclw5mKLvYYPCU/UpwTrbGL+kOVWiUqVU6Gg
	WmCTGtvK9xWhDANp9mO0Y5RG6T0EGQYomvqH2XwThWR1jvgjIrurLHJbmpIrZO6HhNH3LhViboS
	Wfp9DLo0uk3pzYY6Ge1iyVa/akkyPFarRzm7dxvoxMSUc4cYCXAIXUKzcsRTv+4pXJd5Kd
X-Received: by 2002:a17:906:6a16:b0:b83:b7c5:de2c with SMTP id a640c23a62f3a-b8fb41937e5mr107585766b.10.1770988608590;
        Fri, 13 Feb 2026 05:16:48 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f6ebd60edsm251679566b.41.2026.02.13.05.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 05:16:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Feb 2026 14:16:47 +0100
Message-Id: <DGDV2EMXHDS3.2377AQBNDDHAV@fairphone.com>
Cc: "Bartosz Golaszewski" <brgl@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Loic Poulain"
 <loic.poulain@oss.qualcomm.com>, "Robert Foss" <rfoss@kernel.org>, "Andi
 Shyti" <andi.shyti@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: i2c: qcom-cci: Document Milos
 compatible
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Krzysztof Kozlowski"
 <krzk@kernel.org>, "Luca Weiss" <luca.weiss@fairphone.com>, "Dmitry
 Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260116-milos-cci-v1-0-28e01128da9c@fairphone.com>
 <20260116-milos-cci-v1-2-28e01128da9c@fairphone.com>
 <20260117-obedient-galago-from-eldorado-8e0ba4@quoll>
 <cb2430f2-8601-4c72-af6b-10f1ff16c188@oss.qualcomm.com>
In-Reply-To: <cb2430f2-8601-4c72-af6b-10f1ff16c188@oss.qualcomm.com>

Hi all,

On Tue Jan 20, 2026 at 2:18 PM CET, Konrad Dybcio wrote:
> On 1/17/26 12:54 PM, Krzysztof Kozlowski wrote:
>> On Fri, Jan 16, 2026 at 02:38:56PM +0100, Luca Weiss wrote:
>>> Add Milos compatible for the CAMSS CCI interfaces.
>>>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>>  .../devicetree/bindings/i2c/qcom,i2c-cci.yaml          | 18 ++++++++++=
++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/=
Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>> index a3fe1eea6aec..c57d81258fba 100644
>>> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>> @@ -27,6 +27,7 @@ properties:
>>>        - items:
>>>            - enum:
>>>                - qcom,kaanapali-cci
>>> +              - qcom,milos-cci
>>>                - qcom,qcm2290-cci
>>>                - qcom,sa8775p-cci
>>>                - qcom,sc7280-cci
>>> @@ -263,6 +264,23 @@ allOf:
>>>              - const: cpas_ahb
>>>              - const: cci
>>> =20
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - qcom,milos-cci
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          minItems: 3
>>> +          maxItems: 3
>>> +        clock-names:
>>> +          items:
>>> +            - const: soc_ahb
>>> +            - const: cpas_ahb
>>> +            - const: cci
>>=20
>> Same comments as other discussion these days - I guess that soc_ahb
>> serves the same purpose as camnoc_axi, so this is just last entri in the
>> if:then: blocks.
>>=20
>> I really find this binding terrible - around six names for AHB - so I do
>> not want another combination...
>
> I dug up the CCI doc, it talks about the CCI having a CC_CCI_CLK clock ("=
cci"
> here) and a CC_PBUS_CLK (AHB interface to the rest of the SoC).
>
> The CAMSS TOP doc (for Milos specifically, but I would assume there's a
> pattern) says that for access to CCI_0, I need to enable CAM_CC_CPAS_AHB_=
CLK
> and CAM_CC_CCI_0_CLK. CPAS is a wrapper inside CAMSS that contains most o=
f
> the programmable IPs on there (notably not the CSIPHYs, at least not on t=
his
> platform)
>
> It further mentions that GCC_SOC_AHB_CLK is required for *any* register
> access within CAMSS. Perhaps it sits right in front of the xNoC-to-CAMNoC
> interface.
>
> This only enforces my imagination of CAMSS being a fully contained "bus"
> (perhaps somewhat like AxNOC on 8996 represented with a simple-pm-bus)..
>
> +Dmitry, myself and a number of our colleagues were deliberating how to
> best represent the hardware going forward and I think we at some point wa=
ved
> the idea of putting every camera subdevice under a "camss: bus@ {}"-type =
node,
> which would hold the reference to the TITAN_TOP_GDSC. This seems fitting =
for
> housing the SOC_AHB clock as well and therefore concluding this discussio=
n.

How can we continue here? What change can I do to unblock this? I can't
tell whether soc_ahb =3D=3D camnoc_axi for this platform so I need some hel=
p
here.

Regards
Luca
