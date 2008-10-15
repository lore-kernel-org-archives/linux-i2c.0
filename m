From: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Subject: Re: [PATCH 2/6]: i2c-pcf: Add adapter hooks around xfer begin
 and end.
Date: Wed, 15 Oct 2008 14:32:12 -0700 (PDT)
Message-ID: <20081015.143212.196108134.davem@davemloft.net>
References: <20080821.024322.35962617.davem@davemloft.net>
	<20081015141914.7d6c3dd5@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081015141914.7d6c3dd5-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: mkrufky-dJidKbW2IEtAfugRpC6u6w@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Date: Wed, 15 Oct 2008 14:19:14 +0200

> Of course we can start with a local implementation in i2c-algo-pcf and
> we move it to i2c-core later if needed.

Please let's be practical and handle things this way.

> That's not exactly elegant. I'd rather make .xfer_begin and .xfer_end
> optional and check for NULL before calling them from pcf_xfer(). That's
> less intrusive also, you don't even need to touch the individual bus
> drivers using the i2c-algo-pcf module if they don't need these hooks.

I think it's more elegant to remove as many conditionals from
generic code as possible.

Where were you 2 months ago when I submitted these patches?

I've forgotten most of the state of these changes since then
and now I have to reload all of my context in.

And because you're doing this feedback _NOW_ it's a very real
chance that we'll miss 2.6.28 with these changes.  And I can't
work on any further sparc I2C stuff I had in mind until this
stuff is settled :-(

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
