Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA653A1E73
	for <linux-i2c@vger.kernel.org>; Tue, 21 Apr 2026 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762861; cv=none; b=P4II6oWqpAsGCS4V2+G4ijFcSsY4K62v3rDKBidLncr7gUBGqyC4lCcHjuMmsG55Xwm4cZuTyg24455PjadL4St+ZPlp4nwLAhNJSbUUadqtMLnAt7yre9OI+xEC9Lc3B7LIN/PTylopBbhuUZdJeDjTfhk1UOw5gx8M1xU0Pos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762861; c=relaxed/simple;
	bh=c2RbYcy+iFlDl5AFfa2xTzWrlBsn2+9E63+1Jd4Fxzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhWDpjycMeAszYOR+H21ytrpG4wRg3d5byxaTROGRrWI9PetYZiZJz8IpRv+pxO4AbPWx/DgbSktA289seav06pkcDjwbx5LX2L5z5tyfBTSk0L3DLmZl+J1qThBDl4/Xnmh1myqYTsCaR0SUA4m/FEJHTSbP/h04XPyyGN3mpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iqxyvcKQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q7vTy7Ho; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iqxyvcKQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q7vTy7Ho"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L7PETG1127573
	for <linux-i2c@vger.kernel.org>; Tue, 21 Apr 2026 09:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4GypfJ8XGBKC4oouCH61ngZdwxT5uRzGs1MoGPINQRI=; b=iqxyvcKQXqzx3s+p
	isFMG8LLzkrLwEBXUXzJs6T5c/yxBOzup3/CdgC8Xu93oejm7P5N8APh1fTtjNku
	CP5F2m4fLD5e/ELMR95SjYTiu6Bra2c3J2xU2WNjDbN5exSGiPLh48EMDMBcvLIY
	XxOwvMzgth75so9FRHqabD/8+6VT7UuTTbiOplYAfSf1XiqYTmmt1IbPArY8hwjB
	8iIk8RC0s1KEX8SRDKDXnjxqUDixdOB9PVmhnDl6D14ozN7FeYkBcd/+GtF2YOsp
	lbwoQ6ZYiBZ3p3VuYvlF+exsGjpVb23Xu9yzAnSfVCIsDAkzF7wv7LNABNVO76rt
	8Ew0NA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnw68sxc1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 21 Apr 2026 09:14:17 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35d9e67f6dcso608220a91.1
        for <linux-i2c@vger.kernel.org>; Tue, 21 Apr 2026 02:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776762856; x=1777367656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4GypfJ8XGBKC4oouCH61ngZdwxT5uRzGs1MoGPINQRI=;
        b=Q7vTy7HoQ9ZMRNFdRDOqJFhxUjgGmAUuqbCbhO0WSGIjI5bA7H/VrGvm9xMAenGAgv
         xD1HIlzmZINHpDzrtyxmguQiTmz7ezEMf3ybdH5t4ghZUxfL2bRskWJbpwQwI3+e31re
         3DTRhC4jtB9qF1WcQjTwA9eNYsSa5+bLBSFZJUE4jgGL/KD97bk09jxI7AIQCU2eBQGR
         hC0jCNVAtO+FmFKDxEvbeM+j62VhBYJDQf+8BybhtvHtDUtpUvuD78PrdeMe/8eonwn3
         gXgOb1WAETPnIEWDSPKiv/rqsIkv4I2uv5rlTjNv1oAT/7dNcAdt86mLzTGXGr0vgw+s
         O2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776762856; x=1777367656;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4GypfJ8XGBKC4oouCH61ngZdwxT5uRzGs1MoGPINQRI=;
        b=F1g//2xr8xuiw4vRL/HHOmLl9ibkG89biA23AuBFIiNpM+yi65MKjM5TAows9D2ySR
         RC7UA4iFZf5X0VNYd8x5e5FQL75F9PcSN/wtc9JeHmYPChLVmG7mvFh5dja7wNaZlUrq
         6svh6eklS6V9EaI4saTlfPlwIQP6KRNuthkhgvK/D1yqpJE22aS6vEbtxBRXLmmlRFpd
         QRJfUs6IC6akKOkyjONd2O8q3fSmqNYWVrM1DupAvo9826m4mpEmpS3MoBGfor7oqZOy
         34NzwTmxLZME7WHr89frIJm+W+3y9vbCEf1Z+Siga4+9NS8h/A75aU+A/2SA/qQyL7qb
         0EGg==
