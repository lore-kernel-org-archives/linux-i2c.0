Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794214032;
	b=ObVLxuqwq3Wjv0DCwez/6uFv9tYJRgSaZ1OLdwkpbvsGOKmJ8WB49LG243hijr49Cryn
	 6eeARyLFAZ9dlMtzm0h4ZfLTJ389agnnTlhr/ShUShASbycgwGl328FgC7g1EnqRybLQ/
	 9yaLakKuRt/ZqPWEV4NAxLzWcjreluFL7VrhlNXwd65SKgptzUqUIK+3DYPeWVmIQAaV7
	 m5Hp4ghzHwcRgRtpoqwMILh7l90WNOO660Kil6afKNlJ1zMs1OG4Q+j4+v1JYmIZ17NUb
	 zBqE2KxI4c/26Ky0uCZjxao4LW8scrGQgAcRQ/KWXsKfJshiZuPZWQmC90s1/sfbtSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214032;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=su1u842g4FEjFQofZRxAIR939LIBDxrqAn+twPelgng=;
	b=ut8PR99ZAxaM8BRKq0LT+P6G8g3HyjkURaHDyqGTDrybMl5nHaR2WUZQGpkdvhRxpcpX
	 HwRvG0cCxWX0E+Sg78Xtls629Wh6JJJ99odHxD4UfMBsK6X/PJOGtsdYExBkoLOGq+6vS
	 TxoDJl5QwwCMeuM6wlhIANMWmJDO4WVc17kpMX3oQ4w6OauX6GYRK92YVwu21TCK/Fx/G
	 XkrX5J3cl/TAuz5pj9iRiCyceFcH0VMY4ZE6oEKzGCFgxdqsfLNLPh6Y9m3rGtk02VuHP
	 4AjpdbMNWMn6ApA18LpmUY4fPqtN22UiF5yR1qLJdfOwJgYFIOoV6MrgJvhvznN2xeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WHb2JPx0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iwWDkKwy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E95606A335
	for <linux-i2c@vger.kernel.org>; Mon,  9 Nov 2026 08:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30E95606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WHb2JPx0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iwWDkKwy
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A96ARO42007713
	for <linux-i2c@vger.kernel.org>; Mon, 9 Nov 2026 08:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	su1u842g4FEjFQofZRxAIR939LIBDxrqAn+twPelgng=; b=WHb2JPx00Cy/57oF
	CrqkVCuSFPS5X6IRALFc5yWGdrl7uXknMMBfwJx+Gzq0FeJHGmt5s/pEuyHpj62P
	NYogZ0p6VPsTkkOTHaHwomX43ar87nSvghaz424nMoLjLvDsA+TOQ5W+/SOWysIg
	OHGClLyTB13GYCwVKgojewl1v/b+pASLJc1rhNBe5APNahB/8aLn+7kSKwM6k5Av
	1dPPdSN09sU5kt1OLrSBW7imJeqWSMafbiWElueOZBuTBnN8yNQjH8C5T+ZZNVsy
	9WvCjhnUrjUiL32dQDPwr3c630I0eJlg99kTLZXBkzKCNruHIqxw+B41fCXn7vzt
	BZdD1Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsw5k5ash-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 09 Nov 2026 08:47:10 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb98809caso110793785a.1
        for <linux-i2c@vger.kernel.org>; Mon, 09 Nov 2026 00:47:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794214029; cv=none;
        d=google.com; s=arc-20260327;
        b=Ca24dgNVeslm5HbwmP/T848MM8tznMfya/JKF7xHwbYQxZCPxehFt12nxDje+LGjJE
         NklSdw7BoBBeaG7y5DjmofrB5eLhMoO4s/5/giN1s6yMYF1V/KgXK/uc/P1CGZrL2xlb
         AyavHIf7XY6QgWDv5RM803Wu/0BrgpsLLDupcjbYEHBd8D3LoY6aV6QFf/to1h2ACMkI
         C9Dqbsg3ibfuJHdjbRjENx7nZHa9f0yU9rACLFkpgNCf4HtDfWKotcpYyzI2UHuSLj17
         IduBJz1SzUA4VRSEAMdTmzNkm2mnXrTvxhdH7ZXn0auaIA2nBtCdNJAqYJOB1KqC/Daj
         M9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=su1u842g4FEjFQofZRxAIR939LIBDxrqAn+twPelgng=;
        fh=c9S5RE3QdH0WO3d7fidlvZn/jJSoI8e2Y1F7BFaJOP0=;
        b=qcwdWss3QSnIjNFSB1FAc3Vr5ZslFGiQBrJ3hC/gwZG2IX8YOiyVncBHrQDimMculW
         j8BnXNHIcKAEgVJqExgCXujLevkoYtng5IO5WXDS7ZHrmPrwVzWeCx7IbSoTaAmpRROI
         uigpFtrD18VDIRv1KXsMsyNa/s0J/XA8RiVZSeUIgd+76i6ZqziprTdVCdhgAv/KQTvn
         AtanbCvdUdgzbKcbp8LZN/e90FDbPokfhm7PbU0BcFv0W/RCIK6aywRN5AA8diiO690U
         fMSmZ8nyBkVW/i3qAaVZN3C4uP8MoDZuORv09scKlqmrJYA7TQZtcttmZqt3xB8N2F/I
         PR6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794214029; x=1794818829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=su1u842g4FEjFQofZRxAIR939LIBDxrqAn+twPelgng=;
        b=iwWDkKwyAtT4HS74ExdfTWe0rXOC6Bz5MFmKOMILWuhgJWsdunAz6TnePeeo6+Qp4Z
         lYA8V/pdcr3zm6XZ5BtztsQ/0dXON+1R+Q2oBl5eALxBRJfuW2YHvTq1EIvyoAGzkGx4
         xV4U7oloSEMJZv2KHfq37TQDvUY0w98xSPcl01EpijSKUtWyeMfKHXu5iYU0QiN2rrny
         xrnPaCF9HSnHQF2muuUoOtPAp0P9/ySKqkgLQqMX13DQugQY9gzUBKX9dDU87hff15Yl
         CU4ZlHOQXo9aRpawxU+3qWj3Cp/jW/mrVWAseaF3RoXpJDiGtwf1qYnA6m6XEayG/2gw
         Uz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794214029; x=1794818829;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=su1u842g4FEjFQofZRxAIR939LIBDxrqAn+twPelgng=;
        b=eO0F9gTmHF+HytyJK614lyQd9fVSBZPlKtLgBwlBQ0An+2g2TTDxyIbyGPfswN/TDj
         vL71fPJS3RxSvFTjdhbWgCM9F4N4M/r+rEC+x1o9mTQBLZ0jWs7Dps8DhBydtRJsH0oC
         VglxOWOQUsL1uE6NJd4FkXjJrEsXuboWDEQGk7RFzsUl5EFN+K2qe6haAL1Rm0NOvsgZ
         UR5Sfbzzb+5NGc6z9AY60M8dHdHU96q0iqfvjnN9fNW3hoAekxDDUTHcRU++ugnvmwpF
         uE2YTXAzyUyK4ro0QUxqancUQAa4b3+JkvfKQZR1Nf/j2p3HdIThe26K5+tiHvnI5X3s
         3WMg==
