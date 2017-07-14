From: Boszormenyi Zoltan <zboszor@pr.hu>
Subject: Re: [PATCH 3/5 v4] usb: pci-quirks: Protect the I/O port pair of
 SB800
Date: Fri, 14 Jul 2017 10:34:20 +0200
Message-ID: <d599eeac-d159-cff6-7140-7b6cce026c7a@pr.hu>
References: <20170621035349.4125-1-zboszor@pr.hu>
 <20170622132134.7200-1-zboszor@pr.hu> <20170622132134.7200-4-zboszor@pr.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170622132134.7200-4-zboszor@pr.hu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org, Paul Menzel <paulepanter@users.sourceforge.net>, Christian Fetzer <fetzer.ch@gmail.com>, Jean Delvare <jdelvare@suse.com>, Nehal Shah <nehal-bakulchandra.shah@amd.com>, Tim Small <tim@seoss.co.uk>, Guenter Roeck <linux@roeck-us.net>, kernel@ekass.net, wim@iguana.be, jlayton@poochiereds.net, marc.2377@gmail.com, cshorler@googlemail.com, wsa@the-dreams.de, regressions@leemhuis.info, Alex Williamson <alex.williamson@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Toshi Kani <toshi.kani@hpe.com>, Jiang Liu <jiang.liu@linux.intel.com>, Jakub Sitnicki <jsitnicki@gmail.com>, Thierry Reding <treding@nvidia.com>, Vive
List-Id: linux-i2c@vger.kernel.org

2017-06-22 15:21 keltezéssel, Zoltán Böszörményi írta:
> This patch uses the previously introduced macro called
> request_declared_muxed_region() to synchronize access to
> the I/O port pair 0xcd6 / 0xcd7 on SB800.
> 
> These I/O ports are also used by i2c-piix4 and sp5100_tco,
> so synchronization is necessary. The other drivers will also
> be modified to use the new macro in subsequest patched.
> 
> v1: Started with a common mutex in a C source file.
> 
> v2: Declared the common mutex in drivers/usb/host/pci-quirks.c
>      instead of in a common C file.
> 
> v3: Switched to using the new request_declared_muxed_region
>      macro.
> 
> v4: Fixed checkpatch.pl warnings and use the new
>      release_declared_region() macro.
> 
> Signed-off-by: Zoltán Böszörményi <zboszor@pr.hu>
> ---
>   drivers/usb/host/pci-quirks.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index a9a1e4c..593942a 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -279,6 +279,8 @@ bool usb_amd_prefetch_quirk(void)
>   }
>   EXPORT_SYMBOL_GPL(usb_amd_prefetch_quirk);
>   
> +static struct resource sb800_res = DEFINE_RES_IO_NAMED(0xcd6, 2, "SB800 USB");
> +
>   /*
>    * The hardware normally enables the A-link power management feature, which
>    * lets the system lower the power consumption in idle states.
> @@ -314,11 +316,13 @@ static void usb_amd_quirk_pll(int disable)
>   	if (amd_chipset.sb_type.gen == AMD_CHIPSET_SB800 ||
>   			amd_chipset.sb_type.gen == AMD_CHIPSET_HUDSON2 ||
>   			amd_chipset.sb_type.gen == AMD_CHIPSET_BOLTON) {
> +		request_declared_muxed_region(&sb800_res);
>   		outb_p(AB_REG_BAR_LOW, 0xcd6);
>   		addr_low = inb_p(0xcd7);
>   		outb_p(AB_REG_BAR_HIGH, 0xcd6);
>   		addr_high = inb_p(0xcd7);
>   		addr = addr_high << 8 | addr_low;
> +		release_declared_region(&sb800_res);
>   
>   		outl_p(0x30, AB_INDX(addr));
>   		outl_p(0x40, AB_DATA(addr));
> 
