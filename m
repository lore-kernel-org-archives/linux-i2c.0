Received: from mail.as397444.net (mail.as397444.net [69.59.18.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4929277035;
	Sun,  1 Mar 2026 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.59.18.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772373510; cv=none; b=j/nGKsetnnAOZsIOlmJYgiZk4t3/yaRnC6vL5MLuMr6BaVJmTkK0S2moiJFL0W3PgfOGDzh1F6WkRSMOKaviiwVIcQaG8EFUvOh8xAI5411oN/mZbK45xhHweSHEmOdP+nb7RzvF4U0Spu1AGkhZ8E6MO2P6RdW4jEtzVOBnQ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772373510; c=relaxed/simple;
	bh=VBAxkN79KbtbIQxki1glUGp8krKbyCWtPtGK9crataA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9dr8ABZ/NeRyISrUQoh7EjglIn4zR42tAfkpxDsGS173WVnkR9g0BppZ72uurPXjnsO2h674wA/40nbkka9dxMY53j3H6G+IyPLWJaVLyHYpkWI1KUxQ4hP3aH0+Kmj/w+CDB+QxuOriT6dIiDczwN2Tt0ftgvMpSqKjqc/5p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mattcorallo.com; spf=pass smtp.mailfrom=mattcorallo.com; dkim=pass (2048-bit key) header.d=mattcorallo.com header.i=@mattcorallo.com header.b=VZJmOYAM; dkim=pass (2048-bit key) header.d=clients.mail.as397444.net header.i=@clients.mail.as397444.net header.b=rp/Vl/O+; arc=none smtp.client-ip=69.59.18.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mattcorallo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mattcorallo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mattcorallo.com header.i=@mattcorallo.com header.b="VZJmOYAM";
	dkim=pass (2048-bit key) header.d=clients.mail.as397444.net header.i=@clients.mail.as397444.net header.b="rp/Vl/O+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mattcorallo.com; s=1772371262; h=In-Reply-To:From:References:Cc:To:Subject:
	From:Subject:To:Cc:Reply-To; bh=03hGzaCRmdd/bGfmzvUfQvUWBy+Zp/ur0GSlkHmwux8=;
	b=VZJmOYAM8VVgYoN/ByhW0vhh1yroTivOJZBkgQFTHeujCT5p5g5rgyNGJ3NVnnyhfO+f8afIiea
	+cKlm36+DPIrRaWy5Q4XX1E7Z2HnbAaCDt68swCCrFP0zTSGtWMaQKd2ExG4O4m4UY0RLqD1QN44+
	oosJeKCFh/w/0dHovWaYTbnAGt4717vkY9cEYxrnaRRcNYUzHNkFEquU7txS6ivr4qm2KhhRDC7Kg
	RZzcUvDuj3yIqjcJoPFQtlygjGiMSEMJMXOj4jidNMffb/gD1zpdN8PYhQ9q8DF+B0SW1VT7G+xZE
	3hKr132n8YeBSZFxcIAlT0pUMmj7uJpe8Lvw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=clients.mail.as397444.net; s=1772371264; h=In-Reply-To:From:References:Cc:
	To:Subject:From:Subject:To:Cc:Reply-To;
	bh=03hGzaCRmdd/bGfmzvUfQvUWBy+Zp/ur0GSlkHmwux8=; b=rp/Vl/O+LUWMcI5+Tdqd6yLmva
	DRsFwcsw8AgsKxrSGjxWMKPH7PZHXk7yW5tnnttyMky3I9/VoUh91qhyQRNdhDb3ftNfkjxuogFeU
	wt4GVJcRmFv/91SNtGhjHM5wqrh81rR1pvR5seQ4+OzKEgIkIXGocXG0hame9gQAdGIHJRsqFQXxh
	wIb8m9PPavr0aTkSqEkFG/4LRgwJkB66cXZiYoqAaWKeGQvDrFSRiLw7DEu+1IH2YzvM+nSFHmnkk
	T268zICk9Q685f2IcgB7ZzkBH+28IYaYqo1GS57k9lHao8du/wXRDk/SbWL1zTmcUdtQrlNz/6B8H
	TVuoNirA==;
X-DKIM-Note: Keys used to sign are likely public at
X-DKIM-Note: https://as397444.net/dkim/mattcorallo.com and
X-DKIM-Note: https://as397444.net/dkim/clients.mail.as397444.net
X-DKIM-Note: For more info, see https://as397444.net/dkim/
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
	(envelope-from <yalbrymrb@mattcorallo.com>)
	id 1vwh7y-0000000BJeH-40u5;
	Sun, 01 Mar 2026 13:46:35 +0000
Message-ID: <a149cb52-925a-4365-8529-081e7e0a7b81@mattcorallo.com>
Date: Sun, 1 Mar 2026 08:46:33 -0500
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: PMBus memory overflow
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-hwmon@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>,
 security@kernel.org
References: <d5abeb59-8286-425c-9f78-cd60b0e26ada@mattcorallo.com>
 <00baca6f-8046-46ae-a68c-525472562be7@roeck-us.net>
 <aAtEydwUfVcE0XeA@shikoro>
 <3a9ab7bf-6761-4a14-983e-e6bb288ce58a@mattcorallo.com>
 <e0e789b3-24c2-4ea3-9c79-fa815d801d83@roeck-us.net>
 <bc9a14b5-8b10-436f-a791-28df245465e6@mattcorallo.com>
 <4e198aa1-527b-4ad8-abc5-e7408296bfbd@roeck-us.net>
 <03da7997-74f4-4435-a6c5-6aa5aea2f6d7@mattcorallo.com>
 <2025060749-attendant-trout-d2c8@gregkh>
 <695ebdae-7292-4a83-8aff-763da184921e@mattcorallo.com>
 <2025060848-reset-recovery-f67a@gregkh>
 <d16cb075-f924-4bd4-adec-8eaba589a3f2@mattcorallo.com>
Content-Language: en-US
From: Matt Corallo <yalbrymrb@mattcorallo.com>
In-Reply-To: <d16cb075-f924-4bd4-adec-8eaba589a3f2@mattcorallo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/9/25 9:57 AM, Matt Corallo wrote:
> 
> 
> On 6/8/25 3:14 AM, Greg KH wrote:
>> On Sat, Jun 07, 2025 at 09:25:44AM -0400, Matt Corallo wrote:
>>>
>>>
>>> On 6/7/25 4:19 AM, Greg KH wrote:
>>>> On Fri, Jun 06, 2025 at 04:57:37PM -0400, Matt Corallo wrote:
>>>>> Adding security@kernel.org cause probably they should make sure this gets fixed.
>>>>
>>>> That's not how security@k.o works, sorry.  As this is already public, no
>>>> need for security@k.o to get involved at all, the normal development
>>>> process happens here now.
>>>>
>>>> So, submit a patch and people will be glad to review it!
>>>
>>> Thanks, figured I'd ask. Sadly there is a patch that folks seem to be okay
>>> with to fix a buffer overflow but its just sitting.
>>
>> Have a pointer to that patch on lore for the maintainers involved to
>> review?  Note, we are in the middle of the merge window, so no new
>> changes can be added to our trees until -rc1 is out.
> 
> A proposed patch was posted by Guenter, and tested and confirmed that it fixes the issue by myself, 
> at https://lore.kernel.org/linux-hwmon/284466fd-39e8-419e-8af5-41dbabb788af@roeck-us.net/ . Wolfram 
> suggested this patch was acceptable at https://lore.kernel.org/linux-hwmon/aAtEydwUfVcE0XeA@shikoro/ 
> but that's the last he chimed in on this issue.

Any update on getting this patch applied Wolfram? Looks like the buffer overflow is still present on 
at least 6.18.

Matt
