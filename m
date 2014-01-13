From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] dt: Update I2C trivial devices list
Date: Mon, 13 Jan 2014 09:57:56 -0700
Message-ID: <52D41B14.6060701@wwwdotorg.org>
References: <1387239151-19226-1-git-send-email-bgamari.foss@gmail.com> <52B07870.6070809@wwwdotorg.org> <87a9fztofc.fsf@gmail.com> <20140113125128.GE2586@katana> <87r48cklgj.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87r48cklgj.fsf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 01/13/2014 07:25 AM, Ben Gamari wrote:
> Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> writes:
> 
>> On Tue, Dec 17, 2013 at 11:47:19AM -0500, Ben Gamari wrote:
>>> Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> writes:
>>>
>>>> On 12/16/2013 05:12 PM, Ben Gamari wrote:
>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>>>>
>>>>>  This is a list of trivial i2c devices that have simple device tree
>>>>>  bindings, consisting only of a compatible field, an address and
>>>>> -possibly an interrupt line.
>>>>> +possibly an interrupt line. The compatible field is used to lookup the
>>>>> +modalias of the driver which will handle the device. The compatible
>>>>> +string may begin with a manufacturer prefix (separated from the
>>>>> +modalias by a comma) which will be stripped off during lookup.
>>>>
>>>> This part of the patch described Linux-specific behaviour, whereas DT
>>>> bindings should be OS-agnostic.
>>>>
>>> I see your point but it would be nice to have language like this
>>> somewhere. One of the biggest challenges in diving in to writing a
>>> devicetree is figuring out details like this.
>>
>> What about putting this into a seperate paragraph prefixed with "Current
>> Linux specific implementation:"?
>>
> This would address my concern quite nicely.

The text should go into Documentation/ not the DT binding.