X-Forwarded-Encrypted: i=1; AL+hErEtCOh/WDnv37TJEnKoOpGKCGBDh3WU/h4TvEgt+ecFK545MpcYYL6EUZsIg6Dd+FLZrzY858OR3bE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rIQyFNwLMERPI8A861CSKHXRjag0xvg611P8KwZEKRVzCrQqv
	A8gUmngt1kvg5L/KaCs/AN3NXDAC2Eby4GGcizA1SF7D/Rvd0l/XDORWmZLSjgdTufaQKFlnRdc
	VXMTqfyZm0ZIqlrwHzxPrEhF2tiQanpcr58zgAT7W2lTA4wkkM5xC22zJ6HMn4c4HJNoscY9ZdT
	eR6z+XxT3OI83QP6osS61W1AsgUx3Zd8F8MS6QIA==
X-Gm-Gg: AYBFou1tA1NHyJwkXBSslmLLIoXLLpF4G46ISI++680uwuVUY1uZMfm1oVCM5nXWxss
	gDLvZTXX3llRyeE40bFMoS33GkCbNfrRkKw7/5IAQRr0brH7zdn5YhL8L1Q9sHfKQibc/+rzhwA
	C58043te+YF5hAA7c2HL97OUasJZcli9HLbBQRPZvxJWhfQQu5qmyyvfFU2f7f6qqld5VJLFuCT
	d4aQzEePC6m0zZI/7q/N/eQxnlGcq5UX+IGV49/uqmFSGHBcID0IaaK6iYwSeuMqWLmeysMMg0=
