Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D9836E49D
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771346104; cv=pass; b=WgRlAa199Vh+xqUVZlWlGL4CxyP9vz7b5J5hUw5tPjw4WB+ZENZbt6z3kKT6lU6gtBDDHttgmXXBZETUbvpPb9pdsOA5q01G/R9SrZFUlY/xc+qU30RAxf4bqe/id/T3vGLOKqbX/yF/z8cywGCp5NsC4yQDpwP8teXF5a0he3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771346104; c=relaxed/simple;
	bh=fOduQHfnOBnWN0eyuIDOU1ydKPk/q90IXpg/RDM1QR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewFGa+23wVaIxc+zoqhco9r9rdHsjYx9EPf1cGP3nHkwFboxRq3apwnLuDTpjXCPKzEYAyvtfeyDxUsjshzhUbr0ZmSmRwHTzXt5D/RoqdSK1+q22xAupvEkAa0noYF0ayzcG4lBjy+lNxzayDLRccwQzokoQ+JuqaWZQm7pBas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ntyiyq00; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jv0U0c7v; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ntyiyq00";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jv0U0c7v"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HBMgJ21613313
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 16:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PMRely7AErEzRnlh5Io/kCgcffqQUskngQe8L7efOeo=; b=Ntyiyq00RWaM+fc/
	TUC9DbjyNOs9Japaw2XM8AzuljQaLriO0RaRNhzZ+M3n9GsPJAarbHbNpp6/PEET
	gseZBFEhAk9PFvKbcuqIyVLHbWpwFEMFeIDirSc1YSbOfN/yqyinzYH9i+VfCdBg
	kDFlAw9zf/CAG7A/WEcdtMn15P6upTitTGeFiniShyJXTSG7O3j8MyA8aIcKzfAr
	Q+7Tn0Vt/pa3U6/q99jGevTHoj3vd8AP+ffcTFEdEK8hI/K7CbzPj0WWTsiqxGVx
	UA8XNebusAFfwhYn8V64fiLlKGkejzO6A3SOPbVqMXcxcDe4mkWA+RlmB/lg5Dya
	DtxXDQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc662u5em-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 16:35:02 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-506c0da79c5so269369651cf.1
        for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 08:35:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771346102; cv=none;
        d=google.com; s=arc-20240605;
        b=TZwweylu6kN7yqPXPA41s9TCllN6cfEdKjDH+sktoXuMJnyuaXAogIjm6h3gxnqU4x
         ZFbpIoexKg7qBjLSIquCwIZkiB8ACaLRbnQcS/SCPRzj04OJInPMjT/Sqo0fWmECJX0a
         KTuMBCjnMCaMBDhxQEDzPRSBN3fEmgqhdWOlCqfMVeOCHCqUK2XKbI2holFEWw8M3Nv+
         2Vk+9FlgEtcult6bmZnsW1kvmFA83SeZSkhagzQZcPPu+s4APm+lQda/tsyG36K6e9nD
         15IipI78i73rAhXK2qMacMMkJ5TUcbi2LSD/KqVVOP1pRsRDNGLX3EVUo9tpF6KqC7ly
         04OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PMRely7AErEzRnlh5Io/kCgcffqQUskngQe8L7efOeo=;
        fh=VfUGkBLTHFDOIBNMq1S9d70Mv0Di6fe/u+C0s5q3Pc8=;
        b=SEdkJC5Zm/pp7OjKReVkfRd2ybnzfeYlqBYs1eIHzeHoNt8qrA3BDHsHRixokR4x8w
         DX/dAKJuDvDPXQzv30Yknk7IMPxtmmyOUndmf+0bfsqj9yd4hoKOm1v71LGCC64dzBHU
         kmFu6mwRGnMyZ65xx/qqCY0bc9dhMwuM2OLE0u54MPOqFw+cxA2B4+NZoDyr50CJDRYS
         wMhkdtIMqpcXyQGQ2MGFOLAM7aBVE709CHjkOej1+g8IAyGHbW2/vR1UwknqgNmMoMna
         CZdw1VezaborsInx7RfYL2DnKkoFzTMPtbWAXlIDtNFzO25W8iEqEjNcAJaxyZoQLCR+
         4tWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771346102; x=1771950902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMRely7AErEzRnlh5Io/kCgcffqQUskngQe8L7efOeo=;
        b=jv0U0c7v3kBIS3xZr/Fpl9OHCwiHk/0345qjt9aqm5ImZAY+H6kNo8/aoYApoGV3Sx
         wRoJgSgBqmUyWV7zebznE3oeD/NvddnlppUWlAVQOGG+WF1B3M2BQNZA2lHKBn4E4+3T
         Lv0pIGEEJpdd3OzN6R9aUgoXrQa+Iw/O6/KN9boZ6x8tQET5Un0zmqRSdAjQFbLHZohI
         bmaaYgRBigGMLnNqT6BYZ2XLHnP8rEmd54wy24Ey7LjfxiemKs+i2VvjPAJUYIL+Aqfh
         0KjJaEezQEqLTyZyiEGFJAdGkATWcPIoFpj/sbO0JI0/Tca7yrqbjPrO2VyEtBxyTIJL
         05qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771346102; x=1771950902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PMRely7AErEzRnlh5Io/kCgcffqQUskngQe8L7efOeo=;
        b=DeuaYi2umbrGSoH4JphLcbrywsUXzmOKIkVHIWFZw+bJSOJH8Is6Gvvdvpw23zkyYN
         sm/8QZO4orFSw7O5BaurOgveawSW/eTRvSHno4V7vgRwR1ZIyvMowgDBRO/e7YWPjlr1
         92zTp6XBIe71H/sehrENEGSD/X6R1Kxdv4b6HZaRc2+sJ1gXWjX5YgYKzY+vnT89dhRF
         yLOgx8T9dDz/kddzV1Ix7MIyU5yhneLShbn5CQMfqyXHC8XRX0bUSKKJF7KUPQbdIcEs
         iUQnIvGUTsC7Hk7Beh24KxevcXAGrjUNKAQwPbOrrcPVJSKLhgWSY/40Bdxs2RzYLFsG
         PriQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/FgfWY902sgy08XpYQMMvpM3r681gAU6Lk0r/ZM0hgflKe2Y0lLPIwlT6cr687LK9SZXyqm2+lkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCowAh84JwIjBbe1Nb9sDabdeEt5P/OiBlaKr1Bi5FWxhunoPr
	W80o0spTn2VDTZ6YVwpkHXakV6Hdm8kaT8rf2rX1abemE/vBknWNdPSDtCDgITK7oI//aATjoiC
	1+I7GsI5RnexDN5AhmnsrXCCfUlUTcSxqcOUS16sDEqmkVowkxAGaDIsliPk3xv64zEop4d1lVI
	zcsA/SScUKRIw1/FlWNQtu15icyC4n+yp3h4/pRg==
