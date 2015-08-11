From: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [Patch v3] driver/i2c/mux: Add register-based mux i2c-mux-reg
Date: Tue, 11 Aug 2015 14:04:37 -0700
Message-ID: <55CA6365.1090009@freescale.com>
References: <1434657458-16553-1-git-send-email-yorksun@freescale.com> <20150811153916.GD1525@katana> <55CA1ADF.200@freescale.com> <20150811161610.GA1523@katana> <55CA2472.9080000@freescale.com> <20150811200254.GC1523@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150811200254.GC1523@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On 08/11/2015 01:02 PM, Wolfram Sang wrote:
>>> I'd think that "little-endian" or "big-endian" force a setting. If none
>>> is present, we shall take the CPU endianess. Or am I overlooking
>>> something?
>>
>> You are right. The current code checks for littel-endian property. If missing,
>> the CPU endianess is used. Do you prefer to check littlen-endian first, if
>> missing then big-endian, if both missing then use CPU endianess?
> 
> Yes. Do it like this.
> 

OK. Will do.
Do I have to add myself to MAINTAINER file for this driver?

York
