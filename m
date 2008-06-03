From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: [patch 3/3] i2c: add support for i2c bus on	Freescale
 CPM1/CPM2 controllers
Date: Tue, 3 Jun 2008 13:49:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0806031338350.10290@shell4.speakeasy.net>
References: <200805142314.m4ENEjPV026316@imap1.linux-foundation.org>
	<20080602192630.GD6226@fluff.org.uk>
	<20080602215343.07ad6e02@hyperion.delvare>
	<200806021403.46232.david-b@pacbell.net>
	<20080602221923.GF6226@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080602221923.GF6226-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 2 Jun 2008, Ben Dooks wrote:
> makes reporting the amount of data written difficult, how do you
> indicate I wrote m bytes, got an error, and then continued on to
> write all n bytes of the i2c_msgs provided? Can anyone think of
> an actual example of where this would be useful?

Useful enough that someone would actually write the code to use it?  No.

> Yes, that does make sense to return the amount of data written to
> the user, however having a quick look through all users of
> i2c_transfer() all just want to know if all the messages where
> sent (which is an easier check that to compute the amount of
> data in all the messages).
>
> Would it better to add an new i2c_transfer-alike call which would
> return the amount of data written, instead of going around modifying
> all users of i2c_transfer() ? This would also make transfering from
> one call to the other, with i2c_transfer becoming deprecated?

My experience with I2C drivers is the same.  No one cares how many bytes
were written before a NAK, they're just going to take same failure path no
matter what (assuming they even check for an error at all).

I think it's enough to document the interface can't provide this
information, and if someone does have a real use for it in the future, let
them add support when the time comes.  There's no point in creating an
interface that no one is going to use.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
