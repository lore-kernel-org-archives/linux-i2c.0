Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E670468C06
	for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766594; cv=none; b=YhkhSeKhEioweqXmTAtq5nSjTCv1Ia3yjeVndEsHCRTWvHqds7j2BQ933n3PrWs/WeTnlTmviZlsss+RRegg5FQdyv9p4+7niFs+NmFMdxmQu3B8hL4I3VL0zhAJf6U2O2qwyVnYEVs+3p2QhGoh1INfqRqG3sFfvO0umFPhIOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766594; c=relaxed/simple;
	bh=00A4izmS3+qqC6S9DjNshzjIp420gqhDfuHUMZL3ozo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lcYvp4t5+lzOvY8jXi8vHB2NVERP8hrZZkaGbDeiDZJnEfzjV9bWes27qk1nIFezZRaUhdqEqGtQZ6dFYaMczVoVAfwO5T0XH1KyIR7jbvjf1tdaXoKkFwBmnA02Cj8JPH4Bck2Y12XxZ3y89v3u6A9mSi5CHH2GczHPJQzHSHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ORr9shmd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UnQmKCpO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ORr9shmd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UnQmKCpO"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UB7aSL3547293
	for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 11:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jdREyfHkaKXyyA2KgfRqNuEH6FRhqqn1hFmmztPRCyw=; b=ORr9shmd1lZq625v
	bVNgw2g+TMvKu5RGuUJhe+EUi6QxX3PaJ5IQtJcWedfQ8VVsYzDz4NW9SdaOzLtM
	tzci/c/Rbv5B1yWmSN7I4u9e0ULaUhqtIaEj9Q6BkXpCrcu1pHLQFKnIHq+Ev7Zz
	kehui+ueLSIOv8laPZZWiwQQlo0P2UV7ZnF8dEdtYNcFA1+JFm8GBv4KJQh1/DUu
	bYC6umuFudGzmcINMPDswVDneEvX2EFWlugQAowC1Bf1RPVCGTE78tReVz6MTCQp
	QIcKUA2KUD5xyznngLrXwfMplGR7hJN6+OPzIQrISr5dqO+QC2GYzie5sjLpg3Ux
	k1xKlQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0w141875-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 11:09:52 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-917a04d1cb2so1045086d6.0
        for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 04:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790766592; x=1791371392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jdREyfHkaKXyyA2KgfRqNuEH6FRhqqn1hFmmztPRCyw=;
        b=UnQmKCpOmpBlUsDtrxoxuis1otfaQILbiz/dO0t5TRRACIoYox8tQmwe8h3F1JfVvd
         XFV2j93+5x9HTIY79bfLzrNKUpOJmyPAD9zGr9/88eFYHNXgHViNknqdgryy43wo4f1J
         BbC9XHL0NsRGOadPuCBDCbB9K4R5f7UGJTWI4gJOhZLZEskJ3nGD8Y7B3/QnZdF7kZUu
         lcwd7rxumh3EB1HdmqPa1yjgiP2LRVanIG1JML9NlgfnpLt0N68uAgspVAX8+NvMBh6U
         1WEe35MRi6LwLsVVi67Yb254RYCafQPh2PGrlx21KZi9dCJZltFRu7rF9bPPANjB5cud
         Xw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790766592; x=1791371392;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jdREyfHkaKXyyA2KgfRqNuEH6FRhqqn1hFmmztPRCyw=;
        b=dx7zg7cUsAp7DCfV21JahqgPAYUN+GS3WTLXG35e/MLMiEoHTPWlFjbY2SWmUCHbbB
         yAA8PKU3UWAsAflUpD+sTe4iLTshRn7Z+TfWW43MEgfk4fgWM1pvOrh03wAL8PnmJb8T
         fAd1wuFGqjkXXG8+OHkVV2THpXk/s5mqajtV3Z8sBA2rFHxRORNhAY5ru0w/PfaduI0i
         plAWn5usFjyLntIhtumKz6HGGrpI4ZQ7FG2jxFRUeuIKCoE8bOtzJiXG8xDEDRIMJFpM
         yg/iY9HAljywLKhUbhkJu8pgBnHIc4Z/miUNVdEsfW3MxWAMF8fNUhVs7aB7ALbLt3FZ
         DnTw==
X-Forwarded-Encrypted: i=1; AKwUvBwfjrHKgrX6Kd4s4m+jQEV5WjifLAUN3bZVrfFUp7gl8Xw644adbV/xaqLkD/2ZqT/Ew3ejnnzEB/8=@vger.kernel.org
X-Gm-Message-State: AFuF++miA2gkHibA72iM+iOfEQ0Js1qeuv26SEv/Yrvx9f3W3CzN9C0z
	EVc7AS+jltvjje5iXqKMB7pVxaWNe+EXdRm3BCJVsy2acxCYruXgCeBxxv8ygXKLB0VKMpoiU1i
	UqxxZITTuutHbza8g7PcbMAB8dfwSFcwVYhg3RmRitPDTTgjYobtv+XInQ/ed9fQ=
