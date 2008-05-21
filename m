From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v4] i2c: Add Intel SCH I2C SMBus support
Date: Wed, 21 May 2008 11:04:12 +0200
Message-ID: <20080521110412.3617b022@hyperion.delvare>
References: <20080428105738.06429ed2@hyperion.delvare>
	<20080429110628.66d4892b@dxy.sh.intel.com>
	<8AD95083DC3E36478732061D97524415030F8FAA@pdsmsx411.ccr.corp.intel.com>
	<20080430080351.57b8c21d@hyperion.delvare>
	<20080505141807.1aa458e1@dxy.sh.intel.com>
	<20080505110757.6454c220@hyperion.delvare>
	<20080506095036.274e91f1@dxy.sh.intel.com>
	<20080512225718.7440ab42@hyperion.delvare>
	<20080520135635.55238a08@dxy.sh.intel.com>
	<20080520113140.44e40b77@hyperion.delvare>
	<20080521102105.13d75e59@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080521102105.13d75e59-PCb9FJy6fea75v1z/vFq2g@public.gmane.org>
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

On Wed, 21 May 2008 10:21:05 +0800, Alek Du wrote:
> On Tue, 20 May 2008 17:31:40 +0800
> "Jean Delvare" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> 
> > ETIMEOUT is indeed not defined, but ETIMEDOUT (what I wrote) is.
> Ok, my bad.
> > 
> > Well, the datasheet clearly says otherwise. How did you test bit 31?
> > Your code uses pci_read_config_word() at the moment so you can't read
> > bit 31, you'd need to use pci_read_config_dword() instead. If Bit 31
> Yes, my bad again. fixed now.
> 
> Again, here is the updated patch, thanks for your kind review:
> 
> This patch adds Intel SCH chipsets (AF82US15W, AF82US15L, AF82UL11L) i2c bus support.

OK, this is the right one this time. I've added your patch to my i2c
tree as:
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-add-intel-sch-i2c-smbus-support.patch
It will go in linux-next and is scheduled for merge in kernel
2.6.27-rc1.

I've also updated sensors-detect and http://www.lm-sensors.org/wiki/Devices .

Any further patch to this driver should be an incremental one based on
what I have in my tree. Things that could be improved include:
* Allocate the device data dynamically to get rid of the assumption
  that only one SMBus interface is present.
* Rework the timeout mechanism so that it doesn't depend on HZ.
* Documentation. Most SMBus host controller drivers have a
  documentation file under Documentation/i2c/busses, it would be nice to
  have one for this new i2c-isch driver.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
