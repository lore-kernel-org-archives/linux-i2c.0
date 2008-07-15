From: Nick Teen <xpage_de-LWAfsSFWpa4@public.gmane.org>
Subject: Re: i2c_smbus_write_block_data does not send all bytes?!
Date: Tue, 15 Jul 2008 12:22:05 +0000 (GMT)
Message-ID: <952972.59634.qm@web27607.mail.ukl.yahoo.com>
References: <20080715125702.48c9569b@hyperion.delvare>
Reply-To: xpage_de-LWAfsSFWpa4@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080715125702.48c9569b-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

--- Jean Delvare wrote:
> > > * What i2c bus driver are you using?
> > =

> > i2c_i801                9008  0
> > i2c_dev                 8164  0
> =

> Hmm, did you connect something to a SMBus header on your
> motherboard?
> Or are you talking to an I2C chip on your motherboard?

I try to run linux on my iptv box. 0x5d is a I2C talking PIC on the frontpa=
nel.

> > > * How do you know for sure what actually goes on
> the bus?
> > =

> > Milksop GPL Reflasher - 0.20 - (c)2002
> andy-/Zus8d0mwwtBDgjK7y7TUQ@public.gmane.org
> > with CheapI2C
> =

> Err, what is this exactly? Hardware? Software? Please
> explain your setup in details.

I've attached SDA, SCL of my device using a cmos 4050 to my parport.
Take a look: http://ivtv.writeme.ch/tiki-index.php?page=3DMonitoring+I2C+Bus

Nick


      __________________________________________________________
Ungl=FCcklich mit Ihrer Mail-Adresse?

Millionen neuer Mail-Adressen - jetzt bei Yahoo!

http://de.docs.yahoo.com/mail/wunschmailadresse/index.html

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
