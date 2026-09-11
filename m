Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E1E493D37
	for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148561; cv=none; b=pjrnq4xf/nFTnYw0Wl8goDrIKXPi5FyPyT9N+UXwHrMSEuKtU9ab2XtiL+mG6Z8V/s0dNQDXKkD3XQng5Jo9b0QouIbUTtDxRFoG4iqviEVd6TxVg93dFa3RFHRSrT2G8oxYB/EZ6BlkQEwjJIEcCrzaayc3x2IN19NjAP9xoyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148561; c=relaxed/simple;
	bh=kFHvX+j5xnDFzShZOxxu4wH2RoChAV+8BEcmCcK9z/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BM7s1xCTE7a3+phgbYNJleEZOyXBh5kUhu5lUesRHvXiKvgTjyzVDfo+3H+GycMXgb8u8JePAR4BGkYCdsoVMnpUnVxm2dCts6UQ8TNLRyq3djd/nb+y454qAr5OsUi+PtCmK+o539dp09si05QHaKfwUFMxd3t8q2PJLioiH9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C0EXKfWz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pz8XyeQN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C0EXKfWz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pz8XyeQN"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BHWObg810126
	for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 17:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P2TFrQqlwMVNl590WEvJJn/aZLgIQNxcVVRNL0lpuOI=; b=C0EXKfWzS5XqIXis
	6Gb1tYFg4M1KyxffOLcLNKXvjcoAWvw3yp0yb0bHg860ixQOqMmr8cG5xhLRQY1Z
	FZl8ALfgs7WNaZYBypXpwx+kB4RUoEUBki1SD5qjE2eRjDdUaKvbBAdfusTjMLsr
	lQki3HL4VVM0qXdZmBSeXMcVvtMZHkx1fIvD3kpSy3kYW5rseeO/O7TK0KtumofM
	JYFvw61fm+R+WWrjLQO+QUQmMSEg2/4oCoiz1TU4vxaw0WZ2oUpJBokNCee/Ikqp
	Iw3mX7jYX9eBbdOhCDCg2rGSuteyJdJbKpeicqGCJDmmxynyDyH9JGoX0Kx7O3Il
	WpwOmA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmnv203su-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 17:42:38 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-86ab8302b54so1157460b3a.1
        for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 10:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789148557; x=1789753357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P2TFrQqlwMVNl590WEvJJn/aZLgIQNxcVVRNL0lpuOI=;
        b=Pz8XyeQNkOjpyUFVbtMJojglAOBL6/oxuvbdF6okbwnVj9jhFYSjeuhw4rjjpntqLz
         6DgSS1jjcuEAyb5X2bn/tn/KD0dNrHyohYXyPh9Z8BoPPMjzTpDRWC0RHKPT1xfhVDrA
         KFDD68MtvfsKD+6XBjEkC5mTITNk2nRJnXLlxIesmwMWkl9S7VP4r1MHbFoEihW721hV
         gamrC6jPNVNqqIqu0dme1JDlfkjA/94b3jIqOf7GO3DLmZU5ol7rq/xb8bIVmwk9achg
         jt9D3KrJuB1vEk/vMDt1J90uWNvK9Rch7BS6VUlxWhnsgwYTiAwU6u3owJW7u2yk4W3y
         qAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789148557; x=1789753357;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P2TFrQqlwMVNl590WEvJJn/aZLgIQNxcVVRNL0lpuOI=;
        b=DHgO/oLcp0Q2IagP575O398n9MWsZ2MIvT1dczXWe6U0SY1rkG6MTs2EtqMuShpXyA
         yJ5iU6zfAvS1eS68ajFwZJZKJ63cK03frX8EgrFAADiyH12YFijzLOdCHxUkjeIEkjLq
         fJ1aEhHkwo4srYC+2CRPZGSZDhfIxVNkj+cGzMRCjoqHvE2mIvv6XJohqPDw7UnDroFD
         Gz2GmrUJHboKBryBO2lu3TTkiTUfX4ksLy8Iy774c0xMyic/doS6wMDEDIqycZBMnB0C
         ZBizvqGPYHtRE6S+rl9UEOgfNyTRftLUt17D+CLsl8ZIsbI7KosQ62uXPTcTKTyK5MJo
         uBRg==
X-Forwarded-Encrypted: i=1; AKwUvBxEtn/uK0PfAWJfM4iRDMRq/kp2pD0B6prfOfTqJO1vC2CO0Ue3xsX6c10bzHNDuQp5/OJmkKYwwv0=@vger.kernel.org
X-Gm-Message-State: AFuF++n61kJdNQbqQNABxuLLcXXmh3zdFVGjP/zjloM8RqBMc0Ye9FFW
	YO6shrntl1IP80Y+rHt9rlp+tEjFBKaDtMWZ+XXLly4wzQzoK9pQB8XXhzGm/5s0oyVx3g7Ss9n
	r//wM60lCpL0DNR+3CNn8TKSCz4o7yZLpitJsPaVaOme49nl7e9mcXCUMSGmz6K0=
