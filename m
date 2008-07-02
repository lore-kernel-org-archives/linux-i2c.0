From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Grouping i2c bus drivers
Date: Wed, 2 Jul 2008 16:42:07 +0200
Message-ID: <20080702164207.76304a01@hyperion.delvare>
References: <20080627145236.2a20aaad@hyperion.delvare>
	<4868ADCD.3080305@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <4868ADCD.3080305-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Mike,

On Mon, 30 Jun 2008 12:56:29 +0300, Mike Rapoport wrote:
> Jean Delvare wrote:
> > Hi all,
> > 
> > As was mentioned previously, I have decided to group the i2c bus
> > drivers to make it easier for the users to know what they need (and also
> > for me to know what drivers might be affected by a given problem.) Here
> > is the list I have at the moment. There are still many drivers in the
> > "Other" category. I suspect that many of these should move to the
> > "Embedded" category, but I don't know for sure. So I would welcome
> > comments and suggestions for improvements.
> > 
> 
> [ snip ]
> 
> > obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
> > obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
> 
> SCx200 are Geode GX/LX devices, so I think it also can be moved to embedded.

As far as I know, the Geode uses I2C as a peripheral bus, much like PCs
do, not a system bus as most embedded systems do. So, in the light of
other discussions in this thread, it's probably better to not put these
drivers in the "embedded" category (which might in turn be renamed to
"System I2C host controller drivers (mostly embedded)" or similar.)

But honestly I'm not too sure what to do. Grouping by functionality
makes sense for the user, but grouping by bus usage makes more sense if
we end up splitting the bus drivers depending on the time at which they
need to come up.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
