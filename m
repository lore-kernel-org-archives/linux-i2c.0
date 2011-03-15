From: Timur Tabi <timur.tabi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] I2C: Add support for 64bit system.
Date: Tue, 15 Mar 2011 10:56:07 -0500
Message-ID: <AANLkTim0_ttjDPJvx71B-=Ze5dRTrKXfpavx7gxvYr5p@mail.gmail.com>
References: <1292830654-7056-1-git-send-email-B33228@freescale.com>
 <20101220145954.GA1126@trinity.fluff.org> <D9BF0938-44B1-4BB8-BF3C-0A9CB44B9CC5@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <D9BF0938-44B1-4BB8-BF3C-0A9CB44B9CC5-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Xulei <B33228-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Mar 15, 2011 at 10:44 AM, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org> wrote:
>
> On Dec 20, 2010, at 8:59 AM, Ben Dooks wrote:
>
>> On Mon, Dec 20, 2010 at 03:37:34PM +0800, Xulei wrote:
>>> Currently I2C_MPC supports 32bit system only, then this
>>> modification makes it support 32bit and 64bit system both.
>>>
>>> Signed-off-by: Xulei <B33228-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>>
>> This been build or run tested?
>
> Yes, Any issues with me applying this via the powerpc.git tree?

I'm concerned about the fact that we have to have two defines to
declare code that is 32-bit and 64-bit clean.  Technically speaking,
all drivers should work in both environments.  It seems silly to have
"PPC32 || PPC64" for everything.  Isn't there a generic "PPC" config
option that covers this?

-- 
Timur Tabi
Linux kernel developer at Freescale
