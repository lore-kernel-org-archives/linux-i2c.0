From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCHv2 4/5] i2c: i801: Remove pci_enable_device() call from
 i801_resume()
Date: Mon, 16 Feb 2015 08:41:03 +0100
Message-ID: <20150216084103.3cdec362@endymion.delvare>
References: <1423657928-25534-1-git-send-email-jarkko.nikula@linux.intel.com>
	<1423657928-25534-5-git-send-email-jarkko.nikula@linux.intel.com>
	<20150213113302.0e20b8da@endymion.delvare>
	<54DDDC4E.5010602@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54DDDC4E.5010602-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jarkko,

On Fri, 13 Feb 2015 13:13:18 +0200, Jarkko Nikula wrote:
> On 02/13/2015 12:33 PM, Jean Delvare wrote:
> > This looks reasonable but have you tested this change on a range of
> > actual laptops to make sure it has no unexpected side effect?
>
> Unfortunately I have only limited amount of test hw which are working 
> fine even if PCI device is disabled so I cannot hit those issues that 
> were seen in the past.
> 
> I suppose this patch unlikely cause regression since if you look at the 
> call chain pci_enable_device() -> pci_enable_device_flags() it doesn't 
> go beyond taking the current power state since enable_cnt is always 
> greater than 1.
> 
> drivers/pci/pci.c: pci_enable_device_flags():
> 
> if (dev->pm_cap) {
> 	u16 pmcsr;
> 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> 	dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> }
> 
> if (atomic_inc_return(&dev->enable_cnt) > 1)
> 	return 0;		/* already enabled */
> 
> To me it seems current power state taking is practically no-op when 
> device is enabled since pci_set_power_state() calls in i801_suspend() 
> and i801_resume() have already cached it.

OK, you convinced me. I'll still test the updated driver on my two
IBM/Lenovo Thinkpad laptops (T60p and X230) to make sure we didn't miss
anything.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
