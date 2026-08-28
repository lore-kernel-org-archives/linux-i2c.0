Received: from smtp.smtpout.orange.fr (smtp-75.smtpout.orange.fr [80.12.242.75])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D719336196E
	for <linux-i2c@vger.kernel.org>; Fri, 28 Aug 2026 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787949724; cv=none; b=r+EN5fkHRM5xnyENO/tQh2ZkYKZSs3kwlT0She77Eq92a3oUQgQLecT+DLKTtdMIYeMWIvyi5EeaWMMLFUSDoZYjvE5ryjTKB+4PaM96myTTsaRysAXlWWoLt1ee0wcl/NrfX6awVOnyE+JbvVLmnC0MlSxf5m+3cXohHg0eovE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787949724; c=relaxed/simple;
	bh=NSaVn7AHt8qA+uILI4/bx4odt7pRB13dSijKrCIEt7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkpNk0GCXjUog28H+pwd2qcobOXymYBSltvRXlZs4tIO3BPbqZNILf9dcPkMhX6iNUHej453TjLnY5g62C8YePi8ILHtSRNzTBHNfHnaKpXuopoQdyP2CfOGO7DN9ePWmAJrFcsGRZCyqMrD9U+hX2m+Rnz2ZkV5kNrJPumV7/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=mNdn5ojH; arc=none smtp.client-ip=80.12.242.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="mNdn5ojH"
Received: from [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e] ([10.65.86.61])
	by smtp.orange.fr with ESMTP
	id 03NZxTkEox5HF03NZxA7Ve; Fri, 28 Aug 2026 22:40:49 +0200
Received: from [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
 ([IPv6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e])
	by smtp.orange.fr with ESMTPSA
	id 03NOxNUjQCiHw03NPx3cy8; Fri, 28 Aug 2026 22:40:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1787949641;
	bh=HKrFpzBvfIoM9ilsRfu5XPuvKnr6zM3SA7HOxOIyOLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=mNdn5ojHKPeF5u/hXtemGJ1rV8XAtVNs94GKiALvSnKjmTxPnXx1/MFHb3IZ6/53+
	 yg/Xv9ESzsPaeFDTDuR32i4HwkTuIOLfqvkjaakRJqXzAqdKsJqx99kg42j40zeYXo
	 8qEbARtCdm0vXjbG8fKlLcgpBUcfnFhwjT2QAIfBwvhn77KR4hHRtaeIv/vZAUEHBT
	 CGttPN/etVefxua+Qzdcos1wXBtgk9GGaJNpRJKedrXIoWSqf3mrVTYs6gz82nLze0
	 iIXB2nma0Kmqa8nAOmKDVfLeRo0cFQCuEC40jW0ltdiBfKiwj9TTPJrkOhnsxTbhbM
	 E/kZIePsda7KA==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Aug 2026 22:40:41 +0200
X-ME-IP: 2a01:cb10:785:b00:26fb:aefb:6cd2:db0e
Message-ID: <c9137cb9-8cc1-4c68-aea0-f429b14c1262@wanadoo.fr>
Date: Fri, 28 Aug 2026 22:40:38 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: cp2615: handle allocation failure
To: Andi Shyti <andi.shyti@kernel.org>,
 Triet Hoang <triet.hoang.dev@gmail.com>
Cc: bence98@sch.bme.hu, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260816161751.24840-1-triet.hoang.dev@gmail.com>
 <20260818111703.19604-1-triet.hoang.dev@gmail.com>
 <apG_qiYtTQvt9s-y@zenone.zhora.eu>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <apG_qiYtTQvt9s-y@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 28/08/2026 à 19:09, Andi Shyti a écrit :
> Hi Triet,
> 
> thank you for your patch.
> 
> On Tue, Aug 18, 2026 at 11:17:01AM +0000, Triet Hoang wrote:
>> Check the result of kzalloc_obj() and return -ENOMEM
>> when the allocation fails instead of passing a NULL pointer
>> to the message initialization helpers, which would return -EINVAL.
>>
>> Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
>> ---
>> Changes in v2:
>> - Clarify the commit message to describe the actual behavior change.
>> - Fix coding style regression
> 
> Next time please don't send your v2 as in reply to v1. It
> confuses me.
> 
>> ---
>>   drivers/i2c/busses/i2c-cp2615.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/i2c/busses/i2c-cp2615.c b/drivers/i2c/busses/i2c-cp2615.c
>> index 951de6249834..c1275fcad636 100644
>> --- a/drivers/i2c/busses/i2c-cp2615.c
>> +++ b/drivers/i2c/busses/i2c-cp2615.c
>> @@ -128,6 +128,9 @@ cp2615_i2c_send(struct usb_interface *usbif, struct cp2615_i2c_transfer *i2c_w)
>>   	struct usb_device *usbdev = interface_to_usbdev(usbif);
>>   	int res = cp2615_init_i2c_msg(msg, i2c_w);
>>   
>> +	if (!msg)
>> +		return -ENOMEM;
>> +
> 
> Your patch looks good, but, as you are at it, can I ask you here

Yes, the patch looks good (and the proposal below even better), but is 
not a must have.

In both cases, the error handling ends being done at [1].

This is not obvious at all when reading the code, but looks safe.

Just my 2c.

CJ


[1]: 
https://elixir.bootlin.com/linux/v7.2/source/drivers/i2c/busses/i2c-cp2615.c#L85


> a little effort? Personally I don't like and I find unreadable
> the form:
> 
> 	struct cp2615_iop_msg *msg = kzalloc_obj(*msg);
> 	...
> 
> 	if (!msg)
> 		return -ENOMEM.
> 
> Important assignments, like kzalloc_*(), shouldn't be made during
> declaration. I prefer the form:
> 
> 	
> 	struct cp2615_iop_msg *msg;
> 	...
> 
> 	msg = kzalloc_obj(*msg);
> 	if (!msg)
> 		return -ENOMEM.
> 
> Works for you? Do you mind updating in v3?
> 
> Thanks,
> Andi
> 
>>   	if (!res)
>>   		res = usb_bulk_msg(usbdev, usb_sndbulkpipe(usbdev, IOP_EP_OUT),
>>   				   msg, ntohs(msg->length), NULL, 0);
> 
> 

