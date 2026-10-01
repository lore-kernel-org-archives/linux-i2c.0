Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642DD42BC5E
	for <linux-i2c@vger.kernel.org>; Thu,  1 Oct 2026 12:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856882; cv=pass; b=Iz/wIyuvPGTX6KKgtm9R09spLXylGMARlWll9+fYag42DL7iKHzm2xKegY9UgHXJvSot9FTWZ2zanaGmmC4dr6S0vfXDesgACe6cIPKJyAXYegMdtlRNS6Dgdgvmq4a5Tcj+dAsjOymC+PDZt8xdn1hue3KgVWs08ZgT3aHH2w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856882; c=relaxed/simple;
	bh=GQ+mO9FqZTwGcpM6upiyjFp46GJQt7lNaQI6Ua8Mn+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bt4mH5P/QG4DVrSDQLjRnV8GRjtD5OkJIfdjiZq1f+1buGQgCmvP1pkn9xGk0HT/6dGrqUAuJfx7Uyrm1x6/aO2hAs71jujUYDVBiuG2F9GvUMG/LpovyYkt+k5HTDUg8E7/Qat3wYMbSV9P5eUK0nDeVpZOdc0yc1fZQLym1iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ix+QKi5q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dCtO4muj; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ix+QKi5q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dCtO4muj"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6916xMGY1062173
	for <linux-i2c@vger.kernel.org>; Thu, 1 Oct 2026 12:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y2V8uPC0AzCmkid0pU7KtPQteVbme3oQvQ9onokkXOY=; b=Ix+QKi5qPV1KtdYU
	Fd25b3ki3mnYwBCEfyyo8hdnic98d5QIh6iuvE6YaWGQ5wyjxfrRUAtvFXTy19dR
	rciV7KX7QI24gLaKN1mcP2EKic2w47fzakCeYc7x9r0OAjhiu0zuewMAp7rCOJfm
	PK2uj6B38BTmvItLU4ryTowSYZxZ0iaaMokEpxDNVywufMAGE0aXRWrUIBx0j3lU
	J9fs4CYlvJYIlrwm0y9UTz5vf0uvZPnMnYQxXS2pdmx2tFzw9WfuKT6wK+c5e+7O
	azYNBplUrf1peMWraTpwUdfDTrMB2j0fkv2CM4MsUiAdPa6hXZ6gU2IlgUXy0bMJ
	etfVfQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h17mvus37-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 01 Oct 2026 12:14:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e82060977so92603485a.1
        for <linux-i2c@vger.kernel.org>; Thu, 01 Oct 2026 05:14:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790856878; cv=none;
        d=google.com; s=arc-20260327;
        b=gOfsKVffTFfH6d73nwFZFm7VZJEgU5LZoJ8M3/yZiz77GszWeUHeV8gyyAbDZabSMf
         mQ7HRbypigXDkJkYV9h3EgFYOQ63vlt7ZVxOs0j4xEyzWfOd/3S1OMteobBIDqPFdxMO
         VP9bsQrEv8yM1jl0M1sUJoGDS3mXpriukXUopC2G7wbGNwuLQ/tb+iCv+4HlvY2qNsSx
         EqSqTQbaNkfQ8KqKIa32d8REDf+DLY9jaEQ+upq7SHcxLcUtBeutlAr/FyGUv2dv+B9Q
         wQ37GJZZgh5wJ63VF7WcZ3V3CYyv1fDFTLyWNSLcVpNW5ZPfEbG2oRUvNbPd4X9lJTK6
         wUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y2V8uPC0AzCmkid0pU7KtPQteVbme3oQvQ9onokkXOY=;
        fh=7V4f5d8c+FTSXL6KCL7HpYyqxn4qn2m8VctegdrBFmY=;
        b=iP9Y1N/QkvJeHrfwWjrxSVfSqDVuBOSa3NAfB5BIAzsdZCZ5oSjbgZHF6Lp4EuNWys
         CB05tPFQHFXlBI0HV2UFEqYLutuWd0QJY+I7DrHxme3O6/P2tf5Yqkw2llG+NN3H7xQI
         YBBDBPF9pBBuC2Ipb/lKzOZYuHO6D9qeZx6nEcMH9JZH+1VUDxwSrznp0mSkGr1ciai/
         NJ3VLva7fBLVGP52DUvxeNCUeggn0SqxLqMW5u16jXwnpmolJU8rbh400FHX7H1i97g1
         lRFkKq3G9YM+WiA4N8aiwbKHJ0h56FD9E+/VUg9H8NggIn4qeG/Tj6pW62w76W9u4VcD
         EVWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790856878; x=1791461678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y2V8uPC0AzCmkid0pU7KtPQteVbme3oQvQ9onokkXOY=;
        b=dCtO4mujndbEcqcughlEHpHAB9ClpP71TWr5+XYy5XAR4HoQpiTgeBIgmzyY33GS2w
         pPh4EM3v1HhBjVFA+GJmuQEnOZqUw5flMFk2KNPHnEoRwCd82Cqnw5pnDW21v8OhPulD
         sK5DIT8uXzlkz6VPhBXTe7YKRjV1n86wuf7kR2Vb9ZYvN24mS+9LrhAlypV0UYLBatTt
         aJ6nQfjWUz35KBm2urdIMUhr8T7JcTLF5/mm8VW1LXYxRS8oifyfkcaHGSUpafI49ZDO
         PUkekzThVDjJYeCWUSye1lpkmMB4ghi3f8kIhaVl0DSPhYpZXAuISMQaXTNrULXoTpB3
         H7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790856878; x=1791461678;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y2V8uPC0AzCmkid0pU7KtPQteVbme3oQvQ9onokkXOY=;
        b=OMG45lNAwktSrQkw6ungctw0+u+VfzFFzQcejMWNjXR42wV0XrqjHy3ZcRCSDBsZ4C
         V/GX9yXV2Ozp+WTTdR2H1N0TB2o05ml6fcUByMLUKlhHRAIUKuIdTNNi0q/kpbqmyAtF
         R9aRhsRm0XuRw33Oo8GLJE5pchbDVV7bRroPIKjBxWKUcHudtUOXNICMiEV15eaE0EdB
         2ypAqFCBlUyfXFylAyIroLe03zaNVXTYvjndvnZjqB7iw3iZtT7ewcBMSw7bt9WeHIVX
         9FdxuzIp09yRy/gH/sk+WyYi9b0Q65RaJQUXmJT+/DSN6PjW+6kyaAx/dAepDUQtAbxb
         NgRw==
