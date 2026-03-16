Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462DB3559C0
	for <linux-i2c@vger.kernel.org>; Mon, 16 Mar 2026 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773648185; cv=none; b=S9bkTW0rWkt++1XPhJfRNrdu8cc8a21ycMKFnRSoSjGUScGfsTr1vo7lSgEXhXbaGS6buJI3LJDDY77UcpL8K3mD9o6mvXCAvIiQXApHyw3cw5IIMQxAU/byYlDuCMVXLfTsFsZ2SFR4/5sw3NaAXnV8a0rueB9q0QIBdfdococ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773648185; c=relaxed/simple;
	bh=I3ozpn0AlufRc2Jss5KsZyj0nVqY6AoUdItpi643AQI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Py3XUaDCTxH4j8uOmpzGnZ0cidudLHR1OELnO0X63SEd1NVnimWiSjlZJQmLSU0Lf/bjpuhB7tFl9HGQQeBk7YiVZXaxK3dJ5TI0VYpjpwkY35bkRovZE2/Ollv+pl61HhGcSJf/qKw80zdlj5Z0Tx5ya3gDJhJLn4ygTbfx+IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=TC477T5P; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="TC477T5P"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-664f8bef4e7so1472364a12.3
        for <linux-i2c@vger.kernel.org>; Mon, 16 Mar 2026 01:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1773648183; x=1774252983; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sU3L+3tbACqITsDz16andVuW8wZL35d5pmOo8PiAQ1A=;
        b=TC477T5PvaGkjcNwJm7pCqcz8viqAUum5A18ihSZaEmGWIxEvx3ewsyFaw58OamBkT
         B0Ta3lk6ieThz7uSz6TzQnsQ+u/6+/P3GsJXcxxmjQF64EisRgGDi8hVZ+06+a7/QZHd
         KY+GFQ8v1xqBJSTshlsWqiCfDmbohnH4RavHs6OSRKK/gBiKgTUBh8Jnxl0M4ZBhjEnP
         qHQCNMwlz1dkd5k4iweQt9GhdTpt8OqGpPi+GN1G6w9jOJVbFvNChsG2i95SaYbiomss
         m6hazGTRuBHQW+eshgYiqfQp+T9eEGxYynYIXH9Fza02ByhkVEbnAiGNqWIRrcmLnKLv
         9nSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773648183; x=1774252983;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sU3L+3tbACqITsDz16andVuW8wZL35d5pmOo8PiAQ1A=;
        b=KbEnVVvgYQUYD5BIlQwlj4J7N/c78T5FuDCKh7qpZBO23GRVP4Wp9xxDDw2HgYSRij
         pghSRSHLgADraCIE/rATiObHr6Ch/DBka2Be1dBF94hkJUN37uhkEdk8ghuI0xMB1Iil
         6aJ97cbp4kUCyQG1WctchMTlzXtWMRAkzuamjq4n2Bq3hP0ZSCA7jUl3cFOVu2Z/T8jU
         TcObbNq1QpO96A89fv/0v5dU2ePN6GB2c8R+toxh+tNY0zFF2bU5S/sQfGNf/8xLMaX8
         sMo+QD7cyuCgqZ2LMAgGNzhSz82G1gnS8oWyBEJPS2I5jnUQI7SQpWkkPBgRRbc3uWRm
         bvdA==
X-Forwarded-Encrypted: i=1; AJvYcCUnkDkjNO92oMtlRL9jBHJFYg38SKcfPTt3iKpRqabyQiRKnVI2EBxRSTBzUX31zEBC0H1c34fAYw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Mxg7/M5WnCqqrb1yW4FoUA5/0+ehvZU7Y/g8COmLZkeip3dz
	YRWGjY8ohek+JTIwhNhYkx3TUn4XUX1xtjuad/gMBWCUuZZlVYfdZgNjumyhR0ycFQM=
X-Gm-Gg: ATEYQzxG3jV9Fsi7wbjD4IrugKVwaLeL4SmcxFwx/YAPuQ9taHg6k3NCXxZxSyPysJD
	pfqc2bmn8wbjecZxe/+eWNOBt1Cnest6byv+qDS5qq35jNWh2bf+g6xzBshNZwYLevhwB6wl046
	gtSc8143abQbL8FOH0zaHXkoKeBBtKuJhPaZj64CWRf0KKUo8kxlULw8FlyYk7s+brpdtdvU8zY
	ga2H/Ew9Qfhe3xGuITYApQzAhfkeFHBl8GditFnJEghCxUQ3orLET4cFJcFinfo9UrS1BoeY/Ka
	0c4Mki3gXnRqiBa5luBzr5CWpcys1oHodQR61qveg7Sy/GY4Pfb+czB+Xc9GDzt8JEVt9X12Rhd
	N1LdCMy24/U2bTxVmd4m8hTnxmJHPqKHHtur1iNzSermGRiFjRluoVyolPCTWsHpaz0Y66Oh4oZ
	IZBsUgL1dGEwUjuT5SMrMy0ZX1Z7AvnX3MKmC0tpMdaASQepsS7VRUArJOJ9FbgFhOk1Ok
X-Received: by 2002:a17:907:98e:b0:b97:554:f12e with SMTP id a640c23a62f3a-b97650c2f9bmr622693766b.14.1773648182486;
        Mon, 16 Mar 2026 01:03:02 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b976d0b5886sm504167566b.65.2026.03.16.01.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 01:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 09:03:01 +0100
