From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: Two start conditions for PCA9554
Date: Wed, 30 Apr 2008 14:26:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0804301422140.9894@shell4.speakeasy.net>
References: <20080429131114.GF3195@local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080429131114.GF3195@local>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: "Hans J. Koch" <hjk-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 29 Apr 2008, Hans J. Koch wrote:
> I have an embedded board with a PCA9554 on it. It's an 8-bit IO expander
> similar to the PCF8574 in mainline. One difference is that when reading
> from the inputs, you have to do the following:
>
> - start condition
> - send slave address, R/W=0
> - send command (0x00 = read input register)
> - issue another start condition (!)
> - send slave address, R/W=1
> - read data
> - stop condition
>
> Can such a protocol be handled by the i2c subsystem?

Yes.  That is a normal repeated start transaction, and AFAIK exactly what
all the other PCA, and virtually every other i2c chip for that matter, use.
The smbus read byte data function will do this for you.

If you want multiple stops in a single transaction, the i2c subsystem can't
do it, but I wrote a simple patch that allows it.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
