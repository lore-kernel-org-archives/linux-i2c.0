From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 01/03] i2c-i801: Add basic interrupt support
Date: Wed, 13 Aug 2008 22:38:40 +0200
Message-ID: <20080813223840.42ad6fb3@hyperion.delvare>
References: <488762C8.6090105@gmail.com>
	<20080812101545.600ca850@hyperion.delvare>
	<48A33342.1050105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48A33342.1050105-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Hans de Goede <j.w.r.degoede-fbo2DhPpy/Q@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 13 Aug 2008 21:17:22 +0200, Ivo Manca wrote:
> Hey Jean,
> > Ideally this define would replace MAX_TIMEOUT (in a separate patch) so 
> > that both
> > the poll-based and the interrupt-driven paths have the same timeout 
> > value. Right now,
> > the timeout handling of the poll-based path is rather ugly (the actual 
> > timeout depends on
> > the value of HZ.)
>
> Hm, seems like a very sensible thing to do. However, I have no idea how 
> to implement that, since you don't really know how long msleep slept, or 
> not? I sadly don't really have time to look into this right now, sorry.

The trick is to not rely on the duration of the msleep(). As you
rightly said, we have no clue how long it slept. Instead, we remember
the initial value of jiffies, and check after each iteration whether
the timeout has been exceeded or not. Something like:

	unsigned long start = jiffies, now;

	while (!time_after(now, jiffies + timeout)
	 && !<other condition>) {
		msleep(1);
		<do something>
	}

But if you don't have the time, this can be done later, no worry. It
doesn't belong to your patch anyway.

> (...)
> I'll send you an updated patch later this evening. I don't know anything 
> about config files though, so that'll have to wait a bit... The module 
> parameter will be added though.

The Kconfig language is pretty easy. But don't worry about it if you
don't have the time to look into it: I'll add a patch on top of yours
implementing my idea, no problem.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
