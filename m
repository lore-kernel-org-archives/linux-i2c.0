Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B882F339840
	for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 06:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769151240; cv=pass; b=d88cjhScjMdddh9+MQVZjAKawpSmAm6YBQtHlDPpx0waReyLwhAipNzONTghYttV7IRhsE0L222gTGn12OGdWR9jc0SwFTm1J+4l9axHNDsh/Apl1vJ8nQpU9ubEX7fFpyiVZ5iCRB49GuG0iQWZH4VBfV7NMdGXvM8CoHQUEmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769151240; c=relaxed/simple;
	bh=s/FYJs2yh0Mn9e9zJI3uFU6aHvmEISj88LdCakLhM38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Icxuvqhs7VK91RSzp/K7t3OOvcA83YBIqVm2obPg8o4YCnS3igcMolldGjlyg/jydxGhJbWF0ZhA6DjLM6wsUdLQRnLJrr7fBTlpgzBi0DD0wHJv3QN6ikGxvT10pkLKfPCXpUkeIg+/pp/PVtvrck4vfXJlZb5frwDE7CtWQWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b2/i92SU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V9qqrN8F; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b2/i92SU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V9qqrN8F"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N5I0ks3705183
	for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 06:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s0VLzkj7kBAIvIeyO4Yw8QzJDHtyD3yHiv4q5/eKWxs=; b=b2/i92SUYiaESdwo
	VjpgHSfUiI9ApnLF4g+bN9LAW7zupMgnhCP4F9o8tLoJO7gv+VIdRuAgKrfweDLy
	YiZLR7ffNcNbVFBysSa3ZrZ0kOuzbK4SK/MykF6F/4rmfOTJy/xFloC7XR/3Cm7a
	00MPHEI8J1dbYMJ/4d2KB+bpBTZ6ZWt5ay5qh5w2ArRGpwyGy5wTEDUuU88a9ISf
	RJZcc39lq2fkNIq04SmCjD7HPi4JCp8INMfsq8smh0uOtBljMhR81ImMqt7kjgJH
	onVApRORNsJUohMQArtR0lksWoi4QJHICWbMkiMzJi91TVVjajjnQ/R5efOFfgxb
	Ijc6AQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buuaysnr0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 06:53:55 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89493622b50so4352896d6.1
        for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 22:53:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769151235; cv=none;
        d=google.com; s=arc-20240605;
        b=eepr54LfSVIt2K+uBnxLGKRDqeG1I4o62evLw/QIPYhoQC5SXnWPP8/YZMTZf2crop
         FE/PNQaDPUk25dkWYqhXRvRKM3mtGpKOHQVaOOQGbUx1HxhwyTl/QEfJgWntIiscy6o/
         3nACCMyp9DwidnSVdIYCTtsy36wcDAv+hOWZ61TgSzs22AJmvOUcQF+Y8xL+1Mw7/QxH
         Lc2WbOqymux3dkBi0G+aR+WS4aR17RRv35S++PT0JQP5P6ezBNBnP5DZI1uOU2I5snbc
         yZ6xQ0t9N/BMqrhYbbxOmCVD8/CKIA/2ci3x0LQ4D5+SmpG08b2IUJTnBh8RgP4QcXxm
         e5AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s0VLzkj7kBAIvIeyO4Yw8QzJDHtyD3yHiv4q5/eKWxs=;
        fh=umbfbWKGafJykf77CgiaOCBTzIEu5cjuck8I+2OjmGY=;
        b=L8ImrBxmGCr/ACCNLKv4iQWAlpItRCphuPtcPrq93o6HL2a7qR1KWPUCQzyt7crjDT
         D1+7FikzTTFYoJz6uIkXDIVhAguTXpkyizJJesGtkdUMhr4bT9MiaCuSFNHXesF8Gchi
         7/5LpXaJockSPjaac1yROuqpFj00RA6vB0EL069J0fdPE4AG1pwUFdF6EGvARYvVT+CV
         bqYNGnMbMf5//ixxAqzhrIWBmrTvRapl2m6vAfIPLAqaPN8GHuV7+s5AUnN/HQHVcrGK
         xXpwhCl1WaWWxjN9/tsThKBRi6H5HV1/4TGWyFFe1l5OVDuYCP2ujz3hrpbCYkiJBlHc
         NAHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769151235; x=1769756035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0VLzkj7kBAIvIeyO4Yw8QzJDHtyD3yHiv4q5/eKWxs=;
        b=V9qqrN8FeI7bpL7z3GZmcvB2xt3DwtUM9ZL+YQ9s08CojxSeS4vSxglBCIwksTKUWi
         w2lvIDxcMdbw/07m30Vf+6AINY0EDYvvbV704RJPIvkg2VzGHkCRMN7GvyIN5hWmTtno
         3F7Nm75V0BS2EqiwluXv1XuFdNNfHGy8Zf/ZcTVlFEocdd3FETgjGCKumZM+O5i5pE4E
         4LUZEmcNmiBCuwaDwbUhCcr8KIUH/9e5HDr0zF+keMf1g7YCst2m2fNmNYRo/ti3D+tm
         Wab4j3BpDSjGZfquQEloUTlHO1m02N2wk+PXb29k5QNlmR/4mO5aVvFzuH+jJExEkV+O
         uG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769151235; x=1769756035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s0VLzkj7kBAIvIeyO4Yw8QzJDHtyD3yHiv4q5/eKWxs=;
        b=Z2lYjmWWrixv+d7wTC6Hi9Kh6eaHt1tsncBCGZT6Lc/yQU6aKDk9GoUppi2s2MtLw4
         y9Wt1rcEfUV+uUGB2/WHQWnQxoiyaBK0bqkyzXBesc+MLqfMvj7xNOIzzPhYixR5caOK
         /6htJecW6l5wZvgZMcfH/lktnJS27xLDVhHuMMZ2YrJLWutdPwblCnlSh8yOMX9H+SrH
         /1ynU94Ite0F+EMcX9y6j5PS6wLTTnp/yRfivySabTFfl9HVNb1CwbXO6Z79NkLMul00
         LxAXB7sNYvS6vNm7fRgvs7f6kkaiG85qUf9JrrSh0pQzOcaQkoXpOvkpVXZVUTxNaTtZ
         CuEw==
