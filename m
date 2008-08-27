From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Fwd: [PATCH 2/3] I2C: at24: add kernel interface for
	reading/writing EEPROM
Date: Wed, 27 Aug 2008 00:19:12 -0700
Message-ID: <200808270019.12987.david-b@pacbell.net>
References: <200808251941.54964.david-b@pacbell.net>
	<200808261335.36103.david-b@pacbell.net>
	<Pine.LNX.4.58.0808261852580.2423@shell2.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0808261852580.2423-nuiHJn5p267P3RPoUHIrnuTW4wlIGRCZ@public.gmane.org>
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
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 26 August 2008, Trent Piepho wrote:
> Lots of tv cards have eeproms with configuration information. =A0They use=
 an
> I2C driver called tveeprom that exports this:
> =

> int tveeprom_read(struct i2c_client *c, unsigned char *eedata, int len)

That presumes the driver somehow has access to that I2C client.

(Also, that it's an I2C EEPROM.  I keep wanting to have something
usable for SPI EEPROMs and NVRAM too.  But maybe nobody else cares.)

 =

> > Last I heard, the U-Boot policy was not to touch controllers that are
> > not required during boot. =A0Despite relatively common cases like needi=
ng
> > to set up MAC addresses ... maybe this patch of Kevin's can make it a
> > bunch easier to cope with that U-Boot policy. =A0:)
> =

> U-boot can put the MAC address into a property of the MAC's device node in
> the OF device tree (which u-boot passes to the kernel).

Maybe with PowerPC it does.  Not on ARM.  ;)



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
