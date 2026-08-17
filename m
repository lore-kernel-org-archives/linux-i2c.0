Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5C53C8196
	for <linux-i2c@vger.kernel.org>; Mon, 17 Aug 2026 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970011; cv=none; b=hRNLMmMLoWQq0Lojl9T9riT6vqCBzyqU9RY2tXE+SO6to45cWEODLdG71Imf7V313sCmPvuutgNO74IlvXgcfZvSiyszY2AlXDAoPBXcjxUMG8tEjG4NEIoaFwkqrWNyhN3v7xOWWNIsyKLBM3aZaT/Z5RXd/MJTnd7bMWxPNgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970011; c=relaxed/simple;
	bh=Z79/ZV1E8lF2jWkDMN9b27oGyaC5VsZs3hHaYMieIGY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KS482yIYMqXu6Gag2V6B6AwA0eiamznpodTe5yoVEOWH1wTbVXQATALXIC3ddg7goc0cHFh8yKfxc2iiyE68ygfwzoQngu7MGp0bBP/HuJxBL087ELZaJxKhxqNuXe8aYObaSUODvEkKjyYVCR4Dyt/MG3XpEqP+wVgh9Ne+l0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PhysNm1Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DM05b3yK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PhysNm1Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DM05b3yK"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HCAfWB1884193
	for <linux-i2c@vger.kernel.org>; Mon, 17 Aug 2026 12:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	06m8/yZdG4MzauTqBv305qAiTU6fVqdgjhYKqZEeEvM=; b=PhysNm1Qt2xf3c5H
	aWfD2KFpX1/JGIy2MrajMSKK9VmD7pXkFwLhuPBEDoTq0Z/4kH/eQ22pHWBVZmhp
	+7FDqELru6sXQoglKNT9nhb9LFPI5ubgsXeQUs+qORFOxDZNttcSv5MU0B1NMkjt
	wngqLwayRyvadz4Jn0KfKTzZrygM6ac6OZGfHiYhSWvQIVJHGKj9L8t1rr6Knlqi
	iVGqSD3ifL942K/cxRaqOcRWTmEywVWZJ5HZhqbz0vRdpkb40a+6ksIqeDNmF8zL
	Xk8c2v1KCS5khPGXLEq3Go/0OwBCGYspSfyNS+DYltTWKuKGoSLs97+sF+/VlaHY
	mFz9Cw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3xw8gvfa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 17 Aug 2026 12:33:28 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-936aa3d9dfbso310203485a.0
        for <linux-i2c@vger.kernel.org>; Mon, 17 Aug 2026 05:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786970008; x=1787574808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=06m8/yZdG4MzauTqBv305qAiTU6fVqdgjhYKqZEeEvM=;
        b=DM05b3yKK+DrIHvm4ORc1IPPUTP5dJj+i9Bbsfo+gpeiwYIqAKDYrxwsDKgaCwxl0p
         T0mkdGVDEsxGrERti0+IhKuLF/rAsYCXzns6lJkWt8THJYGlvj8k/0/MHu5fqSP8uq52
         FUu+kaKHX7Al+wz0gcDkOo75vfrFq8BVl/emKKtrF6Vmlym2xkDP7GI8vZ+n9DZXwDNP
         oVoSZ2LWPPH8rJXQyuDndFaGvMLWuIi4VRnzfOo4D9j6sk6KG+Hed5cJ8J71rxmVb+ZX
         0u6tdJpQ2Y/d/w9akhgaVkia9WAWUOFFipNSsC6VfrdIVaDIIHNlJzjfLHZsRTq6ADYq
         5Aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786970008; x=1787574808;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=06m8/yZdG4MzauTqBv305qAiTU6fVqdgjhYKqZEeEvM=;
        b=hdxrplEE5yHxgp0ECvdod26hyMQodNMH2b9bXMJPJpbfL5SdOsX0CHOxFyd8Jonly0
         pcftKDN0GOIwi8MPuJVqEb7Ejx6qftP5vAX/LcpIfkohjIgZBhbx2FAL9IIYe1zQOjiV
         ti1QbW02wPlyqZOYREDr+acq4FfAwwo2pLlTp5D64ImOozo5iZdsGysk1kzAlJp7Bjj4
         DJ7YYsLFymmaJPnZ+t2ryXzSIwrRKnFduJee8mjZMODB1I42eeEl9IWqyLnfsP9pVaOA
         3B0uwmI2/UgovmQz5FkkJULAlPzbFg+UVdmj0vOydXUpIK2VXLi6OqxuJjSoqBIh4K2S
         Xxag==
