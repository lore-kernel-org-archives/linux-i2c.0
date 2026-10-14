Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B479563FA4
	for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792002465; cv=none; b=Pszr5S2td1eUYvjEfXvo0LuyINLsbVkkq3t7YwYzKF2WdO5ag6AtPf/e3Fd8TFXBcdVv2uEIkzkWnz1YdZJKiqnkQ8CBiJY9xbLyvTuNnhD5GvvOL3UFv/K+Ja4rywpNh+Vf8TrZ/7KVjHhq/cf7fg9qTnOL4UEJiVQGyjS9+nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792002465; c=relaxed/simple;
	bh=U/Vkfvw4hnItpjnozIJs+gajkX/CA0gS8JJ2x/F0i/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CgpyGnOnkAFqDfRmdLXAo7fjARTIKgn0PFi773LZmZ3DQXWSr/xSvE9mcq33wvRj/BBqHomYUKwzbUDby2iJbOhExGpbZFiim3ErTI1WP5HpKFvcECybOz5miwI4/yrmZNqE2WFlGKfK05C1+mZ624FPFVWmbb9wRqxM30UB4tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P5G2o/ou; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fg3pyaqz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P5G2o/ou";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fg3pyaqz"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EGZnET3469274
	for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 18:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XCRXy6jRcZHOHEg2EMNJm5Fu8QWLy5d9vUyJpE6AgZI=; b=P5G2o/ouR6X6YCn6
	8Tzjl5CMhTTYzO5hYCJiyE2kEVfWYEJlBkLKJlCZxmJQfMXaE5wOEkj51EU5kRw+
	MMb3GwlYPXRhvih5hiZQbuG7wnj0gr3Ti5PIg1r8NOYyU5Oea7QEMHT53IYZgZtc
	srlkguPgvRpvu/+5L2QLlCLo3U1S4iMI0wngWOrjUmvKOdQAhQafq8tleH+eG10P
	piJjcvX1Z4ME2P33F02AjaB2ZwTKE5Tn2g8Jaq7oWO0lw+z5WdLTHaKyz7QlVzTP
	pHjUt26WEvT2QPHU1h343W6t7EUtrXGPPCYpOJ/6sbXaoADjmayb2vhyoz1DG+q0
	+HB/Pg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hadd78epb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 18:27:43 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1383723dfddso2348243c88.0
        for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 11:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792002463; x=1792607263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XCRXy6jRcZHOHEg2EMNJm5Fu8QWLy5d9vUyJpE6AgZI=;
        b=fg3pyaqzbZxBwOCkTA9T4auGw5a7Iwai3B4qv/5Dhnc+ZJdnp5bh85jLIDal0lGjd4
         IoBiNObtV4LUo8XkbETftr6fm+d8xQSdCCOmXDwx1F62nHCf9oshRWSnqR61t6vG3dAi
         Y3e2PtJ57vaey6D16AfAFDByRD4dA1mIT15tWBZKm5xDt2pEMcVxu1l1XqJuGI2QTiQA
         bgXQgOJLu/XgBHj51coNA9/AaLxEF1oqrIhiRKil5bsdMIy5Wu1IgaauGwsFcd5YTbhL
         eTla3LpRMxi/PtPWsZa9CiXvaGon5lS+Vci98FC5jdbuDiMjDpg2GQ0HFy7D4sdqPRkr
         77Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792002463; x=1792607263;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XCRXy6jRcZHOHEg2EMNJm5Fu8QWLy5d9vUyJpE6AgZI=;
        b=CJSi4jOBRvi8r/bNqj7r92D8DFG4qwy0rHrUN3LGY0jJ9vTGZeehzDcJTXq682Dhb3
         SFyuVFcVjyAxV6cwI2xVyIB6ko1+a0u+Tcx7xCBk870VYLET2aGEAxh/yZKfbVQmrRIW
         bIQI9JYnQlRhKRyLi1uF5L5gHAITaHgQvVK8GynBCQ9Q2AZlkOmZPD6Pro8/ThgL6s1b
         iexJG/AenSTAFbNSv4hPMlP6Br2zngmsa75aW4i92bquFyhtJM0x26FnYqG59/wcOH+B
         cvzT9fBNC57UTvP81/+csYBO0i6xn1kPDlHmVPmlteo+nISaMUX7uw/lp3YPuI5y/k/G
         NX0A==
X-Forwarded-Encrypted: i=1; AKwUvBy0Jav7p6gVT/E8RV8RG+9aUXoFvTwo7a/7uPsMTpFj8dHs/FjdAbxUgjrB+Q41XmubmA2koOoLuVw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQfJdXo73vN4HQ05e92JKYsmfs1dcww1uBn7+C6g4Qy+3NIkbG
	Y0UQMJ/3Yr3uAxy8Y07Alq2u8fi7fHta+0YjGsgGTIDWoo/DyDfoRqjbrd0LSwmcH4dg4wjKG6Y
	GdqUTTdTQzC63azPSr90u5DL4dlfv22FuQU3ec4exrUvIYqeUu/CGvOi3sbL2V4M=
