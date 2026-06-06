Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150F319ADA4
	for <linux-i2c@vger.kernel.org>; Sat,  6 Jun 2026 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780783665; cv=none; b=bRfIP3j6bNv4rV48qCHTT+Lthj04wTJuhULNxX7rbVT7Cx+tbyUQgk5h6A6BKDb3DEm28QGq9rhCwMtVz0B3Ig/12qqmi7BD7PDVxaZoN6C8xt9GaKzKx/1GvL2cBTDRv5ANGpVPlGQhgGEgLDNiIUN4IkxUCMDWg1Ln4YigewY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780783665; c=relaxed/simple;
	bh=9iuj5l0sCkKU9w7gdExDHF784qD/2Jj7cb01Bwt75cI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQpNiSDY/c5jkdAlddOJxyBQKuCQ+Kmv9fgFcApqv5QeyYDoCsIf1H6bh3st1gwqsORzTkSbUn3FYzqejlJfbmJTHKN7Kj2+82pkQ6RVto4VnqOx7np5ns6YkXXW/ScFQwMfbQ1zpl5alPzAqVuEnIlhk+3kZVanOGCbVN4GBeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=AeGORvRX; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="AeGORvRX"
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662] ([10.64.95.107])
	by smtp.orange.fr with ESMTP
	id Vz1xwKzc2B6b7Vz1xw6ELF; Sat, 06 Jun 2026 23:58:13 +0200
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPSA
	id Vz1owq3QBibRrVz1owT7rp; Sat, 06 Jun 2026 23:58:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1780783086;
	bh=EchWlvJ3PydfgeHB+TRTfCvRAuTTMpFwlCBVkM3mmvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=AeGORvRXEfAW70HJGCDNkQHmhl6bshfswzHeDshdDJlrC657MPOKhgJzdmKTE9LEN
	 hZOYh1Y+dQgvtMyXiwdsIss2t8IDcKDGCGn02VDDeGETyBri4UlAT3coEJYCLY6iZo
	 BqrFK3UlLgoXVBdgtIfK/+vylDD1NLTGO8FwvSyN6koby4E9ZWm8OOy6Hov7e7PXhg
	 81993AXcuA8eq6/3Ydg+l1LIOVdXSEfMdPFGRlHTd94+s39LxBeW8gDI2F5HY6kbFF
	 VNK1880w2EaIvSyZVK+NpcPRXR/DJZ0U2BtrfgJb4E8S1+dAKI5wRQ6LZJjFKCurlD
	 5i+tGLs6fkzCw==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 06 Jun 2026 23:58:05 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <0b13ebc9-8781-46ba-9a55-cb4d54afcf1a@wanadoo.fr>
Date: Sat, 6 Jun 2026 23:58:03 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] i2c: change return type to bool for
 i2c_check_functionality
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260421161607.61314-3-thorsten.blum@linux.dev>
 <afhjp_ib0padlv5z@ninjato> <aiSRJups6bcEtb3U@linux.dev>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <aiSRJups6bcEtb3U@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 06/06/2026 à 23:29, Thorsten Blum a écrit :
> Hi Wolfram,
> 
> On Mon, May 04, 2026 at 11:15:19AM +0200, Wolfram Sang wrote:
>> On Tue, Apr 21, 2026 at 06:16:09PM +0200, Thorsten Blum wrote:
>>> i2c_check_functionality() returns a bool - change the return type from
>>> int to bool and update the comment accordingly.
>>>
>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>
>> Basically OK but you need to fix the in-tree user first using the 'int'
>> behaviour [1]. I'd think you can send it with this patch as one series
>> and have it go in via the I2C tree, but Lee has to agree then.
>>
>> [1] $ git grep 'i2c_check_functionality.*='

I think it should be git grep '=.*i2c_check_functionality'.

> 
> In linux-next [1] shows no more results and I believe all have been
> converted.

Looks like:
    drivers/gpu/drm/bridge/sii902x.c:       ret = 
i2c_check_functionality(client->adapter,
    drivers/media/i2c/isl7998x.c:   ret = 
i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA);

need care.

CJ

> 
> Thanks,
> Thorsten
> 
> 

