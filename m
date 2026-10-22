Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792672093;
	b=BU+t9nIZ9y4jdtGk/UhLvrhOfLXiK1BGXzWCBFcffHGHTlJmFx2R5OY2gpKG2Rsfbekh
	 A7OBZnLslMM1d02fhMzCn1omvxL8NsvNzIXUJWdsWAQQHKU022s+nbQ3UHPFM4QrlO6sU
	 iZxnbQ1Ju4dprRUFkXRqO9r1d6SIM093f6lrzzi4PQIdzciP10imk3j1Prk2uECUc15FT
	 8e4PE95Yzh3a+ZY7qQ1f/j4IKexkoV7RHs6VW21RV6FZDPw+Mmgk7bgYNzlxzZkojRtml
	 BQo56T75GHRPthHVLnrpaMAsMxakqEN8cwXOsDB/5/UBO+7n9CLWRdpR+GR1ab7JZcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672093;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ffhVe/j6yRlCzr2Q00fG+yNfZLrhxessWH3dfhlXdzY=;
	b=1O9sf7Y+raoVxuhph7n8gE+jHhcDwQMHqcVVUAdouYqGpJczNdzxo7QFJJ021R0NC3YD
	 OdqijhiMkzEmoW0kWzr5k5W51tzN4KyVjgfTXbefYar0Wl812FiGbr2VC9nAahLgUddss
	 rxVZ8BKEHB8MMLeKyUTuOuXEWcp5NCJvKtY8eY0hcMUbBC0UrFr9EowNB0aSyO9zsKplc
	 U72OgYIMpLFsG1wbIJN1drSZxIthC3xF1GbP+tfZQypRP/2Q0aBjUDvXTzVbRJmpDJmi3
	 q9J3A8psy3x+3TkoJr7LsbqeWlljD1ZWPXYkUxHrntggbg5FEA8TqzaFoYZ4vBLrpEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qk7LeKmg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="YDDvB//5";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD74B606A321
	for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 12:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD74B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qk7LeKmg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YDDvB//5
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA0AbN2918706
	for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 12:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ffhVe/j6yRlCzr2Q00fG+yNfZLrhxessWH3dfhlXdzY=; b=Qk7LeKmgKfl8ASss
	r/S31nkFb5YhbcmUSm5td/BECe5v1/SgAUKL+3yoqW/lRibA20tcdz8GOCTejfBg
	SJnhc6mDE3oLYQ7nfvuFZ8AOxYLsPwr0r1E38ln8TXP18dG+8EWHGPBJlKfBr3fE
	VcGF4BIJOrqH5FDylxqT4Lq/KDCj1IJpqJhG5yfK7/MIdqpE/fgqBrq9Q/nILTw1
	IzY44rprRytmIoIGq05urfI+V3wtpeFQtS4HFrD3I/HhyzSUlG0u+Vhxnhui2rLv
	qbPfovCQT1cJYHYgXzKW0O4anTJTXMj/jGOLvJ/icvRKkqNw4umV6qAIrYgHlM58
	W+/f+w==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ab7et-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 12:28:11 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-82322894f5aso1222989a34.1
        for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 05:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792672091; x=1793276891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ffhVe/j6yRlCzr2Q00fG+yNfZLrhxessWH3dfhlXdzY=;
        b=YDDvB//5wUrrsMjA+YOjITn6gFH07RI8ByXRGm5tbEi/x3FTKojCVivuRWJ8C5RsGE
         hpAN++kQIO2OzyiQI61LcvkrklJLzwQhpZe0FPXz+0w977W+VaOzM0xrifW2TDcLrySu
         ntOAlduDV/IVdjKapF8Sr0LDsRgzDICMUTekO0VJsHXE2UjAySxZ6INfhIbHZwZsf/y9
         otgi6zR74w7vRYgkYAy4l2d3R4CCVY9tNUrFutkieB20d0VTUXkEcX85/XMgBYH/YwCi
         7ePqJ+8bn2e1Jp2AVdwBRmo2ZNnqF/m/kfZDxOIoGZ6cgr79hzVrAZCvEoZwSqBKuQnl
         Dt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792672091; x=1793276891;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ffhVe/j6yRlCzr2Q00fG+yNfZLrhxessWH3dfhlXdzY=;
        b=vqVf9vjPIcQvp5Rq/IOnacFvbpYkwq3e/mcimDW3k/whMGjmKyfkUQ1jmUvSj9tRF/
         dTldfcpiFJrRfo+FIXI9UbWIJj+vUepqAlDm/6Jl3yYLcdJAduurXTv+BqmjJnYJrFTJ
         /equtx//vuBzAUsAfJTpmulDJrHlNMqWbPWjGvB+VPMhPLU1g/D3ODpBWuEY+r9yGSDU
         h026AxY4KG3hddZImAlgIxqJgOCYfD5DoAklF/+biGGXXgMiD6x131G6Q00U4SjfqlXG
         5UllcVPTyDtIByMwDNNsW22Hef6OiZ9RWSVdecr7CbmH3qi+FLHyQSSsCP35BojnZR0L
         U85w==
