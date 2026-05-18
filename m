Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4801DD877
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092179; cv=none; b=aBuu+1Yxa7Iu09AB8YHOA7ZMIs0+2poNjgyjo7nfS7wZf4t3In/MBtewPMoPm4MQ0DALx0FLj6+RQwZCd4C7puR2W5xUwvXMSd6D34vI11/Z3l/k0zqGIZ6ZBfc4a+1K595FBRQDc0F9ucgtzworUZReB5OKWWzAkeMSnOpVhKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092179; c=relaxed/simple;
	bh=N8Y+1HLBvsUTvy+51zph806zbzJZWuiG+Tj4xa5M9rE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fIyZXnk++bV+GwayWp2J9rZ78bbQhOTFIndutmQndeNhaA2T0vAm5UP2IA6Q3WiwdC7IMj88UEvzNDhN+mlxWtSNogFHpc+wcVasezXKk/NxjR5YTA1pm9qevc9acNRQv6PEgnk9ci7IUTGolQegfpxrTmaLXsQaVBFbUASPkgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cyouj4cH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VQvROKz0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cyouj4cH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VQvROKz0"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I7eNSs970086
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 08:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LqTGa4kDhF95nhlaNKGfGr70dmwIfEOdRZTGS9S6bUo=; b=cyouj4cHemLRBoJT
	C6A3oEwgzLKfWxWDGSaq3Zn1By+/yDTkvO/qyThgSYk8FF7kwJaNJhE4YfcuJ8jV
	ShdixKMGrCFJqA1WJlU53diGHS6LZOJ4Q1iL9Q5PW9QViJjU0T5IGzPXsRXsp3Bk
	HHQT16lbaI3iu5YCrpHTAhbi4ypEtYSS1MHSj8dNqELQRedv3TTRmprzo+q+UFbJ
	x/Zc2vXEzkE4wbLinbxH0XWK1OXGulRL6appat90IvLubHsLOMbI6+SYCg3hlTAN
	IUrp6El+TKHH37QXGeQH9gE6jHo94ACVZuB4+hskPDzWH4Tf1ku1L/4NeISpheaL
	7xzQBg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6hv7wb3w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 08:16:14 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d9f1bccd7so6044791cf.1
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 01:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779092174; x=1779696974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LqTGa4kDhF95nhlaNKGfGr70dmwIfEOdRZTGS9S6bUo=;
        b=VQvROKz0tDjOLl8jsLZlry/HFC/KPEzmCSRQ3YVcGz5inNRECNmHPA3YbI1jOrvv9u
         TpmDpaFFYXSJHY24zVayS4oeQDqLhx0mCFufB3jXO6QAso+pgESNuhwlbzAHouFmK7/P
         Re1Se3xJ9d/I68UKX7Y4CSfiS6+m8x/1ZLdEtl738GdeLlQemaa2XjyINYvDrq+If0US
         qBe0bpakLuC7VKofy/QdbWALEmJHS5TN1VJEUjUta8K2cuvJ+7N4eQGhQEtlEfmdtdbT
         ZjIOUI56SwbAF9c4WIQPrlCU55QvnBW+THTcSMr7PYGf+PStADnahFF298796GU7JGk/
         SwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092174; x=1779696974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LqTGa4kDhF95nhlaNKGfGr70dmwIfEOdRZTGS9S6bUo=;
        b=gedLvswHqDUBvn1AdWFyKI4I1a9i5gbz7FtwuAIMtRubCSWiDPW+rMtzFbBItdC9UQ
         v9rgjl6de+OCwV2dezFTEZecnXxOTZTBD+05d4q5nJHb7T1XAxe+s4vseNWPR9C1t6WV
         Pz7Hg1yN317t4zNsRdZRp+7qKzouLwtTDdYIETKDlIZhQoR+s2N35BiQR6jE7jLU0WDi
         XNUnBzMS8fQd7CLTEJFUPeRgBmdU2yguHOy6ejzuhDn5cY7ryeFoUmDdIzjveiJcr+lO
         OuYcd72yui52MsIylqEBxPEGqZmiCh2a3bxs6tpw1yvGJpg/mslClxuM1slpaz8LoNT4
         xUZA==