X-Gm-Gg: AYBFou3aqDlMfQjX+G0ZanllBYZoQGSXoDY51hZuz4PspI8TLU1J9Uex5y6nP8QTtZP
	/6uQb9ODoZSludo/6xlG0BgBOprbaBMeIci7EeSZeL7X10iMrCVn8IcAAoZ87ugF1q5sbmWXimt
	tWuQH1g91Lho/kxvK7n5a0qxPVO+yQVcFkfZv4tpV5d3Lgp7eug05yPGs2c8F+tbWbG1AQN4HJC
	VveNF//oMB/AJd2o6E+T9ukjtkA7968+aq3pbRtM1Zcv2+bieslJLOUi7WhR6cqdJ5FfZdoSQb/
	YrwI4HTnqtcbSqzfvh/jfnhBfE3wIW5mm/9kEqF0NttMS6FPo44HLM6DZgS381XZTBEQuVPhbRW
	b2ypYOG2a0M1v7VBlkw1nDA==
X-Received: by 2002:a05:620a:261c:b0:939:b8da:1242 with SMTP id af79cd13be357-93ca93311ecmr149389585a.0.1790766591446;
        Wed, 30 Sep 2026 04:09:51 -0700 (PDT)
X-Received: by 2002:a05:620a:261c:b0:939:b8da:1242 with SMTP id af79cd13be357-93ca93311ecmr149384385a.0.1790766590966;
        Wed, 30 Sep 2026 04:09:50 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae15c73bcbsm644653a12.37.2026.09.30.04.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 04:09:50 -0700 (PDT)
Message-ID: <5e1b9e97-d4b8-402e-9c72-782c0a73e4d9@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 13:09:47 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 12/15] arm64: dts: qcom: maili: Add CAMSS and CSIPHY
 nodes for Maili
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>
References: <20260923-hawi-maili-camss-v1-0-cbbb42e534ef@oss.qualcomm.com>
 <20260923-hawi-maili-camss-v1-12-cbbb42e534ef@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260923-hawi-maili-camss-v1-12-cbbb42e534ef@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA0NCBTYWx0ZWRfX4L+Px8srGxvw
 Kq1IUkinDt6iEukG3YFXOXcrPAH/wyzKJv/5QK5HT0NWfmpURJpF0MGGiMSzl8q0HZzi0TJxcKA
 kFCbq+UJ6KozMYp8/9GThCOvIUWxkT4=
X-Proofpoint-GUID: 3NaNA03qtpR9usWYD4Ne0OBSegyqGXHh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA0NCBTYWx0ZWRfXwzn2yL8LRwMk
 VN3OEtTXR1m5e65zkbC3cSKne5yz2J62bfHaF/MbN/L5s2ToBRLXPNenp3CewthswsNC6keCAL5
 NeNfMjvm47SvIprnx2iRvokKf+nKp+1TU4gSSHbwbZoRjYy1yTRGPouqOchSdmVt5AfT64puw22
 kxJQituPmBpFiBJNjelx7aipxSR9Be+alijhk+ABuEEbq4AL5PajklyNVNYCvJ9bpREClzMbAV1
 m19xPvPu3qUzYwuJLXO84naVHifFVfr+RlPlYTn6OH2i/lQucs9BweNguuy5mMi5P2teHtA3PFM
 L9iPow54PTqX2Em+UHSM9mHO6AIyd/FxbjQM64D7h+uzgYG7E4Sileys/epEj52fHr9XXIzkni5
 BgYESZ5iCzT5tpykfv9XzBS+zJS/1HG6Ky+2U7whJs36pa/9/uq40ocHUWKQmCC7F1Cikbr/sXQ
 bvZmQNTr1LN0QbrnTig==
X-Authority-Analysis: v=2.4 cv=J8Q/fwnS c=1 sm=1 tr=0 ts=6abcee00 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=PJER3EP_5_adeMidZ8cA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: 3NaNA03qtpR9usWYD4Ne0OBSegyqGXHh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300044

On 9/23/26 1:02 PM, Nihal Kumar Gupta wrote:
> Maili uses the same CAMSS IP as Hawi with five CSIPHY instances
> instead of six. Add CAMSS and CSIPHY nodes reusing the Hawi-compatible
> driver.
> 
> 5 x CSIPHY
> 3 x TPG
> 3 x CSID
> 2 x CSID Lite
> 3 x IFE
> 2 x IFE Lite
> 
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