X-Forwarded-Encrypted: i=1; AHgh+Rps+niCQosD27xLaD6ByT5Q0d8FH3iEFmpouMxtOmb1mXL9Ylm+oqR31ihsbWVYbh/adQKjEeZCD4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZz2LJxJzJooFrx7Sz4jkfvUTcnS53wgP3d+but2aguXNvtCM2
	rPkR/zK/0zjZyzhZ1fvGJHsIzRjbpp6ZYt4AmnftCeuCnGh9UuqBvy94vp7Zft8z+vn/Gmpby0h
	F+lNxxhgD+/eSnxtl/widDbGODkzbHVpqwfXq+zFrZntUxztDP6eKDayYU+GNkUc=
X-Gm-Gg: AR+sD10m948tkFlgysXWtveLPibGVnU8zVwV2XYiNLoQuGcwjLisgg82QblW7jXBxKL
	mx79jyVu5/m/3e/M17ZjXK+TTyita2fdaTFFhl+OtRgKFcJPT4znF/afWfB37QWDObR/220DLTp
	jNLHLzbeGp5YSLrMEyzHNez590jYFYu3xSjpf4rMYAQ1lBk6HOxNzlAYt5NCnf0gFQ9455h28eD
	gazmHS4t+y6CEL/gkGZbxnKcscp7dhIMPfM2FEW+h/9CTy3OtfMjk2YKYgM/LZjJiWRrdBIoCAk
	vciaGpxHzpiMwdmpmOiWSyKBYOHc/QOb9qiIq3eTTqOmHkBT+LpnwW7IWXGBLrXby5mqXjpuzJ2
	0A6A0UgBX+fti801xUIs=
X-Received: by 2002:a05:620a:45ab:b0:92e:f3ca:2ebc with SMTP id af79cd13be357-93704c10e97mr4005285a.37.1786970007953;
        Mon, 17 Aug 2026 05:33:27 -0700 (PDT)
X-Received: by 2002:a05:620a:45ab:b0:92e:f3ca:2ebc with SMTP id af79cd13be357-93704c10e97mr3999885a.37.1786970007473;
        Mon, 17 Aug 2026 05:33:27 -0700 (PDT)
Received: from [10.40.99.41] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d859b274sm569500a12.25.2026.08.17.05.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 05:33:26 -0700 (PDT)
Message-ID: <dbef6c37-0124-4b2b-b223-53362c659ff4@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 14:33:25 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johannes.goede@oss.qualcomm.com
Subject: Re: i2c designware change broke touchpad of a thinkpad
To: Thorsten Leemhuis <regressions@leemhuis.info>,
        Hardik Prakash <hardikprakash.official@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
        linux-gpio@vger.kernel.org, wsa@kernel.org, brgl@bgdev.pl,
        basavaraj.natikar@amd.com, linusw@kernel.org, nathan@kernel.org,
        chaitanya.kumar.borah@intel.com,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        trantiendat29042005@gmail.com
References: <20260718054330.8975-2-hardikprakash.official@gmail.com>
 <b4a4eadb-282f-464c-843a-19d415a34d0c@leemhuis.info>
 <CANTFpSW+w1GZMbLXszuqZFCZjeVJfFG2bc1vJad+OMzsy-CPCg@mail.gmail.com>
 <aneQvMN_Zet2b62n@ashevche-desk.local>
 <b5b95476-636f-40b1-8575-47918169b7bb@leemhuis.info>
 <CANTFpSWzV9tzMwc2cURCQBhpZmrv1SsZqnwBEu0jt=ZQWfvWgQ@mail.gmail.com>
 <1a209e14-05c6-4796-a8fc-d0c3a776520d@leemhuis.info>
 <CANTFpSWnTjoTS8hBOvVM_w3pWHyOiBhch_GXe_mG-d56WeF-0w@mail.gmail.com>
 <5a5f7f58-b35b-407f-a5e5-293a88cafcc0@leemhuis.info>
 <CANTFpSWTkwmb3F9UnZmeaLizH-cC6evXD=kd1eNwJWkCfyj8DQ@mail.gmail.com>
 <a23375c9-d188-4737-bfa0-f10e66ae7f08@leemhuis.info>
 <CANTFpSWhqkw4735EFyQ4XoSEiqsgCKt4jTxH4SDO-m3=ybwccw@mail.gmail.com>
 <444caa3c-01ae-4516-b63a-576e095fef94@amd.com>
 <9095d7c8-92fe-4163-98f8-a53bbcefd6cb@leemhuis.info>
 <CANTFpSV9jguMzmfN7STb7XANYdn8i34bVmpT=0NdJ_o=3_Y1CQ@mail.gmail.com>
 <1bca212d-fe9c-4666-8ac1-743f8c9ef1c5@oss.qualcomm.com>
 <7c410f84-86f2-48e7-bee9-4c5c038bd115@leemhuis.info>