X-Gm-Gg: AYBFou1IMUcOSw/FLYjAzt/xBdKZvOg95Yzyxzqr2s9Kc9XjzjKsrPOiYaZwRDbzNDc
	7QeArO/0V3tvGRw4IQHfzijMmoCRqOdbvHFDw8E6B3PgIaS7YR9849Xcw9x185lgumZNvmzdzhL
	tUV+O4WQjAC0BTcTDaBwCmgQ5dl4Rp/986D+nCBQROIMwKLmoM8m7zeCtS+RgngxZ7Bnb6iLRuE
	2C9DZObcR6RTT3/697NSbkxkaFSINDM+zBkZfA6WrULDWDa7liOJ79COte3SiCthJZMimhBB8YX
	rjDgnbjZSmmAGjOstU/EEtzY0ll0MXD5icwx5qyNJh9f45C2riJ1dBDPAaYtkYEEEdMS3P+CBHi
	0Ih0IeFiMXHkgxqk28NcYiXPusKKe9+uU
X-Received: by 2002:a05:6a00:4ac6:b0:84e:89a:b8ec with SMTP id d2e1a72fcca58-86b31ef6e46mr7785217b3a.11.1789148556930;
        Fri, 11 Sep 2026 10:42:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:4ac6:b0:84e:89a:b8ec with SMTP id d2e1a72fcca58-86b31ef6e46mr7785156b3a.11.1789148556310;
        Fri, 11 Sep 2026 10:42:36 -0700 (PDT)
Received: from [192.168.0.6] ([49.204.105.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b286c49d2sm1515413b3a.10.2026.09.11.10.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 10:42:35 -0700 (PDT)
Message-ID: <e152a20a-c80e-488b-a875-404c916cccd8@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 23:12:28 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] i2c: qcom-geni: Vote for SE clock rate using OPP
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-7-091697dbeb02@oss.qualcomm.com>
 <fdfbd73f-8739-4845-ab18-c5f59898e192@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <fdfbd73f-8739-4845-ab18-c5f59898e192@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDI0OCBTYWx0ZWRfX9tZmEKS4yxac
 4x8i4fke1XMF2siQ2xlHnNWeRoUFO+yW2cIql1Mu9xMQF71sWdtyXgIqEB1ZUtq2KR9znlJk1iq
 4dLeuqSLipW/GdjmbM6zvFlO89XZfr4=
X-Proofpoint-GUID: cPGZYNragwesgDpedkmg8F_mPg9IySaK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDI0OCBTYWx0ZWRfXxM7Kzix+7hoP
 ZT5M9u40+Ordr5wyvm7Bz6cSH+1AhmVTk8exBbNErWG3VBGVQX3cSPLn0nvKWPv5AKUVCW8HE00
 75vu1iddGfQt+EzSqLJNUo3IyllCEvB55Z/9lK21QMukNFENfaRU+NtSQx81xQ9ck83WdeNQraJ
 BVngYBxZJ0Wh0pIKf4VxYwP8vT9RKM+kDPj7mSDscMAmxMNe6fd9gqZ9gwxYFGjAMaCx1RDbjwE
 g8xnpX990Y7nUfPJ/ThS4SG8768amJIth6NpLHZeNsNWrjsvQcVrKlf6Zebt/26XhNRFTkQXiJe
 v+3tMna8tNBP4vQrhj9BvXIKJ1ULHjSSrd13hYkRZMAPud75tO/D3hAlJpTFfR67sKB4cldC2Fr
 8kHs/P2x11Me6iKS0bhX8qYObQaUmjTtYcsuiFnwqb2BoacNrdMNgn+aGXDr09+pgrkYPQQWNyT
 lu1rchs7m+Xxu837ZvA==
X-Proofpoint-ORIG-GUID: cPGZYNragwesgDpedkmg8F_mPg9IySaK
X-Authority-Analysis: v=2.4 cv=XvdvqlF9 c=1 sm=1 tr=0 ts=6aa43d8e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=KFINdI5Z0390/lZYonNNQw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=NZ9nq7LxGt4YLS7AZqcA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110248

Hi Konrad,

On 04-09-2026 14:22, Konrad Dybcio wrote:
> On 8/27/26 7:59 PM, Praveen Talari wrote:
>> The I2C driver currently assumes a fixed source clock selection and always
>> programs SE_GENI_CLK_SEL to 0, which is not sufficient when the controller
>> needs to switch between different source clocks.
>>
>> Add the source clock index and frequency to the I2C clock map entries and
>> use them while configuring the controller. Request the required
>> source clock rate through dev_pm_opp_set_rate() and program SE_GENI_CLK_SEL
>> with the matching source index.
>>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
> [...]
>
>> +	dev_pm_opp_set_rate(dev, 0);
> This and the below call are unnecessary, rate and enablement/disablement
> of a clock are orthogonal operations
Yes, you are correct.

However, in this case the rate change is primarily
used to satisfy the voltage/performance requirements
associated with the selected source clock frequency
rather than the clock enable/disable state itself.

The runtime PM handling follows the same approach
currently used by the SPI and UART GENI drivers, where
the performance vote is restored during runtime resume
and released during runtime suspend.

Please let me know if I'm overlooking something here.


Thanks,

Praveen Talari

>
> Konrad
>
>> +
>>   	return 0;
>>   }
>>   
>> @@ -1236,6 +1249,12 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
>>   	int ret = 0;
>>   	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
>>   
>> +	if (gi2c->clk_fld && gi2c->clk_fld->src_clk_freq) {
>> +		ret = dev_pm_opp_set_rate(dev, gi2c->clk_fld->src_clk_freq);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>   	if (gi2c->dev_data->power_on) {
>>   		ret = gi2c->dev_data->power_on(&gi2c->se);
>>   		if (ret)
>>
