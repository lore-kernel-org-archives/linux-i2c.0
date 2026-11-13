Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563534;
	b=zSDCOsMXQQj1r5r/3vM/rQdaxbgcLw/sltbyIjQOBmA1bYlARnvMN4EWgf5urOoZeImA
	 JjxjaDu83rais7QtYZC5BR98ABLlzInZGysBJYF6DfskCujny55zOfiDus+dnnQkNNnkZ
	 /xBq+s5yd5IcZHfFfBCBncjRKxCiRyI9I81TiSK9rZlsov4ClD9BU1t7HybGXvNZeUDKS
	 jW6Jwl888SvqMtZmNxDYfZ1PKpNalYvpz6EfN2Y38KkRgzCBaiAbvINRsENBntITgaLxZ
	 6ZneD2WEDDtCuPjzBB7jsc1gjvxwbSzmF+p0TlPwsb8UA1Tuc5u7tYkyob+tmSIXi4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563534;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=2opdJJXryXP0UsevT5a27VA/3GVOoWINCm/Xq0V9S9Q=;
	b=V9tIPFyOwD/6h4jwAyCRSO4lJZosYZ1zcgfdw9daEHiYqxuSw0oivP7vURS7qNLmggjX
	 YMysAQtb44Vk5uIJPEOITQ5041TkkAjNxjrziUZbWY9U+FuqcqT+XB3/VU4QpHSU2gQU4
	 pjPEHoxjqkJOooAVbAWdLXYATOmmZvX+UN4j+73Zq8dw7RZDdNn+c62hcTkgh6+Y1KOHV
	 fVBsDMU4198pNF+HU7ie9epx3+KYgrUEy1rs/pxgzhSRc3ojty6bVTIgjc5SlXZiFcgox
	 7vpOZmQi5Z5DngJr8vwn8x+ffHzWB9hQ4KKnfwWMZt613hAdS4m1NCcZe1sV8v9dtHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PA5TPt4A;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bBlgxb+y;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A49606A32D
	for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 09:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2A49606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PA5TPt4A;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bBlgxb+y
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8V2p24101695
	for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 09:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2opdJJXryXP0UsevT5a27VA/3GVOoWINCm/Xq0V9S9Q=; b=PA5TPt4AiyN2M7qR
	6qlpPBiRG9Srj2CvMMY/VGmmN3bvgLGTbWUkKCBRi132sc+aKVL6XR0pdoNSsAzc
	9UcJM8+o4QU2gDmaSxM/CK2e4o3m7/SHHPzxIlBGxtdzRnxbyESSjwfxwmF7jayI
	VexIfz9ABCtz8Xzm1tNj2kSEY32njRA9uWenbAjrPYtaroL0+TSHCsZBDNahQkOK
	O9rslZ4EXNMc3D0xWDU7pK3mhqAmc2LEFTotucyQTy2rbBW3fsvVLpYxJ7JReHoe
	eejX3P3gJkMDm23rXWIGRkFCwcFDo/YGbkhXXmGhkFRgRoF7mWvrhPxbHuhOLnTk
	C3hakw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkfdjm2j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 09:52:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-946038e22f5so21709585a.0
        for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 01:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794563532; x=1795168332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2opdJJXryXP0UsevT5a27VA/3GVOoWINCm/Xq0V9S9Q=;
        b=bBlgxb+ythUFOa/5NUKa1DMYkYlmt+dTUsy0owJ7bOHzTw3MRgu9V9SF3A7ErFd0H6
         Jxqr3n5iPCOJv2xNGra+Fc9LHtCTgmOeiVbkK12USlqjQcm18p+k1TXedjIuhCd3MkS9
         acwKGFnjHZkDPdGVBD3JZR+nxx1x8gptvFwe7QqZ677E1Xk7mGpFSipbiJrucTuKXmis
         pyGEesFmP8Oq7Z+fiircEEptUMko54LD5l6HvvX3PRdjYMen20cKpxLl4kpu5Ma9iEfm
         4LLN5hiHDX6d2XuKsiO+uLJdV/Up/keu3vfe9DlAsL3oJxR5rrT8YZZ66dDXpyZujV5x
         i6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563532; x=1795168332;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2opdJJXryXP0UsevT5a27VA/3GVOoWINCm/Xq0V9S9Q=;
        b=q43o4YAeQAvquzJ+hInShKjy7bipHPM6P5fFbSuWODSVHU4PrKkheN67SB1aI0iOLs
         57vA6DUGyMd3YfkjiFoDBe9M8QwjkXRnuAobbEd3TLIZo19iysfHWM3YE26s7jkfdGOd
         7kd0JPo9qMD0WX7oDIvnaHo8Iosqo4E0Z2D1/9rHlI6kb0hK8D1p/8T6QDBhrQp2+rT5
         ZJwS+/ssGsAAcbCzOju0A/yY1DoIGH+vjkvfFLUcOPr1RpuIP9IzhWXg0IJ1XwMGEhiQ
         giRzSIMD6nFX8ul8ST3TtCQ1SDsmeefR2YkI5OLgnuenOAt9COKJgyyvtbcdiTgdTPz5
         ejzw==
