Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA5544C653
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118156; cv=none; b=Gr3zdZyOZb3rx5pTB8v3n7uqZxaXDFPtP4VErpfQiJdF2ZDjr++2HJln8JRXfK7k7juX+W9r2tb8G4lxBl2FpuznFLn4fhNlYJUmbyYNYsDkQQhkqc6Ke35oc8nh+moWBP1TmYXOJX8yNW7bfEs0TAtYQzsLcRxI8lHT7tDPyH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118156; c=relaxed/simple;
	bh=PZa+it5ln/dZYcDQVhHQXLPvxKtKTwctIopAUS1NAD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kOs3p2+caBhPAwlwU7zU8HM7o1LgHNmcnlQ4NCNd2MwVSdU8oMkpnq4P5+RfujNJQ7CXV70lSmd37HX2h38vlgWXzBalAej+IbGV1oTBLrX6qPoauikBuw7dGz2JtAYDvFvAnpk3GjkSXsz+QLRD7JeZQvHTL3e4fmq1DxZqVZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gUlhy41E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YiDiEOpn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gUlhy41E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YiDiEOpn"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBcZ3l3450198
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 12:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b9uVtnp4ftgJs/XKrszPRlmmg1Es/wCizqUifj6MXDo=; b=gUlhy41E5kpGea3a
	BB/5TjJubdLBbShBspxaioRA3zRpyuDaKtkVR/wpGTPVFOFfmDQ5VJnluUXqLBoM
	oNWPHNhzq2VZK1v0u5HynxX+G7Pk0W96tCUXdZdLLFcPtERI5rZiY0nCPJj4Txon
	wGIfNPgYbygwq4ldkVQlvR77PLCsywATtUe7pTGRY5kVZdDewvsUVQQBM8lcqFs7
	aQlBBPIXbxL5X0AMHKVOaS2yyHVcMkRjkAB9rtJ26gQLEdMvY9sa90T9+7+aH43t
	ehYUjxSrz7oFz8oCmJV9TgrS5o9mvj9JFTgZN8utN/faivcBtBnhDb5SK1xRbtuQ
	RZrx/Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe7ka8pue-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 12:22:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e68cbeb53so104897485a.1
        for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 05:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784118153; x=1784722953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b9uVtnp4ftgJs/XKrszPRlmmg1Es/wCizqUifj6MXDo=;
        b=YiDiEOpnIX6kUmKqJ6UeCTr31JEQPSPMobQYrqFC8yvrQzLIKtWk2X/GrAjTiQPY3k
         i6vIFkQ6miRAIBpQjlZKQtGha7V5vfsBIAx1+zHGdxliaCmjUBnZhAErOz0XLhdfi4QM
         Le/wwF/870k7kEdZBd6rWM6SNOlllMcpnJhaXYGKcVZVeF5woImzVYJzW8u7W535+2BF
         TLKq103haV8/8Qs+e91yc7SaRNhGMwqrCCon62FU54K1xnzvY454lnzCmP1jsfkZbubb
         EaNAHdBL4ph8wiB7NYTFPNS50WsFoQvQOaqBYZkIhDIcgeANg8MOLjs46H5oVwf1Sm3A
         wwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784118153; x=1784722953;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b9uVtnp4ftgJs/XKrszPRlmmg1Es/wCizqUifj6MXDo=;
        b=tCe6OtFXuzA/P3fTNo/F3QSBi26C0YE7XYaowf7rP/A3CcgIkDjX2gK9VaDrHa8lif
         ivQHPejY+dTQMiHzsp2t1pWmNf68H4ZTzrvyjUKiLqoPBGf43wqX1cs/4vYqzMhvvtTr
         39r00tTAYN1y5suB+DBrABl79eZYjjk36qCkJt7r+FJUIDHmCSkGvY5QG837CZP+rqV4
         1RhkZbJlrdIKfIPsKNvbVmZx2DgKIlyLp+6h9wCgz6hJEQ0Drg53JZT2EfdDckOEZ0rP
         /d1Z3N7UZ8fjki3ghnFOih63e0FPsoRyDJYZt3mbeGIRvGWEyGBDybv4IzORMnquJPgB
         XQvw==
X-Forwarded-Encrypted: i=1; AHgh+Ro3mBrnUPInRRdaXGbol98mLqniayR1kCOKXtWELSqudOQgnCVC0P/DfQP2tPPyUAcEapO9WGEwgvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOe4iziJNr8VC6bGOleUAu8JM5saYGAPxCUYebQcUEPvduu4ab
	aOQfDBkj6x70eo6ON/cOS9NoLRxIzWveUEUndkoLBLWgVqtYoj0B7JHKpuc250XFQNH+BBLyjMh
	w+/r+r9BS1SPloJcAke8QlY5qPO+BpGlXhVfvZhcE8Mez8wY5tE66Kqm6PPe9ThQ=
