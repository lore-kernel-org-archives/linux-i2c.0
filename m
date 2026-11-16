Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794846819;
	b=Z3HGwgAZf/rp5ks84bjvdtE5kp2xoXZ5g1GOG/mvJgvi83jESRRCW7o2K+BYNXm1XIlR
	 pCwif28RIPxyJmHm6HpIbfiryIYU/VaSGRTxBId5e0Hykm+Clel1xUUKdPhE3XBMb5IF/
	 ajp1rpMPqDSO7xtBj5iYNi4MVn+ClzK9/pyeFKWrH51Zu/t/IWj32MjuZZJsTC8A+LUbZ
	 +cKcWlzUITKtmpiJcVNuKIBIEHgqMTD5V0vIIUPcHg7Ln9z5CHOCMZYUPq+SLm+bKlO1V
	 i+nfuq7IPHp4FCGj/f+y+QDRDOR3VF/M3ao0LllSySSBqi6QVEfHeUVUfom72dCoHaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794846819;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+YFT6eckgNpq4qRTPM9jABLx7aQhTdDPS9Vpg0WMrlM=;
	b=wsPQEATtzB6rB51rVWM0d0i9bpICllXyikeUu76mUhHzmULRIb6h0pkDEmrHoK6zUs7q
	 1ElS60oguOn6S0DEF3DvibyuNDt4R82zyHJzMFVQi6Wgx8a7k1/oRiojZiq1Xdbi9j9Db
	 izaH8HgTF9BtS9OjonJaxiIqWBNZhy405NAMVMWTMPn3w134OSh6met3xOASI0x5Bwh81
	 QVXAmqpJ0aNO6I/TJNEal0zLACgEJg5SRDcRAsc6/GAe74JH0lRK3r9wCaauSe1wLE42o
	 2pldV8PtNp61uBS7MXten7z6W1WacUBTPdEXcluBmAQRlRJjnp61HfpJbgJTF2rJxxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PndPl9SN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F77606A332;
	Mon, 16 Nov 2026 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PndPl9SN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3A41F000C4;
	Mon, 16 Nov 2026 16:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794846819;
	bh=+YFT6eckgNpq4qRTPM9jABLx7aQhTdDPS9Vpg0WMrlM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PndPl9SNKnbANT8vi5uI8WjZVnYtcOWcq6rIAX7B2/+Sf59r5PlG2wBv6sY/m2DXT
	 RFq32DH5sKfmqBpmfKf6BREgtDuTbX+4dkHmV2QNcpFKGJc4nhPvk0Xq3K5TgMCWf5
	 PwNLouKFb+3oow/3spPlCQ2w/t+Gg3XMpZirJY7YBXG08mafesTOyt6VOI7VphQHdI
	 uXGx4By4ZFmroq01sozTBnNTkUXzcicwpjTJO7YNc0r1DVODJIxttkKZHbwsbPaQ5U
	 GED8sHPz9qN+bjDN5jS18inbRGHfoErmwuF/OOoIYcD+9UlX5W3bv0ZXftGVFVRWH4
	 645czed779JBQ==
Subject:
 Re: [PATCH net-next v2 3/3] ptp: ocp: support the WiWi revision 02 Time Card
From: netdev-bot+sashiko@kernel.org
To: ahmadexp@gmail.com
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, andi.shyti@kernel.org,
 linux-i2c@vger.kernel.org, michal.simek@amd.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kuba@kernel.org