X-Forwarded-Encrypted: i=1; AJvYcCW02Fs7hp6vfzB4SDntZnUu2ZE6qm/mWR0R7+oif+NrcHL6NNAXd/A0CegPrsy1uXAzNgB0TaLBMaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZYcpmi1r4xwwYOpPalfI73Zryvlzim6SEJLk82SZbZqhzGtPX
	pIFeZD5dZ0M8yngl9LsEDiSYRlFDkuC6dc08hphjo9auPj9vBbbN7qaN96ybS2S5bpKkH3ovC+J
	iAvw6IjpIxz9u51rAJlMVbOR20BG+toFeoqSqWEqKCM4XwYgPBTmVOKMtXTubpkL6ZHCuhkOk6s
	fT+vIJPkg1K7jjvWwOwjsh8Z5hJU0GEUReCqekpQ==
X-Gm-Gg: AZuq6aII9CPWFqxnQmk2e+vItPPdDPC9v0Z7eYnD+MMDSvHWYoQzz0H2wpoZxGNRBCw
	nXu6g7ByDBEg2CSrc4e0RWnb5ZjAOWlV3t44R2xh7209AsKVwI4V/gEo6PimcxIbIaKfmO4gLV0
	OPeExylSq7ws/M4WCQKpW/5GjeafIm8e8NTSQ2cB+8MLAbiGDuZusQjtHJRsrmc5jcEqWgP1a63
	HWGmNjBnwX+VkNHGQxIru6L
