From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: xgene-slimpro: Add ACPI support by using PCC
 mailbox
Date: Thu, 20 Apr 2017 10:05:52 +0200
Message-ID: <20170420080552.7hymw4gqy4kzecns@ninjato>
References: <1490733977-23760-1-git-send-email-hotran@apm.com>
 <1490733977-23760-3-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ooc5deqzjawzas2w"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:47551 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941360AbdDTIFz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 20 Apr 2017 04:05:55 -0400
Content-Disposition: inline
In-Reply-To: <1490733977-23760-3-git-send-email-hotran@apm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hoan Tran <hotran@apm.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Loc Ho <lho@apm.com>, Keyur Chudgar <kchudgar@apm.com>


--ooc5deqzjawzas2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

have you tested these patches also without PCC? So, we can be sure there
is no regression?

> diff --git a/drivers/i2c/busses/i2c-xgene-slimpro.c b/drivers/i2c/busses/=
i2c-xgene-slimpro.c
> index 96545aa..a5771c1 100644
> --- a/drivers/i2c/busses/i2c-xgene-slimpro.c
> +++ b/drivers/i2c/busses/i2c-xgene-slimpro.c
> @@ -32,6 +32,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/version.h>
> =20
> +#include <acpi/pcc.h>
> +

Please keep it sorted alphabetically.

> +#define PCC_CMD_GENERATE_DB_INT		BIT(15)
> +#define PCC_STS_CMD_COMPLETE		BIT(0)
> +#define PCC_STS_SCI_DOORBELL		BIT(1)
> +#define PCC_STS_ERR			BIT(2)
> +#define PCC_STS_PLAT_NOTIFY		BIT(3)

Please keep it sorted by number.

> +	if (!acpi_disabled) {
> +		mutex_lock(&ctx->tx_mutex);
> +		init_completion(&ctx->rd_complete);

reinit_completion?

> +		slimpro_i2c_pcc_tx_prepare(ctx, msg);
> +	}
> +
> +	mutex_init(&ctx->tx_mutex);

Why this mutex, by the way? The i2c-core serializes access to the
adapter. Maybe I am missing something?

> +		cppc_ss =3D ctx->mbox_chan->con_priv;
> +		if (!cppc_ss) {
> +			dev_err(&pdev->dev, "PPC subspace not found\n");
> +			rc =3D -ENODEV;
> +			goto mbox_err;
> +		}
> +
> +		if (!ctx->mbox_chan->mbox->txdone_irq) {
> +			dev_err(&pdev->dev, "PCC IRQ not supported\n");
> +			rc =3D -ENODEV;
> +			goto mbox_err;
> +		}
> =20
> +		/*
> +		 * This is the shared communication region
> +		 * for the OS and Platform to communicate over.
> +		 */
> +		ctx->comm_base_addr =3D cppc_ss->base_address;
> +		if (ctx->comm_base_addr) {
> +			ctx->pcc_comm_addr =3D memremap(ctx->comm_base_addr,
> +						      cppc_ss->length,
> +						      MEMREMAP_WB);
> +		} else {
> +			dev_err(&pdev->dev, "Failed to get PCC comm region\n");
> +			rc =3D -ENODEV;
> +			goto mbox_err;
> +		}

I think it doesn't make sense to print a dev_err and return ENODEV which
is treated by the driver core as a non-error. It means "not present, but
OK". You probably want other error codes here.

Regards,

   Wolfram


--ooc5deqzjawzas2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlj4a9wACgkQFA3kzBSg
KbaTJA//Y5codW96eHYMY3Muvlj5z2L1KX6NtN3lKro6HoDEHLsNN/Vki5cwG+ip
qtdWkz+iwW6/TL7FJ8enPKObowraXUsOLUIXKghrEKRHVc9xOLCx1PMarKzdMJfl
QMAdzM4bBATz8mmbAP6hCp9cv8mURFM6c/Kw24Pw3RCDNBKZe6baBsPgjShmQcsG
arUfGNoakhSTrIFwCJecI9hX/M+n+bUPQBRKJqyLXSFjy/eND1as2E6IoczZI/wr
xx14iYQi0mfqGVFJP+hiU9wC8rerG/0kAzdIVgmIDpjKGUCz0Oc3FtamMp7wq+VP
Er2Wya0+ycT2aYn0Z3KgLaNElkZVXSC0mU1VsrqtUbeKOHypNh1qIDwQNT4E9f9l
DElDxJFisl0K3HnmvGdoroLox3neDFkZRV1yHxKT5Uc+3Ja+xK+vXZiNqYhpVrYx
MM+2VSWvmDeurWN5TPWmK0bN/UlzFNjLimm3fY+qUZCLhTEWjpBPdsyFw0IOiyvz
ouNmFstobGmw8JEJeaRIK8obEMC2KpsfdDtw2Fu0HSP4Mz7FniKK4impfQg0VmH3
dYxYXkXAwfMm2rFfafLlPI5VG1PCgpPeQPXBm4mYtwJhmrpCXwlwe2FvQ5GMWz78
bJQeY3noVbZGl65FknZ0KGzKvgro76VIdVVXNW5iD+0l5DlUc+4=
=93cc
-----END PGP SIGNATURE-----

--ooc5deqzjawzas2w--
