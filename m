From: Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: Add possibility for user-defined (i2c-)devices
 for bus-drivers.
Date: Tue, 13 Nov 2012 21:23:04 +0100
Message-ID: <50A2AC28.7050304@ahsoftware.de>
References: <1352829968-4908-1-git-send-email-holler@ahsoftware.de> <20121113195533.6db71716@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121113195533.6db71716-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Till Harbaum <till-RcHadlBFbzVAfugRpC6u6w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Am 13.11.2012 19:55, schrieb Jean Delvare:
> On Tue, 13 Nov 2012 19:06:07 +0100, Alexander Holler wrote:
>> This makes it possible to define i2c-devices at the kernel command line
>> or as a module parameter for bus-drivers which want to offer such
>> an functionality.
>>
>> Drivers which are using it will have the a parameter named
>> devices with format devname1@addr1,devname2@addr2,...
>> e.g. devices=ds1307@0x68,pcf8563@0x51
>
> No, no, no. We did that 10 years ago, killed all the code 3 years ago
> [1], let's not do the same mistake again, please. We have a sysfs
> interface for instantiating clients dynamically from user-space, it's
> way more powerful and flexible than your proposal. Just try plugging two

So how do I define a device, e.g. an RTC which I want to have alive 
before userland starts? Currently imho not possible.

> different i2c-tiny-usb adapters on the same system and see the new code
> instantiate the wrong devices...

I know about that, but it probes and you don't have to use that 
parameter at all. I think some people can think for their self, 
especially those how would use such a parameter.

> [1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=7f508118b1c1f9856a1c899a2bd4867a962b0225

I think my patch looks nicier.

Alexander
