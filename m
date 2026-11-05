Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793867907;
	b=VZs6j0V6mTJgem0Z47uO30UW95Q8AFYRbnWsepgW5Y97gTBh46b/Cj3ybKbuZrBI4jI8
	 +WknCVHFhBatgTliT5O5AajNPy85+7IGq4U8xsdYlqcQwKhYQi3RUPw7eDlSCgbA0zALc
	 JqSALPlbjh0oCqHBiXFbFFExDVFDCctGnYOrHOT9cOpGywPl9NHObFtD5rybItPTSBKXh
	 0IW3feUEX9baSifAfT1NkZv5BcyfxB7MIfvBqp9Hug+e/KMFxKNlrsb1or9UGzbSsHlaq
	 wuEtTYHNtnotEH9IOMrZOQwHH+U53vZYG5Vd6KVTKPsllYyfJXqU08NBywWS2EURzzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867907;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=CZU3+TIcrOhVuaVEBRSfCnpA3ZSr2HheVe8dQ5VOkHY=;
	b=mxk2vStY6kw4klF9aGiZkVUpiE9dMPHBBQuTx6nGpoToK7HPeU4CzK/PGXTyT9Sb5edi
	 bfELT2j0G/EGpAnEaRcTl21bGVnrhlKRWiGHmwVHJxgwDlVoZ53zMDdOtb84K1QRFYCUz
	 IcwU/JFhv/B//yCtnlcFhAEv0qDPDpi11kYAA23dAMFDtMnknLjXuyWxw6FAj0GvGqvxn
	 SX/Y+AmbEnNlER/RjtIqWDTB/gCSgDIRu0phdQfA58sr337NXQl3TXqfXICikgKUmGRYH
	 tzr6CJua22+pBspeFNN4PiiXdmqsX/7myk4KHV3embwniYnboUru+q5SV+dh1EDAokg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MT0bcWVw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PpAqXkri;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEC5606A31B
	for <linux-i2c@vger.kernel.org>; Thu,  5 Nov 2026 08:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EEC5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MT0bcWVw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PpAqXkri
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A58RNrZ247701
	for <linux-i2c@vger.kernel.org>; Thu, 5 Nov 2026 08:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CZU3+TIcrOhVuaVEBRSfCnpA3ZSr2HheVe8dQ5VOkHY=; b=MT0bcWVwxNd47Za4
	3xN7qRK5eT9NaFg7k1a12Nomu/0HGiWDMCDUHklSBvxgkbG0ir5ud3AQCoBkDxRq
	sJFLePHQ2zy0cHlxOUpYvglzSrCLb0Ax/wxBEPrXVJMVUolOH68ZR80HrE9rCm5T
	5ICHFA87XvLFtIN5A58VhPrP0KQcSu5itmXDgpaZfMpBSispwxEegH5HzQDs8aL+
	9uXDvfUbU+8/NbU2eg/QkdA7CluMhzKsOSikqHGhVGIEGVoRiV55orVHYYUJHSwE
	YH60u4G1SNh9tYm/p6VncNZwDdig5JFLidOhaXyfEVPmH/wGqQiKaHYZ4Ye0dqAp
	5arn6A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrpaag1hv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 08:38:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93e49a1d3b1so414458285a.2
        for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 00:38:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793867904; cv=none;
        d=google.com; s=arc-20260327;
        b=qCcB3t/eT4BhKqkthGws8wbdr3D/SWp/vbxn8COu79R6+oAGYPzImSIyLF/DpBD8wb
         WQYuwUErZhGsT9LgG9sb9zR3f/m0N/CPY/YGeQtYFKMVgSnc7bUWkAtE8QE4dC+n4yFY
         rUc2hpdrYrqTsRU3s/6UMxay+EAiks2cNFOXBJMM6wVMMGquMVWSPEgAD2kiU1hJ+DA1
         ILvxS8VUvgCfKR59sru4RWLT+K9y9HqTpzAwwgW0tSiqBhRZUHeGCtafIV1ZsDYa+AfS
         F5xD6x4A8AA0j+NglkUn1xtQtTp43sPEj4AZIDahyHWCI+Ws2mYYwxI5EhK1tr1wErsN
         wRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CZU3+TIcrOhVuaVEBRSfCnpA3ZSr2HheVe8dQ5VOkHY=;
        fh=qi4geYEgYo1h+qcryRQs/avS6ZQav+bsod8Ihw0PKjU=;
        b=AH/9LpejqGMiAx2JaBQCrmQHccSx39BtRL8nREKPqH6FWKiWvr2try0D8Rs4zEBWcT
         +HPRMY1G5zhre5XbDZeye1RtDlXnn0e0XfXOn/0+1yRSVQ/9G8Q8VcKTMg37tsbEpX6Y
         5Fg4oaK5cedHj8AgEuq/i8ajEwMgxK0AKjH6HwnNuYI64CXhCttuTu1by5HJSxFcYsB9
         KVCJwTRBOZRVH5Em7r3vbMEMFxEhc5kyMAwDHyMLxDSE1IDaJV7G0hDER07vXQ/57EpS
         yfk7Suh+jAIMlHOsUbJFhB+A+d1MM0pEDNQX60swPLwcHqQHEQDgGjh093x4Iqbq6e0L
         1WWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793867904; x=1794472704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CZU3+TIcrOhVuaVEBRSfCnpA3ZSr2HheVe8dQ5VOkHY=;
        b=PpAqXkriQntDrPuY3ZICEBJ/ozr3kUcuGRVFjg+8CJ0rloo/ucAdmx8RtCdzVN0wlL
         uPCkfD48XxOC1XH50Q31GSMfoPelQJa60IWGvuy9SlFU+pKM7xfFxLsBXaJoZNVO6v0o
         lTI5jx6s6sc64KYQ1aFq70PfyrX1EnIVLVgfSxYX79JrAgZTLXn8QF7zlZBSEPqC14yz
         C5XSTCybAlmO1mgnlspWgb32Vigu4H80fSNRJnKQ9zTw8bE9nUX+h9c4HcfzAFFVu5LO
         fEtVR5dvL5sBqGNfenS7rjSEXfc5iW4PXbX+NtmqpT98JaMdBLEzlvPOTY4ImFuTvjNc
         9Fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793867904; x=1794472704;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CZU3+TIcrOhVuaVEBRSfCnpA3ZSr2HheVe8dQ5VOkHY=;
        b=cNrmXyfBYh/EV/bZUoJPOPI20W9Bj6N+6U8xZlyHH65NLsfnB4POCaRrAqufGR31GC
         3biecBZQ15PTirg9j1a10DFdsAWfC/TqpoM5kfh6Fw4lv3k5grKqxnjT/9BqZvc0IqOo
         IXhlbkYbYSQUEkSi9dOBGvQOLrDPc2e6dmw9j9NwpKzaEDz9UTvCeysCp4BC57iFb5ss
         tkUiwk+77ZVThCE4qEJRYJk04zK7ngDfjaaX92tjXcMFlQQ2vsU9sGfNWMGgpGYteUJ4
         voZETlgJuVhOlp9G2fsoVJinJrOIqqlaNt++xp1WOz0ieepJ0t51zcgBT3sghA2H+0U3
         Nm2A==
