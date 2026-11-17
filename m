Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794894352;
	b=kNPMtCtZjz1Fn98cQ/JTPKN6RQvjiYXEnyP/v+D0Gnt8e5SnCsD0nYrD+7ThgP73nIv+
	 XytUPYZZXbzaxSYbafyb9Av0jf3HVDtQjIWA/OBJxGKWmfPsBo2abynbar91i9w/6J2Iw
	 CZirubbPDuyiwDT0xeztkVprJO7kU2b9qoLJ6bL3PP3iXPxocee/jKl2+eTv5Oo2ySzQK
	 FQ5IsEPs6++LgZoAlqyOD0lXg0FOi4egktfLfwdrfSVw0VnMqb7maOs9k9vCLd0eLi3gs
	 2T1oe0KQ+0AVs14JHp2j4lRblz/yzP6NK6YIX+OGYZGc+acMccIN9GYAbG42sYqSQNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794894352;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=n85HmyOSN6jvS/g5YO1GGb3sdeD+U77x1O1SrJ65+YY=;
	b=1SE4H4kURre/8xtPgZxVECHWtU+J6ZZ5YRFgWrjDlPQ0PDKhsK35W2TJ1LWwv6KqTS4q
	 iwLf2w/I0zYbCtlxwAF4rWyV8pKfrwHHhM548APQd/AIS/8uYALx2e56t+SC5wuZh6kNh
	 k5hlmGkcJzeWgRMDqLYPclfG5XSvPyQWFR3w+KGUjP8Duny1O3+KEc0cadGQrDuxwxvr4
	 vGRVj7UeiQ4/9uBZkag99UEvpiaQdyG25T/UEqE4B0thhtYjw0Gkt6hekwQ6Vxl+eLNHb
	 CflW/264d7wbH1B+4LqrgrG6AxPqFaUJmBkGGpWYEMG3w3HTuy3Et0FJcM0EeOFYfHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QGiSDl5p;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ECM3AelG;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F72606A332
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 05:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64F72606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QGiSDl5p;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ECM3AelG
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH55mpa3350219
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 05:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n85HmyOSN6jvS/g5YO1GGb3sdeD+U77x1O1SrJ65+YY=; b=QGiSDl5pjpdI1ncS
	iJjmhqczDfDsj7WxQw8UoymTsNvzBA5aKEBXrTvkyVQZUlxhBhCCCXBYK9ZR0DNE
	Klv1ZrRZnExr2QSBWv0U4xK7/J/CoXQAjluxjat/DhURLU9PQMRG7KWsBVqeV2oV
	eH5qxFELVzwTdma4Cp6MpW309SgNFdCLSp+9dUCQ+APfcKqWGUjdowJEVjimO6a0
	DOTZWv5AbTy2+Fhc42rbdFJf/7EW0y3v5KZMAoW5xCFZXwhtG5z5K6+40OqvyOqp
	HxcAlP2K2hQpefBG8sjmcyh8DH8qS4jN3J5Dai5Kw9G7NOFfyD4vSr+o2tCxWInm
	j8sZNA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0gfr04h5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 05:45:50 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cdd4dafdcf3so3584170a12.2
        for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 21:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794894349; x=1795499149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n85HmyOSN6jvS/g5YO1GGb3sdeD+U77x1O1SrJ65+YY=;
        b=ECM3AelG2XZFsJ8dP2VNSPIreE3cZUoP4XvFnsnQ/E0OhJU+Q3bpSJBX622B9yQEfD
         42vKj5AGZ7QOWiyog06cgFaW3RU3wqjyfyoTS67bflJ+4R2hP9VZI0X23GwkjV1jQxNx
         Eb7TNrv5F4nE0zeHFZI7FZ5NvG5fzUBXATtf7MBenbz59fF7HLoCz0631mqSc5Kw6RC0
         6FD6GFZ+SUHb5+4VBf5SyKH+QurJds5NrDBQXJNH7e5Zmkx6W/8M8xjSnW6tQn6gy+Cn
         l54IeMqyVVKHD6cOBxtmmXS/MNgDUWqfINRcUu/X/b3e3cBAzr3uCmFhBSUZz0DARLAq
         J0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794894349; x=1795499149;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n85HmyOSN6jvS/g5YO1GGb3sdeD+U77x1O1SrJ65+YY=;
        b=cR3lwaaoB+ma/yMV5cFT+QyH62qLKZYm1PLkKXuN1W3ZHqC1qygPu/DXiK8bYw6JW1
         QjNpzZ/nKiSSa7QuZhb9NVV4QQfhpH8lZRNmsvKdW70DUdhR3GXToiBjKWsyii3/9Z05
         ONy9DbMFRaN2k1sL8U+Eiv7u4LloqBRx10P491EeEcwZ8MURSgb81Ufw/FXdNmMM2dHF
         e6HAJFTf1HCAOfR50b4lPglSfHPblg4PCjzJMhZWSkU9vlp3yWnoJFemuoF6wWgj+QTE
         gnJaNe4xSUX+gpe3LUbP0KJ5ot78hzCh4BWAEJu4KTL2ZV8YBYWMAtN2R+vm7TYuZecA
         kghQ==
X-Gm-Message-State: APuU4Z9Thx5Uvo8V4wrOFexpA5y/rHi5THlU6hgq1R9QlK9z3RLIkjzx
	kbQxQqBSYF8+BLRqV8C+PY2ZfTGt6+EZUY2uOZGNJTaCDL2Y4tO3+Py9JhqccY6gut4vmqi45sW
	U/tZRAng07M+MLhsDrAYG8bmb4v2Z/9atQHqQ5fUAgnRqOav+DSwVTJWkjsO3/XvBqSfcXhQ=
