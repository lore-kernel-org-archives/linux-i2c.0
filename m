From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Subject: RE: [PATCH 8/8] i2c: i2c-bfin-twi: Move blackfin TWI register
 access Macro to head file.
Date: Fri, 25 May 2012 06:12:06 -0400
Message-ID: <DB904C5425BA6F4E8424B3B51A1414D170230E5AF6@NWD2CMBX1.ad.analog.com>
References: <1337152826-9850-1-git-send-email-sonic.zhang@analog.com>
	<1337152826-9850-8-git-send-email-sonic.zhang@analog.com>
	<CAM=Q2csSuQ3R9U=XKwj9F0xijTxx_ULperAiQYD_X3a5GKVjFg@mail.gmail.com>
	<DB904C5425BA6F4E8424B3B51A1414D170230E5ADF@NWD2CMBX1.ad.analog.com>
 <CAM=Q2cveBrYUiNYEbUgXyTnK2JhVD8UyhGgYJ=Zr86YnMMJ6Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAM=Q2cveBrYUiNYEbUgXyTnK2JhVD8UyhGgYJ=Zr86YnMMJ6Dg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>
List-Id: linux-i2c@vger.kernel.org



>-----Original Message-----
>From: Shubhrajyoti Datta [mailto:omaplinuxkernel@gmail.com]
>Sent: Friday, May 25, 2012 6:10 PM
>To: Zhang, Sonic
>Cc: Ben Dooks; Wolfram Sang; linux-i2c@vger.kernel.org; LKML; uclinux-dist-
>devel@blackfin.uclinux.org
>Subject: Re: [PATCH 8/8] i2c: i2c-bfin-twi: Move blackfin TWI register access
>Macro to head file.
>
>Hi ,
>On Fri, May 25, 2012 at 3:24 PM, Zhang, Sonic <Sonic.Zhang@analog.com>
>wrote:
>>
>>
>>>-----Original Message-----
>>>From: Shubhrajyoti Datta [mailto:omaplinuxkernel@gmail.com]
>>>Sent: Friday, May 25, 2012 5:48 PM
>>>To: Zhang, Sonic
>>>Cc: Ben Dooks; Wolfram Sang; linux-i2c@vger.kernel.org; LKML; uclinux-dist-
>>>devel@blackfin.uclinux.org
>>>Subject: Re: [PATCH 8/8] i2c: i2c-bfin-twi: Move blackfin TWI register access
>>>Macro to head file.
>>>
>>>Hi ,
>>>Some minor comments/ doubts.
>>>On Wed, May 16, 2012 at 12:50 PM,  <sonic.zhang@analog.com> wrote:
>>>> From: Sonic Zhang <sonic.zhang@analog.com>
>>>>
>>>
>>>A small description may be helpful.
>>>Also the $SUBJECT says move the patch looks more like the remove.
>>>Am I missing something.
>>
>> The subject says these definitions are moved to a head file by the other patch
>for Blackfin architecture.
>
>Got it thanks.
>
>You may want to add a dependency otherwise it might lead to a compilation break?
>

That patch for Blackfin architecture has already been merged into mainline.

Regards,

Sonic

>
>>
>> Regards,
>>
>> Sonic