X-Forwarded-Encrypted: i=1; AKwUvBxeoALIa2fEkGAA5lyjlOfoHgFUU3S9tv4veFFmT+HpHfn5yp/l7sGlAfFznXbXd1xLf6s8OUCCawI=@vger.kernel.org
X-Gm-Message-State: AFuF++kNBTWSaR/rGzNai7hvEnIH1hdPllGjoIP8d5dwtI9WQBMuGeUm
	6IDiLAu+73MUiucLXEHN4TcRHRGtXWJEDyUyHALaEajnnU7PnG6VxE2LCmwKMIQkG4x4q6LYEYf
	UTVnstfbQ8/6X0HyOF39LPORi2lCn8wMm+hlc/mYLfevtbaAGhLAwHKvcur8yaPFn/IbLUC+lJo
	t6sINNw8/cB+hD8UlbAnPYsQfbiUMVMlzboT7OYA==
X-Gm-Gg: AYBFou0eZb41hzD67r5mdeK+lTmcfROoCEbHa+12tzg+lSobHtONRqt/RrT1qgwd01Y
	U104CsZDGwgZWvKKyqthkFs6vjvpgFgazabJBE/0LeE77kmGBfJJByrrZxBH4pX6Ao5kTPSEC8e
	HNfFibAzIjgrkmUE1ANJnn13kTWNkElT8ViFmTNzj44xrOEAiwRnNSS2ihU4ibOkQJCMJPEERuR
	QIDOdvnO9Ggt+yot1l7l7uF100LI+3meCF36351ay/u81DC7bsvXobTGtbTBLUdWzdBAcQ0SKWX
	IWCqXL9kPvbMToW5+1FrG9PUJJVw
X-Received: by 2002:a05:620a:40d2:b0:93c:bb1b:b6b7 with SMTP id af79cd13be357-93cbb1bbbaamr275240385a.12.1790856878438;
        Thu, 01 Oct 2026 05:14:38 -0700 (PDT)
