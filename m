From: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [Patch v3] driver/i2c/mux: Add register-based mux i2c-mux-reg
Date: Tue, 11 Aug 2015 09:36:02 -0700
Message-ID: <55CA2472.9080000@freescale.com>
References: <1434657458-16553-1-git-send-email-yorksun@freescale.com> <20150811153916.GD1525@katana> <55CA1ADF.200@freescale.com> <20150811161610.GA1523@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150811161610.GA1523@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On 08/11/2015 09:16 AM, Wolfram Sang wrote:
>>>> +	if (of_find_property(np, "little-endian", NULL)) {
>>>
>>> You should check for a "big-endian" property as well, no?
>>
>> I use the little-endian as an option to indicate the nature of litten-endian
>> register. It is default to big-endian if this property doesn't exist. I prefer
>> this way unless you strongly suggest to add both and throw out an error if
>> neither exists.
> 
> I'd think that "little-endian" or "big-endian" force a setting. If none
> is present, we shall take the CPU endianess. Or am I overlooking
> something?

You are right. The current code checks for littel-endian property. If missing,
the CPU endianess is used. Do you prefer to check littlen-endian first, if
missing then big-endian, if both missing then use CPU endianess?

> 
> Oh, and I forgot the biggest issue: I get build errors, because
> __LITTLE_ENDIAN__ should be __LITTLE_ENDIAN. Is this a recent change or
> why did it work for you?
> 

I tested it on 4.0.4 kernel. I see a lot of reference of __LITTLE_ENDIAN__. I
will test the new patch on the latest kernel.

York