X-Gm-Gg: AZuq6aLmX7e5e/LGeDgGr2mU3YnjeTenq7H1TEHCvDjaEG8GpcxCh0RsCTDTXFeJ/Dg
	FDDkgm0YHP9Sxgss5aMI3ihP3ZUVKaMqT9s4Wug65tZHsm4d7DrVxNwKWmgZbxdV3HiD6fsyVho
	/KsicRQUlMcTQ2/1vNWshraAHaGshzHX2Ms4v4YTbny7lTKXhJEex/DCtw863E8O0kpKyvUrAzN
	iFHQTRr1LH2d6eq/dQl9f1u8x/EsGOjdVSEJRlk
X-Received: by 2002:a05:622a:19a0:b0:502:f07e:8569 with SMTP id d75a77b69052e-506b3fbdae1mr151322661cf.35.1771346101957;
        Tue, 17 Feb 2026 08:35:01 -0800 (PST)
X-Received: by 2002:a05:622a:19a0:b0:502:f07e:8569 with SMTP id
 d75a77b69052e-506b3fbdae1mr151322301cf.35.1771346101540; Tue, 17 Feb 2026
 08:35:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213132058.521474-1-quic_nihalkum@quicinc.com> <20260213132058.521474-2-quic_nihalkum@quicinc.com>
