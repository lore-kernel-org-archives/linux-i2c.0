From: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [Patch v2] driver/i2c/mux: Add register based mux i2c-mux-reg
Date: Thu, 18 Jun 2015 08:08:51 -0700
Message-ID: <5582DF03.7010109@freescale.com>
References: <1434575634-27977-1-git-send-email-yorksun@freescale.com> <5582BB1F.5050606@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5582BB1F.5050606-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On 06/18/2015 05:35 AM, Alexander Sverdlin wrote:
> Hello!
> 
> On 17/06/15 23:13, ext York Sun wrote:
>> +	switch (mux->data.reg_size) {
>> +	case 4:
>> +		iowrite32(mux->data.values[chan], mux->data.reg);
>> +		break;
>> +	case 2:
>> +		iowrite16(mux->data.values[chan], mux->data.reg);
>> +		break;
>> +	case 1:
>> +		iowrite8(mux->data.values[chan], mux->data.reg);
>> +		break;
> 
> I'd like to see at least [optional] read-back operation after each write.

Maybe I should add ioread after each write without using an option. I want to
avoid additional option if possible.

> And if you stick with iowrite*(), maybe it desires a comment (in the Documentation/ file?),
> that write will be little-Endian, therefore BE users must take care...

I am consulting with my colleagues. If I cannot come up with a native endianess
solution, I will keep using iowrite and add a comment.

> 
> Other than that it looks good to me...
> 

Thanks.

York
