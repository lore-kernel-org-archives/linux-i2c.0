From: Uli Luckas <u.luckas-vFjI0mZ6VZs@public.gmane.org>
Subject: Re: Grouping i2c bus drivers
Date: Mon, 30 Jun 2008 16:04:14 +0200
Message-ID: <200806301604.15083.u.luckas@road.de>
References: <20080627145236.2a20aaad@hyperion.delvare>
	<4868BE37.1090405@movial.fi>
	<20080630145532.5a8452b5@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080630145532.5a8452b5-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Monday, 30. June 2008, Jean Delvare wrote:
> On Mon, 30 Jun 2008 14:06:31 +0300, Riku Voipio wrote:
> > Jean Delvare wrote:
> >  > obj-$(CONFIG_I2C_PASEMI) += i2c-pasemi.o
> >
> > I'm not sure if one would classify pa semi dualcore 2GHz systems
> > as "embedded", but this i2c controller is embedded into the
> > PA SEMI cpu..
>
> By "embedded", I had "embedded systems" in mind, not whether the I2C
> controller was part of the CPU. So it's down to: what systems are using
> the PA Semi hardware.
>
I think neither notion of 'embedded' really does the right seperation for the 
link order problem.
The actual question is: "do we need the bus for early system initialization". 
Therfore we should maybe call this group of drivers "I2C system bus drivers".

Uli


-- 

------- ROAD ...the handyPC Company - - -  ) ) )

Uli Luckas
Software Development

ROAD GmbH
Bennigsenstr. 14 | 12159 Berlin | Germany
fon: +49 (30) 230069 - 64 | fax: +49 (30) 230069 - 69
url: www.road.de

Amtsgericht Charlottenburg: HRB 96688 B
Managing directors: Hans-Peter Constien, Hubertus von Streit

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