X-Forwarded-Encrypted: i=1; AKwUvBxFIqrGKXnfWUD21STkayfTbF9JtrMu5kaSwAXA1oOkWoHXOft+UAUFfQbI2ButDM9bXSWyng+8OFk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpUJqanZfusGQOrAJliypugvwnTnUraC36abgySmZjPcWipDnW
	+wifiU5J1kLWkFbq9NVx6UDLpcASrcbNm61PyUi44BrT4LYuXPfRBER1qp+H4oVQkAKJk29PCgI
	PeV2lUHV3Rl2C0cEBvGMSM8CIWr8DBGVQv2+jtKwUYVDwutW35ZYPCD5xENsCEX0=
X-Gm-Gg: AYBFou3EjN4uaZTaY1dQXE4ARue9TqlaM8xmtZZhJQWRQpO2ZFscCUZX86rEmfZcr26
	fo8YTL51F/WBGM2Swer2s/ZOGobWzzd4JWChXlVNZt3WXCzyip6O2G3JhyM8N8WdVCg5rJqgvmO
	eD0mlOutJxAtT69tn/SaflNj9n9B9MPgXdgM3IdcdTx7uU/000b3YLmmEJnsSsu5eDvu0/dg7eV
	ps8s2cBGso6FC5VWN+NEwBOAyTy8cnwwTgAsITow4/ML/OZCh8nD6IQD8S+/z/V2OFfI5f4R5WT
	doHORH9VulNq4FQ2LRmR22vb4wWfnLKrf2RCtf3qSCKxjaWv4T9nJb0G8sURWcDgy6Rpd/5nazH
	yXMFNlJPXy41pXQU7YVVEe/vKEzJeWOUl
X-Received: by 2002:a05:6830:6f88:b0:7f9:555:1def with SMTP id 46e09a7af769-84e30c31e32mr1258625a34.11.1792672091187;
        Thu, 22 Oct 2026 05:28:11 -0700 (PDT)
X-Received: by 2002:a05:6830:6f88:b0:7f9:555:1def with SMTP id 46e09a7af769-84e30c31e32mr1258609a34.11.1792672090792;
        Thu, 22 Oct 2026 05:28:10 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbcdd9d82sm4892517a34.10.2026.10.22.05.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 05:28:10 -0700 (PDT)
Message-ID: <d6a3a783-c6ec-4f93-83ee-ce30848917d0@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 17:58:00 +0530
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] i2c: qcom-geni: Vote for SE clock rate using OPP
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
 <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-6-5da1096243c9@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-6-5da1096243c9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JudkP84C c=1 sm=1 tr=0 ts=6ada015b cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=gi_f2RLh3HdMVU9WvNgA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-ORIG-GUID: YG0-iSDsF-ei_3fLPejDrLobMs7p06NT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0OSBTYWx0ZWRfX/s/Ejnm5Ngjp
 7cISk6rc8YBYlB/klB901mZ3mzccTk9TsGDeqEG49q4jVqDFQMxDxgeWLMGr5g3fv2bgKCTcaBe
 K83zP/EPrV+AokSajSup2PphhwltSSk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0OSBTYWx0ZWRfX0ozAnC9OWjwv
 r243EnB1sJCMS65qiS9kvCVZRyTXsCwJI4w7S9EKfNpCFjVtnUijodWSRWISTF+uobl5BDknAc9
 QAtBgCCgn895hz6wsrOcgZ+6y2PmT4trgk7s0Co7dFc1tJGmGAQMR+TE+C9GMIa8kfQwoYxgBRk
 1HjvFTqHPuThEKI1gtg6MzwZchcOTVn9n/PU9h38UKJS7NFahCeKD0A6SrH7s+bBqAKRW60cNmW
 UsXp3KugZaUGu9v5g8qLSKb7bGJzN3UrxMx847f7WEtPqCcqK3ZkZNcqYAiH97h/fleB4nH4HsS
 vX4YBgVGpSglgm7kQ8VHIrcctodBQWyZ5RIYdcwonHjnhdJm/KIf2gSZedr9Ps3OTiXmtVC6Uqa
 YQ5rbr7J4LYjrRsg2Ej/zT6KNdg57R9VNOrvLbQil9qEiCnJ++ugK6SWdEd8s5MyA751UpKCQUC
 YdQ05uZoB2FOrkyxHkg==
X-Proofpoint-GUID: YG0-iSDsF-ei_3fLPejDrLobMs7p06NT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220049



On 10/15/2026 6:28 PM, Praveen Talari wrote:
> The GENI I2C driver selects a source clock based on the requested bus
> frequency and programs the corresponding clock selector. However, it
> does not request the selected source clock rate when OPP-based clock
> scaling is used.
> 
> Store the matched source clock frequency and vote for it through
> dev_pm_opp_set_rate() before programming the clock selector. Also remove
> and restore the vote during runtime suspend and resume.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