X-Forwarded-Encrypted: i=1; AFNElJ+LkoNg3+tcKQzV9j1vXCTCfWrBziEq3BfVVEimfyh4y7azUpTozlXeHq+68/0jcMSl9h+SlQRwtug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5sil6Fme073w/N4FurmisgW50ZViKU4i7xtWhGLMnldLycDM4
	ZGSUsBBfVcUv9zA7iX0vHoi99fjwoHqM+guB3V5ah0hm9wHxaOIVq1f3ETuKUHPtX5HyLHrCsms
	2FTL2kqmppjhF0EMb2TgMCKAsJhfA6i85C/eRfO33po0TA4FB/7OTmpk+Drk2gBY=
X-Gm-Gg: Acq92OFgxJB3jdMFaUR8Vb4a1p+RjnUjeqAkUydD3LOPzdu8fYBuwkheO4/N/k4b0g4
	2okw8RZrf5GttXp9fgPLuvqWYKJu0ZSRU4fYjqVS0g4ruuiV6XEnYjn5VezL/DrwJ7rRnw+fxSQ
	PVnBY1NFgu9qefD1ix3iJECBjJGXnGNGEK5ayC+cdxBMxPrDAdiUQkrXjBBq6g94tk6sEMXaYch
	kzHkxHl0GcsNVYtmHVONZfvjKnVjw2+tsKYp/YHodE1dehUOiXPdEqbUWx50lJFPxO2VwrP1dHQ
	Fn3vNUh30f42U5sXq/0jjZOXb6drsu+iC72Rqd2NWulbldJOWAfFW1PIx7He0s78+TQPGeLm67n
	YVKp08uKv8F+hI1XESBbf+R5wnwydiKdNaVqOfQ8Lg+ZcZqHkeHcrrKWj2QlnHVl4+mVUOYCR5w
	g++Is=
X-Received: by 2002:a05:622a:111:b0:509:d76:fe73 with SMTP id d75a77b69052e-5165a0dc367mr126325871cf.3.1779092173986;
        Mon, 18 May 2026 01:16:13 -0700 (PDT)
X-Received: by 2002:a05:622a:111:b0:509:d76:fe73 with SMTP id d75a77b69052e-5165a0dc367mr126325631cf.3.1779092173555;
        Mon, 18 May 2026 01:16:13 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4c23feasm547248166b.14.2026.05.18.01.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 01:16:12 -0700 (PDT)
Message-ID: <7bf3e5de-d9b6-4478-b5a5-0ee37ab37626@oss.qualcomm.com>
Date: Mon, 18 May 2026 10:16:11 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] i2c: qcom-cci: Do not check return value of
 cci_init()
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260515234121.1607425-1-vladimir.zapolskiy@linaro.org>
 <20260515234121.1607425-3-vladimir.zapolskiy@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260515234121.1607425-3-vladimir.zapolskiy@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA3OCBTYWx0ZWRfXya/1vhjvxNkk
 mTj9mPZ0/T1QazCcqQNzwi/4O57wZg//lXHaiGKgC3xbJtq1y8jv1+Fvt+rcS45uFuZN5+4o+GU
 eoUiSDBWn9dLBOtuM6BZoOUpJtUre9b3MNyf69TPl66Q6Go4LNSMiicolwOBWo8ptWElZdS56tH
 YLZIqESfVCaiaO1rbxWfB9/zBniBfR6VmCi35OrCJIscffEUBgfHLdP+Qf3YZXrEixZPb/JFZSG
 v+QdW/CvNsRbHfEJ9NWXw+eHGeJOq/TgSgcrH6VIu0zNe0nCcfemPO9wd+DjwVPtTpbBklO2G3T
 tH7oNgAF1IlwCjuh5VLqH/zRka2d/ivGd+OvGJXj9pu53S8hV07u+2Va1XIAcHf3jCG471YhHfm
 fiSwQCRxGZYo4i1PqeNyb4v7qfqWCJzER4kCR/umJ6z+yoyBC2mesmcwdbHwwAD4mctQaNrldHH
 L/e2m5ceCqnKM9abtLw==
X-Authority-Analysis: v=2.4 cv=a8oAM0SF c=1 sm=1 tr=0 ts=6a0acace cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=WNlnsbhrpSPQkgNWvCMA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: xOnwBOdCN8a_3gbXE0QNVGvQpTBR7GHa
X-Proofpoint-GUID: xOnwBOdCN8a_3gbXE0QNVGvQpTBR7GHa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180078

On 5/16/26 1:41 AM, Vladimir Zapolskiy wrote:
> The cci_init() function is not supposed to fail, and it never returns
> a non-zero, so it'd make sense to convert its signature to void.
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
