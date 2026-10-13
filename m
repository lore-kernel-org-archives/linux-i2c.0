Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840BF3BE635
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882157; cv=none; b=r59Sm77aMn9Pv1/3FgWD7kujk/2wNMghDEyIh1ddaK9vDTvk1L05Ii3kFcoKk96LzO0ng0ulGutaa3uXvToq4lKItkBO3B7qNwGftiuP6f/RCD8E6gSXdmXoQlNsnrrBI5YNnOWuPhf5zHrV+/5Isns0wqTnD3hD21TL6lYHegM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882157; c=relaxed/simple;
	bh=JbciLIm74BwXlCx8BvBBIdoDAcxeKe6KT3Bs0d7Ohk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbEQHBBs4uu3LYBlGHbXeunP3WjOr9lXp2Bf/SDS6EeKVyx/++Ydc12c+/bRVaeQMYn6nvriw7lAm0FN5QS5f7YHFvyL2bG/e3d6F73PNJemwHl5dcycMBced3na5zZltnGYTemjPQqwjuGOkXvep02w/8G2rF5mH5MZfvJdub4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dOanNEkR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i+U176mg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dOanNEkR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i+U176mg"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D902oe791427
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 09:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u3ROTOT5NmCg7aGxkDpwUT2Hj0+sJX/h77YrLceB0Fc=; b=dOanNEkRJMJ/9FLQ
	+/TI89ktNfkA0ptZV3S/yf4VZQfd48XySBJVRuvB//POAy5ILeSEN+XaWFS4R3gW
	b2OM66DC05UzUQ/TTkZhq0Cjtich5qzsxV4pbobL1CWA5SVOV4xSajGMjeu7S7O6
	FfF9160CGS7fe5zU5Wsl5oYnZS2fkWmaIyQ7kiIwzbB4LCtLFjFhFBhqiGsH6iFx
	KfxaGm57s8lTg2Dr4zN6tvU2yaS2LyY5uTJA+gM4QTqFWgNiU6kveHuGOt3aU5Rd
	UQlDSJtQV6iNK5+Kq/BzBvYNTcEVw0Mbs9PMva+KirK5vKUEZ69qYIO1Uy/ndoD+
	JsOddw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9hmjr0gn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 09:02:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5338bd59032so6525751cf.1
        for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 02:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791882155; x=1792486955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u3ROTOT5NmCg7aGxkDpwUT2Hj0+sJX/h77YrLceB0Fc=;
        b=i+U176mgrXx1EifV+5HUrObib2xiyDygCHyVkOM+087eHPcDYkKtSt6hKgx0YRYaBR
         tIDxlhovhRAXt9VPwZsg0RKwTX/Qoat8JieU0r2b1yqOeVCNbH7Dn63AGgCk4GznjEnL
         xH+rNUq6jRBERUhNzQ8y93fxbj03EpVn0JAoU1+Jxhecl4btVfUrPDg7cbpTEQyMR0NQ
         r2bg3RGPWHQoB/vH7EXo71TZhYK+xTDG+rYi7HpCbaqU6HFhWRSDNF4uBWxYIjUI9Khl
         pzh/9dcDGdCX8P5Buat/AkNpmdeL0S7KTDNdoYD3fAO+/0AW4KtMe1vUyx+FRRPQrzQo
         uxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791882155; x=1792486955;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u3ROTOT5NmCg7aGxkDpwUT2Hj0+sJX/h77YrLceB0Fc=;
        b=DdeVVTjhPPcbGUxTMZdmwfiFLF0g7dwO7xGXjMcI4CNVkgErJzk3xHHjIzzTW9mRZG
         e3CWuVTahZVqn7Je3iWHc6ZR4CgqBBDsqw2rbEgg88Waxd4DyWOYA16yhL4IP6HRPy8Q
         2wHQ/Mne7xAmbP5+jVL452fAEH8knlVGvOkgz7gfGu/0AN7BROAprWcmkZgaFaBXK3W9
         xWCyPE7C3Y/Nb/baPbh2vny0Vc/fKPuaUwTNHnsNav/rKejwnvafQEXlEIGqS6md6ZEn
         dZ6EG4gUQJSO6St+6yssg790N4JDpB+l/YEDSRmXm5JnK79rEj49bhV9ffxUtMY8oNff
         TEMw==
X-Forwarded-Encrypted: i=1; AKwUvBwnftlC9LW3HIWARKpsiweFHCB+udEjjNCRuHdL9tc1TUV9yXSVvgcNTEPVABJPl5EfSdN3KqNjFyU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKMPA4PapDVkKUtORi2a7EAZ2TbQnC8ijSoyhRtD8vyuPclt7Z
	suC7vlpGW7iFRXIu1kUAl3PNRWybv9Tkdg72hH5OTXDDNNb21ES3pTSA9hajsRh69xEJ76o8vfd
	5LOXiFdVPN4FEKmvSAohZXaJWTO/LJIvAyUywubuo7iDQpnLv6y0XJnd4WvTG5OY=
