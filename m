Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0797B318EC1
	for <linux-i2c@vger.kernel.org>; Mon,  1 Jun 2026 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780313508; cv=none; b=R3sRIUIzM3GKKfA5xKYgYGWPGinaksBvmKDigP77zTjld/e134A7yQW6IeQIQHHMufp0GQvQ/qGy2KNbvwHgNISZbv8nIqDkb3xzI+a688ocSvo3jmbOrP0vl/okQkZzLUON8j06lTwH3YvJQUiJRyNrxJhvMsQb8SrT5GpqQUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780313508; c=relaxed/simple;
	bh=CMCbK4GBOtetUzOVTMPXigvLXYggmTaBv77AMOXmYQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pN8CpsZ4fYccsiDMluL151lPGVtu0mFn6HCcK0tiX9KGyPR57+lTjGaHgkqKWhHRTTF5/cpltxofBqKuVyyjgs/Y2ufSYl1zfkqXnU0Z45oUmakbiRuT2wv/5DJy4mr3MVOPAPgpjPqN7mlVnN09uPcd1aRgcHgEGN3qqrupPZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JsZUh8jt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ITh9lqgx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JsZUh8jt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ITh9lqgx"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518fJEX144956
	for <linux-i2c@vger.kernel.org>; Mon, 1 Jun 2026 11:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KNn3eBFCqh3QzXGSL2O+S+DDaMQWJbT1f9codb+9lr4=; b=JsZUh8jtnEvvs5GW
	jmxTVtxFAf1no+JrbippW/yG5S/T9BCf06BcR6vYLOuYVUCp65jOzR74+Ju3sMBM
	B4/KyB1NXLXfTarY9X7D56ZpeYf7oMgzjT5JRLupYmRp5jUMXB/ybyTERp6h/EGS
	P8xFu9xkGHmoF1tQMbnWBZnjTRMPDNCzSaLPa1RoyZAMSRtEIPU473o8WZgWB89+
	r5HCWy0ecK4xPGwB8eBODTnQLqkRm+1bw0qxALND8Onci0KK6ID8kXwvbaz3HQWN
	qLZz+gV9Y2lYYrcLr5RBo9R1EQd49lDROaVmDHZMgH40tjHC2O8gckT5rtVx9VbJ
	sEnNXQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6strmuq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 01 Jun 2026 11:31:46 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-59d595bfd94so755616e0c.3
        for <linux-i2c@vger.kernel.org>; Mon, 01 Jun 2026 04:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780313505; x=1780918305; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KNn3eBFCqh3QzXGSL2O+S+DDaMQWJbT1f9codb+9lr4=;
        b=ITh9lqgxbCua27O9/EObQvnsT/zeJ79Zbo1FTPZ2N3uRyCGZPcp01bhQNAToFftEHS
         pUm+3bWFiq8G+GTzJ7RHID1b2wm3/ySlqW30IXitsG3KBfJXPIHGqtFoUriCv2n4CErV
         90QjImFA9akwJgX3NHZA2Pg42JxsPUSpQUu5C+r7jzS85M7QcnhXA3dIeSp9bBcP4J4B
         h4rAZ0colXgYJBYPdldBknPGF3yrE8fXCadwESzUwvsS075M93+HOEDXNqEfuC2vvywV
         kti5GXAz89JH/WFgeaNHjsM08olFC47V2wLw+ZIOIEuO4/qlH8mKxiGe3g+oTg/jiQWo
         Ivuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780313505; x=1780918305;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KNn3eBFCqh3QzXGSL2O+S+DDaMQWJbT1f9codb+9lr4=;
        b=pMXRounuYWVvUviDyu/6ssExnAKVQM3ajF8HOBeA79j0DxQNAlzaxGJVrnMnBV0xeH
         IUqmrTMIbaqbBKvTdB7IeyNXMcboNqDX0DwngNCe1roAdT8HwwURgAX9Z9QnCP8c7U5t
         SzIMGu4jztALL3IfzCfNMA7WTzS/FjW3S0B5eShBXL2QP1aXMJ008YikWihs1InbcNRv
         qwarYHEFZN0rufoPyNJ/vD3wkpF+rCAsd6eBGziU4oblPIxy4cWkgMerJ70kUZxd6Acn
         wideKzXY+ptS6LXFzQbG0yx1o6TJEvLRESbJccGf0ApYvsesnQiOxNFBnbtL6jDGCInc
         1Tsw==
X-Forwarded-Encrypted: i=1; AFNElJ+KNbXeocnf0tx/p+gFXl3wzAyFOLHrS8NnWX/OWP9r3aXN3jSyjzLfBodna3C7WgiwtA5+ykW1u20=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbquuURN9P1/Qm0Zd/HRiuUNp/gzstGb9hB/8c7mNef/Eo8xFJ
	It2c97Poe8spnwVnVYTBHaEA5qOxU3rzyfv70TR5AzbYz/d3a+gPKWPCTevRbxi5xzHfMfOl3YV
	t1vw2GizdUr1tknu+rP9gS+OXXDOAms9KOhx/6AQacclUN/jazvDkLQ1h34suk40=
