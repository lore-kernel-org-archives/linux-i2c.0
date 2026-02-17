Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663AB33373B
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 11:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771328395; cv=none; b=MU0fYbUQFQnopM7/bjWVKyDOKNznL5LSRjPfLmXqOG//jWvDtDRd5QYcFyqEwdjTcToD5SXR5+3orcqj/OyjHfGEUnubc9U4v3nYnB1K3sfNURPE3S0zE9CcrKwuGDi6tlVwWpxlu0Tu7AV7xISdsBceovJoY7STb5nF1nGNjKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771328395; c=relaxed/simple;
	bh=QsuwglBs+zRzTr2NV7KRHwtUPNxAO16CZ3Y0FqqRsAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uix54H5x6sdcXgPcjgO+KITX9904FcaYM+od+gIcBZ3h4LNRAJot/iefiI3RuCpb2C/3xDIV322M/dimqjd3WrcpMtQL8APLXlOVWUcghohuc7X4XcEaIrsakMm3QqS/l/cTnFGJHOLW+iGfyC7f7LbL+d+T+IfLqKN9eoeZKT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i5L05+bN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rd4sx2Rm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i5L05+bN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rd4sx2Rm"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GNUZwZ2417574
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 11:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WEaN+TOcw45eckwzgu0y3RymRNT+PuKjJJFzwTDz88A=; b=i5L05+bNtTk4Kp93
	dGlKEUw9UMSKqJ6QKRUcw7saSC0kSLDcyny6oEczG65A5c7BjXQf4zwIEl9MM9xG
	YZ3yVAa4OVFMj3Q8C3zkC8A6Y91Ksjf9+0uJ23dqWmQDOsD/VFERJYfSV1l1R0m1
	HVqYS3HbOFvQ7tXuY5bZf+V23aQHfdeZJgha9JebYt6d76lGfiCRAiqhtpTSjRKx
	6e65t1LzusUCt5pbZzvojTvXlaPS9zPLGTDlSsZdb7k7VvosHXEBROB89veqhHlv
	JtO/7/e0qeIUeyfkwX9/0NiZ0pdR+o6NASzOf1QJpPRuHlMseuBY1ukm2WzAYkhx
	fVXkRA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6tma2hj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 11:39:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb45a6b860so225222885a.0
        for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 03:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771328393; x=1771933193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WEaN+TOcw45eckwzgu0y3RymRNT+PuKjJJFzwTDz88A=;
        b=Rd4sx2Rm8fHEiKxxE3yATwe7qKN5QITMMoT+VH2iJfFuj+xhnFJSyEIZe7lHQq88vt
         7hAyBjJLRCU/1cSNQKlk2H9197HoYRs2xWxD6ADnsBbuP6N2owoDhLSRvP0pfBPVGx79
         1zw5pIC44tLGJX1NIDETbfCaC941F1OyqVUn5/1V3LQZz9sNwQWPadR2noeGbFsDzAOq
         4DS6QFpXXJVyNib4LiPRXPzK248+53MrVwWBXk9rlDKmhybbi+B47SO/h6z4GTuDF5IB
         wQTMZ4bG3uxO0n+9hhSTwN3H4zwD5Ow4Eh9YY7PbPf0R5D8ueLGRCIP7D9HF7/5cclD6
         piHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771328393; x=1771933193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WEaN+TOcw45eckwzgu0y3RymRNT+PuKjJJFzwTDz88A=;
        b=a4jgT/GgVi7ZEoL/aORTUWVehmNEIHVTwwMstGsvL0z7MiIeuX4RgL5CKXKfNfhgX1
         j2YUuEVj7ly2KGSS5g1SR8fuHMHkGfxQ/YwuMSatWT2xPKMn1VBpyt130gqQRFVvlLWr
         W6fUw56UUGbRNqG+MK4QUlIVqqKT1t0I4q21xBObCOiAGRMlj/b4TKPrNb1RAeltTV4g
         bLEM+LCbWPxwwwAsq2Hjxx43wxggG7jD3L+ItjZYmhLzN6Gx1+CTVZIbVcaKe/ANF+BM
         cS3/ToPHUmFBsO6mI0bPciFcfNWFapq2zbW69ZuBrs1XhssY5RuZFo/lPHDnBTWOY2Uo
         NK4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSiXm31kjGtW/vkGSohM9FW+DsKAi1Dk24zNq+IG6j6oIgEhXFHs0UfTLZkEYV8GkoACeMLo+tJqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY83TF195fx4FfE0Zmd01mNS/5gRbe2wfe2vO6DyqOysKwD5iZ
	BBoMJh/vxE0hgRJ76t/FZbzC/8ZJjeeJxDW9H5ZoTHOT1l8+CNnKG3AcWOnGrXEd4/MCvZoOv3k
	bQNUbFLou2ktrl/TYKG5svqxq3uD89Va5q05vBtcjL+pkLukSEY2Vrkrhv1qrfXg=
