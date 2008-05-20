From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3] i2c: Add Intel SCH I2C SMBus support
Date: Tue, 20 May 2008 11:31:40 +0200
Message-ID: <20080520113140.44e40b77@hyperion.delvare>
References: <20080428105738.06429ed2@hyperion.delvare>
	<20080429110628.66d4892b@dxy.sh.intel.com>
	<8AD95083DC3E36478732061D97524415030F8FAA@pdsmsx411.ccr.corp.intel.com>
	<20080430080351.57b8c21d@hyperion.delvare>
	<20080505141807.1aa458e1@dxy.sh.intel.com>
	<20080505110757.6454c220@hyperion.delvare>
	<20080506095036.274e91f1@dxy.sh.intel.com>
	<20080512225718.7440ab42@hyperion.delvare>
	<20080520135635.55238a08@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080520135635.55238a08-PCb9FJy6fea75v1z/vFq2g@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Alek Du <alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Alek,

On Tue, 20 May 2008 13:56:35 +0800, Alek Du wrote:
> Modify the patch according to your last comments except for two cases:
> 
> > > +
> > > +     /* If the SMBus is still busy, we give up */
> > > +     if (timeout >= MAX_TIMEOUT) {
> > > +             dev_err(&sch_adapter.dev, "SMBus Timeout!\n");
> > > +             result = -EPERM;
> >
> > -ETIMEDOUT
> 
> there is no -ETIMEOUT defined

ETIMEOUT is indeed not defined, but ETIMEDOUT (what I wrote) is.

> > > +     dev_dbg(&dev->dev, "SMBA = 0x%X\n", sch_smba);
> 
> > What about bit 31 of this register? It says whether the I/O area is
> > enabled or not. If it's not then you're registering the device but it
> > won't work, that's no good.
> 
> As I tested, the bit 31 of this register is always 0...

Well, the datasheet clearly says otherwise. How did you test bit 31?
Your code uses pci_read_config_word() at the moment so you can't read
bit 31, you'd need to use pci_read_config_dword() instead. If Bit 31
really isn't used by the hardware, please report to whoever at Intel is
in charge of the technical documentation for this chip, so that they
can update the datahseet.

> Here is my patch v3, please help to review it:

I'll review it later today as my time permits.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
