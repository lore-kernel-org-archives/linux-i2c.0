Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826308;
	b=OPFB0/bzEFLbJ6jkek+17qewUHeKSyape+UXMSIcanrs1mmW49UZg8R6itmEnHyNMzCM
	 Q1hjU+73RU/soACAqTTXx3x/R+XA8EvDwIDQl3vu8U4VvNu84LOsaFdMxC6r683BCGzYd
	 rRJUkxjoXkIinBUTt+QFTpG6acBhD5h5N0DfQcjQUzw0GpMSLyjePPr7vf9S/JhClASR0
	 63pn8nVMlEdR9q7dbxMDss2xjjjwA9JMkNwoEqRuNuf/mn4z/nLyTNqyPuePGX442KnpJ
	 oxglKIhESlUiAAEs5KzP8QbfwWbMx11lEsORWUgXB5RBPQ5zUcBm/Z18c96v/3h91iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826308;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=DNZx/fJio0QkyIvjPmXj7q0Y3XwFo5rxRepEK0oSLsc=;
	b=5kH3JyWc0wkkpnvHemKlM2KUw0VBSDOfAGItWqLT8fXYC9DA1MGiebp+rWctS7bRoZvc
	 3cpJed7OfIsU7EFAYVQbPncHdlA0vh3/B+4Q4k3kapwB9dmdP24QrRhzZF6e0KduxoglH
	 IUzDWHhIoWMh43qwJ0sJ6ie50elm4Ljb+KqXi5IBBQZV7YPAabcE9PZkDCrFJKeipUoeV
	 50p3XJ9tR8PX9tHrRdAuL9CzgdS1L1VVtIn8zYjtWSRw+eYD8LaDVWvsjjy73chGIJYli
	 r2FtSFp2nW/yuv7i7pL9Thg3H/p6S0nsRX2TeYC7mKPX+VB8r8KYnd2jAxMHcK/p1dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qr3W95QW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hoMGSkkl;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5BA606A331
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 10:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E5BA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qr3W95QW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hoMGSkkl
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG9PXme3428380
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 10:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DNZx/fJio0QkyIvjPmXj7q0Y3XwFo5rxRepEK0oSLsc=; b=Qr3W95QWtux64/FI
	+pAhcXt7H9zdKXShDzY7iBSeeuCWr7CLy1HAD8r7Y6wvhtPl3+U4XDHUGUgnUj2W
	+Z1cdwcZzTg9OLxKlHj/0+lFJAPxoR5ROp+6HNTEmE0TGnF2KWPRrwZNXbijy/Ro
	SHPSnEh31na7h9/0xEQbyDgKbS5FRiRNAJttZ33q/giJ89o5Fpr9CT8yXP14cvGP
	giSvr23JoYBDecACp8Y9HaNVoBLqa9/hH7UubAikto7jlLp3wql9OyFS+972EF56
	uiXNjd+CalvmVFeIf3RFE7i4px1UOR0Gvcg7ArR1P2O0JCvy/iq+T0QETBKcteYc
	Bz6uLQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyy6gg9pc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 10:51:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9493e89d4f9so609197285a.2
        for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 02:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794826307; x=1795431107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DNZx/fJio0QkyIvjPmXj7q0Y3XwFo5rxRepEK0oSLsc=;
        b=hoMGSkklzvCO4JLISup4koj5YZiJKiJiBzQvr3k+ImcjTAbJ+Z+C4UtzkXc3L7D2fP
         PLK+dg/OrUSQbDSMTVgRYwrUA0z9uU2nbslJOxu+XU52SYkaIohwE6/y/whOyUj5oXMB
         CAvvqxFfKariY4Qacu+4hBvhKoj4bMbxkDs5Jz+1G+oeaiqbMFVt+Eiqq+epe9uyQ9uK
         XN5ydyPVcE4wawfCv9Q2e8r9CoF3EqPe/oBrltjVssHtgBQw0yE2ZfqAYCVnduQR9+2w
         pfLPC0gtB5QGL95A6OnfGcWnuCUn8oXQDd9Y2aopwhtsDYblKaRE5ZemQ5msLnWaMfKj
         4MfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794826307; x=1795431107;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DNZx/fJio0QkyIvjPmXj7q0Y3XwFo5rxRepEK0oSLsc=;
        b=l6bpTyQSVADOnavpRcE/UD4wciRCNp3QSoe2vuNyZ9semoIjhktdyQG0VgUqw0ReY+
         9wX5P0OPz4GUQScIXu7i8V8VDhJojj7RUZy0rj6EDw3cU4GEzoJg4/cdhWCa9WKR1Hiz
         I9p+NF0GysQWjlnZK9YWuSnM5fnrqYvQw6UvM2ZwHPn1419QuoxJ/X6I5Spo6UlIFo2z
         TRcAHQWyWCjpOjyA9Dm2hjapFEtmp0KzHR8cjZC3gyfmYzljlVt4+K5VK/KyM3HgVvmW
         SJJnneX5NgTq12wffllPsu+/H31mHqAbE8C9IFMs6zcofxO3bWsCWVh1Y6FxxIuLGfFg
         BRRw==
X-Forwarded-Encrypted: i=1; AL+hErF4VU/ICw8/YsVsSB9lTKIID7Bu6wIpZlOkKELR/E3EUWmiH3e8cbcnbJQwZWIA2n0h7bDHdTxBna8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1J4FAOcqszJiJuGuzJ85GBhPOAN7jX9ab7lf1MhmOA9hGtdx+
	aK58sRioBghK8k0z/ODSlNrNivhEGJwnokzmk82rTKAWtRAqRwtQXZg///l5THIu9ZH44TEJL1N
	DnK5d90NKquJS/uyP5jgQ/LsIDYwQUVUEMTeWKeXComIlUfDcfxfD7UNwnyhFFEI=