X-Forwarded-Encrypted: i=1; AKwUvBwvdJGw1nbLUIwt1aW+HVqgMk6yDu687H086pBr6a8z2SS0kfdg/SyoIurTTm+P5IOE3sMUb9jRg6g=@vger.kernel.org
X-Gm-Message-State: APuU4Z83u8uOmnW8MuOGkXgp0dp3Tsfv9kEXMNnGUQ7F6bz426xHfrVC
	1A3SJLY/7uNbXR1EmBmaz/u4qC0HDNgf+PykL5QPUXD+HNwEP0x7cXBm6HIB3T/TxrFebOpCFKv
	rU39kRgxqXNwOB7XAvmWYroy32hNdc3hk+rcP2+3bw3sioW9i9UMDhI9lNn96hdG0W5db/0NWe9
	hvUGmfDoGiD9YY00DVEdW2v4s4qqsqInjbDovYrQ==
X-Gm-Gg: AYBFou2/x5TMlx3XSRxj187LUpgdpVC9Urqs0RkoHYqeR/I4CPhUy8QUKIOhJgTkhUd
	gnhKaAbPeOkrD24gBGahZXRxBgZSbErBdkdtOZqGDHeheWd9xzsNe1rcZBfvhjWR8Erly9cIpJc
	xV1q3piG/JMnO//HLjIZms5ExDzmyU9+ajwVTu/vsOmCdsTUith9dNxjBnmCyj36DDyz1CRPOlf
	8ZEEcMWc8A3RJ3YFBFjJmIqtDDrdmAbvgQ4mTtGmTy2seIsnQW1MOrR1MBUS73vzbmHKAtAjnrv
	wOh2B2wOJC30kPT9cTcppNIUMivh