X-Gm-Gg: AYBFou2EFXG2o8SuPELrDEI6Ot0EMOKZ40cfAvrkaWbMNA0aFXLlDoBXZQtUa8JgDi7
	uz3IT3IB5rlYAVOcxuoFJcZDSQcXzUEDMNe/VMNBhh7I7VZZ7U1so0kSP+fLurOlvu4lgIyJGk2
	guxHbCffoDcingbVv8kLw6r82hRcX5aZxiKTxakH4pEnMvM+H4RoAqczLmGB3LeENEdNlEUW+Lr
	ob7uC5CzThEAKWn3i9OSVxa8Cv/Ncs++AM7t85LXP58Me9eo37TitQYajPxebAQkgb+wgxXn5Kx
	QJYHkNvhYT77MR7yragkETOSLQ7WuKpjR8WSwytzqlezYHnJ97h3uJJbu4/8c00rRDzA0eNrPoc
	vCN5cInoieG313DOnTbtg8g==
X-Received: by 2002:ac8:59c6:0:b0:52e:3991:84c8 with SMTP id d75a77b69052e-5359f6a0984mr234072311cf.2.1791882154557;
        Tue, 13 Oct 2026 02:02:34 -0700 (PDT)
X-Received: by 2002:ac8:59c6:0:b0:52e:3991:84c8 with SMTP id d75a77b69052e-5359f6a0984mr234071911cf.2.1791882153956;
        Tue, 13 Oct 2026 02:02:33 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9765d1asm549448066b.8.2026.10.13.02.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 02:02:33 -0700 (PDT)
Message-ID: <65609aa6-fb54-4987-8573-36fcd650977e@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 11:02:31 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] i2c: qcom-cci: Detect capabilities from
 CCI_HW_VERSION at runtime
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261004-cci-imp-v1-0-227d12cb4829@oss.qualcomm.com>
 <20261004-cci-imp-v1-3-227d12cb4829@oss.qualcomm.com>
 <717d9cb2-d7e5-423b-9d0e-fad307385474@oss.qualcomm.com>
 <CAFEp6-20=Hkb9ZsubULMg9YYVzEc11Y37g90Gu1mxpvOwqJB9g@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAFEp6-20=Hkb9ZsubULMg9YYVzEc11Y37g90Gu1mxpvOwqJB9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNSBTYWx0ZWRfX55E4CEZnjwS7
 ThG48sFBri3YgH86PYPwEQSILMKgm+rxabxxyEpDkldmTFeZ7df39u0ls3eMOdbezwXnmSgPNT/
 BE3IBjMkISxtEp+6UyMxR1e9TJLvRgE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNSBTYWx0ZWRfXxzc3hDpiX2Zv
 awL4XaA8oyxXJzm8gZrgZ4JqphpCnqtow+vzD6glXqVC3ctaftu1F7//nsyt11qMAq9oIZ7BpKw
 zSMZBSZeUpRGRZsN3IOWDiKbXk3tSTW5//+ZkZYFH+9o9HvNI5b9V55JR8K7N1HgXzA885MaFFP
 Wwkb3k+EjP8c03x2wVEeEBAi/PvqPYv/zVry3ZQJaz2NdP1YPsKwTc9l1WaoSYt+2J03aUQUYBb
 CR168ueGMvGppJXgM/tsz31k2HZ2+EHwk2MyKMKjz0LVmZN3tCg37OM9bH3c3s63dbAzG4iu0Aa
 ZvuaXSdgyqfcVOs1Izxpop+S5e3pm0whCB+0AtQ589r2+7PwhODQFySLXQwllSn4uN81xASxO6d
 YjLSCSt9eb+mgSlJJVr3yXBdR+fqIUOwH0EnkfDWzEm2Tu+qcY/yl9v8cvKHXU9I1VzqYBOkFX2
 OR+LpGocbvgD/0yu1dg==
X-Proofpoint-ORIG-GUID: D7qthB84a4Zsuw0r-x4mRlwCwQVvtUsD
X-Authority-Analysis: v=2.4 cv=O5+sLx9W c=1 sm=1 tr=0 ts=6acdf3ab cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=9Ai6TmSYiC37dqtxzEEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: D7qthB84a4Zsuw0r-x4mRlwCwQVvtUsD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130035

On 10/13/26 10:21 AM, Loic Poulain wrote:
> On Mon, Oct 12, 2026 at 3:58 PM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 10/4/26 9:09 PM, Loic Poulain wrote:
>>> In theory, every SoC integrating a CCI revision that differs from
>>> an existing one should introduce a dedicated compatible string.

[...]

>> This looks a little sloppy - can we infer the number of masters at
>> runtime somehow?
> 
> Yes, we can either add a small msm8916-specific condition in the probe
> path, or derive the number of masters dynamically from the number of
> master subnodes present in the Device Tree.

The latter sounds good

Konrad
