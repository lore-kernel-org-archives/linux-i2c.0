From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: I2C bus locked: marvell mv64xxx i2c controller driver
Date: Tue, 5 Feb 2019 20:58:57 +0100
Message-ID: <20190205195857.oadxiswya5wq5hca@pengutronix.de>
References: <CAEHvULnPFtCK9cD3GtFKoZ+OHaqN1ZJMmPxK+OPnYqhptk8t7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAEHvULnPFtCK9cD3GtFKoZ+OHaqN1ZJMmPxK+OPnYqhptk8t7w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roman Rozman <rozmanro@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Cc +=3D linux-i2c

Hello,

On Tue, Feb 05, 2019 at 12:18:05PM +0200, Roman Rozman wrote:
> Having an issue that i know was found many years ago, and there were
> patches along the way for it, but i'm still having an issue.
> =

> I have a SFP connector connected to the switch, the EEprom is fine & read=
able
> ,the connector is working.
> But after i reboot the device from user space,on startup an I2C bus
> locked issue is happening.
> And the EEprom of the i2c device is no longer readable.
> =

> see screen capture during the reboot:
> =

> [ 5.663823] i2c /dev entries driver
> [ 5.852006] usb 1-1: new high-speed USB device number 2 using orion-ehci
> [ 6.058964] usb-storage 1-1:1.0: USB Mass Storage device detected
> [ 6.065221] scsi host0: usb-storage 1-1:1.0
> [ 7.112857] scsi 0:0:0:0: Direct-Access Generic Ultra HS-COMBO 1.98 PQ: 0=
 ANSI: 0
> [ 7.122702] sd 0:0:0:0: [sda] Attached SCSI removable disk
> [ 7.752006] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [ 9.832006] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [ 11.912005] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [ 11.918603] lm75: probe of 1-0048 failed with error -110
> [ 11.925496] orion_wdt: Initial timeout 171 sec
> =

> [ 14.472004] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [ 14.478563] sfp sfp: failed to read EEPROM: -110
> =

> I read regarding the known "possible solution" that the master should
> send nine clock pulses((SDA) is stuck LOW). And the device that held
> the bus LOW should release it sometime within those nine clocks.
> =

> My question is there any GENERIC way to do that for the mv64xxx driver?
> Or maybe there is some other solution for this.

The relevant keyword here is "recovery". The i2c core has some helper
functions that make it easy to reset the bus if your pins can be driven
using a gpio functionality. See i2c_generic_scl_recovery() in
drivers/i2c/i2c-core-base.c.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