X-Forwarded-Encrypted: i=1; AL+hErGubFH12bIREo4UdStN9pUmZGR+VllKExLnUd9kyaq7x+28tFJ6/Ztu6cBySvHIuUs1yaKKCrHbEZ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+eQBfxWUfAdkQ8xccNCxsie9XneCbESnUKcFhVfeP2gFeYKnw
	CJ75fYYvW6fttHW9FVCnOuRdqwZzSziu5ZMf/O3p3FIIq33cQeznKhbhHRLqff+ofrZHCU+hqE6
	raBp9fEo6cs9D2Jd5g5NAhh08eLsiRqwVkSKBpFDk0iVfz/WOvnUL5asS0Z3bTSCiIln9UNA=
X-Gm-Gg: AYBFou2TUrwQ2bGWY4tTMgqsKB0MFwvtdFgVTc3D1ofV7wo9cKUtuJnUTFjU92aKl84
	PuUUczK9HIaipnCRNmXPaie5XqiptrLuDrhvgxZ0/YgM0gPLJtrFBz983VHtbyVZOWOddipHFxp
	xmu4JFLTkCQ1UBAEkOO8rcMD4328yEueiHbg+TouyOOHclFGYGUd/joM5Fo0oABoPshWycvAhWf
	ngpElylcCPm5oHDeXGR8PlVa783i8k8YUl/42/G0WrY95o3yUSXHJMqqKAvL9Lpa3tY/ww12M3G
	ooutc951qoLf33FVenn5Jwh7R7qhfbaw2LZZ2k0ftqqikRPRyy8YkBPv8ruEoZ0V1PmCTD4sSSR
	IqNuTB/yNcn7lYHmp4r89TDEjDY9R3zjy7uu5CEDfoe9rgFOzN9QswuLStz+5BnWL5r6k6ZLjd7
	fOfa5P8LAhyUvmcIFE9V6LyCo4ktJ7OgY8O6M874KHZRP6JAM4PiDBOpm6FdAbnNvbapTNCrRHl
	XSMCbY78HNIiAsX2R4mWRCbwNY/r33uKJH0zYR8t7A/
X-Received: by 2002:a05:620a:6606:b0:93c:7955:afd9 with SMTP id af79cd13be357-9494bb9e1dbmr296002485a.52.1794563531907;
        Fri, 13 Nov 2026 01:52:11 -0800 (PST)
X-Received: by 2002:a05:620a:6606:b0:93c:7955:afd9 with SMTP id af79cd13be357-9494bb9e1dbmr296000085a.52.1794563531469;
        Fri, 13 Nov 2026 01:52:11 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b3asm73666766b.27.2026.11.13.01.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 01:52:10 -0800 (PST)
Message-ID: <b47bcc52-b969-4337-bd86-890b9cd80c3d@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 10:52:09 +0100
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
Subject: Re: [PATCH] i2c: acpi: Force Dell XPS 17 9720 touchpad to 100 kHz
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, penhouse24@proton.me,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20261113083940.2583439-1-mika.westerberg@linux.intel.com>
Content-Language: en-US, nl
In-Reply-To: <20261113083940.2583439-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzOSBTYWx0ZWRfXyK9pfJc8cMt0
 Aaba1zS/OyjXLgDBFhKA6tKvDYHBN+3l58uejJRKbYIGy7uopLjcEWGfwy1CP6+c9kbgectv1lV
 1+tXlFsq1rfzmztDzjLTZWdvy8aacWI=