Date: Mon, 16 Nov 2026 16:33:38 +0000
Message-ID: <179484681859.3136.5472457983791141613@kernel.org>
In-Reply-To: <20261112163333.12523-4-ahmadexp@gmail.com>
References: <20261112163333.12523-4-ahmadexp@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch blocks only one write path to WiWi flash.
- [Low] The submission says the PCI Revision ID alone defines the WiWi
  register interface ('the Xilinx subsystem ID and FPGA build number do…
- [Low] The patch defines WiWi identity three different ways.
- [Low] The generic 'fw' row in
  Documentation/networking/devlink/ptp_ocp.rst still says the running…
- [Low] In ptp_ocp_wiwi_validate(), the revision-rejection message uses
  "Unsupported WiWi PCI revision %#02x\n".
- [Low] The WiWi documentation says GNSS2 is not wired to pins, and
  ptp_ocp_register_resources() skips the GNSS2 UART on WiWi.
- [Low] ptp_ocp_i2c_bus() casts info->data to struct
  xiic_i2c_platform_data whenever bp->wiwi is true.

--

ptp: ocp: support the WiWi revision 02 Time Card

This adds support for the WiWi 2163:1008 Time Card (subsystem 10ee:0007),
PCI revision 02. It reuses the FB resource table, adds 0x02000000 to the
MMIO offsets and 32 to the interrupt inputs, and gates interrupts through a
LiteX enable mask. It validates the revision, BAR0 and MSI-X layout,
reports the full image ID through devlink, and rejects devlink flash
updates on WiWi.

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 625a85b2dc7e5..10ad2fbeb9675 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c

[ ... ]

> @@ -1321,6 +1341,13 @@ static struct ocp_resource ocp_adva_x1_resource[] = {
>  static const struct pci_device_id ptp_ocp_pcidev_id[] = {
>  	{ PCI_DEVICE_DATA(META, TIMECARD, &ocp_fb_resource) },
>  	{ PCI_DEVICE_DATA(CELESTICA, TIMECARD, &ocp_fb_resource) },
> +	{
> +		PCI_DEVICE_SUB(PCI_VENDOR_ID_WIWI, PCI_DEVICE_ID_WIWI_TIMECARD,
> +			       PCI_VENDOR_ID_XILINX, 0x0007),
> +		.class = PCI_CLASS_MEMORY_OTHER << 8,
> +		.class_mask = 0xffffff,
> +		.driver_data = (kernel_ulong_t)ocp_fb_resource,
> +	},

[Severity: Low]
The new documentation describes WiWi cards by PCI ID 2163:1008 and
subsystem 10ee:0007, and says unknown revisions are rejected. This entry
also requires class 0x058000 with a full class_mask, so prog-if must be 0
as well.

Is the extra class requirement intended? A card with the documented IDs but
a different class code or prog-if never reaches ptp_ocp_probe(). It stays
unbound and never logs "Unsupported WiWi PCI revision".

In the other direction, ptp_ocp_probe() sets:

	bp->wiwi = pdev->vendor == PCI_VENDOR_ID_WIWI &&
		   pdev->device == PCI_DEVICE_ID_WIWI_TIMECARD;

This ignores the subsystem and class that the table requires. Could both
places use the same identity rule, for example by carrying a WiWi flag in
driver_data? Otherwise a device bound through new_id gets WiWi handling
without matching this entry.

[ ... ]

> @@ -2173,6 +2200,12 @@ ptp_ocp_devlink_flash_update(struct devlink *devlink,
>  	const char *msg;
>  	int err;
>  
> +	if (bp->wiwi) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "WiWi flash updates are not supported");
> +		return -EOPNOTSUPP;
> +	}
> +

[Severity: Low]
This rejects devlink flash on WiWi. The commit message says "Device
recognition is not validation of an update path". Can the same flash still
be written through raw MTD?

ptp_ocp_register_resources() still registers the ocp_fb_resource
spi_flash entry on WiWi. Its IRQ moves to input 9 + 32 and is unmasked
before the children probe. The board info for that entry is only:

	.devices = &(struct spi_board_info) {
		.modalias = "spi-nor",
	},

It has no partitions and no read-only marking. So spi-nor registers one
writable MTD device that covers the whole flash, including the golden
image at offset zero. The commit message confirms "SPI NOR ... bound".

Writes through /dev/mtdN (flashcp, mtd_debug, existing Time Card update
scripts) then go through the stock spi-xilinx driver. The new
documentation says the vendor's programming path needs a modified
spi-xilinx.

Could a privileged user erase the golden fallback image this way? Should
the flash be registered read-only on WiWi, or should this exposure at
least be documented next to the devlink restriction?

[ ... ]

> @@ -2331,20 +2367,29 @@ ptp_ocp_register_spi(struct ptp_ocp *bp, struct ocp_resource *r)
>  }
>  
>  static struct platform_device *
> -ptp_ocp_i2c_bus(struct pci_dev *pdev, struct ocp_resource *r, int id)
> +ptp_ocp_i2c_bus(struct ptp_ocp *bp, struct ocp_resource *r, int id)
>  {
> +	struct xiic_i2c_platform_data wiwi_data;

[ ... ]

>  	info = r->extra;
> +	data = info->data;
> +	if (bp->wiwi) {
> +		wiwi_data = *(struct xiic_i2c_platform_data *)info->data;
> +		wiwi_data.force_32bit_access = true;
> +		data = &wiwi_data;
> +	}
>  	start = pci_resource_start(pdev, 0) + r->offset;
>  	res[0] = DEFINE_RES_MEM(start, r->size);
>  	res[1] = DEFINE_RES_IRQ(pci_irq_vector(pdev, r->irq_vec));
>  
>  	return platform_device_register_resndata(&pdev->dev, info->name,
>  						 id, res, ARRAY_SIZE(res),
> -						 info->data, info->data_size);
> +						 data, info->data_size);
>  }

[Severity: Low]
Whenever bp->wiwi is set, this casts info->data to struct
xiic_i2c_platform_data without checking that the resource is an xiic
controller. platform_device_register_resndata() then copies
info->data_size bytes from the stack copy.