X-Received: by 2002:a05:620a:2a06:b0:93f:3120:6c82 with SMTP id af79cd13be357-947842b77b9mr459160385a.78.1794214029333;
        Mon, 09 Nov 2026 00:47:09 -0800 (PST)
X-Received: by 2002:a05:620a:2a06:b0:93f:3120:6c82 with SMTP id
 af79cd13be357-947842b77b9mr459157485a.78.1794214028925; Mon, 09 Nov 2026
 00:47:08 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104230529.3040285-1-vz@kernel.org> <20261104230529.3040285-3-vz@kernel.org>
 <CAFEp6-3x9P7Q3+RESpMo7mKNYqn6ed0XswSJhhr1nFyHg-w22g@mail.gmail.com> <a3be2e35-13ee-4e8a-b231-5aa0326f6933@kernel.org>
In-Reply-To: <a3be2e35-13ee-4e8a-b231-5aa0326f6933@kernel.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 09:46:53 +0100
X-Gm-Features: AclHuK9zw2alH4oLwzChdmZ5Pav3qFoszwduIqZlWs6L6xUG87_aNWF28AoD7cY
Message-ID: <CAFEp6-00odwOgmhx9hjLUeCWJo1XSFDB_rKMMinF2frRTcaq+w@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8350: Add CCI device tree nodes
To: Vladimir Zapolskiy <vz@kernel.org>
Cc: Robert Foss <rfoss@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNCBTYWx0ZWRfX44afgQtK0BRb
 +gX8WIecwRoKrEmwdgDV5fRLrBy2yR+dejY/YQIbNFdDUsqB2H1c7i3nJU9Tdc72z/ItsbXXD3W
 M+AhJCrY81iQzFcC4+o3UhtYwQFOL562nnr5KVcQKBfyYCnLlowix7PZYkipQ3Q23K+xJzdmXiY
 nOw0o0cgUuMkUKRzq+xZ8lDpxaCDjvnCKFI5SGuG7qwQV37fpySiRDhVeYS5wtdirggep4O0wSC
 nimzgr6t9ATpeHNmiYTIenKQy9Zw8jR9XirEj6V8Z+gpXbcdutUaNuUT5Qj3VJwVgjBplgoecW2
 +4HFUxJ7SWaX7PLoV91SiN1xlRTc0PS37L5/Rw20/0Q2A3XFWmGDET8bxQxGbr/lTeZdltS+iFq
 erq5tXaXfEH3+b96C3iWa1kXfZPpIhIjfC29+wV+o/uzyg0e+anktWhZNvX8Ak51GCvg35wvAHx
 UqHVqnZiGKFox1AXHJg==
X-Proofpoint-ORIG-GUID: uYPxbLWHH2EbKi2vImrPDp1DsiiLXNPL
X-Proofpoint-GUID: uYPxbLWHH2EbKi2vImrPDp1DsiiLXNPL
X-Authority-Analysis: v=2.4 cv=G/aJgNk5 c=1 sm=1 tr=0 ts=6af1888e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=5RSu-QFQllxlmxuUrqoA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNCBTYWx0ZWRfX5a44R4bnygBi
 6Cq98cERWJhGTzqv/gK+7OfyJK2bKmdoe2mHoYjmn7rzO5i+s2tS6wRuU07iFRpuU9PbsQHvHcB
 RhXCohXJqETDSPBXTKazJjRGcyOLbYU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090034