X-Received: by 2002:a05:620a:40d2:b0:93c:bb1b:b6b7 with SMTP id
 af79cd13be357-93cbb1bbbaamr275234585a.12.1790856877804; Thu, 01 Oct 2026
 05:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-hawi-maili-camss-v1-0-cbbb42e534ef@oss.qualcomm.com> <20260923-hawi-maili-camss-v1-1-cbbb42e534ef@oss.qualcomm.com>
In-Reply-To: <20260923-hawi-maili-camss-v1-1-cbbb42e534ef@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 14:14:26 +0200
X-Gm-Features: AclHuK_XuSX4ZePWnnpee2tgGkBBnS3UvugT_wZeMdgt7PGi5qaYm1CjHnboJlg
Message-ID: <CAFEp6-1Zvt0hhBd7LNx2hsyi9J+bxCT8EWN3jZ4B30SO58SCow@mail.gmail.com>
Subject: Re: [PATCH RFC 01/15] dt-bindings: i2c: qcom,i2c-cci: Add Hawi compatible
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Bryan O'Donoghue" <bod@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: X8VqwOb1BKjOTQm31SaeuCZZlQdSZKoq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0OCBTYWx0ZWRfX1cz6uHt7PVgp
 OhWErYDUm3zBJNZqe5+vyqecHKGrl38FObbHLVHV2mLdvQ5gMWuOpwb5iAN1SVo0YijoAaMwCIe
 /nAgDreY1EiVya9E0s/o018D3tPdBbkAWVPNk1uRObmp0kFcRI1bgM9oFlgQujL3RcLauV8fH5t
 Ds5lmOmQq+SQdYyxATXrR58hS0Z79G5GTRaweuQIb5MDgTaWEi5BycU4luoNGrQqnagubw4+2df
 5G5KnnPWfTVfRkLJE9eQDIgB/1tProvHCkjYnsQ6U6qDZgHGm3O5LGVKhzWDa83PT6k8rL/72g7
 u6P6n7uugM0j10M5kWtEuvu76WO/2HopeGSN9fg0lwU5NdIpW/xe5o5arWev4vojM9yY1/DivJw
 Plsw58bMsCBiBgiAeqD28G+WT79gg9VYGdICVrHqqNpb/Ofg1Blv0Zg7CadnuAagN+f7JXxPPgW
 VgCjMjQ0XVq5um3UlZw==
X-Proofpoint-GUID: X8VqwOb1BKjOTQm31SaeuCZZlQdSZKoq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0OCBTYWx0ZWRfX+IAALHyjsiAf
 swcP0eoO6sy+YpkUjaxQhG2peh48yIrw4s7KwijE6v3MuZ4nmnxWfDWHiFUBjnhsZRcuKjLZHux
 VdkGq7NfFmISx/vIdgILpA2C7R+SCT8=
X-Authority-Analysis: v=2.4 cv=KuvYSmWN c=1 sm=1 tr=0 ts=6abe4eaf cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=R4gLiKe44IeHqeJXRIIA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010048

On Wed, Sep 23, 2026 at 1:02=E2=80=AFPM Nihal Kumar Gupta
<nihal.gupta@oss.qualcomm.com> wrote:
>
> From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>
> Document the Camera Control Interface (CCI) compatible for the Qualcomm
> Hawi platform. Like other recent platforms it requires two clocks, so
> add it to the corresponding clocks constraint as well.
>
> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Do=
cumentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> index 1e8def25ec0ec1ef6b34859709d10a2a36fe36f5..b2b4d4bcf780792515ec153c8=
73bace1764fb3e3 100644
> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> @@ -27,6 +27,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,glymur-cci
> +              - qcom,hawi-cci
>                - qcom,kaanapali-cci
>                - qcom,milos-cci
>                - qcom,qcm2290-cci
> @@ -137,6 +138,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,glymur-cci
> +              - qcom,hawi-cci
>                - qcom,kaanapali-cci
>                - qcom,qcm2290-cci
>                - qcom,qcs8300-cci
>

I think we should stop falling back to msm8996. These are newer IP
revisions with additional features and resources, such as different
FIFO and queue sizes. I also plan to submit packed-write support soon,
which will rely on those capabilities. It would be better to add a
dedicated variant entry rather than reuse the msm8996 definition.

Regards,
Loic
