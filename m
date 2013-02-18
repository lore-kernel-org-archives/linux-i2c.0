From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: i2c: Multiplexed I2C bus core support
Date: Mon, 18 Feb 2013 15:01:10 +0100
Message-ID: <51223426.8040201@gmx.de>
References: <4C36E6E2.1070307@gmx.de> <511BB2F8.9020300@keymile.com> <51220036.4030508@gmx.de> <512204BC.7060603@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <512204BC.7060603-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Cc: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Am 18.02.2013 11:38, schrieb Gerlando Falauto:
> Hi Michael,
> 
> first of all thanks for your answer :-)
> 
> On 02/18/2013 11:19 AM, Michael Lawnick wrote:
> 
>> On my project I do no automatic i2c detection, but all is controlled via
>> user space. So I always know where and which devices and buses get
>> connected.
> 
> You mean you add devices through sysfs? That's another approach I was 
> thinking I'd follow, except it still doesn't solve my problem... meaning 
> I have no reliable way of telling the numbers assigned to the busses added.

Under the assumption that bus numbers increase (which might not be true
in some special cases that do not hit me), you simply compare existing
buses before and after add.
This will be no more necessary if your patch works as intended. Due to
other work load I will not be able to test in the next weeks :-(
-- 
KR
Michael
