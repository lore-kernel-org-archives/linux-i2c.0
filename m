Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795859257;
	b=Q41E/WGFShoDxDW9kTy9snT/j+jPXuNjsMyBhyZScVhwJMA099qA2RyttoGcAZ7GQEu1
	 zzSbyubYS4Oxygm1k08RL2xTh6F+bq82Yr/O0SguENMupIbye3u/fXT/zdY1DG+Cy5eho
	 p8rty2i6Hi1oQlkkWiiSVKyjFhyUifGl9mMbgI6PWIVmbQngeil49SDOw0qcFSsTpWfgI
	 9zoi8xwgNzlQbkgz+KRW/hMiT+h6Aa27WA7am0k2woL2cZjcJT7CYPGxhkMBxES0vXICK
	 yZ0TcvBB5xuTlERGWXsOnt6g4yvrSIJimPycFaK7sNMPsn/NahMUqIXydm30Wvz5qKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795859257;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=FyJp9QfPY3YUWGG3S6HBUh05+r/4JnDVqJPyNXnlgPE=;
	b=VyXuM9/vszhVM+2UtmzbS2I9bSIcw4s6nSL5DN8xhVRo+T6rDy+jsLgtJlKnXwZhCv8N
	 WC4M9QV/4LHPG1dwXedBDtvfjbmpGKCqQJ8JRMcsvjVz4qMZYd9C63xH8jb81aWOtLLpU
	 ccJUVKMlIYimmPKCLfk8j48fDHPjXNMYHby+jwA64i72vIeONn/6BBEGjkmsJTjaMPZl6
	 uKC2Mo+v/gHIUzStCjlpbHlhpeqiw70qWpcraOMDYUrjIp9R5ZDeymPvIkB+qGFgBYknG
	 HgtqbkTFLzPXFFn3bmfqZcyM/zPEAOeCc8FqQABKmaQnn59cAvUthGccolu6rp6fAFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=f5EhgS1S;
	arc=none smtp.remote-ip=35.89.44.33
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D7D606A31C
	for <linux-i2c@vger.kernel.org>; Sat, 28 Nov 2026 09:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78D7D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=f5EhgS1S
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id X0EtxoTtYAR1iXF1mxGnqQ; Sat, 28 Nov 2026 09:47:30 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id XF1lxSallSgq1XF1lx28pg; Sat, 28 Nov 2026 09:47:30 +0000
X-Authority-Analysis: v=2.4 cv=c8KrQQ9l c=1 sm=1 tr=0 ts=6b0aa332
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=bC-a23v3AAAA:8
 a=pGLkceISAAAA:8 a=_jlGtV7tAAAA:8 a=VwQbUJbxAAAA:8 a=hlfnyKRkvWnGTZ9Lqq0A:9
 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10 a=FO4_E8m0qiDe52t0p3_H:22
 a=nlm17XC03S6CtCLSeiRr:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=FyJp9QfPY3YUWGG3S6HBUh05+r/4JnDVqJPyNXnlgPE=; b=f5EhgS1Spqu0
	XtU9+z6/x3L/49za8YRkTIKWDXRGy2YM3GQxd9l9I383eyA1HpfYKLzRUzrpYx99kiLZ4/QVutoys
	wAzCWrRAB3EUxLOC919Hx6DWgGd6Iz7cdKe8Jhqe/r24uvVpgMIrwKfo7en9/CJ0VNjs3pr6/x2+7
	1MsZHfuUiUc5cRRUsHH6+Kv+t/pH2+VU6cexp8zCrs0voshRWseL4sMzkH6P9jyh3GmdLrUrfwfFl
	W2Rn07l5TA/6wge0Y5Wele/C3R9LJ/CL4RlVVjm3WrTdoZKFkBaQn9WPzFgeSBfwPUqhYYPBXPAEe
	CMdF3n6vqD+GJ7GoqjJivg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:40874)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.2)
	(envelope-from <linux@roeck-us.net>)
	id 1xXF1l-000000011Kb-1KHy;
	Sat, 28 Nov 2026 15:17:29 +0530
