From: "Hans J. Koch" <hjk-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: Two start conditions for PCA9554
Date: Thu, 1 May 2008 22:35:01 +0200
Message-ID: <20080501203500.GC3210@local>
References: <200804302301.56732.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200804302301.56732.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 30, 2008 at 11:01:56PM -0700, David Brownell wrote:
> > I have an embedded board with a PCA9554 on it. It's an 8-bit IO expander
> > similar to the PCF8574 in mainline.
> 
> More like the pca9534 or pca9538.
> 
> 
> > Can such a protocol be handled by the i2c subsystem?
> 
> Try to tell drivers/gpio/pca953x.c that it's a pca9534;
> I think they're register-compatible.

Ah, I only looked in drivers/i2c/chips. I'll give it a try.

Thanks a lot for that hint,
Hans

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