X-Proofpoint-ORIG-GUID: 1jUNovh2Pqyott25ZDSoy9C43jF8umzW
X-Authority-Analysis: v=2.4 cv=DoTDa2/+ c=1 sm=1 tr=0 ts=6af6ddcc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=mdUqMN-9PR8XuoQFAEgA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzOSBTYWx0ZWRfXz3kOSeD0WybI
 hdsKLiAbbcw+IJxBA101JQzBwZUJRmq/qmfnHPXy24gpX8kBV2ucnT/Z8Zap8oW3jH7AzIo0AsA
 nHQpE/kQcJvhxcAy7/aX2tvobPBOl/GKGUimGMT5zUJsbV0sam/LwKiXJHobGV/4z0XmixUhpBw
 IxSqYlvQGiDud8VT/Tbi02UVN4X5xHIzgLqzZNYWwhv1gVE9nNL0syqLwuj6R3jhBQ7pp8ufdH3
 afJ7WrPgD2PDQ5T9dShYFnKdnkDrD9GCa9/7tQLOHRnH59Qfyw8O6pz7D7uJ43ueGuljFyBTdtC
 kbLR1Z/v9nWo0vvLysnx6HaKOrE10ibMHgzQ08we+f0xSaKv2CbWau3k74EM7SXmo+6UWVCXu72
 quw3GEdWQUtGTp7Gtz2htgYhJkDcKyeLugVHq1UgpuHPXm9VkDpKWooIG8j+JRg+BlvQhZJAwDv
 AaJVHer0eXDFBeQvuIw==
X-Proofpoint-GUID: 1jUNovh2Pqyott25ZDSoy9C43jF8umzW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130039

Hi,

On 13-Nov-26 09:39, Mika Westerberg wrote:
> The Dell XPS 17 9720 touchpad has the same lagging issue as with others
> when run at 400 kHz as the ACPI tables describe. This particular system
> does not use standard ACPI ID but it seems to use "Windows Device ID"
> VEN_04F3 for whatever reason. Add this one to the 100 kHz quirk list as
> well but since this is not a standard ACPI ID match it also via DMI
> strings just to be on the safe side.
> 
> Reported-by: penhouse24@proton.me
> Link: https://lore.kernel.org/linux-i2c/20261109104542.GL176724@black.igk.intel.com/
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thank you for your patch.

> ---
>  drivers/i2c/i2c-core-acpi.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index 84841ed13487..98a8d63e3fb8 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/device.h>
> +#include <linux/dmi.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/list.h>
> @@ -356,6 +357,16 @@ static const struct acpi_device_id i2c_acpi_force_400khz_device_ids[] = {
>  	{ }
>  };
>  
> +static const struct dmi_system_id i2c_acpi_dell_xps_17_9720_dmi_ids[] = {
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 17 9720"),
> +		},
> +	},
> +	{ }
> +};
> +
>  static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
>  	/*
>  	 * When a 400KHz freq is used on this model of ELAN touchpad in Linux,
> @@ -377,6 +388,14 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
>  	{ .id = "ELAN0678" },
>  	{ .id = "ELAN06FA" },
>  	{ .id = "ELAN1300" },
> +	{
> +		/*
> +		 * Some Dell XPS 17 9720 systems do not use standard
> +		 * ACPI IDs so we need to match also via DMI strings.
> +		 */
> +		.id = "VEN_04F3",

04F3 is ELAN's USB/I2C-HID vendor ID and the commonality between all touchpads
with needs this seems to be them being from ELAN.

Also a quick grep through my DSDT collection shows 0 uses of VEN_04F3,
which makes me think this is pretty unique.

So all in all I think we can just add a match on "VEN_04F3" without
requiring / adding DMI matching ?

Regards,

Hans



 

> +		.driver_data = (kernel_ulong_t)i2c_acpi_dell_xps_17_9720_dmi_ids,
> +	},
>  	{ }
>  };
>  
> @@ -385,6 +404,7 @@ static acpi_status i2c_acpi_lookup_speed(acpi_handle handle, u32 level,
>  {
>  	struct i2c_acpi_lookup *lookup = data;
>  	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
> +	const struct acpi_device_id *id;
>  
>  	if (!adev || i2c_acpi_do_lookup(adev, lookup))
>  		return AE_OK;
> @@ -398,7 +418,9 @@ static acpi_status i2c_acpi_lookup_speed(acpi_handle handle, u32 level,
>  	if (acpi_match_device_ids(adev, i2c_acpi_force_400khz_device_ids) == 0)
>  		lookup->force_speed = I2C_MAX_FAST_MODE_FREQ;
>  
> -	if (acpi_match_device_ids(adev, i2c_acpi_force_100khz_device_ids) == 0)
> +	id = acpi_match_acpi_device(i2c_acpi_force_100khz_device_ids, adev);
> +	if (id && (!id->driver_data ||
> +		   dmi_check_system((const struct dmi_system_id *)id->driver_data)))
>  		lookup->force_speed = I2C_MAX_STANDARD_MODE_FREQ;
>  
>  	return AE_OK;