Message-ID: <90fdb29a-a753-466a-b9a3-7a461f5dbdc9@roeck-us.net>
Date: Sat, 28 Nov 2026 01:47:28 -0800
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
Subject: Re: [PATCH v2] i2c: diolan-u2c: Use get_unaligned_le32() to read
 serial number
To: akafelixab@gmail.com, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org
References: <20261128-i2c-diolan-u2c-unaligned-v2-1-c6028a74f24f@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20261128-i2c-diolan-u2c-unaligned-v2-1-c6028a74f24f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xXF1l-000000011Kb-1KHy
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:40874
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 1
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLFSfs2MQcEJlf31/wc3Ncgv1kClxJKR8XVWdJ0Hp1bWgonFbk9Xy4xbOpD5WStcSXFA76B5YBMC7GzDJSOsZyIOMnA9H22N2UlWwE9eMcLq/cCLdIZ+
 NjSS3uVv+9wgiS+uP7Pm3YO/AkjvI7kBxlTi40WZ6ZIMme/OVWhT6jk8IT7vKeXwLjcHfCWk/EDiXgdW5niBAIFdsmIF08Cy8Ife+eJjn3/aVQCRkc/q9HaF

On 11/27/26 23:06, Felix Huang via B4 Relay wrote:
> From: Felix Huang <akafelixab@gmail.com>
> 
> Sparse reports:
> 
>    drivers/i2c/busses/i2c-diolan-u2c.c:290:26: warning:
>    cast to restricted __le32
> 
> Replace the explicit cast and le32_to_cpu() conversion with
> get_unaligned_le32(). This preserves the existing conversion semantics
> and silences the sparse warning.
> 
> Signed-off-by: Felix Huang <akafelixab@gmail.com>
> ---
> Changes in v2:
> - Reword the commit message to accurately describe the motivation.
> - Do not claim that the existing access may be unaligned; the
>    serial-number buffer is naturally aligned.

That does not match the reality of subject, description, and code.

Guenter

> - Focus on fixing the sparse "cast to restricted __le32" warning.
> - Link to v1: https://patch.msgid.link/20261127-i2c-diolan-u2c-unaligned-v1-1-0c3621b7690d@gmail.com
> 
> To: Guenter Roeck <linux@roeck-us.net>
> To: Andi Shyti <andi.shyti@kernel.org>
> Cc: linux-i2c@vger.kernel.org
> ---
>   drivers/i2c/busses/i2c-diolan-u2c.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-diolan-u2c.c b/drivers/i2c/busses/i2c-diolan-u2c.c
> index d502f6e47..24db6d26c 100644
> --- a/drivers/i2c/busses/i2c-diolan-u2c.c
> +++ b/drivers/i2c/busses/i2c-diolan-u2c.c
> @@ -16,6 +16,7 @@
>   #include <linux/slab.h>
>   #include <linux/usb.h>
>   #include <linux/i2c.h>
> +#include <linux/unaligned.h>
>   
>   #define DRIVER_NAME		"i2c-diolan-u2c"
>   
> @@ -283,13 +284,12 @@ static void diolan_fw_version(struct i2c_diolan_u2c *dev)
>   static void diolan_get_serial(struct i2c_diolan_u2c *dev)
>   {
>   	int ret;
> -	u32 serial;
>   
>   	ret = diolan_usb_cmd(dev, CMD_GET_SERIAL, true);
>   	if (ret >= 4) {
> -		serial = le32_to_cpu(*(u32 *)dev->ibuffer);
>   		dev_info(&dev->interface->dev,
> -			 "Diolan U2C serial number %u\n", serial);
> +			 "Diolan U2C serial number %u\n",
> +			 get_unaligned_le32(dev->ibuffer));
>   	}
>   }
>   
> 
> ---
> base-commit: f4585067150b85e33f60876149a6e742928da75e
> change-id: 20261127-i2c-diolan-u2c-unaligned-2599ede88a92
> 
> Best regards,
> --
> Felix Huang <akafelixab@gmail.com>

