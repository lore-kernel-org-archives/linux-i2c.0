From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Sun, 8 Jun 2008 13:26:50 -0700
Message-ID: <200806081326.50442.david-b@pacbell.net>
References: <1210883799-25188-1-git-send-email-w.sang@pengutronix.de>
	<200806031336.35678.david-b@pacbell.net>
	<20080608104038.006be072@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080608104038.006be072-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sunday 08 June 2008, Jean Delvare wrote:
> On Tue, 3 Jun 2008 13:36:35 -0700, David Brownell wrote:
> > I personally won't worry much about 24c00 chips; I have some for
> > testing, but haven't seen new systems using them for some time.
> > It was news for me that they exist on DDC links!
> 
> Actually I don't think there are 24C00 chips on DDC links. These chips
> only provide 128 bit (16 bytes) of storage space, which is insufficient
> to hold EDID data. So I think these are 24C01 chips (1 kb) which
> behave like the 24C00 as far as I2C addressing is concerned (i.e.
> answering to all addresses 0x50-0x57.) Apparently Atmel make such
> chips (the datasheet doesn't mention any I2C address, and the 3 EEPROM
> pins which are typically used for address selection are labelled "NC".)

I see.  The only data sheet I had handy lists 24c01A parts,
which *do* have address pins, not marked as NC ("No Connect").
But I see the 24c01 is as you describe, though it's "not for
new designs".

And I'm a bit puzzled how the SOT23-5 package for the 24c01B
parts will be addressed ... those signals aren't pinned out
there (couldn't be!), and the address doesn't appear to be an
option which is exposed in the part number.

- Dave

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