X-Gm-Gg: AYBFou0LkbooNqI0WNJ5tk4rBzpoLPjzQ5/VEKlSUBpwuTJyMEy197LN6YqUHH52wGr
	a+ucWMsO4rxLt81k4ElZtNoXtD395eKJ20zJIGpu2H4n2ZiCbiZyK05O5HvdlmqOK/bpay0n3Zy
	FD118DGsu5g9kvROB3JwFJpuHyCc1Wb8d72PwUNHaXZ/ES9JDVWVN49iJxs9SHoE8yEZCpwBGU2
	H1wsyTX4MoDUi3iJ7SZwHhaPGRFSZ3QjUxNAQPcMPW3BKntTZXV2rfJ2BiieI9I7VxXV+86YGXZ
	5q1S+8pYxMyV8MWDi/EFEApPsgO67cUecmvtYG7PGuYV8gfSdx7liBZTTihD2nK6jcMGR4JTPkC
	Jm8v86OuSde9BXoRtuyyu9qU5N2YFWoMy
X-Received: by 2002:a05:701b:2084:10b0:143:8188:fafe with SMTP id a92af1059eb24-16a63099ec2mr24162424c88.41.1792002462585;
        Wed, 14 Oct 2026 11:27:42 -0700 (PDT)
X-Received: by 2002:a05:701b:2084:10b0:143:8188:fafe with SMTP id a92af1059eb24-16a63099ec2mr24162381c88.41.1792002461889;
        Wed, 14 Oct 2026 11:27:41 -0700 (PDT)
Received: from [192.168.1.2] ([106.222.235.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a442956asm62360686c88.16.2026.10.14.11.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 11:27:41 -0700 (PDT)
Message-ID: <02a7367f-ea7f-4c20-91c4-03b751562ea0@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 23:57:36 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] i2c: qcom-target: Add driver for Qualcomm I2C
 target controller
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261005-i2c-qcom-slave-v5-0-6254cc7c08d3@oss.qualcomm.com>
 <20261005-i2c-qcom-slave-v5-2-6254cc7c08d3@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20261005-i2c-qcom-slave-v5-2-6254cc7c08d3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BaVNQbt2 c=1 sm=1 tr=0 ts=6acfc99f cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=N5Y/PXOiYxOVLBGg3HvMCg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=b46tEugvMB0N3bD9OT0A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: MgFfbCB_zsT00sXMhYI5lhMjUP8f8cm-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX1fUdvozdWyuN
 0dYLNHCaIP0H8zc5xlV6Rk/oZaW7YOuFABU05YaQQ0YA0bgUEh8ZpEQgdlYdsWvt3t1mhraHjST
 ZfjFGVU9GQI4r6wkIAff6g0hAJ9T07pXnptEaAY5fv5pVvdzTf6dRYup/UnTX4Nje+JdvA7Rb+k
 g1hGtGenu+EEw7KddaIV6F/Rb+4o/baw17iJzEhKS0ZC+seJnKoPkdczkzEW5P2Gk+k1wb6jopa
 78GuvD7d1JYPQA5Ehty4P2XmLGoilOi+Kna6zrXMG8S0wdJy+Qd+GrvgmWNi/wYJYznCnigtFiy
 cioHqoviJVdofPHi/z7iE+R2zI/M49jPMWSpD/dZyfqLvtNi0GUgxty/1tkdY8ZTauJkiNTPwVA
 m7FwIPrxhkqaXxsszXLbHsFkUb8OIvAotryNRqlYVLwGmT3od1KGms01qrvWC7qCtkJpD5JQtCC
 HSa3OlVauA2jPOGjjaw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX94EgD/fYF3Ci
 gPZ3adriXV5yTDsEcGwmO8b7LXuW7o+zFLoep8ke9pS+rXf5mz30gU1uxgnqR5BcDgkF5Z0+O5U
 S9iJE3yiDqczmZ69u+z24IpQxgvemp0=
X-Proofpoint-ORIG-GUID: MgFfbCB_zsT00sXMhYI5lhMjUP8f8cm-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140073



On 10/5/2026 10:15 PM, Viken Dadhaniya wrote:
> QDU1000 and related Qualcomm SoCs include a dedicated I2C target
> controller that operates exclusively in target mode. The existing
> Qualcomm I2C controller drivers, GENI and QUP, are master-only and
> cannot serve systems where the SoC must respond as an I2C target on
> the bus.
> 
> Register the controller with the Linux I2C slave framework through
> i2c_algorithm.reg_slave and i2c_algorithm.unreg_slave. This allows
> standard slave backends, such as slave-24c02, to be attached at
> runtime through i2c_slave_register().
> 
> Handle IRQ events for RX FIFO service, clock stretching during read
> and write phases, STOP and repeated-start conditions, and error
> recovery through a software reset.
> 
> Enable the required AHB and XO clocks and vote for interconnect
> bandwidth. Restore the hardware state across system suspend and
> resume using regular system-sleep PM callbacks.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---

Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>

