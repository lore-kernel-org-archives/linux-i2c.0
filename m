From: "Maciej W. Rozycki" <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: [PATCH] i2c: Improve the functionality documentation
Date: Sun, 11 May 2008 17:02:42 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0805111658580.26604@cliff.in.clinika.pl>
References: <20080510103937.1c74ca8c@hyperion.delvare>
	<Pine.LNX.4.55.0805110818040.18978@cliff.in.clinika.pl>
	<20080511111452.6e76e939@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080511111452.6e76e939-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, 11 May 2008, Jean Delvare wrote:

> > > +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> > > +				     I2C_FUNC_SMBUS_WORD_DATA))
> > 
> >  Indentation (obviously it is the driver you are referring to that has got
> > it wrong in the first place).
> 
> There's nothing wrong with indentation here. Alignment on opening
> parenthesis is a common strategy, and checkpatch.pl accepts it.

 Well, it suggests I2C_FUNC_SMBUS_WORD_DATA is an argument on its own.  
The call is short here though, so it may not matter in practice.

  Maciej

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
