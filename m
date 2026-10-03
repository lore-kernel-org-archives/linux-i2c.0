Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F162C15BB
	for <linux-i2c@vger.kernel.org>; Sat,  3 Oct 2026 04:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791002162; cv=none; b=RaONogYe7uwHl2lDqJLMxnD71DjZ2oujd8mbISfB05GPhMC44JABCMbHL6R88Fr3fXnm74Zafd0+yeryGM2N6stFspcJdFKw5tUFznRzU/SL9qAVWiR4CZL24TD4ZEZ3ZTW0zG0jGLn9OLrI4uf2HuwiNQSylbtEej5vmj0//XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791002162; c=relaxed/simple;
	bh=bCd7eq3BXAnK7U3piXSHOrcMyq5T7wZbV28bkpGeuqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9LzsrlL0nf2ZncTy+WuDoSVLI12KOhPf5jEBhsiT3AII5o9e8pUIWZHwQ5dp2CAPPBkmlYbtpFo9XAZgY0A7DOveUgLrqgOMJPTp4r18c9+PVSyJ8ucqFXrbDSey2Mxts1JkFzo1/3Vk10Qk1Lf0lSl3Qlh8AofgL8vXINdbLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iAuqpBks; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bD7kMGt/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iAuqpBks";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bD7kMGt/"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6933OSDT2558197
	for <linux-i2c@vger.kernel.org>; Sat, 3 Oct 2026 04:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Gni+Xpimx1HzcnK+4D8GTpegyFf9CN2x+hfzGZ+jB0=; b=iAuqpBksVolr2wpe
	9IY/VWCYxYWrlYndx1OzSKFhrMY0Ty+2EO7E6f9OcEMY7fIIK2fSrQQGHYFSpc4E
	Wh7OYLcAc9tB4L2lA+AzgyOrLp4/wjPrYiSd1LO5J6FGJjHoS2FxBdZNLK9FOm/P
	JrU35RL60a/qiP5B8/EsmvRtddK6lyPjhQOJIR/D8ZfKtEKjzfzmLv4dyQo0Dt6B
	EPBD1KUul8UmqU3Bwv9vkfimsHDMSjSqwu2aonISrXWSnVrLGnrNURE6sxZMJpvW
	NpLO7AxfTVbXuwXGGykz0pRXxsaojRzC8SUAtkbdMPZaTCajE2405Q/rVehtkm0N
	liytEw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2sryr3d0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 03 Oct 2026 04:35:59 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso23277eec.0
        for <linux-i2c@vger.kernel.org>; Fri, 02 Oct 2026 21:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791002159; x=1791606959; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Gni+Xpimx1HzcnK+4D8GTpegyFf9CN2x+hfzGZ+jB0=;
        b=bD7kMGt/LBS13W1TnSy6Qf/2YTWtvs30h/YBgHqL7qTko+NIF9zlCmF+9sd+qCZMJt
         2LHRULwORtjLXEuEH2Ol56hEhtZ/5I+1QV6Rs2eUyZlCVZTeLteOA2COUFnWt4eHWEJ3
         Cwezu9w4BEbORry5BCHDnBtSS3q/vq8/LiMeMBhuWI5QeblfsHX3/TVsRuUdLGKYUGC8
         nf7ncctjeIXAMQEZCT29y/l+fsZG+nuX5Ka8VEIZuhaCLlczsaITqfBevbvubN6DYm8H
         QeW7caQs7fnd9brJlyiWrGL++3qsJqd90bxQiATjaDrMu7z1EeDax2/bepdKlolr2QAU
         ei6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791002159; x=1791606959;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Gni+Xpimx1HzcnK+4D8GTpegyFf9CN2x+hfzGZ+jB0=;
        b=aaDFj6WpG8tIURZSUFmYffOnMbhRvjXpU1UYNr8Qu2AFs/PLqptfboP8xZo2Ut0J0o
         2Er3wxB+s6MZdc8MTLuqLg0UAC2dfSsnmkvmsT5BkEa5i8arFzlNqVlVoTVHOL/lgdy7
         bnvtfaivJsklsQlgJSFDFMD37S7iszbcd7H4zVA/oC7XWJ8uTPYNc71cAKVBr3kdMQS2
         I3f+r6Ck/dKcu+Xpr24vb/akTXWEP4bB7dytCSWaDAFuYAitkBvOtrFe3zvWaZj2J4/t
         y3YSiHy3sItcRlOfKA0IXCsIvvZvsLhcTa5CaLHFmUpEiHN8Y0C/i1EzL+9a7LMXRwZ6
         sIyg==
X-Forwarded-Encrypted: i=1; AKwUvBwjDcE7AzRKTAfstL2esit/E3HUkWrKsXmrMkRKx1KM39rqNNLGbL0T8+bbe95T/Tc0FHsyQx4KJow=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJAWjvtUZ5LP8nWLlfgYVBlWW8Nvsh2TeTbr4AcLt0ZT7821ss
	4ZCgRLOQ+mBA43v4byQzC1nwUzU+Cajjt2gDCAtJM6O2tnjv2XLWazGbp5CdTYxC/o3b5nE6VG8
	NT5WJ2r38Ab+nnu1qwQT7d5i45dLyteCsekzQtPjmy3R9/TSX9JWAeK5QLioT7P0=
