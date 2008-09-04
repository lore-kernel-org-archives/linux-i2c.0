From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [RFC: 2.6 patch] remove the i2c-at91.c driver
Date: Thu, 4 Sep 2008 13:25:30 -0700
Message-ID: <200809041325.30330.david-b@pacbell.net>
References: <20080831161005.GC3695@cs181140183.pp.htv.fi>
	<200809041218.49604.david-b@pacbell.net>
	<cd73a99e0809041314i54c7fd71ued53270517ecc829@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <cd73a99e0809041314i54c7fd71ued53270517ecc829-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Andrew Victor <avictor.za-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thursday 04 September 2008, Andrew Victor wrote:
> According to the datasheet, the G20 supports both clock stretching and
> repeated starts.

Same is true for docs about current silicon ... but the clock
stretching doesn't prevent those FIFO problems, and repeated
starts are barely enough to support older versions of SMBus.

Is that a *general* mechanism for repeated starts?

Or is it just the current/limited one where there can be at most
two segments in any combined message, going to the same slave
address ... a write of up to 3 bytes (assuming 7bit addressses)
then a longer read?

Either way:  driver updates needed for that!

(I'd call clock stretching to prevent those FIFO issues just
a bugfix, myself.  It should need no driver updates.)


> The TWI is now also connected to a PDC, so we can set-up a DMA buffer
> for the TWI receives and transmits.

Using DMA also implies driver updates.

Maybe the best answer would be to remove this and have a g20-specific
driver later.

- Dave


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
