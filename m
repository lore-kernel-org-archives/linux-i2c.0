From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC][PATCH 4/4] RTC: SMBus support for the M41T80,
Date: Thu, 8 May 2008 09:46:20 +0200
Message-ID: <20080508094620.5e6c973b@hyperion.delvare>
References: <200805070120.03821.david-b@pacbell.net>
	<Pine.LNX.4.55.0805072226180.25644@cliff.in.clinika.pl>
	<200805071625.20430.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200805071625.20430.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
Cc: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, "Maciej W. Rozycki" <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Wed, 7 May 2008 16:25:20 -0700, David Brownell wrote:
> On Wednesday 07 May 2008, Maciej W. Rozycki wrote:
> >  Well, I have to admit what I know in detail about I2C and how it is 
> > handled by Linux is what I gathered over the last weekend.  The idea of 
> > the change, given a change had to be done, was to make the driver a bit 
> > more flexible.  Of all the I2C RTC drivers this seems to be one of the two 
> > only that require *both* I2C *and* SMBus functionality in the driving 
> > controller at the same time.  With this change in place only either of the 
> > two is needed.  Please correct me if I am wrong.
> 
> It checks for "I2C_FUNC_I2C | I2C_FUNC_SMBUS_BYTE_DATA" which is
> admittedly odd.  Because if it can do I2C, it can assuredly do
> that minor subset of SMBus.  (Modulo bugs in how drivers end up
> reporting their capabilities.)

Not totally correct, see my reply somewhere else in this thread.

> > (...)
> >  I think a pair of functions called i2c_smbus_read_i2c_byte_data() and
> > i2c_smbus_write_i2c_byte_data() could be added to the core though.
> 
> Too late.  Those calls have been in the I2C core for a long
> time now.  ;)

No, we don't have any function named that way. Not that I think that
these names would be appropriate, though. I'd rather have
i2c_smbus_read_i2c_block_emul() for example.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