Content-Language: en-US, nl
In-Reply-To: <7c410f84-86f2-48e7-bee9-4c5c038bd115@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: NcYWxGdv3eYIyPWVn_tfpIxK24AtU0cQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA5NSBTYWx0ZWRfXydCFOAtm8W+m
 B9F+vHYBC/RiK6DqI/I2qTNiTTk2wKN3NvL8qP+pmO4ZLxJWtXkxdsxsY71cDJ59JdAEPdWq6Vk
 UxV+79x0edcC7C4ipNX71h6NLClF9nw=
X-Authority-Analysis: v=2.4 cv=SuCgLvO0 c=1 sm=1 tr=0 ts=6a82ff98 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=rrvG0T/C2D967D07Ol03YQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=lAgNKBcoAAAA:8 a=EUspDBNiAAAA:8
 a=KMWZhIlz7PXNtTpEvL8A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=drE6d5tx1tjNRBs8zHOc:22
X-Proofpoint-ORIG-GUID: NcYWxGdv3eYIyPWVn_tfpIxK24AtU0cQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA5NSBTYWx0ZWRfXwWX6K0T6XoMh
 Wczs39b+mvT6RdrTDFFH+y8sHzntEXNW+3cuO7unf4U6Qzo6NlfnpAdeZPX/nkIAXPYOMQ2FfPv
 IJbWlq1YMLm0q2WxTeGXp8quRYN/MrvMOzLvBcoHDPDU7dY1NDmfkuDBi0pJkF+6TUUk8jrFrZt
 VjtzDKoq82yRgbp0Lg9IYdSTEragSAxXatPAg8kH3MgJSJiqmoY0h/NVlSlqdrF2ZJCszPG9kMR
 6uzZDE8resL4k9tt/8IZUZORaH327uFqaxsVtgqyQ9FQfzWpAiF8NYJWaQN5PnAXqIfhqwggsSH
 Akth6xyLhuJHzlrdc1cl6bo1r8pRDLcmUiNQo2iHa6eeKxnOhL3UgqqwJ3AbCN0nvaGBMALqJYA
 sAbChm9YgpWeJ5vqOEBCE8r3nPteRSDueAcxXhOMtMc+597k5u5SglWxltyxka4QTdl0zkKLpv1
 vr3TXthQ1WIjP0gBufw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170095

Hi Thorsten,

On 17-Aug-26 1:12 PM, Thorsten Leemhuis wrote:
> On 8/17/26 11:51, johannes.goede@oss.qualcomm.com wrote:
>> On 14-Aug-26 12:09 PM, Hardik Prakash wrote:
>>> On Wed, 13 Aug 2026, Thorsten Leemhuis wrote:
>>>> Hardik, could you submit a revert to the lists? And then I'll provide my
>>>> Tested-by and ask Linus to directly pick this up?
>>>
>>> Sent: https://lore.kernel.org/all/20260814100719.9548-1-hardikprakash.official@gmail.com/
>>>
>>> Verified on my end that it builds clean, boots clean, and correctly
>>> restores the original Yoga 7 race (expected tradeoff) without
>>> introducing anything else.
> 
> Hans, thx for looking into this.
>> Thank you for submitting a revert for this. Note it looks like Torvalds himself
>> beat you to it and already reverted this for 7.2 final :)
> 
> Yeah, I pointed Linus to this and a few others issues and then he
> reverted the change directly:
> https://lore.kernel.org/all/628bbf10-29f1-4e9e-b23b-4c47657433b9@leemhuis.info/
> 
>> I hit another problem caused by this now reverted change, where the PMIC
>> i2c bus would not show up on many Intel BYT/CHT devices. I wrote a fix for
>> this (attached) on top of the now reverted commit.
> 
> FWIW, meanwhile "Tran Tien Dat" (now CCed) with -next ran into a problem
> on a MSI Modern 14 H D13MG that the revert seems to have resolved. But
> the symptoms were different: the two DesignWare I2C controllers in that
> machine apparently deferred probe forever and are never retried:
> 
> 16.429266 platform i2c_designware.1: deferred probe pending: (reason
> unknown)
> 16.429286 platform i2c_designware.0: deferred probe pending: (reason
> unknown)

Right, that is actually the same thing which my patch (on top of the
non-reverted original commit) addresses on BYT / CHT devices.

When I wrote "the PMIC i2c bus would not show up" I meant that
the i2c-controller for that bus would never get registered with
the kernel because of the probe being deferred forever.

Regards,

Hans


