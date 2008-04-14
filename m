From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Mon, 14 Apr 2008 08:57:33 -0700
Message-ID: <200804140857.33732.david-b@pacbell.net>
References: <1207914198-8561-1-git-send-email-w.sang@pengutronix.de>
	<20080414072227.GU13814@pengutronix.de>
	<20080414143925.31b55b39@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080414143925.31b55b39-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Monday 14 April 2008, Jean Delvare wrote:
> > > To support the X24645, it would be necessary to raise AT24_MAX_CLIENTS
> > > to 32 (what a beast!). Then again, most eeproms will just need one
> > > client, so this would cause quite some overhead in most use-cases.
> > > Maybe it pays off to hande this dynamically?
> > 
> > As eeproms are normally slow things anyway, would it be a big
> > performance impact?
> 
> I agree that going dynamic makes sense. Not that it has anything to do
> with the speed of EEPROMs though - the memory allocation will be done
> at device initialization time, and after that dynamic or not should
> perform just the same.

Right.  X24645 looks a bit more bizarre than any EEPROMs
I had come across; it'll need some changes in chip config
data.  You'd think they'd just use two byte addressing!
I guess doing it that way lets them use SMBus-only hosts.


Wolfram's at24_ee_address() cleanup looked fine.

The header looks OK, but I'd add a comment *encouraging*
folk to double check those params for their chips, in
particular to check the page size.  It's OK if their chip
has a bigger page size than those "defaults" although they
could get faster write performance by listing the right
value ... but it's NOT OK if their chip has a smaller write
size than what's listed there, they'll lose data.


I'll be glad to see this go upstream.  :)

- Dave

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
