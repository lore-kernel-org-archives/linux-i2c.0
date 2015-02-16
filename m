From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCHv3 5/5] i2c: i801: Use managed pcim_* PCI device
 initialization and reservation
Date: Mon, 16 Feb 2015 10:29:18 +0100
Message-ID: <20150216102918.53042ba0@endymion.delvare>
References: <1423835545-17991-1-git-send-email-jarkko.nikula@linux.intel.com>
	<1423835545-17991-5-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423835545-17991-5-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 13 Feb 2015 15:52:25 +0200, Jarkko Nikula wrote:
> Simplifies the code a bit and makes easier to disable PCI device on driver
> detach by removing the pcim_pin_device() call in the future if needed.
> 
> Reason why i2c-i801.c doesn't ever call pci_disable_device() was because it
> made some systems to hang during power-off. See commit d6fcb3b9cf77
> ("[PATCH] i2c-i801.c: don't pci_disable_device() after it was just enabled")
> and
> http://marc.info/?l=linux-kernel&m=115160053309535&w=2
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
> Changes from v2:
> - over 80 characters long pcim_iomap_regions line splitted
> - gotos and error labels removed
> ---
>  drivers/i2c/busses/i2c-i801.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> (...)

Reviewed-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>

Wolfram, please commit this series, I have reviewed all patches and
tested the updated driver successfully on 3 different machines.

Thanks Jarkko for the good work.

-- 
Jean Delvare
SUSE L3 Support
