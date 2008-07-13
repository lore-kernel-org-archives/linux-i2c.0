From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] gpio: max732x: add support for MAX7319,
 MAX7320-7327 I2C   Port Expanders
Date: Sun, 13 Jul 2008 11:18:47 +0200
Message-ID: <20080713111847.69b35ce5@hyperion.delvare>
References: <4875A893.3090402@gmail.com>
	<200807111425.00961.david-b@pacbell.net>
	<20080712091610.4ec242c3@hyperion.delvare>
	<200807120046.29389.david-b@pacbell.net>
	<f17812d70807122304o533d8af9k1384db653b264912@mail.gmail.com>
	<20080713092050.6dffd8d3@hyperion.delvare>
	<20080713091236.015E920ABDD@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080713091236.015E920ABDD-ZcXrCSuhvln6VZ3dlLfH/g4gEjPzgfUyLrfjE7I9kuVHxeISYlDBzl6hYfS7NtTn@public.gmane.org>
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
Cc: jack.ren-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 13 Jul 2008 02:12:36 -0700, David Brownell wrote:
> > 3. for chips like max732x, actually, the range of 0x50 - 0x5F will be
> > monitored by the I2C chips at startup to decide the connections of
> > AD2/AD0 pins to GND/VCC/SCL/SDA,
> 
> There's no need to monitor addresses ... before the first data bit
> is sent -- whatever value! -- it's known how those pins are wired:
> 
>  - START bit ... SCL is high, SDA falls.  Any pin that stayed
>    low is wired to ground.  Any pin that changed high-to-low is
>    thus connected to SDA.
> 
>  - Prepare to send first bit ... SDA still low, SCL falls.  Any
>    pin that stayed high is wired to Vcc.  Any pin that changed
>    high-to-low is connected to SCL.
> 
> And then the master updates SDA to match the first (address) bit,
> and lets SCL be pulled high ... the i2c slave has all the data it
> needs to be able to determine its address.

Totally true. Add to this that the first 3 address bits can't change,
this gives the chip some more time to setup its internal logic to match
the 4 LSBs by the time they come.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
