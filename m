Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304133DA7F6
	for <linux-i2c@vger.kernel.org>; Fri, 27 Mar 2026 09:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603240; cv=none; b=XzI/UKVze5aYeeXNYtc+wSqogC4KcF+bQapk/yMojr1FfQrRPwFSa2TwShSgv1prAWoJxHvi7MJci0Y9C6V9QSlYfJUwUDOyUGae9AAw3WQsTZcopi3IhiLAOTc55KXQp2MtrstQgt235Zg5hv+HpLfaxFMupgaRFj4lCrGJui0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603240; c=relaxed/simple;
	bh=zB4ZiLmN2RKfWX6WblIwamGdqZtLoGTpjg5bwYuqCVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNvlK0cpNV3oFmvj1dgXcbcCV+RaurX/TOTbxvxwItx6TUyjEBAlTQELbsfkA+iyi5Fg0b9g9Yb3y7DdeIYhWSCHUnxZlhVeJ2emUjILRG1BLNH3KyvUNol7mRdcdPHo+V2reBBStcsZX8WOI3wAV0bXIWIXLedI4n6vFwzCEq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pqj1hgLB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=adzBjRTA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pqj1hgLB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="adzBjRTA"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R6vnRZ3713728
	for <linux-i2c@vger.kernel.org>; Fri, 27 Mar 2026 09:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vHJeKbH0lAHajsANLPABVW3ed/VjpIkjfCZLVcj7SpQ=; b=pqj1hgLBfUnWKrEb
	Se8sdDcAvF7myU9p+4/d86uklF2IbpDzoFubZuEkRD01b+pd2+yGD8iro8hgt06d
	Obtm/NyjEjKcwA0QiT4+lk2y5FLzTr9LB8ROl8MtqXHA6KFderVdKOYelvkeO3EH
	KrpelHs8rs3F8R+zRxT/wB/O6eRFmvdRrOLyPv0SozVpY//4lWmNVhahlvbTkxdG
	j696yrDwqTgodlvAFaukiP0xD+Jg3Fyl8G46d6udZdmuYJjL88385Eeuu9EfeeQM
	bBVgJPRXLJPLdfC3U0dXeKVw+QfdqSN59y0EMO+HL2AmKmM+7DzjQRI2qz/UY8B2
	KNEMGg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5hapsekq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 27 Mar 2026 09:20:31 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89ccf10567dso8203946d6.3
        for <linux-i2c@vger.kernel.org>; Fri, 27 Mar 2026 02:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774603231; x=1775208031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vHJeKbH0lAHajsANLPABVW3ed/VjpIkjfCZLVcj7SpQ=;
        b=adzBjRTAPUSJFK0ZjhhW0H1swD/LSgBvoRAHJ/Kr/3ai57B45gX/b7gvow0i0fIRTS
         KsFHtIpNF0gp1dWsS9HWmz5y8k/ksjv/yb0xsbFRsTBIO4Q9dbWlS3JQlXUPYsC3jeo6
         cUu+wcJcCCvDYrKaAx5FDTQkvrs7k6fi5KaGXfM+0mn0Tej3m8KbQonolVd+Mt3zYx6m
         y4TzgnfK832aH9D5bd+TCJEHIofg3qyTLlBhziAze8ErMB7o6RTYDQjRrOqZO41wEXk3
         m4xUtvSmls0Xc8N9K1+fXVbtmTA61UvxhStTDSVUVBoC1/h0u7+rrFBgjhI6kidahoNZ
         6N9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774603231; x=1775208031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHJeKbH0lAHajsANLPABVW3ed/VjpIkjfCZLVcj7SpQ=;
        b=GLgHUaiLBLEcvaocntQEydOkDC+pXKR5B20cRFGvNjpnUCokzhIKGpRzUuMaFsUTZ7
         85Vr43Sj9uHu1AC3bclEw2Ss3LaHSWoGQUBg4hHaJEvXmoCUmTsr57dtTuAgSmjO5jIr
         ImxZpV74PBCqEJfRglBuoikuGcn8OpuFQkawGrBLRTW2ZtTlcxoQKpGllt+JyUuYnvbw
         dx+ZXd6m23ktv+4FOYvLoaCSykBQJbIgwDsEEwWclzCTDUY5TC7d1+F70/7A/jKHmyk7
         /0vOx1BFNKrlXHfbSZnNX7JDcm0JKn1Kry8JoHWX9sDaKTnuEj/LcF7XmbXbBF1fXykH
         /6CA==
