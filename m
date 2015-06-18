From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: davinci: Fix bus rate calculation on Keystone SoC
Date: Thu, 18 Jun 2015 15:17:53 +0530
Message-ID: <558293C9.9050904@ti.com>
References: <5582870B.7030304@nokia.com> <558288B0.1020706@ti.com> <55828ADB.3080604@nokia.com> <55828E7F.8060501@ti.com> <55829159.8050707@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55829159.8050707-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thursday 18 June 2015 03:07 PM, Alexander Sverdlin wrote:
> Hello!
> 
> On 18/06/15 11:25, ext Sekhar Nori wrote:
>>>>> +	if (davinci_i2c_read_reg(dev, DAVINCI_I2C_ICPID2_REG) == 0x2206) {
>>>>>>>>>> +		dev_dbg(dev->dev, "Keystone SoC detected\n");
>>>>>>>>>> +		d = 6;
>>>>>>>>>> +	}
>>>>>> I think its better to use a different compatible string for i2c on
>>>>>> keystone devices rather than using a fixed hardcoded IP version.
>>>>
>>>> Yeah, this should have been done from the beginning, when the driver has been
>>>> re-used for Keystone, but this time is already missed, so I don't want
>>>> to introduce huge incompatibility with the existing device-trees.
>> How is backward compatibility broken? compatible property is a list, so
>> you would do something like:
>>
>> 	compatible = "ti,keystone-i2c", "ti,davinci-i2c";
>>
>> Newer kernels would keep working with older device tree blobs. Older
>> kernels wont have the fix, but thats true even now.
> 
> Ah, beyond the evalboards, there are device-trees not linked into the kernel,
> but flashed into the boards, as originally in OF. They are part of the HW, its
> description. Not part or description of the Kernel. And you have no way to
> introduce this fix any more without updating this OF part if you go with
> new compatible property.

I see. So how critical is this fix? That should be described in the
commit description. And if its really critical, stable kernel should be
CCed too.

> 
>>>> And from the other PoV, device-trees are for something one cannot probe. We
>>>> can probe for Keystone revisions and can free the end-user from this headache
>>>> completely.
>> Keep in mind that this can invite driver patching whenever version
>> number is tinkered with in hardware - even for otherwise
>> software-invsible changes.
> 
> That's true. But I do not have an overview, how many IP versions do you actually have?
> I've found one revision in Davinci manual, one revision in Keystone manual, even
> including minor revision. Checking only major revision now can survive couple of minor
> changes in IP.

Yeah, sticking to major version should help. What I am worried about are
versions coming in future, not those existing. And development on
keystone architecture is ongoing in TI.

Thanks,
Sekhar
