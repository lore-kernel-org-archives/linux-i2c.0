From: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Subject: Re: [PATCH v3 2/2] i2c: xiic: Use 32bit accesses only
Date: Wed, 23 Feb 2011 10:37:31 +0100
Message-ID: <4D64D55B.50405@monstr.eu>
References: <1298396971-611-1-git-send-email-monstr@monstr.eu> <AANLkTinRVKMdOU-8DYLHe5q92nb3ysKnnG-jq8f++AEs@mail.gmail.com> <4D64C08F.5030604@monstr.eu> <201102230936.09921.arnd@arndb.de>
Reply-To: monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201102230936.09921.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, john.williams-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Arnd Bergmann wrote:
> On Wednesday 23 February 2011 09:08:47 Michal Simek wrote:
>> Grant Likely wrote:
>>> On Tue, Feb 22, 2011 at 10:49 AM, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org> wrote:
>>>> i2c driver is used for LE/BE that's why is useful to use
>>>> 32bit accesses. Then it is not necessary to solve any
>>>> endian issues.
>>> Are you sure?  I would expect the BE version needs to use
>>> io{read,write}32be variants of the accessors.  What platforms have you
>>> tested on?
>> iowrite32 is the same with iowrite32be for Microblaze.
>> I have no problem to change it to iowrite32be if you like.
>>
>> I have tested it on microblaze big and little endian platforms.
> 
> I think what Grant was saying is that iowrite32 being the same as
> iowrite32be is a bug, because iowrite32 is documented to be little-endian.

Can you pointed me to that documentation?

> 
> This is probably fine as long as you don't have any PCI devices,
> but if you ever get PCI support, it won't work.

Microblaze have PCI support but I don't have the board for testing.

> 
> Also, it heavily confuses other developers such as Grant and me
> if one architecture defines things to mean something completely
> different from the other architectures.

As I see will be good to review microblaze io.h and use generic one.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
