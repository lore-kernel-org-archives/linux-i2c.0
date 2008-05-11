From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Improve the functionality documentation
Date: Sun, 11 May 2008 11:14:52 +0200
Message-ID: <20080511111452.6e76e939@hyperion.delvare>
References: <20080510103937.1c74ca8c@hyperion.delvare>
	<Pine.LNX.4.55.0805110818040.18978@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.55.0805110818040.18978-j8+e0ZhYU2SU0huXySazC6sMm+1xrEX8@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: "Maciej W. Rozycki" <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, 11 May 2008 08:23:01 +0100 (BST), Maciej W. Rozycki wrote:
> On Sat, 10 May 2008, Jean Delvare wrote:
> 
> > Attempt to make the documentation about the I2C/SMBus functionality
> > checking API clearer.
> 
>  It looks good to me.  A minor nit below.

Thanks for the review.

> 
> > +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> > +				     I2C_FUNC_SMBUS_WORD_DATA))
> 
>  Indentation (obviously it is the driver you are referring to that has got
> it wrong in the first place).

There's nothing wrong with indentation here. Alignment on opening
parenthesis is a common strategy, and checkpatch.pl accepts it.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
