From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: axxia: Add bus recovery functionality
Date: Wed, 13 May 2015 10:26:45 +0200
Message-ID: <55530AC5.1060806@nokia.com>
References: <553F7B11.5000204@nokia.com> <20150512191211.GC4449@schokonusskuchen.bad>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150512191211.GC4449-oo5tB6JMkjKRinMKxDlMNPwbnWRJjS81@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>, Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wilshire Jay <jay.wilshire.ext-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Lawnick Michael <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi!

On 12/05/15 21:12, ext Wolfram Sang wrote:
>> Use recovery framework and implement bus recovery using "Bus Monitor"
>> > register. Tests show that shortening SCL to GND results in "completion"
>> > timeout with "BUSY" bit still set. So initiate recovery in case of generic
>> > timeout and "Arbitration Lost" condition.
> So, how could you verify in this setup if the recovery actually worked?

Yes, it's tested with jumpers and oscilloscope on a custom Axxia AXM5508-based board.
9 CLK pulses are there and it's also jumping out of recovery if SDA is not low any more.

>> > +	switch (idev->msg_err) {
>> > +	case -ETIMEDOUT:
>> > +	case -EAGAIN:
>> > +		i2c_recover_bus(&idev->adapter);
>> > +	}
>> > +
> Doesn't look right. -EAGAIN means arbitration lost which is not a
> condition to reset the bus in a multi-master setup.

I'll resend with only -ETIMEDOUT triggering the recovery.

-- 
Best regards,
Alexander Sverdlin.
