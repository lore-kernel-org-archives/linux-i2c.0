From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RESEND PATCH] i2c: ismt: Add Intel DNV PCI ID
Date: Fri, 08 Apr 2016 15:34:29 +0300
Message-ID: <1460118869.6620.54.camel@linux.intel.com>
References: <1460118583-134008-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:19210 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757AbcDHMdn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 8 Apr 2016 08:33:43 -0400
In-Reply-To: <1460118583-134008-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, scott.lawson@intel.com, alexandra.yates@intel.com, linux-i2c@vger.kernel.org

On Fri, 2016-04-08 at 15:29 +0300, Mika Westerberg wrote:
> Intel DNV has the same iSMT SMBus host controller than Intel Avoton.
> Add
> DNV PCI ID to the list of supported devices.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> Wolfram,
>=20
> This is the same patch that conflicted with another patch by Alexandr=
a
> [1].
> We have now verified that it is the iSMT driver that is compatible
> with
> this particular PCI ID (not i2c-i801.c). Not tested on a real hardwar=
e
> as I
> do not have such machine available.
>=20
> [1] https://patchwork.ozlabs.org/patch/584758/


=46or me seems that Mika is right and this is the right place to add th=
e
ID.

>=20
> =C2=A0drivers/i2c/busses/i2c-ismt.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-
> ismt.c
> index 7ba795b24e75..24c48e899a22 100644
> --- a/drivers/i2c/busses/i2c-ismt.c
> +++ b/drivers/i2c/busses/i2c-ismt.c
> @@ -76,6 +76,7 @@
> =C2=A0#define PCI_DEVICE_ID_INTEL_S1200_SMT0	0x0c59
> =C2=A0#define PCI_DEVICE_ID_INTEL_S1200_SMT1	0x0c5a
> =C2=A0#define PCI_DEVICE_ID_INTEL_AVOTON_SMT	0x1f15
> +#define PCI_DEVICE_ID_INTEL_DNV_SMT	0x19ac

Nit:
I still prefer to have IDs sorted by their values.

> =C2=A0
> =C2=A0#define ISMT_DESC_ENTRIES	2	/* number of descriptor
> entries */
> =C2=A0#define ISMT_MAX_RETRIES	3	/* number of SMBus retries
> to attempt */
> @@ -181,6 +182,7 @@ static const struct pci_device_id ismt_ids[] =3D =
{
> =C2=A0	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_INTEL_S1200_SMT0) },
> =C2=A0	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_INTEL_S1200_SMT1) },
> =C2=A0	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_INTEL_AVOTON_SMT) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_INTEL_DNV_SMT) },
> =C2=A0	{ 0, }
> =C2=A0};
> =C2=A0

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
