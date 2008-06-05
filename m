From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Thu, 5 Jun 2008 10:38:23 +0200
Message-ID: <20080605103823.7c284726@hyperion.delvare>
References: <20080604201334.19636f30@hyperion.delvare>
	<20080604233335.13459512@hyperion.delvare>
	<9e4733910806041611l41832e07p4f55424be0ef5ea0@mail.gmail.com>
	<200806041710.59338.david-b@pacbell.net>
	<9e4733910806041742va67401en608c8c4b8c4c11b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910806041742va67401en608c8c4b8c4c11b9-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jon,

On Wed, 4 Jun 2008 20:42:00 -0400, Jon Smirl wrote:
> On 6/4/08, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> > Wrong.  The probe returns zero if it bound, else negative errno.
> >  Those functions don't return booleans.
> 
> You guys are so literal. I should have said return 0 or -ENODEV or
> some other error.

Oh, David is several persons now? ;)

> (...)
> There is is a parallel here. With PowerPC device trees I can put the
> exact address of the i2c device into the board specific device tree.
> Now there's no need to probe addresses. That's equivalent to what's
> happening with ACPI and serial ports. Maybe we'll implement device
> trees on all archs and then we can get rid of i2c device probing.

It's the manufacturer who decide, not us. And at the moment, the PC
architecture isn't using device trees for I2C/SMBus. That's an
unfortunate fact we have to live with.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
