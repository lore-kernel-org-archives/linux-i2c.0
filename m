From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 4/6]: i2c-pcf: Add a way for bus driver to ask for
 no smbus quick mode support.
Date: Wed, 15 Oct 2008 14:33:21 +0200
Message-ID: <20081015143321.7df02b35@hyperion.delvare>
References: <20080821.024327.144744678.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080821.024327.144744678.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Thu, 21 Aug 2008 02:43:27 -0700 (PDT), David Miller wrote:
> 
> i2c-pcf: Add a way for bus driver to ask for no smbus quick mode support.
> 
> Some PCF bus implementations have precise knowledge of the i2c
> devices sitting on the bus, using things such as firmware device
> trees, and do not want any of the auto I2C device probing to
> occur.

Nack. For one thing, the SMBus quick command is not an equivalent for
device probing. Probing can be done with virtually any I2C transaction,
and SMBus quick command can be used as a regular transaction (even
though I am not aware of any Linux device driver using this at the
moment.)

For another, with the introduction of I2C classes several years ago,
I2C device drivers should no longer probe random I2C adapters. They
should only probe adapters which share a class bit with them, meaning
that an adapter with no class bits set should never be probed. With the
advent of so-called new-style i2c drivers (which follow the standard
device driver binding model) this is even being enforced. So, if you
find that a given I2C device driver is probing your adapter when it
isn't supposed to, get that driver fixed, or even better, turn it into
a new-style I2C driver, and your problem is solved.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
