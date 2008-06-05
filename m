From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Wed, 4 Jun 2008 19:14:27 -0700
Message-ID: <200806041914.27291.david-b@pacbell.net>
References: <20080604201334.19636f30@hyperion.delvare>
	<200806041727.51746.david-b@pacbell.net>
	<Pine.LNX.4.58.0806041731250.10290@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0806041731250.10290-13q4cmjDBaTP3RPoUHIrnuTW4wlIGRCZ@public.gmane.org>
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
To: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wednesday 04 June 2008, Trent Piepho wrote:
> So scanning an I2C bus doesn't work as well as with PCI, we all know that.

As I said, not just "scanning" but also "identifying".

PCI was designed explicitly for automatic configuration.
I2C was not.


> How does creating a new "i2c listeners" system solve any of these problems?

That's an entirely different (and unrelated) question.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