Hi Vlad,

On Sat, Nov 7, 2026 at 7:12=E2=80=AFPM Vladimir Zapolskiy <vz@kernel.org> w=
rote:
>
> Hi Loic.
>
> On 11/5/26 10:37, Loic Poulain wrote:
> > On Thu, Nov 5, 2026 at 12:05=E2=80=AFAM Vladimir Zapolskiy <vz@kernel.o=
rg> wrote:
> >>
> >> Add Camera Control Interface (CCI) controller device tree nodes and pi=
n
> >> configurations of the I2C busses to SM8350 SoC dtsi.
> >>
> >> Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
> >> ---
> >>   arch/arm64/boot/dts/qcom/sm8350.dtsi | 147 +++++++++++++++++++++++++=
++
> >>   1 file changed, 147 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dt=
s/qcom/sm8350.dtsi
> >> index a51942c99f8a..41dff3736061 100644
> >> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> >> @@ -10,6 +10,7 @@
> >>   #include <dt-bindings/clock/qcom,gcc-sm8350.h>
> >>   #include <dt-bindings/clock/qcom,gpucc-sm8350.h>
> >>   #include <dt-bindings/clock/qcom,rpmh.h>
> >> +#include <dt-bindings/clock/qcom,sm8350-camcc.h>
> >>   #include <dt-bindings/clock/qcom,sm8350-videocc.h>
> >>   #include <dt-bindings/dma/qcom-gpi.h>
> >>   #include <dt-bindings/firmware/qcom,scm.h>
> >> @@ -2830,6 +2831,88 @@ videocc: clock-controller@abf0000 {
> >>                          #power-domain-cells =3D <1>;
> >>                  };
> >>
> >> +               cci0: cci@ac4f000 {
> >> +                       compatible =3D "qcom,sm8350-cci", "qcom,msm899=
6-cci";
> >> +                       reg =3D <0 0x0ac4f000 0 0x1000>;
> >> +                       interrupts =3D <GIC_SPI 460 IRQ_TYPE_EDGE_RISI=
NG>;
> >> +                       power-domains =3D <&camcc TITAN_TOP_GDSC>;
> >> +
> >> +                       clocks =3D <&camcc CAM_CC_CAMNOC_AXI_CLK>,
> >> +                                <&camcc CAM_CC_SLOW_AHB_CLK_SRC>,
> >> +                                <&camcc CAM_CC_CPAS_AHB_CLK>,
> >> +                                <&camcc CAM_CC_CCI_0_CLK>,
> >> +                                <&camcc CAM_CC_CCI_0_CLK_SRC>;
> >> +                       clock-names =3D "camnoc_axi",
> >> +                                     "slow_ahb_src",
> >> +                                     "cpas_ahb",
> >> +                                     "cci",
> >> +                                     "cci_src";
> >> +
> >> +                       pinctrl-0 =3D <&cci0_0_default &cci0_1_default=
>;
> >> +                       pinctrl-1 =3D <&cci0_0_sleep &cci0_1_sleep>;
> >> +                       pinctrl-names =3D "default", "sleep";
> >> +
> >> +                       #address-cells =3D <1>;
> >> +                       #size-cells =3D <0>;
> >> +
> >> +                       status =3D "disabled";
> >> +
> >> +                       cci0_i2c0: i2c-bus@0 {
> >> +                               reg =3D <0>;
> >> +                               clock-frequency =3D <1000000>;
> >> +                               #address-cells =3D <1>;
> >> +                               #size-cells =3D <0>;
> >> +                       };
> >> +
> >> +                       cci0_i2c1: i2c-bus@1 {
> >> +                               reg =3D <1>;
> >> +                               clock-frequency =3D <1000000>;
> >> +                               #address-cells =3D <1>;
> >> +                               #size-cells =3D <0>;
> >> +                       };
> >> +               };
> >> +
> >> +               cci1: cci@ac50000 {
> >> +                       compatible =3D "qcom,sm8350-cci", "qcom,msm899=
6-cci";
> >> +                       reg =3D <0 0x0ac50000 0 0x1000>;
> >> +                       interrupts =3D <GIC_SPI 271 IRQ_TYPE_EDGE_RISI=
NG>;
> >> +                       power-domains =3D <&camcc TITAN_TOP_GDSC>;
> >> +
> >> +                       clocks =3D <&camcc CAM_CC_CAMNOC_AXI_CLK>,
> >> +                                <&camcc CAM_CC_SLOW_AHB_CLK_SRC>,
> >> +                                <&camcc CAM_CC_CPAS_AHB_CLK>,
> >> +                                <&camcc CAM_CC_CCI_1_CLK>,
> >> +                                <&camcc CAM_CC_CCI_1_CLK_SRC>;
> >> +                       clock-names =3D "camnoc_axi",
> >> +                                     "slow_ahb_src",
> >> +                                     "cpas_ahb",
> >> +                                     "cci",
> >> +                                     "cci_src";
> >> +
> >> +                       pinctrl-0 =3D <&cci1_0_default &cci1_1_default=
>;
> >> +                       pinctrl-1 =3D <&cci1_0_sleep &cci1_1_sleep>;
> >> +                       pinctrl-names =3D "default", "sleep";
> >> +
> >> +                       #address-cells =3D <1>;
> >> +                       #size-cells =3D <0>;
> >> +
> >> +                       status =3D "disabled";
> >> +
> >> +                       cci1_i2c0: i2c-bus@0 {
> >> +                               reg =3D <0>;
> >> +                               clock-frequency =3D <1000000>;
> >> +                               #address-cells =3D <1>;
> >> +                               #size-cells =3D <0>;
> >> +                       };
> >> +
> >> +                       cci1_i2c1: i2c-bus@1 {
> >> +                               reg =3D <1>;
> >> +                               clock-frequency =3D <1000000>;
> >> +                               #address-cells =3D <1>;
> >> +                               #size-cells =3D <0>;
> >> +                       };
> >> +               };
> >> +
> >>                  camcc: clock-controller@ad00000 {
> >>                          compatible =3D "qcom,sm8350-camcc";
> >>                          reg =3D <0 0x0ad00000 0 0x10000>;
> >> @@ -3348,6 +3431,70 @@ tlmm: pinctrl@f100000 {
> >>                          gpio-ranges =3D <&tlmm 0 0 204>;
> >>                          wakeup-parent =3D <&pdc>;
> >>
> >> +                       cci0_0_default: cci0-0-default-state {
> >> +                               /* SDA, SCL */
> >> +                               pins =3D "gpio107", "gpio108";
> >> +                               function =3D "cci_i2c";
> >> +                               drive-strength =3D <2>;
> >> +                               bias-pull-up;
> >
> > I had similar comments on a different platform, but why pull-up here
> > (for SCL/SDA)?
>
> Here the setting was literally copied from the downstream pad configurati=
on
> of CCI SDA/SCL lines, likely the same has been done for other platforms t=
oo.
>
> > Do we expect boards to lack the external pull-ups
> > required by I2C?
>
> The I2C spec requires pull-ups, but I believe it does not require externa=
l
> pull-ups explicitly, so there should be no contradiction with the spec.
>
> > If not, enabling the internal pull-ups seems
> > unnecessary. Also, what is their effective resistance on these
> > platforms? Aren't they typically too weak to meet the rise-time
> > requirements of most I2C modes anyway?
>
> Likely you are right that the internal pull-ups alone are too weak to get
> the I2C bus functional on higher bus speeds.
>
> What's your preference on this subject, do you wish to see 'bias-disabled=
'
> instead? I won't have objections against it.

Yes, I would prefer bias-disable. I think the pull-up configuration is
an unfortunate setting that we've been carrying forward for quite some
time. It would be better to use bias-disable in the default pinctrl
configuration so that the baseline setup supports proper board designs
with external pull-ups, while avoiding unnecessary internal pull-up
'interference'.

Regards,
Loic
