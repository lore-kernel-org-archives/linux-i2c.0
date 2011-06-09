From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] staging iio: Replace kmalloc with local variable
Date: Thu, 9 Jun 2011 10:29:48 +0200
Message-ID: <20110609102948.7a3f8d57@endymion.delvare>
References: <1307450354.1516.23.camel@anish-desktop>
	<4DEE20E7.4020008@cam.ac.uk>
	<20110607134135.GD15795@trinity.fluff.org>
	<20110607160206.6cb3168d@endymion.delvare>
	<BANLkTim5-ZKXtDkSQyHAJ9-iKtOPsJ917A@mail.gmail.com>
	<BANLkTi=e0A2G-d+t4VF5V0gj+eNoh3KRnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTi=e0A2G-d+t4VF5V0gj+eNoh3KRnQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: anish singh <anish198519851985-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, gregkh-l3A5Bk7waGM@public.gmane.org, manuel.stahl-GeUHRtUQU7nSyEMIgutvibNAH6kLmebB@public.gmane.org, lucas.demarchi-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 9 Jun 2011 13:53:09 +0530, anish singh wrote:
> On Wed, Jun 8, 2011 at 10:41 AM, anish singh <anish198519851985-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>wrote:
> >  On Tue, Jun 7, 2011 at 7:32 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> >> To be clearer, it is down to the i2c BUS (adapter) driver, NOT the i2c
> >> device driver. So the patch is correct.
> >>
> > I think i can take Jean ack on this?If yes then Joanthan kindly apply
> > this patch and i think you didn't lead me in wrong way as whatever
> > said by you is corroborated by jean also i.e. it is I2C bus driver
> > responsiblity
> > to care about DMA.
> >
> Sorry to ping you again.Can i take your ack on this?

Yes of course.

Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

-- 
Jean Delvare
