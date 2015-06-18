From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: davinci: Fix bus rate calculation on Keystone SoC
Date: Thu, 18 Jun 2015 13:30:58 +0200
Message-ID: <5582ABF2.4090308@nokia.com>
References: <5582870B.7030304@nokia.com> <558288B0.1020706@ti.com>
 <55828ADB.3080604@nokia.com> <55828E7F.8060501@ti.com>
 <55829159.8050707@nokia.com> <558293C9.9050904@ti.com>
 <558297B3.2060406@nokia.com> <5582A7AF.5030000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5582A7AF.5030000-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello!

On 18/06/15 13:12, ext Sekhar Nori wrote:
>>>> Ah, beyond the evalboards, there are device-trees not linked into the kernel,
>>>>> >>>> but flashed into the boards, as originally in OF. They are part of the HW, its
>>>>> >>>> description. Not part or description of the Kernel. And you have no way to
>>>>> >>>> introduce this fix any more without updating this OF part if you go with
>>>>> >>>> new compatible property.
>>> >> I see. So how critical is this fix? That should be described in the
>>> >> commit description. And if its really critical, stable kernel should be
>>> >> CCed too.
>> > 
>> > Now we got to the point, see below...
>> > 
>>>>>>>>>>> >>>>>>>>>> And from the other PoV, device-trees are for something one cannot probe. We
>>>>>>>>>>> >>>>>>>>>> can probe for Keystone revisions and can free the end-user from this headache
>>>>>>>>>>> >>>>>>>>>> completely.
>>>>>>> >>>>>> Keep in mind that this can invite driver patching whenever version
>>>>>>> >>>>>> number is tinkered with in hardware - even for otherwise
>>>>>>> >>>>>> software-invsible changes.
>>>>> >>>>
>>>>> >>>> That's true. But I do not have an overview, how many IP versions do you actually have?
>>>>> >>>> I've found one revision in Davinci manual, one revision in Keystone manual, even
>>>>> >>>> including minor revision. Checking only major revision now can survive couple of minor
>>>>> >>>> changes in IP.
>>> >> Yeah, sticking to major version should help. What I am worried about are
>>> >> versions coming in future, not those existing. And development on
>>> >> keystone architecture is ongoing in TI.
>> > 
>> > This is not really critical fix. Currently bus rate is lower than expected because of these
>> > calculation errors. The fix maximizes the bus rate. So newer SoCs will run little bit slower
>> > until support is added to this part of the code. Not really critical. So no point in CCing
>> > stable maintainers also.
> If its not a critical fix, do we really need to care about older DTBs
> which have been ROM'ed into production?

I tend not to change the DT binding, but if majority will decide it's the way to go,
I'll prepare another patch. Let's wait for other opinions...

-- 
Best regards,
Alexander Sverdlin.