X-Received: by 2002:a05:620a:444f:b0:93e:6620:bde7 with SMTP id af79cd13be357-94421712a51mr3342705085a.20.1793867904577;
        Thu, 05 Nov 2026 00:38:24 -0800 (PST)
X-Received: by 2002:a05:620a:444f:b0:93e:6620:bde7 with SMTP id
 af79cd13be357-94421712a51mr3342703485a.20.1793867904183; Thu, 05 Nov 2026
 00:38:24 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104230529.3040285-1-vz@kernel.org> <20261104230529.3040285-2-vz@kernel.org>
In-Reply-To: <20261104230529.3040285-2-vz@kernel.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 09:38:12 +0100
X-Gm-Features: AclHuK_XOYAY9o7oM-e2793fJtzmXvNCrEJQLGGzCvifJ5wF3W3-wOy2cPxKVws
Message-ID: <CAFEp6-2sv6AJhWqABPzQQcfv84j3VrR6+_=wBst9L5GdNZgQcQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: i2c: qcom-cci: Document SM8350 compatible
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzNCBTYWx0ZWRfX8pRsPdvpqvC8
 7hRZ+jN4CSuebz5OYOwDu2LuMG6WZTxtFOEv7ImXwliceENbBDvtgliU9mGa3fTHRGoVKjVsCtr
 cwfcFHeVr/S2ZxuMhdeyyvg3JUfvjnOuioYhTkYY9gQla8mh7FZnR8MUln4MNfHaWH7b9KB4p0p
 7X54xoTxv8q8Q19IUSmwFHJDG4gc5PfDhpu/+pzTUkZpXtIXx33S+UMrCa0HR6o4ooivbt9KdRK
 mrzsSn1f6Y+TOnMARpsQ1Pjpel7yjSG3OwwhNkonl96b9FuWSulf2bYGmlzDp6AnVXrH/sCjiWY
 vBWYqRaplOPKM62L2dkk/dPwZKffNxRyGw6FBxxPxEwfW2+XZKz5yncn4ZSNj/qUul+DmcIepIa
 R07cMhtP849Vs2YSdi57EtkWgLxjGWLs++aAmpiHgvb9rqjw2+02lVcQuV7qcKCSxYr9fMy7isN
 2YCUXzKlf/ma1Y6/MYA==
X-Proofpoint-GUID: Q6iZAMR8neBYjD08LVXzxhl8XX0GRdhL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzNCBTYWx0ZWRfX4BADdCz2/fy+
 fFwPTaUU1ljNhgJoND9puJH0HOxXeoZNmsXK3HXuo3cADskZ7kuz6MrbLQv5fw1Cd+KWsl/ovM3
 sQWIXrLKhBbKAeLINZH0mjpdREOoN0A=
X-Proofpoint-ORIG-GUID: Q6iZAMR8neBYjD08LVXzxhl8XX0GRdhL
X-Authority-Analysis: v=2.4 cv=WOXqzXsR c=1 sm=1 tr=0 ts=6aec4081 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=-vm_nUme4f6pGPv4iSwA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050034

On Thu, Nov 5, 2026 at 12:05=E2=80=AFAM Vladimir Zapolskiy <vz@kernel.org> =
wrote:
>
> Add Qualcomm SM8350 SoC compatible to the CCI device tree bindings,
> SM8350 CCI is compatible with CCI v2 found on MSM8996.
>
> Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>


> ---
>  Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Do=
cumentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> index 1e8def25ec0e..63083e0bdd9c 100644
> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> @@ -40,6 +40,7 @@ properties:
>                - qcom,sm6150-cci
>                - qcom,sm6350-cci
>                - qcom,sm8250-cci
> +              - qcom,sm8350-cci
>                - qcom,sm8450-cci
>                - qcom,sm8550-cci
>                - qcom,sm8650-cci
> @@ -219,6 +220,7 @@ allOf:
>              enum:
>                - qcom,sc7280-cci
>                - qcom,sm8250-cci
> +              - qcom,sm8350-cci
>                - qcom,sm8450-cci
>      then:
>        properties:
> --
> 2.51.0
>