X-Gm-Gg: AZuq6aJ/G4Uxskq499/+MLsUHuKRr3u9N/IYni9gl+aLrsKsGN008qbFrzm2cDQ3Y9Q
	BrGkly0ljvKMPBgNLHNgaUbXHvSp1I2mL2PIPtg3A7KXKc93NWOem2BtEM79VmSmWOzmrs5+CK5
	5DxyZ8v95TINmvBdWFwX6V1WaSvh/HaZaskZ25plDmx1T/IWgJm5Lj+7AKOfUM8rZFhMsXeUQum
	Vif4GYc0LD60patC9pIP19f9LojjPv/D+tzuDjmZwVtXzZPWxBn1vg1QmIisYRiBZz4noLAdpEV
	1t8Q7Fz7XYH8Dmn2lkiMhSUd6qTW2p1zOVhid95XXdLeum16a9u73PzCBstNumVjy1/Sl4WMOz9
	Q7Nk0rD3sx+ooeRFhmUN+hjcIQquab0zyUHhIQEO13Svw4An296L6ZaDwJsCs1mrJiOQevrKhi3
	qqfs4=
X-Received: by 2002:a05:620a:480c:b0:8c9:eae0:d1df with SMTP id af79cd13be357-8cb408b8285mr1323281685a.6.1771328392796;
        Tue, 17 Feb 2026 03:39:52 -0800 (PST)
X-Received: by 2002:a05:620a:480c:b0:8c9:eae0:d1df with SMTP id af79cd13be357-8cb408b8285mr1323280385a.6.1771328392353;
        Tue, 17 Feb 2026 03:39:52 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad19bfc8sm2309709a12.1.2026.02.17.03.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 03:39:50 -0800 (PST)
Message-ID: <119f619e-9f3d-4c21-8cf1-a8b4e1024ed2@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 12:39:47 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/13] soc: qcom: geni-se: Introduce helper API for
 attaching power domains
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
        dmitry.baryshkov@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, chiluka.harish@oss.qualcomm.com
References: <20260206174112.4149893-1-praveen.talari@oss.qualcomm.com>
 <20260206174112.4149893-7-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260206174112.4149893-7-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YMM3HAyS7lOzt9gT7mmD3MTqWq99MavK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA5NyBTYWx0ZWRfX9Me/rGYj7ONg
 CR0ePW4SmdcHk4C5LqgoqgdXIpRNZe0X+hHnnArv5WNZoAm7WJ7jCWX7+zrZ+2UBJb4JF8h4iwV
 g91UA/hcaAI8YhrBJ+mkq1X2MCNaO+Cfzej8GVu1vcR8+NmdFAvgGTVZ9FJSH49SrufH9CGDInu
 p0nESM6rBnhoSVqp6Eu3FCUSkzgqLqidZbmZqdO/IGapyzIGLK6iv99af7D17+dfy8IFcrjzxoR
 k+Rm2GvmSyaPHOO5K/jtto8TCT84ZrACU46ftnje1EbvUg5ZP11D/Rdk7v4NyZxftt85RC+jaDb
 cpnLTf32hmT9bphQuqWsG5d4NcWE8VwXjjlXi3GrFn70PeG80WJCyYBgtyrKkq5nO8atsFv9Pvn
 JjdsajsB5NtKldIJefULxJtbeaWhdkTye8CGcNzNfl4AyWwGNm5qcbZFATcgmFHZB6wIeIKm459
 BthqoIUattD/ENObMmg==
X-Proofpoint-ORIG-GUID: YMM3HAyS7lOzt9gT7mmD3MTqWq99MavK
X-Authority-Analysis: v=2.4 cv=IOoPywvG c=1 sm=1 tr=0 ts=69945389 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=Wk3v8SmLDDZtl8l8IssA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170097

On 2/6/26 6:41 PM, Praveen Talari wrote:
> The GENI Serial Engine drivers (I2C, SPI, and SERIAL) currently handle
> the attachment of power domains. This often leads to duplicated code
> logic across different driver probe functions.
> 
> Introduce a new helper API, geni_se_domain_attach(), to centralize
> the logic for attaching "power" and "perf" domains to the GENI SE
> device.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

[...]

> +int geni_se_domain_attach(struct geni_se *se)
> +{
> +	struct dev_pm_domain_attach_data pd_data = {
> +		.pd_flags = PD_FLAG_DEV_LINK_ON,
> +		.pd_names = (const char*[]) { "power", "perf" },
> +		.num_pd_names = 2,
> +	};
> +	int ret;
> +
> +	ret = devm_pm_domain_attach_list(se->dev,
> +					 &pd_data, &se->pd_list);
> +	if (ret <= 0)
> +		return -EINVAL;

I think we should preserve the original retval for the < 0 cases

For == 0, this can mean a number of different things.. but in this
specific case (where we always set pd_data.num_pd_names == 2) it seems
that it would only be an issue if dev->of_node == NULL, at which point
this function would have never been called

Konrad