X-Gm-Gg: Acq92OHKuXlT1b2e+KILNnUpBVrrNZPS+1bdpXizBkrroxJZYdv8MbBJ4a6wGmh0YLk
	joQRG+NvokDMs4yQsEWGWlr/Huz25ZNgHc/i5QfnL4ZIf7sA/G8uxDjkoChzTr6drjGOJ0VYTVc
	z2a6ElRterFkfx37IoTGbOWoyEK4OfyZiU1yJv7xljAeuUXxs/2kQp/TKrMIyeVuxWcd8inFfYe
	ZLBFP/r+dmrEDRlCuX9pdGJuOsOVe4zds64Ocjt469uc2CZA5YCE0HW3WtvZ89JnpqwG6ZOqXjF
	XRfrzytrNf08RkYVKGgCpPd+VUWoPk5vpbp8eo99y0vXmMSbqdEZNboaFQ2tRXtQUlFZyeVW2CU
	h8l5TIXlQCWoADgE5zrd3uI+S7V8ZCDxR5Bsc2F2AyWvY7V+Ql+IeP+PJQYcrGpp7ec/vboKPMH
	FJtS0ml2Qextf/XN9MrnyhmRKm2Ko0gj+s+G49e4p6ZxNvVA==
X-Received: by 2002:a05:6122:3207:b0:575:360e:600a with SMTP id 71dfb90a1353d-59bf1268aa5mr4050652e0c.8.1780313505323;
        Mon, 01 Jun 2026 04:31:45 -0700 (PDT)
X-Received: by 2002:a05:6122:3207:b0:575:360e:600a with SMTP id 71dfb90a1353d-59bf1268aa5mr4050555e0c.8.1780313504812;
        Mon, 01 Jun 2026 04:31:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b07c2e0sm1977344e87.32.2026.06.01.04.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 04:31:43 -0700 (PDT)
Date: Mon, 1 Jun 2026 14:31:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Prashant Shrotriya <pshrotri@qti.qualcomm.com>
Subject: Re: [PATCH 5/6] media: qcom: camss: enable vfe for Glymur
Message-ID: <7clwzl33xumipuucecv5tovo5mfp2dl7j6v4wmvbwj7d3o42yf@3srv6pzfldhh>
References: <20260529-glymur_camss-v1-0-bee535396d22@oss.qualcomm.com>
 <20260529-glymur_camss-v1-5-bee535396d22@oss.qualcomm.com>
 <449651a8-18a5-40d2-bc68-59223dc8b69a@linaro.org>
 <ad3e885a-c04d-4e78-a037-63ddfb0b9c52@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad3e885a-c04d-4e78-a037-63ddfb0b9c52@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDExNiBTYWx0ZWRfXzQfUvaZQ0lPB
 8onpmaDSnhAhwDqC+yRpaRSkzNcwX6dYmAp/atcsFmcW7WDHnNTQjZZHdncj9pVDJRvjR9zaULB
 aUigSa4HBPuNp8bR/E1hgPbAGruUK43TIdE45IsYE9uWAn5e8qDdTvwyruSxy8U6qYjJb/MUaoY
 4/9tH3jXHv33d4c1HiDUxB/fcmKiRrhBRNsqGA2dtF2Br58HMXWdRItt6T36xmz59lIWiZ7kGnE
 YFr6coLJHQcfizzDQKhYRY/NsTtoJe31JUPnvLtX2NnhqbtqCYXf+R6nOVc15mMDGoHf6k/hQCS
 RlCsdL+cL4pRDVxTIL+aIUonXczhOj7f0zc63oCtBdwgqYbm9L+5rQBurWhUZi6Ok0CPEVISOm/
 8xTFXsj4cDlhwYR139OrraGFbK5TmiwcjveDjbrYlVhsSCkDiO+dtoP0952VaXdgzn3IR9Yj+n2
 Uglojy6HLaGI6Ivdksg==
X-Proofpoint-ORIG-GUID: 0WNzivE6MfrYT1m7cIgtFq2lBkdQUpha
X-Authority-Analysis: v=2.4 cv=HrNG3UTS c=1 sm=1 tr=0 ts=6a1d6da2 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=rVSrNolec8Lwk94r8HgA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: 0WNzivE6MfrYT1m7cIgtFq2lBkdQUpha
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010116

On Mon, Jun 01, 2026 at 04:39:12PM +0530, Nihal Kumar Gupta wrote:
> 
> 
> On 29-05-2026 20:20, Bryan O'Donoghue wrote:
> >>           ret = 16;
> >>           break;
> >>
> > 
> > This is a pointless enum add.
> > 
> > NAK.
> 
> You're right. Since Glymur reuses vfe_res_x1e80100 directly, CAMSS_X1E80100
> already covers it. Will drop the redundant CAMSS_GLYMUR enum in v2.

Is it completely compatible? If so, we can drop the driver parts and
make Glymur fallback to Hamoa.

-- 
With best wishes
Dmitry
