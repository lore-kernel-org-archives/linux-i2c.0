Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794992042;
	b=OHw9Y0GUWOY8ppcX4MnNtaG/F+X7BMBofZs72kSe776M0R9svh2bjQ7j35j+Z6SQdt1E
	 PBglEegwsct3wiqQ3XrV81W8uQng2G/0r4PoSQrX/XSn8Q+ohHztv4wx1w+EgNmUArAJe
	 +RVJAYsL2lJ7ErAYi5Gs0gTGQDrbTDSvAZUJCmEtEyekoNUnXV86SXHG36tgPOPPPuKW5
	 fa0GgAgLsTPkbBlngeo/x89f5/wnIZyQiZuDWbFBaj9l0PmfiUDjic9y56giFGCcMgN8e
	 O3iQrGUhirfT3rMW/VU/sUQTBypnZYp7m2n5nt3tFUJPXy1dfF/ECjopVyOLE1GWhzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992042;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=rT/jrZwwXN904cWDEpMToaPw7m4qZt1ENrd9xxrm5sI=;
	b=sNzcWFW9NvT9p2hExCBEgZ9cEcUjAAjAK7Gk/OUIt4/sBkJzHvHfvMLQGFLqGOUNhUUJ
	 flPQNWXuJ/XxDoqMeoT1dVLsjSkfjwNzETA0q29M/3dI1bc1jEe7aSoOS8NZ0C/dJNV9N
	 cA/WMY7GTP+nwMGRdrgROqhaCpKmAa9cVzeHSfBXHjuixb23EBfZ8aZGNEKcyJG9kY6M4
	 ecP31VBlgizPGg9K2ee0o+Ll70SJXovrHH3B5AgObo32rF42Tam0TmwNpMM12ihSAcE6H
	 Ij9ZkftrXE6kQmePyNOJM1LWMyKT+lU+7fReVc1+SdizssuxH5YSPmVv9JqIh6ytskg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CXb2FBuR;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hL5mwCxh;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06874606A32A
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 08:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06874606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CXb2FBuR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hL5mwCxh
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI8ZAci4060171
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 08:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rT/jrZwwXN904cWDEpMToaPw7m4qZt1ENrd9xxrm5sI=; b=CXb2FBuRtfrKI6Wt
	tT8jIN6qyBYv34z2hn2aEJXlfUTnX1rjG7egcgwnlrCU0ytmXazgbUnnEaVcjZAH
	sOsQrf+fbyZ6B4lp7MSMMlDFHcPw47QRhiglU6DFMxvyNGyOsF2seJ9eLlUeSU+V
	WgWoUJu1DsrRBUjv9veukm5BG1ISJgB+9tSKjyukDXkOQcDh9gK7Uao5QA/9YIla
	ysoL4lEPaypgdVQbW2rC2amX0IzaBPCU+CVG5eVCisHqFD+SUZAJr8duM+rGHsRV
	JBwfsrOWZc+h4ArFZ6X2ssVhVY9s5vIVPq818bd+jqbpxHFPe2Sjy/KdbkOWxdAK
	VfqpxA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yvcj6b3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 08:54:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93e92aad34aso147767685a.0
        for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 00:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794992040; x=1795596840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rT/jrZwwXN904cWDEpMToaPw7m4qZt1ENrd9xxrm5sI=;
        b=hL5mwCxhLsPZmxDjiHZ9i7b06yciCSeCCvWXcF1Bh6awNem1NrXrQzCND5bBceF9P3
         2oTJ870OLhfrhD70CNw9jcoslT8hunATDYJu4w42BBLx5kcgiolUYqeZNd48c7XG8hVq
         sK+cs404Ht+GxkVq9Ema0jfvXs+gesmqTI5TZacLFITaMeUlXygDmkEgpNwvn71xOnQ4
         Fdub+E1TmNeUlbDvcNmjIGacVSM+oR3hqzF91Krxd6ZtYhTLup1qz8X5rSvVI+UdFHEM
         CRbW7VymNiEt/dQkNEMhKJ/4emhyaLFhXyTBj7KrpOzDn2sYwTNA8xkN11S9hlB8ZcqT
         zrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794992040; x=1795596840;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rT/jrZwwXN904cWDEpMToaPw7m4qZt1ENrd9xxrm5sI=;
        b=dOwD3XAfvKjGgMym1klKmyT3x9IAX5ZIgP8xkmxJOr0y9whYT3yx6bHHgjxkLswoVG
         wmShp35bZkUnMTWWPr5S/XTZ5Fj58O3P6rTlstKI/NnGiqT+OtonS1y5RCTdW3FHNXmI
         6wpAOWiRRqh7s7mntXQ6in8SQDdwN6JMcioVaRf0KAlH5nio92FVHdYUcxcBMRK0KMpn
         Cel3Ed7T7zWyfoGn9CbYH1CbMBMes2inCMLtfVAKkahcdCaHzCqi5+lQsbe8s6jr1dZC
         doztNi1IyEYJdW5IYvU3/DXBXvrtaPk6dm4VZX4B96pF2vw3T29lgL+5kROPbb+9VUJj
         /JRw==
X-Forwarded-Encrypted: i=1; AL+hErGgX/jGCdsTKtlzWjdiAapBxo36Ji+CXsFOxhLh+v8WVYTVax2HLwgahWA5kpdbb4Ro/nJm8058a5Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/POrEVG4JohDmJa9ZiG+tJLvCUC13eLvuJN8JUQ6NTRxuPQ+gj
	oZYZpGJoYMClOGeHnhkhOH05BRsqy3nyB7AwNabeHbMoTyYU9MHr3MSYqEtjLL7l9+36wseBJhT
	cxVxcGBA9EbtkIySAAOMCGw4GpVOQ/Njz7MCWxx0hWH91SOEZtPJr6TeJGoEoC9s=
