From: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/03] i2c-i801: Add basic interrupt support
Date: Wed, 13 Aug 2008 21:59:48 +0200
Message-ID: <48A33D34.1000704@gmail.com>
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
Cc: Hans de Goede <j.w.r.degoede-fbo2DhPpy/Q@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Ivo Manca wrote: 
> I'm not an expert, but I think this is the right way to use it.
> The interupt handler i801_isr catches the interrupt, saves the status 
> to algo_data and calls wake_up_interruptable. This will wake up the wait.
>
> I'm not sure whether this is the correct way or not. Any input from an 
> interrupt expert is very much welcome.
> I did test it without the event_interruptable, which produces 
> nonsense, like:
>
> bla bla
>
Ugh, sorry, please discard this comment since it's utter nonsense ;). 
Reading wait.h cleared things up for me. I shouldn't indeed use the 
interruptible function.
The errors were due to a coding mistake from my side.

Ivo

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
