From: Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-tiny-usb: Add parameter for optional i2c-devices.
Date: Wed, 14 Nov 2012 00:41:58 +0100
Message-ID: <50A2DAC6.6000105@ahsoftware.de>
References: <50A2AC28.7050304@ahsoftware.de> <1352839940-7559-1-git-send-email-holler@ahsoftware.de> <20121113224251.20b52f34@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121113224251.20b52f34-38n7/U1jhRXW96NNrWNlrekiAK3p4hvP@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Till Harbaum <till-RcHadlBFbzVAfugRpC6u6w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Am 13.11.2012 23:42, schrieb Alan Cox:
> On Tue, 13 Nov 2012 21:52:20 +0100
> Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org> wrote:
>
>> Make it possible to define i2c-devices at the kernel command line
>> or as a module parameter.
>>
>> Format is devname1@addr1,devname2@addr2,...
>
> Why not do this with your initrd, you can deal with your rtc
> before mounting the real root fs.

I almost never use an initrd. Most of the time it isn't necessary and is 
just a waste of time to build, maintain and use it.

Thanks to git, I even find it it easier to maintain my own set of 
patches for the kernel (which I do since several years) and I find it 
easier to explain such others too, than to explain someone about how to 
build, maintain and use an initrd.

Regards,

Alexander
