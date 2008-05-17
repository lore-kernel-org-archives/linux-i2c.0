From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: [patch 2.6.26-rc1] i2c_use_client() defends against NULL
Date: Sat, 17 May 2008 10:53:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0805171048070.4196@shell4.speakeasy.net>
References: <200805041306.21074.david-b@pacbell.net>
	<20080517144007.7611ab32@hyperion.delvare>
	<200805170657.56833.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200805170657.56833.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 17 May 2008, David Brownell wrote:
> On Saturday 17 May 2008, Jean Delvare wrote:
> > On Sun, 4 May 2008 13:06:20 -0700, David Brownell wrote:
> > > Defend the i2c refcount calls against NULL pointers, as is important
> > > (and conventional) for such calls ... we don't want to morph NULL
> > > pointers into bogus non-null ones.
> >
> > Passing NULL to the current functions would just crash, it wouldn't
> > morph anything.
>
> That's only if you assume an MMU set up to cause oopsing on reference
> to the first and last pages of memory.  Not the best of assumptions...

Maybe BUG_ON(!client) would be better?  It seems more likely to catch
a programming error.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