X-Gm-Message-State: AOJu0Yy+pPhz3Smce1dbFlh1u4wINKrY5eIdswb/nKLfOEXM8cSVVws2
	OEAcU21pStWh1t8wjmAH1KADYfg+tHxAZ/Rgp+2CFD2fOZQAjB3FNuMYfGGtTQkFGRE4ghPYqXi
	Pgxx5VaTQk18lD9yzUVxHe3UY7+dbs8jhP44Qxk5seq0BPuH7Lvl9DlKOU31pZKmG2pgc5Fs=
X-Gm-Gg: ATEYQzxsTd7GWLF5W2IVQtWCRk1R6/GQt/s3knzNp81Ro/hUqC8y/KRQi6LEox7WSos
	KhQL+zzMaM8UeLA8Cfcgo9ePZB90SvWpgO+8HS5Ye9XdB0W2pVgpcy6tAStYONHBVyNJWvaNMLI
	f1Tx6Xl8IH6Wv0j8JWS2XseeIhkXBhigKPv43D88J6yp8lwwtWyGMJSQv8ITIT+KZ4C1/2IwuKA
	dESU7fRAK8OkSJaeGrUGYMoQUUDpezYkzYTx0vYx3oCTVHaZSwHiHruGsZOa1psG0HXkTSvOb4d
	kJX93iuTbz172npqI4plf6K5ySE3/H2Y85/Qq1H4bXCHa2E6zQIvFRmeWWTPKGHPQAhh+pvIua6
	THrr2zc8e0S32jjK1E+uSjD691BrESlVWg4pRg3vKAof0lc1l81Uxl8WferQYDLj3141nTOmV/w
	/YHK4=
X-Received: by 2002:ad4:5aa7:0:b0:89c:cc08:c56 with SMTP id 6a1803df08f44-89ce8dddebamr16552336d6.3.1774603230762;
        Fri, 27 Mar 2026 02:20:30 -0700 (PDT)
X-Received: by 2002:ad4:5aa7:0:b0:89c:cc08:c56 with SMTP id 6a1803df08f44-89ce8dddebamr16552156d6.3.1774603230405;
        Fri, 27 Mar 2026 02:20:30 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b2021872bsm226374366b.5.2026.03.27.02.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 02:20:29 -0700 (PDT)
Message-ID: <b40b9cc3-f3f0-498f-85ff-6c6c31426669@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 10:20:27 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-cci: Remove unused CCI_RES_MAX macro definition
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260326165345.762807-1-vladimir.zapolskiy@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260326165345.762807-1-vladimir.zapolskiy@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TqnrRTXh c=1 sm=1 tr=0 ts=69c64bdf cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=TMqjEctWjwZvrHWsp_MA:9 a=QEXdDO2ut3YA:10
 a=NXw8GaxpU7kA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA2OCBTYWx0ZWRfX9LACDdrZm7YI
 h2iNOmw4L0EZ8E1glo2evzJP66m63Mp413DzfWdJCghJSsS7r9Rb4mdy2OinABQAz2miadmesiN
 bQxQGmyIEEb6DNXI69p11zhacvfeg5RoRte11cPlrdmtRCgHxJPn/OwtSdGW03dZgCAWykB+3bw
 zEzodhXloZrm0XYTz2cyYfiRU544gJuIlTlzMOcgDWKyGOTuZkTGwAqbLbF+ALpf5HGKBGb3oOg
 BsKj3mKU243LYFPmuGxfXUccSUEJx/iBIrMKkH68DwzuBGdCUHWZ08NYIKcnBSlqBXiharZ1pjl
 NAJIALV2UyxMD8bClJ80xrgeemmmD17TN9NEoTJ8cPHJexsav6qVq4XGor5cUgkm4jw67TnXIT6
 eN69lpBfMoHyPnzHv8xfV4kHYXHeOvM0J84v9lZbWSe9uRFn+1LXqYOj5VmxSSUwV0Nflnkok96
 0ypHx2UUzM+QluPsPhQ==
X-Proofpoint-GUID: 036WPxH6vQ3jwipffHNWUXw-gIJueLfh
X-Proofpoint-ORIG-GUID: 036WPxH6vQ3jwipffHNWUXw-gIJueLfh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270068

On 3/26/26 5:53 PM, Vladimir Zapolskiy wrote:
> Trivial change, a never used macro CCI_RES_MAX can be removed from
> the CCI driver.
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