In-Reply-To: <20260213132058.521474-2-quic_nihalkum@quicinc.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 17:34:50 +0100
X-Gm-Features: AaiRm52Qb0GupIhPu3JDqFomu65fscXc6lKfjuE2PWBiawURp4h1BFYQGueyox8
Message-ID: <CAFEp6-2N21rzNADxPyaLTO4N0vWAoKU13oQueRsC9Esrw-BKOg@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] dt-bindings: i2c: qcom-cci: Document qcs8300 compatible
To: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
Cc: bryan.odonoghue@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        hverkuil-cisco@xs4all.nl, rfoss@kernel.org, andi.shyti@kernel.org,
        linux-i2c@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        quic_svankada@quicinc.com, quic_vikramsa@quicinc.com,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEzNCBTYWx0ZWRfX6e1/Te6FGz8o
 rysz/UkjnujxpcUAHLK8BymFoaf4M+Q7cUXIsVff794qAsI0ZbfoKsglR7SvOZaZ3/4S/lXzRhQ
 xvymwdardwQCNO8/OlPVw0WbBiXPEIAc4Pgej7bdmpDUAFfOkHnh3s5bie1pxeBDBzpxxbIqBRX
 xtafvLQ+Ak0nAwYklJ6/5gFaJVxg9tW+qI8XTiH4qGz9qcQUffeZqlz8d6IuPjHRG+A24UlB+Xt
 CYmATDe+YuUcVhN/GpzXTWdiQVkei6VL+KgSHoxUQj22N/IgCRUAcSpRcL0XhQpyibvfs1dTQe/
 DeQIB8s3S5z68Vt+ROJMktWZjvYNMnwCg7TFoWdghMhAQQfmxdPO3mlbC56EEEfATHhvot0puqr
 p8cv9mjSgv/mAqakRYOjl9a3RWTwQEV6p6kt27vAozVKYkzHrmrYDZAoT+GcZuNfqgs22NMWcL0
 kp+0nH2nYS/cwuK/3OA==
X-Authority-Analysis: v=2.4 cv=Y6b1cxeN c=1 sm=1 tr=0 ts=699498b6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=SK6ENzGRsuaxshVCMHcA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: tM58Qxc8eD_2MJOo_qu2fe9xNFtzEpFO
X-Proofpoint-ORIG-GUID: tM58Qxc8eD_2MJOo_qu2fe9xNFtzEpFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_02,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170134

On Fri, Feb 13, 2026 at 2:21=E2=80=AFPM Nihal Kumar Gupta
<quic_nihalkum@quicinc.com> wrote:
>
> The three instances of CCI found on the QCS8300 are functionally the same
> as on a number of existing Qualcomm SoCs.
>
> Introduce a new SoC-specific compatible string "qcom,qcs8300-cci" with a
> common fallback.
>
> Signed-off-by: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>


> ---
>  Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Do=
cumentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> index a3fe1eea6aec..399a09409e07 100644
> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> @@ -28,6 +28,7 @@ properties:
>            - enum:
>                - qcom,kaanapali-cci
>                - qcom,qcm2290-cci
> +              - qcom,qcs8300-cci
>                - qcom,sa8775p-cci
>                - qcom,sc7280-cci
>                - qcom,sc8280xp-cci
> @@ -133,6 +134,7 @@ allOf:
>              enum:
>                - qcom,kaanapali-cci
>                - qcom,qcm2290-cci
> +              - qcom,qcs8300-cci
>                - qcom,sm8750-cci
>      then:
>        properties:
> --
> 2.34.1
>
