From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 5/8] OSIRIS: Add i2c device list to Simtec Osiris
Date: Mon, 2 Jun 2008 08:31:42 +0200
Message-ID: <20080602083142.5f2504e7@hyperion.delvare>
References: <20080529132244.818543231@fluff.org.uk>
	<20080529132406.837870894@fluff.org.uk>
	<20080601092116.63c4808e@hyperion.delvare>
	<20080601213509.GH7334@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080601213509.GH7334-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 1 Jun 2008 22:35:09 +0100, Ben Dooks wrote:
> On Sun, Jun 01, 2008 at 09:21:16AM +0200, Jean Delvare wrote:
> > The "eeprom" driver is not a new-style i2c driver, so it won't be able
> > to bind to device. Having it declared here even prevents the legacy
> > binding to happen, because the address will be busy. So you should
> > either not list the eeprom here and let the legacy eeprom driver pick
> > it later, or add a new-style mode to the eeprom driver - but then you
> > probably want to use David Brownell and Wolfram Sang's at24 driver
> > instead, it's much better.
> 
> Thanks, I'll change this to at94. Is this driver going to be included
> on the next kernel window?

at24, not at94 ;) I hope so. I've reviewed the driver and am now
waiting for Wolfram to send an updated version. The code looked good so
if I receive something soon enough, there's really no reason why it
wouldn't make it in kernel 2.6.27.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
