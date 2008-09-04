From: "Andrew Victor" <avictor.za-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC: 2.6 patch] remove the i2c-at91.c driver
Date: Thu, 4 Sep 2008 22:14:41 +0200
Message-ID: <cd73a99e0809041314i54c7fd71ued53270517ecc829@mail.gmail.com>
References: <20080831161005.GC3695@cs181140183.pp.htv.fi>
	<20080902101127.GJ2716@fluff.org.uk>
	<cd73a99e0809041155m1f9e576dt5659da679fffb56d@mail.gmail.com>
	<200809041218.49604.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200809041218.49604.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

hi David,

> But I recall the lack of flow control to be a bigger issue.
> The hardware liked to TX the next byte before it was loaded
> into the (single byte) TX fifo, and then complain that there
> was no byte there.  And likewise, to RX the next byte before
> the previous one got removed.  Or ... if that's not what it
> was doing, it sure acted like it was!  Now, *THOSE* issues
> seem highly amenable to hardware-only fixes:  just stretch
> the clock until the FIFO is ready.

According to the datasheet, the G20 supports both clock stretching and
repeated starts.
The TWI is now also connected to a PDC, so we can set-up a DMA buffer
for the TWI receives and transmits.


Regards,
  Andrew Victor

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