X-Forwarded-Encrypted: i=1; AFNElJ8fz0pSurqRfEzf7b7g3FtFavZ3JQ5Whzh4n0pcE/5yVXB2BfyhFTVLo4up5J2c3DF4zcYFnqasIfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiDXeWEFa61vkl2lqUSIt4Y9L7i1pan6EB57pm/lJYMKzttryr
	EMb9q1tOEbbyh6rqnKszANB4gBpSURt6LUnQSmRQ7LtDIJuUxMExwD1TKwbDWXTJm+6iZxKbad5
	cZe7g/I1ruF54VAI48XAFOGVI3FK1Y913crN5Q0iii8dF5U2P377soPhYXbHQdSc=
X-Gm-Gg: AeBDies2Ve4Ns5XLHstSgoMBZUn2PC7tRhVES10f50NKaNZeoVjsF8QqQjcAe3cHYe0
	NfSa+NER6So3Vn33jEAC+XgiplB9Ebz+LRGaCGvAUVEt5/tYBzWzOrUPbMnC88TWDu+psPK5ZOG
	VliLGWh2WY5QAQckcYwnaOjUkEyXc+A8fQiQlw+CpEIPwc7nbr7m/9OOWbs7YtaM0tvHBUC3bEj
	GMJji7sefDU8hJhGN11v52wrPooYWGcKcjrSWhT+0g8y3IpSsbUurLflLmBVJgbI6ozdJYPGw9q
	+fZp5+nrZlImeEuA7sOhxeGtoPTUte9/hkBvxJlMqVLHGAVYQ3/WimmhNGJB0QJkZ3BTlDm4qW4
	zRBNyIyWuXAiPWDQ2UhDxnJtV9zEByIipOEuHSJTTSk1xKU06RoohaVLXP6eTdbdH1Hw=
X-Received: by 2002:a05:6a20:12cf:b0:398:ac0d:9a0b with SMTP id adf61e73a8af0-3a08d93976bmr18960835637.50.1776762856234;
        Tue, 21 Apr 2026 02:14:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:12cf:b0:398:ac0d:9a0b with SMTP id adf61e73a8af0-3a08d93976bmr18960794637.50.1776762855798;
        Tue, 21 Apr 2026 02:14:15 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976fa40b2sm9292596a12.13.2026.04.21.02.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 02:14:15 -0700 (PDT)
Message-ID: <f8d43a33-3b43-43af-8ada-9fbdac2df7cc@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 14:44:07 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/13] i2c: qcom-geni: Isolate serial engine setup
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        chiluka.harish@oss.qualcomm.com
References: <20260227061544.1785978-1-praveen.talari@oss.qualcomm.com>
 <20260227061544.1785978-10-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260227061544.1785978-10-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: C9g23uh-FFboneAkUsp8q_-GTxHr5GqO
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=69e73fe9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=3uQcbjdxft5aBLpoArUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA4OSBTYWx0ZWRfX0xbG6Dxxj3hB
 Rx6VFTRmoDX3fMfVlOJzWeJJbuQIqGWQQF+gW0iVWNYougDb1NV4T7vKtAFgMaIc0SrtEzmMlJZ
 /a8F54AO2fES69lhdlBJAvjLNhFJyTz9w/UNSIt7+IoqussqFuz70anAkH9LQF8sy3gQ4xHaczn
 hjIxKas2KCeuUCJdya8X5JZ81ACR6RJIZIH9Z/eOHwzzLpCdF/1aHYkaT4O1x9zMGnLwZvhPyJu
 9PYj0fIo9NPtrGRqPbV0KbEQCpvatnUvUri4N7mnwIUf9CDkkEC/pMbOIY7Eb+earWJpt8xggQE
 OvRCGiUA3NKzs/8wZoqg/7on38xcpvmBgEwLiKlDe3DDIlJXdOYLiB6y3tC/wOHVGRKFk+T3ao8
 bZmM3oZ02yQZuDB8n0leTwRydJj1c56Jc0MJDtiBWRqGViRwBvcFIJcnqdYHKdaMY/jPtfiRLM3
 VLjodhy7dH3ksqubd6Q==
X-Proofpoint-GUID: C9g23uh-FFboneAkUsp8q_-GTxHr5GqO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_01,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210089



On 2/27/2026 11:45 AM, Praveen Talari wrote:
> Moving the serial engine setup to geni_i2c_init() API for a cleaner
> probe function and utilizes the PM runtime API to control resources
> instead of direct clock-related APIs for better resource management.
> 
> Enables reusability of the serial engine initialization like
> hibernation and deep sleep features where hardware context is lost.
> 
> Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>