X-Gm-Gg: AfdE7clhJHEPYutB12COpoJVGfPbYljLQj5Zeu6mH15i5xh9Qm9dXFzL/fWSm99Kv8z
	qrayMd9EeAScK6NrDHWHiI6S2MFd90xLiAOVe0rsLhgp8Qvk85PZaWb2sCCWS216WVRpRosMk7D
	eBw3oH1EujeijUEtkN400tcvGyqFiHXXPhuR+mxXbUUywf1LMlW53N1ze04926apStLKljlPgVy
	N3EnTOGspuVss4afB0M1FOXFRrP64F5xFQAuSGHWsbgL4bnne0PKEvMfiXPYwFgLVPRlPpXydKJ
	ddbBlp7zIAt/bxNKIVomGc5kv5Q7XBLIVmzGOLeRxpCFdWjwMEE7Wah+EVbpnlTzXKjRF0CQchK
	+zLlcjDwE/ugQP5Hf5QEBW3Skn4dtgygzJ9s=
X-Received: by 2002:a05:620a:458a:b0:92e:46cd:7299 with SMTP id af79cd13be357-92ef2c7f24fmr1309036185a.8.1784118152917;
        Wed, 15 Jul 2026 05:22:32 -0700 (PDT)
X-Received: by 2002:a05:620a:458a:b0:92e:46cd:7299 with SMTP id af79cd13be357-92ef2c7f24fmr1309032085a.8.1784118152346;
        Wed, 15 Jul 2026 05:22:32 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm15401266b.48.2026.07.15.05.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 05:22:31 -0700 (PDT)
Message-ID: <c9ea2930-d12a-4445-a2ef-3907597ccd86@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 14:22:27 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/4] dmaengine: qcom: gpi: Add lock/unlock TREs for
 multi-owner I2C transfers
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        vkoul@kernel.org, Frank.Li@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        linmq006@gmail.com, quic_jseerapu@quicinc.com, zhengxingda@iscas.ac.cn,
        kees@kernel.org, agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc: krzysztof.kozlowski@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com
References: <20260708051023.2872304-1-mukesh.savaliya@oss.qualcomm.com>
 <20260708051023.2872304-3-mukesh.savaliya@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260708051023.2872304-3-mukesh.savaliya@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TMF1jVla c=1 sm=1 tr=0 ts=6a577b8a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=s1zqTiH2bahLR0COYxoA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: awUSHGwWrBkA5TJ0JKFwxOAvM5tOnz89
X-Proofpoint-ORIG-GUID: awUSHGwWrBkA5TJ0JKFwxOAvM5tOnz89
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEyMiBTYWx0ZWRfX0dCPigQ3Zmht
 Bb5MpKwL9nIV/zBAtj5gxK56atWMYNqCM5vTi7f4K3Hqs5iOl2kJaSieCMAPTI9byYdGPy23Olc
 mtqf+UUROX1mKLRanD9mPtW4t+zDU8E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEyMiBTYWx0ZWRfX0NK+gXawgd/D
 I7g9iGJ70e9+hh8FAX0uJk+qH6ChzhjFSGiU9K4x4KtVDR0ElvloBDL0U2IDXhGQixN6i9bcOdZ
 b/W4LVRhnHRvUjb72T2v1oqbHs7HT5xTLVa3H8G8tdJRCwNIj6bKHxJ3FiWoZaz6HIhKVYME4PY
 G0TOagDbwnZPqSiQb7nudjUvsy+bePhnh/cTVG+phedQRznveeGYJmaJH54ki8TbetwT5Z0JVDq
 lJk83ONt12tRa1rBIogceccfkv1LyYB3EmpaXLvOl0/6U6hcg2IUw4BRCKqsRZ4Fb+9kfS0UBMM
 q2yF6DMnL6iW+zvGjgUVdoytCIzfmVeklu1X1eahMLmgp7f8CZDFN2ROTuPRiOiNVxTM4ft+XqV
 G+d2lPLHQm9XSSoZyhFS3Ql+3GPQZv16CFVfwBerI79q9sTxXW8D1cHBBTYKqu42/vr/+d2kX19
 KnAAoIencr66/zJ0oOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150122

On 7/8/26 7:10 AM, Mukesh Kumar Savaliya wrote:
> Some platforms use a QUP-based I2C controller in a configuration where the
> controller is shared with another system processor (described in DT using
> qcom,qup-multi-owner). In such setups, GPI hardware lock/unlock TREs can be
> used to serialize access to the controller.
> 
> Add support to emit lock and unlock TREs around I2C transfers and increase
> the maximum TRE count to account for the additional elements.
> 
> Also simplify the client interface by replacing multiple boolean fields
> (shared flag and message position tracking) with a single lock_action
> selector (acquire/release/none), as the GPI driver only needs to know
> whether to emit lock/unlock TREs for a given transfer.
> 
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