X-Gm-Gg: AYBFou1fgbE5ugBZLNiqJ4EKAR6tVOLlNw2w8m/GAi3tDX5Ld7lbSbCwPwT40nZUBG3
	G9l3iRRNqoP+Tv0MoWRAOtZ9lIRhIwSL+fjDUVC1Yr5WPjttqU6fZkVraMwjGLUNRWIU4vnufoh
	e4Oez3FPlhkqrvAaNR66gBWMVzeqWTQETDVgU9+iBPlBzsU7TYOZ7BenbCHfGtvS5SKlqQ+XQjZ
	ml7sdFsjPIObm6RnVlGOQy72tfG44vk0XI4+j08E6vqMvQeuv5Dj+0q97mAJlZ3a/St4Rlhl6UY
	Gy1BHtZziPtQPPn+bWy4+hh0TGdVBD9deDLULVPGN6XpxP45bE+jTZTH3+9GPfcksFWpjdgdijt
	CEDelFbNhXsXfPGjoUX78iIWPFuCVnajIYQDtQxeuRkRFR8KyUtM4kT89s7aKy8sr7LydqAY=
X-Received: by 2002:a05:620a:6f05:b0:93e:6f43:b2c1 with SMTP id af79cd13be357-94999576296mr365359685a.16.1794992040176;
        Wed, 18 Nov 2026 00:54:00 -0800 (PST)
X-Received: by 2002:a05:620a:6f05:b0:93e:6f43:b2c1 with SMTP id af79cd13be357-94999576296mr365357185a.16.1794992039637;
        Wed, 18 Nov 2026 00:53:59 -0800 (PST)
Received: from [172.20.97.137] ([195.50.164.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78430752sm135959695e9.12.2026.11.18.00.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 00:53:58 -0800 (PST)
Message-ID: <70618789-f82a-4cd7-953a-a97f555fa98d@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 09:53:57 +0100
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
Subject: Re: [PATCH v2] i2c: acpi: Force Dell XPS 17 9720 touchpad to 100 kHz
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, penhouse24@proton.me,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20261118073607.297350-1-mika.westerberg@linux.intel.com>
Content-Language: en-US, nl
In-Reply-To: <20261118073607.297350-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=R5OWitRX c=1 sm=1 tr=0 ts=6afd67a8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=PoUxWBnWaag7qOlay5cA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: rPDgv7XSc01WOHNUe2Sjvwb1gU9nkEmy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAzNSBTYWx0ZWRfXxqDyltv8nMzi
 EgqpRBiH5HgxuiFGq+uOCSHX9XQw/rYZAzVxjVfZLT65zSPxHm0NvSX/lZZM0VtwDIxI8wO1qW2
 vcBisLzebo3xuSpdM2UZbT9OfU1dcqE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAzNSBTYWx0ZWRfX1+IGsV1b3NMe
 3z0sHfV05WYR+NwqV4JJpmP/UnArKLzpuQaD22Z85YwgQl2jG+CskV5pA19mNoGd11LQUtAm7P4
 +mdREJV38QW25alr/XrBV3uRy5nS+a2Bf4jEUiXPVzZWKJog0I/BRfd+FJO0S60vGvPQEtiMMp2
 awP4HJ0UlN2tklokRlVKYXbMtLV8N1REUxn6FwgktgUEmUlPzXUDoBPSXfC/wiXP3YI87TyGKoE
 xZZc9ZMuJOFbwgl4NPBjdyywgj2py76ZVAqAjZwC1P3h6LSd+x+BlZv12PSc5fxOxDk6c0ObuzO
 e84cf8H0xbiQFlAcGFvhjYQujkj8xTH4JDjN8wbFdtTy5XMT86ce7yV1o4aOgD6zr9NVDkI8eeC
 pdBNzR96f/L+UNJTTiVoMSvaV/yxyW9yW4vnl81wRs3jist7xUcLwftsvAfzGhUMGIJfJav8vWe
 BqnezR3NqQD33fluKVA==
X-Proofpoint-ORIG-GUID: rPDgv7XSc01WOHNUe2Sjvwb1gU9nkEmy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180035

Hi,

On 18-Nov-26 08:36, Mika Westerberg wrote:
> The Dell XPS 17 9720 touchpad has the same lagging issue as with others
> when run at 400 kHz as the ACPI tables describe. This particular system
> does not use standard ACPI ID but it seems to use "Windows Device ID"
> VEN_04F3 for whatever reason. Add this one to the 100 kHz quirk list as
> well.
> 
> Link: https://lore.kernel.org/linux-i2c/20261109104542.GL176724@black.igk.intel.com/
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=214597
> Reported-by: penhouse24@proton.me
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans




> ---
> v2: Drop the DMI match, add bugzilla link.
> 
> v1 can be found here:
> 
> https://lore.kernel.org/linux-i2c/20261113083940.2583439-1-mika.westerberg@linux.intel.com/
> 
>  drivers/i2c/i2c-core-acpi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index 84841ed13487..64fdf8ffb5ff 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -377,6 +377,12 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
>  	{ .id = "ELAN0678" },
>  	{ .id = "ELAN06FA" },
>  	{ .id = "ELAN1300" },
> +	/*
> +	 * This is non-standard ACPI ID used by some Dell XPS 17 9720
> +	 * systems. They do have the same issue when used with 400 kHz so
> +	 * force 100 kHz.
> +	 */
> +	{ .id = "VEN_04F3" },
>  	{ }
>  };
>  