X-Received: by 2002:ad4:5def:0:b0:880:63b1:3f57 with SMTP id 6a1803df08f44-8949020d656mr29225406d6.38.1769151234585;
        Thu, 22 Jan 2026 22:53:54 -0800 (PST)
X-Received: by 2002:ad4:5def:0:b0:880:63b1:3f57 with SMTP id
 6a1803df08f44-8949020d656mr29224416d6.38.1769151232692; Thu, 22 Jan 2026
 22:53:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122-sm6150_evk-v4-0-a908d49892e7@oss.qualcomm.com> <20260122-sm6150_evk-v4-2-a908d49892e7@oss.qualcomm.com>
In-Reply-To: <20260122-sm6150_evk-v4-2-a908d49892e7@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 23 Jan 2026 07:53:41 +0100
X-Gm-Features: AZwV_QgW9xaHk1V60VCFg-RSltJOSQPj7qJ8VK_VnWofnB4yGozL2VT2va8zIr4
Message-ID: <CAFEp6-3qrfnn5EdLXX1+1qGtAZa=L4QS1nyCs23JnKq+oy=pqg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] dt-bindings: i2c: qcom-cci: Document sm6150 compatible
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=GP4F0+NK c=1 sm=1 tr=0 ts=69731b03 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=AGkvFC_LJttw-4NvuOEA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: n9x9I44c23XPxXBpkhaxBwpyF46NvahD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA1MSBTYWx0ZWRfX3NgoFX84Y6mS
 7IJZTD74dWzUC4MSDh9GCe6as2GiuvdFNQy6BcwpKlM/QfJfF5qjSs9zrVLK1ciELK51jipEjVI
 s8DiVVnAyoh2a555iSpW/CMbqMOz1gL3jNyfOXzGfviMtjBdDxbOtMj/PO+jOwjfy4XpKB3J5Xr
 bDnBgxyxNXV44uwy6IEUD+ZjUL6QQe6QrzUqtdfi/aIrvXJIqKqS5rCuh4ggw7/DqEZQ6Y67aQp
 kXRFeFipiX66mqS5s5BvDv5Lx44CjKD8B40eXdVRbyG2Ttjv2Ms/1bq+DyjB0PbvfoJXgSctmSr
 zlHMXhtB4p72qxbwOV+lU949g/uwImscyD+Auxc0XjxlccljfRQpOLI5ShvzHAv+s+HZniSHeIL
 7fPQs8VZG+ya44111AtyB8K0Ai+5sMFpfS9hHll5HRhS4whAMofoV43N+4BBlvEguUw32yREHLI
 5yBgONrkgBcCrqSPoBA==
X-Proofpoint-GUID: n9x9I44c23XPxXBpkhaxBwpyF46NvahD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230051

On Thu, Jan 22, 2026 at 11:41=E2=80=AFAM Wenmeng Liu
<wenmeng.liu@oss.qualcomm.com> wrote:
>
> Add the sm6150 CCI device string compatible.
>
> SM6150 include three clock:
> bus: Bus clock responsible for data transfer.
> iface: Interface clock responsible for register read and write.
> cci: Clock for CCI core operations.
>
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>


> ---
>  Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Do=
cumentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> index a3fe1eea6aece9685674feaa5ec53765c1ce23d8..d3f87da54fcc14a8f808f34c9=
4551583d8deaabc 100644
> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> @@ -33,6 +33,7 @@ properties:
>                - qcom,sc8280xp-cci
>                - qcom,sdm670-cci
>                - qcom,sdm845-cci
> +              - qcom,sm6150-cci
>                - qcom,sm6350-cci
>                - qcom,sm8250-cci
>                - qcom,sm8450-cci
> @@ -249,6 +250,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,sa8775p-cci
> +              - qcom,sm6150-cci
>                - qcom,sm8550-cci
>                - qcom,sm8650-cci
>                - qcom,x1e80100-cci
>
> --
> 2.34.1
>