ptp_ocp_probe() sets bp->wiwi from vendor and device only, not from
id->driver_data. The static table always pairs WiWi with ocp_fb_resource
(xiic-i2c). However, new_id_store() accepts any driver_data that matches an
existing table entry, such as ocp_adva_resource or ocp_art_resource. Their
i2c entries are "ocores-i2c", with data_size set to
sizeof(struct ocores_i2c_platform_data), which is 32 bytes on 64-bit.

Suppose a revision 02 WiWi card is bound that way. Would this overwrite
the ocores big_endian field with force_32bit_access? Would kmemdup() then
read 32 bytes from the 24-byte wiwi_data on the stack? The extra 8 bytes
would become the ocores devices pointer, which i2c-ocores dereferences.

This needs root and a dynamic ID. Could the override check
info->data_size == sizeof(wiwi_data) or the xiic name first, or could the
WiWi flag come from driver_data?

[ ... ]

> @@ -3036,6 +3081,13 @@ ptp_ocp_fb_set_version(struct ptp_ocp *bp)
>  
>  	version = ioread32(&bp->image->version);
>  
> +	if (bp->wiwi) {
> +		/* Revision 02 defines capabilities; report the build ID. */
> +		bp->wiwi_image_id = version;
> +		bp->fw_cap = OCP_CAP_BASIC | OCP_CAP_SIGNAL | OCP_CAP_FREQ;
> +		return;
> +	}
> +
>  	/* if lower 16 bits are empty, this is the fw loader. */
>  	if ((version & 0xffff) == 0) {
>  		version = version >> 16;

[Severity: Low]
This early return skips the loader check below it. As a result,
bp->fw_loader is never set on WiWi, and ptp_ocp_devlink_info_get() always
picks "fw":

	fw_image = bp->fw_loader ? "loader" : "fw";

The fw row in Documentation/networking/devlink/ptp_ocp.rst still says the
version is reported as "loader" when the card runs the firmware loader. It
has no WiWi exception.

The new WiWi section describes a golden image at flash offset zero with
MultiBoot and watchdog fallback. If the card is running that fallback
image, would devlink report it as normal running "fw"? Should the
documentation say how that state is reported on WiWi, or should the
generic row note the exception?

[ ... ]

> @@ -3109,7 +3160,26 @@ ptp_ocp_register_resources(struct ptp_ocp *bp, kernel_ulong_t driver_data)
>  	int err = 0;
>  
>  	table = (struct ocp_resource *)driver_data;
> -	for (r = table; r->setup; r++) {
> +	for (; table->setup; table++) {
> +		struct ocp_resource translated = *table;
> +
> +		r = table;
> +		if (bp->wiwi) {
> +			/* GNSS2 is instantiated but not routed to FPGA pins. */
> +			if (r->setup == ptp_ocp_register_serial &&
> +			    r->bp_offset == offsetof(struct ptp_ocp,
> +						    port[PORT_GNSS2]))
> +				continue;

[Severity: Low]
The commit message says the PCI revision alone identifies the register
interface, and that "the Xilinx subsystem ID and FPGA build number do not
identify the register interface".

This skip applies to every revision 02 device. The only reason given is
"it is not wired on the tested production image", which is a single build
(0x0000800f).

If GNSS2 routing can differ between revision 02 builds, would a build that
does route it lose the GNSS2 tty without any log message or override? If
GNSS2 is never routed on revision 02, could the commit message and
documentation say so, instead of referring to the tested image?

[Severity: Low]
Only the GNSS2 UART is suppressed here. WiWi still uses ocp_fb_sma_op with
the shared ptp_ocp_sma_out table, which offers this as a selectable SMA
output source through sysfs and DPLL:

	{ .name = "GNSS2",	.value = 0x0008,  .frequency = 1 },

The debugfs summary also still decodes the MAC PPS2 source against it:

	gpio_input_map(buf, bp, sma_val, 1, "GNSS2");

The new documentation says GNSS2 "is not wired to pins". Can userspace on
WiWi select an SMA output source that has nothing behind it? Should GNSS2
also be removed from the WiWi SMA output choices?

[ ... ]

> @@ -5951,6 +6027,49 @@ ptp_ocp_sync_work(struct work_struct *work)

[ ... ]

> +/* The PCI revision identifies the register interface, not the FPGA build. */
> +static int ptp_ocp_wiwi_validate(struct pci_dev *pdev)
> +{
> +	u32 table, pba;
> +	int cap;
> +
> +	if (pdev->revision != 0x02)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "Unsupported WiWi PCI revision %#02x\n",
> +				     pdev->revision);

[Severity: Low]
Was "%#04x" or "0x%02x" intended here? With the # flag, the 0x prefix
counts toward the field width, so a width of 2 never pads. Revision 0x01
prints as 0x1, which differs from the two-digit form (02) used in the
documentation.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112163333.12523-1-ahmadexp%40gmail.com