X-Gm-Gg: AYBFou1TEOeygEqyuSlBHDbSUckrHId3N4KL/4TryuMy65r/9b6cAYH/o9QUYP3GBKb
	3bnkEMUQzvAOoAQ9eemQQMG5Y2179KImSie90ePtys8zgM/CmnUOXNp9M6R4gp4DYr3VzOa8TTv
	zQOy0g3SvKlBZgoa0EvfGTzX0W4wy7H+6pCxDwcBbnvjVLiO/nDqzSPpvlaYUMSERxomfETxvad
	9PdAu3q6x6ghgILPL4UfoHlbMwz88Gt1DWjMT/zFgVgQzkql4A4eOuDl9Z7JYD9uJPLxzQDkPRv
	bJhpXkGuiImpBIfszFn5e7DzVSZ7wJoECkUEKV27pWiR6FXZpKCUkqz7LUOLw2u39FX/SWRrNI7
	hJZmvw6dIVPJPErU+Gux+w1c+8FaMVZ8+wqxVXsf2Mfvbvx1sHx7fYXUhoYVwFY5ksBFQjlRoZB
	4LRzcxvqQdR5vHWWz6RiRUO19YvFK6jpfjK+KA
X-Received: by 2002:a05:620a:4009:b0:949:3066:556a with SMTP id af79cd13be357-9494bce0ec4mr1811015485a.69.1794826306556;
        Mon, 16 Nov 2026 02:51:46 -0800 (PST)
X-Received: by 2002:a05:620a:4009:b0:949:3066:556a with SMTP id af79cd13be357-9494bce0ec4mr1811013785a.69.1794826306120;
        Mon, 16 Nov 2026 02:51:46 -0800 (PST)
Received: from [172.18.133.33] (195-200-21-10.mclarenap.oninferno.net. [195.200.21.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb62d5ec30sm295319355e9.15.2026.11.16.02.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 02:51:45 -0800 (PST)
Message-ID: <12a87383-f4fb-4145-9c9e-15b52a930f93@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 11:51:43 +0100
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
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] i2c: acpi: Add AttribRawBytes accessor-type support
 to OpRegion handler
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20260919193642.43058-1-johannes.goede@oss.qualcomm.com>
 <20260919193642.43058-2-johannes.goede@oss.qualcomm.com>
 <as1gYyr53eIxdzZV@zenone.zhora.eu>
Content-Language: en-US, nl
In-Reply-To: <as1gYyr53eIxdzZV@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0MyBTYWx0ZWRfX5cZv8hqjvvLY
 s2NOZXmTeapc6T0vgN5J1cL9LVlEw30PgQegReEFBnvLEUCqvHBq0iYRJ9o+WpBC86GQyNZCOje
 BK7zzmN22I+wBwJbjDGfxr5eeV8VX5gIbld6cAIgsRuclyj1u3Ho35YVGOzYJ7aVTX1A+FTn/j4
 PCda4xkTg3vT0TKhLQLSoNu4Pyvcbf+hpsNmBl4y83aKz2X63z+OdgP4qzpnccE8rW2+56Wgs3S
 9LfJpxA7HYcKwnX/GCwd8J0YzcoB5UvwAQ2m93HyDoDhaAX4M91/NgErLH1Lm+ncvDgKbczt2sr
 /mP9LFnMnb2ch7PduLE1se4Wt1A6GH9Ste34UhWb4OjXVBquSfFh/+/tYtMPIAMZ+HBpPMBDAMG
 TmSCWgdf5KUfM9McQQNCFL2oS8vK3Qp1k7x+4LOFVOTjffxzZ+9Tbj/jDzGDdIACL7ayKe4uRfe
 p1lxHWgc1q7GqQRN21w==
X-Proofpoint-GUID: fovQVdlABQ4NE4ox9Re0558r0xuFchMF
X-Proofpoint-ORIG-GUID: fovQVdlABQ4NE4ox9Re0558r0xuFchMF
X-Authority-Analysis: v=2.4 cv=D/DSufRj c=1 sm=1 tr=0 ts=6afae043 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=LwtOfSRbDNzKn4Mtwg6Q5A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=CeogzBoLu_OrgXPPlcMA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0MyBTYWx0ZWRfX+UJ+rF81J3jB
 mK27VSrQNQnSjVhFr46MVw+v4I/lsit+KGqmNiRtJxqNT+G/LwMw7mJhwgb3L5D7u9/Pv3mq0uV
 5Wx8QjLb9A59dQhfHb/d6AM1ZzPJ/I4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160043

Hi Andi,

On 13-Oct-26 00:55, Andi Shyti wrote:
> Hi Hans,
> 
> ...
> 
>> +	case ACPI_GSB_ACCESS_ATTRIB_RAW_BYTES:
>> +		if (action == ACPI_READ)
>> +			status = i2c_master_recv(client, gsb->data, info->access_length);
>> +		else
>> +			status = i2c_master_send(client, gsb->data, info->access_length);
>> +
>> +		if (status >= 0) {
>> +			gsb->len = status;
>> +			status = 0;
>> +		}
> 
> We should also check whether status != info->access_length.

Right, good point I'll prepare a v2 with this fixed.

Regards,

Hans