Message-Id: <DH41T22PJEW9.3EO3P50QRXG8H@fairphone.com>
Cc: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Krzysztof Kozlowski"
 <krzk@kernel.org>, "Bartosz Golaszewski" <brgl@kernel.org>, "Rob Herring"
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
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260116-milos-cci-v1-0-28e01128da9c@fairphone.com>
 <20260116-milos-cci-v1-2-28e01128da9c@fairphone.com>
 <20260117-obedient-galago-from-eldorado-8e0ba4@quoll>
 <cb2430f2-8601-4c72-af6b-10f1ff16c188@oss.qualcomm.com>
 <DGDV2EMXHDS3.2377AQBNDDHAV@fairphone.com>
 <DH1LC0C4QD0Y.1XKV1PWFCBQRN@fairphone.com>
 <jexys4ypbizesa3whuvtq36t6hpqm4httlbwtzkulz5pld4yul@lf3joaistvfb>
In-Reply-To: <jexys4ypbizesa3whuvtq36t6hpqm4httlbwtzkulz5pld4yul@lf3joaistvfb>

On Fri Mar 13, 2026 at 5:18 PM CET, Dmitry Baryshkov wrote:
> On Fri, Mar 13, 2026 at 11:43:07AM +0100, Luca Weiss wrote:
>> On Fri Feb 13, 2026 at 2:16 PM CET, Luca Weiss wrote:
>> > Hi all,
>> >
>> > On Tue Jan 20, 2026 at 2:18 PM CET, Konrad Dybcio wrote:
>> >> On 1/17/26 12:54 PM, Krzysztof Kozlowski wrote:
>> >>> On Fri, Jan 16, 2026 at 02:38:56PM +0100, Luca Weiss wrote:
>> >>>> Add Milos compatible for the CAMSS CCI interfaces.
>> >>>>
>> >>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> >>>> ---
>> >>>>  .../devicetree/bindings/i2c/qcom,i2c-cci.yaml          | 18 ++++++=
++++++++++++
>> >>>>  1 file changed, 18 insertions(+)
>> >>>>
>> >>>> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yam=
l b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>> >>>> index a3fe1eea6aec..c57d81258fba 100644
>> >>>> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>> >>>> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>> >>>> @@ -27,6 +27,7 @@ properties:
>> >>>>        - items:
>> >>>>            - enum:
>> >>>>                - qcom,kaanapali-cci
>> >>>> +              - qcom,milos-cci
>> >>>>                - qcom,qcm2290-cci
>> >>>>                - qcom,sa8775p-cci
>> >>>>                - qcom,sc7280-cci
>> >>>> @@ -263,6 +264,23 @@ allOf:
>> >>>>              - const: cpas_ahb
>> >>>>              - const: cci
>> >>>> =20
>> >>>> +  - if:
>> >>>> +      properties:
>> >>>> +        compatible:
>> >>>> +          contains:
>> >>>> +            enum:
>> >>>> +              - qcom,milos-cci
>> >>>> +    then:
>> >>>> +      properties:
>> >>>> +        clocks:
>> >>>> +          minItems: 3
>> >>>> +          maxItems: 3
>> >>>> +        clock-names:
>> >>>> +          items:
>> >>>> +            - const: soc_ahb
>> >>>> +            - const: cpas_ahb
>> >>>> +            - const: cci
>> >>>=20
>> >>> Same comments as other discussion these days - I guess that soc_ahb
>> >>> serves the same purpose as camnoc_axi, so this is just last entri in=
 the
>> >>> if:then: blocks.
>> >>>=20
>> >>> I really find this binding terrible - around six names for AHB - so =
I do
>> >>> not want another combination...
>> >>
>> >> I dug up the CCI doc, it talks about the CCI having a CC_CCI_CLK cloc=
k ("cci"
>> >> here) and a CC_PBUS_CLK (AHB interface to the rest of the SoC).
>> >>
>> >> The CAMSS TOP doc (for Milos specifically, but I would assume there's=
 a
>> >> pattern) says that for access to CCI_0, I need to enable CAM_CC_CPAS_=
AHB_CLK
>> >> and CAM_CC_CCI_0_CLK. CPAS is a wrapper inside CAMSS that contains mo=
st of
>> >> the programmable IPs on there (notably not the CSIPHYs, at least not =
on this
>> >> platform)
>> >>
>> >> It further mentions that GCC_SOC_AHB_CLK is required for *any* regist=
er
>> >> access within CAMSS. Perhaps it sits right in front of the xNoC-to-CA=
MNoC
>> >> interface.
>> >>
>> >> This only enforces my imagination of CAMSS being a fully contained "b=
us"
>> >> (perhaps somewhat like AxNOC on 8996 represented with a simple-pm-bus=
)..
>> >>
>> >> +Dmitry, myself and a number of our colleagues were deliberating how =
to
>> >> best represent the hardware going forward and I think we at some poin=
t waved
>> >> the idea of putting every camera subdevice under a "camss: bus@ {}"-t=
ype node,
>> >> which would hold the reference to the TITAN_TOP_GDSC. This seems fitt=
ing for
>> >> housing the SOC_AHB clock as well and therefore concluding this discu=
ssion.
>> >
>> > How can we continue here? What change can I do to unblock this? I can'=
t
>> > tell whether soc_ahb =3D=3D camnoc_axi for this platform so I need som=
e help
>> > here.
>>=20
>> Any feedback on this?
>
> I went on and checked. No Milos's soc_ahb !=3D camnoc_axi. They serve
> different purposes.

Thanks Dmitry, appreciate it!

@Krzysztof: Could you take another look at the binding then please?

Regards
Luca