X-Gm-Gg: AYBFou0CuvlIcfZnrI3wOMJdq+zFxr7JQepZlD3COELZMPAINzzpmB2+9Ah4YOw3pfu
	12NfmHKguSYAnMKvmJY7JKxb5D5dy/AZQN9qDgHg3NmhYwl1u7oQB5OUnXxBdSFHe8voBrk4hBY
	vQeAf66ZI/R5kifHePavN6ZyAv2fsSo/fTXHepGxAnTOja+Pwyrio1vpZ2JvBmKEQZVTsr8YUfm
	9+mZymrPKzDOvyNR0+2sbUvBOZf6c+YWRBhmU8T4yJQHkiavsnwCxGq5bS2RaIjyENo/Urney/i
	qFiOzVvrSISZVzRQPO+spQpunqC0/m+3u7moFoVq73wi7nJpyLBw5NrcMR/Dp9JzZzUPkNd5Z8z
	tG8TAlyZuvWmxuXQVcIWGL09GPcwqHnOe80kztkfp54XZZOakaDoQHs5eAT79vXvgvpEWujhvRb
	tHoU0=
X-Received: by 2002:a05:6a21:71ca:b0:3fa:9049:d906 with SMTP id adf61e73a8af0-3fa9049ddc8mr5651394637.69.1794894349157;
        Mon, 16 Nov 2026 21:45:49 -0800 (PST)
X-Received: by 2002:a05:6a21:71ca:b0:3fa:9049:d906 with SMTP id adf61e73a8af0-3fa9049ddc8mr5651379637.69.1794894348620;
        Mon, 16 Nov 2026 21:45:48 -0800 (PST)
Received: from [10.218.9.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdddc55efefsm4402940a12.6.2026.11.16.21.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 21:45:48 -0800 (PST)
Message-ID: <9de0e4e7-fb4a-4ff5-8c15-f0413efb10d5@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 11:15:43 +0530
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
Subject: Re: [PATCH] i2c: qcom-geni: Fall back to i2c_acpi_find_bus_speed()
To: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20261116123915.10182-1-johannes.goede@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20261116123915.10182-1-johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X/rHu2Te c=1 sm=1 tr=0 ts=6afbea0e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=olDleomVNStdelZc9YAA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: JSCBFZoW-qDd0H07ETPZqjaXyJI_RmO0
X-Proofpoint-ORIG-GUID: JSCBFZoW-qDd0H07ETPZqjaXyJI_RmO0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAyMiBTYWx0ZWRfX4nelDffPtSfH
 J30GVaYPSG6IljE5fBubvuGwxbrn0W7Gwecysap7k73G4eJxh+jOWpPF1P63k++CF8xfjWqh+RZ
 EH5Fn4y8f00PnohWl/5Ccsq/9fbkt1PJtr8hcNcUXrCeG9fb5OvZFtZutiK6KFk/Pj1tMfoUA4p
 DWdrZeWpT+aTTJ2fynXB6nJZxlio+7R2d5M3w8tef9kB/7tZdElh0xNbMB025qaNROXdVHVPAQi
 Hw5KfbNLLpUyV2bcya0gTFybKc3KkAW0LNZ3dcIQtXotvfVodWek2RmL2IqwLHQjJH8lMcNy95N
 kBcEsUBNd9if7JMs+zKGaYWnr2nA3qdIKdBsFseFmMBXfblUmgBrMfl7xkUmT1JirKJvgGdX1Ig
 xVZgA9kupAxsgqlsKXNRO8GqA8rZS8+S83YhmCtrD2tR26/gJILzb/9Vi2fgkXtLS/CeTpF3W6m
 rouo0PzfUpwEIOWOy2g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAyMiBTYWx0ZWRfX/5ufqtkmh0lT
 dfWoXSk/PH0H964qUWM02a2n7OTJdQHvqKmp1vdNlX9vkzoS5Csb89T6BRl6utJvKFW0nIHTctv
 /5uy1TLvlJIIunfpGxLovI9RLwfUH2w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170022



On 11/16/2026 6:09 PM, Hans de Goede wrote:
> The qcom-geni driver supports qcom-geni I2C controllers being enumerated
> by ACPI, in which case there will likely be no "clock-frequency" property.
> 
> Fall back to i2c_acpi_find_bus_speed() to get the bus-frequency if there
> is no "clock-frequency" property to get the bus-frequency from ACPI if
> available there.
> 
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index ef48ab3e8b94..cfa334e9e81e 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -1200,8 +1200,14 @@ static int geni_i2c_probe(struct platform_device *pdev)
>   	ret = device_property_read_u32(dev, "clock-frequency",
>   				       &gi2c->clk_freq_out);
>   	if (ret) {
> -		dev_info(dev, "Bus frequency not specified, default to 100kHz.\n");
> -		gi2c->clk_freq_out = I2C_MAX_STANDARD_MODE_FREQ;
> +		ret = i2c_acpi_find_bus_speed(dev);
Prefer to return bus speed so suggest to take bus_speed and use it 
instead of ret. As its not an error code.
> +		if (ret) {
> +			dev_info(dev, "Using ACPI Bus frequency: %d\n", ret);
%u HZ ? Please keep the unit also while logging.
> +			gi2c->clk_freq_out = ret;
> +		} else {
> +			dev_info(dev, "Bus frequency not specified, default to 100kHz.\n");
> +			gi2c->clk_freq_out = I2C_MAX_STANDARD_MODE_FREQ;
> +		}
>   	}
>   
>   	gi2c->irq = platform_get_irq(pdev, 0);

