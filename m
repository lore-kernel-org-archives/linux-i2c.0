From: "Karicheri, Muralidharan" <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: RE: i2c:clk: preparation for switch to common clock framework
Date: Thu, 13 Sep 2012 18:44:33 +0000
Message-ID: <3E54258959B69E4282D79E01AB1F32B7041BCDC1@DFLE12.ent.ti.com>
References: <1346350236-11105-1-git-send-email-m-karicheri2@ti.com>
 <20120913092943.GA5912@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120913092943.GA5912-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "Hilman, Kevin" <khilman-l0cyMroinI0@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>> -----Original Message-----
>> From: Wolfram Sang [mailto:w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org]
>> Sent: Thursday, September 13, 2012 5:30 AM
>> To: Karicheri, Muralidharan
>> Cc: Nori, Sekhar; Hilman, Kevin; khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org; ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; davinci-linux-
>> open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
>> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Subject: Re: i2c:clk: preparation for switch to common clock framework
>> 
>> On Thu, Aug 30, 2012 at 06:10:36PM -0000, m-karicheri2-l0cyMroinI0@public.gmane.org wrote:
>> > As a first step towards migrating davinci platforms to use common
>> > clock framework, replace all instances of clk_enable() with
>> > clk_prepare_enable() and clk_disable() with clk_disable_unprepare().
>> > Until the platform is switched to use the CONFIG_HAVE_CLK_PREPARE
>> > Kconfig variable, this just adds a might_sleep() call and would work without any issues.
>> >
>> > This will make it easy later to switch to common clk based
>> > implementation of clk driver from DaVinci specific driver.
>> >
>> > Signed-off-by: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
>> 
>> Subject had "i2c:clk" where "i2c: davinci" would be more precise.
>> 
>> Fixed that and pushed to -next.
>> 
>> Thanks,
>> 
>>    Wolfram

Wolfram,

Thanks for pushing this to -next. Greatly appreciated.

Murali
>> 
>> --
>> Pengutronix e.K.                           | Wolfram Sang                |
>> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
