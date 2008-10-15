From: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Subject: Re: [PATCH 4/6]: i2c-pcf: Add a way for bus driver to ask for
 no smbus quick mode support.
Date: Wed, 15 Oct 2008 14:34:52 -0700 (PDT)
Message-ID: <20081015.143452.114860633.davem@davemloft.net>
References: <20080821.024327.144744678.davem@davemloft.net>
	<20081015143321.7df02b35@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081015143321.7df02b35-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Date: Wed, 15 Oct 2008 14:33:21 +0200

> For another, with the introduction of I2C classes several years ago,
> I2C device drivers should no longer probe random I2C adapters.  

Jean, they do, that's why I wrote this change.

> They should only probe adapters which share a class bit with them,

The pcf driver sets the class bit used by FAN and temperature sensors,
so the I2C layer goes poking around all of the standard address
locations each of those drivers list.

I don't want that to happen, ever.  I know exactly what address each
and every I2C device sits at, so I don't want auto probing at all even
even if the class bits match.

Again where the heck were you two months ago when I submitted these
changes originally?  I could have been working on changes meanwhile,
but instead you're reviewing this stuff _NOW_ in the middle of the
merge window when I have to be on top of things for networking and
sparc stuff going into the tree.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