X-Gm-Gg: AYBFou3CbEREq10OdUZ4KCHFKI+eE4UK30Plh5Pv8f69Zq2BpOXevOma2nZfeH8pxQV
	wrx0Id29RO8EZqqNSzIM7cN1VJx5oJqpC3OEzlA3auPmD+JBvl9WJ88Kvw1VWEfTCLeog7BDCVT
	u8C69k9VnZ7T1U6CO51MsGGpCuupnbYYuYGZV2MENz/LmtxUXHnrKYUC6I351eLTcJyU3qGX46M
	U+QoSHIMFkEMlsJfeeTy0b6mWh0iIwtI/8b+BZGPSLvHwPwG1RMItTCd+v9iPCAWlGeQf1MN9wo
	XI7iKaY/sA8pHMeUuKdJCcsZUMqtvq+ndLuNt7c1hu3iogLdZcwjIp/MotLYi/C62vlOOPoufxs
	qBz/TyuZ5/z8RFDVfIUROsMPkG/KZSQ==
X-Received: by 2002:a05:693c:829b:10b0:351:1251:dada with SMTP id 5a478bee46e88-3511251dc63mr1803038eec.33.1791002158593;
        Fri, 02 Oct 2026 21:35:58 -0700 (PDT)
X-Received: by 2002:a05:693c:829b:10b0:351:1251:dada with SMTP id 5a478bee46e88-3511251dc63mr1802996eec.33.1791002158070;
        Fri, 02 Oct 2026 21:35:58 -0700 (PDT)
Received: from [192.168.29.115] ([49.43.226.118])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14fdb478sm9685244eec.22.2026.10.02.21.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 21:35:57 -0700 (PDT)
Message-ID: <83f9467c-66f3-4ee9-99aa-96e64dff8815@oss.qualcomm.com>
Date: Sat, 3 Oct 2026 10:05:48 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 06/15] media: qcom: camss: vfe: Add support for VFE
 1190
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>
References: <20260923-hawi-maili-camss-v1-0-cbbb42e534ef@oss.qualcomm.com>
 <20260923-hawi-maili-camss-v1-6-cbbb42e534ef@oss.qualcomm.com>
 <45d79c84-cc76-4bee-835d-ed11ce07bf2f@linaro.org>
Content-Language: en-US
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
In-Reply-To: <45d79c84-cc76-4bee-835d-ed11ce07bf2f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LrUHWXdc c=1 sm=1 tr=0 ts=6ac0862f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=+9gQtCFHUNSz6wH2J7y5Uw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=dIRWhvgA580vZDZgd7gA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAxOCBTYWx0ZWRfX8MQvqTmSSbrf
 zfrOeioGwa+p3ipyurHctkXgDnJLeMDefM0Y5VjuB8jib73ldPZVeZANo0jKlYXY0JtrZwqYA5m
 pRBxkhqODQCNwLdYLjbOO+FvhRm2rnc=
X-Proofpoint-GUID: DZrbSmCKOmXDeROk-ZvxjqjspSRZzZ38
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAxOCBTYWx0ZWRfX/Hi/1cCN0UsJ
 xw+RM3L3E2bAyA4tje2KObA225PBbf7/jhE/WeZuXRPWGuFjqTJlh9aYV5gDcsqUHmMJ7Q4rEMf
 JqLZK/tCHWMko7jqAB7H94TpC177DKDAS6C6wZiw5ILe13oc5r3+8gLSIBR2+G71NDbxCdGQe6B
 jgdwPuFQgUvNHpr6k+zwTkOXyIvxAXghdiVhuHDjcNQh1s7nXd/zTYa4JAP1O0GESetpDAjpQW0
 +vlMGdRJ1Tpp2JGBc3/XqWZ5iAzv1Ogr5NiQfmcN4RB6d7duf2PPXoWo3isEOoBM+FkhhRfNwMG
 IcF+xbh0Uu7rDNLHGotLAAiRdgAsPtTlls+HwaEU9NgQsxuxBg7E4GLXmKkZo4IU7geYPWI2DaG
 tOLjQc8n3uinXZ6A/4CvR43D2S8pvAeB7FQ2LvNkZIwXKaf4M73hoSGMzgrq9ZwagLXMofXP4ue
 8jAxOGJTPJqmI8OD9ZA==
X-Proofpoint-ORIG-GUID: DZrbSmCKOmXDeROk-ZvxjqjspSRZzZ38
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030018



On 02-10-2026 20:05, Bryan O'Donoghue wrote:
> In other words VFE 690 and VFE 780/880 don't share the same write-master index.
> 
> So they aren't the same silicon.
> 
> I'll go and find the Kaanapali thread but the feedback here will apply there.
> 
> Name the files per their silicon version not some genX.c moniker, please.
> 
> It _looks_ like 690 and 780 will need to be separated so, I'd like to move away from this misleading genX notation - it may mean things to qcom but I feel we are burying inappropriate hacks inside of convenient gen files.
Agree. Will fix it here and Kaanapali too.

-- 
Regards,
Nihal Kumar Gupta

