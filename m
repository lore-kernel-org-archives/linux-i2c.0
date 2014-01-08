From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 2/3] ARM: mvebu: Add quirk for i2c
Date: Wed, 08 Jan 2014 15:10:29 +0100
Message-ID: <52CD5C55.9090007@free-electrons.com>
References: <1389112504-9931-1-git-send-email-gregory.clement@free-electrons.com> <52CD4CBE.6010902@free-electrons.com> <20140108133958.GA15182@katana> <3195222.U7OZJLz9Y4@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3195222.U7OZJLz9Y4@wuerfel>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 08/01/2014 14:45, Arnd Bergmann wrote:
> On Wednesday 08 January 2014 14:39:59 Wolfram Sang wrote:
>>>>>>> However, when I first read this I thought it should be a -a0 specific
>>>>>>> compatible string, not a 'offload-broken' property - any idea what the
>>>>>>> DT consensus is here? I've seen both approach in use ..
>>>>>>
>>>>>> I prefer the replacement of the compatible string. If it should really
>>>>>> be a seperate property, then it should be a vendor specific property. It
>>>>>> is not generic, at all.
>>>>>
>>>>> Something like "marvell,offload-broken" would be acceptable?
>>>>
>>>> A tad more, yes. Still, since this is a feature/quirk of the IP core
>>>> revision, it should be deduced from the compatible property IMO. It
>>>> cannot be configured anywhere, so it doesn't change on board level.
>>>
>>> So you would prefer using the "marvell,mv78230-a0-i2c" comaptible string and
>>> updating it with the follwing piece of code?
>>
>> This is the approach I favour, yes. Can't say much about the
>> implementation. Looks OK, but dunno if this is minimal...
>>
> 
> I would prefer the separate property in this case, but only because it's
> easier to add in the quirk than to change the compatible string, but it's
> not a strong preference and I don't mind getting overruled if you all
> favor the alternative.

Great, all the different part seems to be validated, I can now send the last
version.


Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
