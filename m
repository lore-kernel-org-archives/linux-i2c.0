From: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Subject: Re: i2c: Multiplexed I2C bus core support
Date: Mon, 18 Feb 2013 11:38:52 +0100
Message-ID: <512204BC.7060603@keymile.com>
References: <4C36E6E2.1070307@gmx.de> <511BB2F8.9020300@keymile.com> <51220036.4030508@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51220036.4030508-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

first of all thanks for your answer :-)

On 02/18/2013 11:19 AM, Michael Lawnick wrote:

> On my project I do no automatic i2c detection, but all is controlled via
> user space. So I always know where and which devices and buses get
> connected.

You mean you add devices through sysfs? That's another approach I was 
thinking I'd follow, except it still doesn't solve my problem... meaning 
I have no reliable way of telling the numbers assigned to the busses added.

>> devices/platform/i2c-gpio/i2c-0/0-0070/chan-4(=>...i2c-5)/5-0071/chan-0(=>...i2c-9)
>> devices/platform/i2c-gpio/i2c-0/0-0070/chan-4(=>...i2c-5)/5-0071/chan-1(=>...i2c-10)
>> devices/platform/i2c-gpio/i2c-0/0-0070/chan-4(=>...i2c-5)/5-0071/chan-2(=>...i2c-11)
>> devices/platform/i2c-gpio/i2c-0/0-0070/chan-4(=>...i2c-5)/5-0071/chan-3(=>...i2c-12)
>
> Introducing links to sub-buses, named with respective channel id sounds
> good for me. Beside that your link example does not reflect your ASCII
> graphics of course ;-)

*COUGH...COUGH* Oh, that was on purpose... *COUGH...COUGH* so to see 
whether anyone was paying attention. Good catch! :-)

Thanks!
Gerlando
