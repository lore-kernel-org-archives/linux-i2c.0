From: Jonathan Cameron <kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>
Subject: Re: [PATCH 1/2] tsl2550: Move from i2c/chips to misc
Date: Tue, 09 Mar 2010 12:16:40 +0000
Message-ID: <4B963C28.10800@jic23.retrosnub.co.uk>
References: <20100309113552.09368dd8@hyperion.delvare>	<20100309105614.GA4664@pengutronix.de> <20100309125628.5300ee62@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100309125628.5300ee62-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 03/09/10 11:56, Jean Delvare wrote:
> On Tue, 9 Mar 2010 11:56:14 +0100, Wolfram Sang wrote:
>> On Tue, Mar 09, 2010 at 11:35:52AM +0100, Jean Delvare wrote:
>>
>>> Move the last remaining driver from i2c/chips to misc. Good ridance!
>>>
>>> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>>> Cc: Jonathan Cameron <kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>
>>
>> Okay, so we move it twice then. Fine with me :)
> 
> I wanted to avoid it, but ALS (or whatever it will become) takes too
> long to settle, longer than I was wanting to wait for.
Indeed...

>> Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Acked-by: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
