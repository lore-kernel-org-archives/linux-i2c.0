From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 6/6] i2c: use an IRQ to report Host Notify events, not
 alert
Date: Mon, 7 Nov 2016 01:20:35 +0100
Message-ID: <20161107002034.GB1442@katana>
References: <1476360640-12901-1-git-send-email-benjamin.tissoires@redhat.com>
 <1476360640-12901-7-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47684 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbcKGAUk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 6 Nov 2016 19:20:40 -0500
Content-Disposition: inline
In-Reply-To: <1476360640-12901-7-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 13, 2016 at 02:10:40PM +0200, Benjamin Tissoires wrote:
> The current SMBus Host Notify implementation relies on .alert() to
> relay its notifications. However, the use cases where SMBus Host
> Notify is needed currently is to signal data ready on touchpads.
>=20
> This is closer to an IRQ than a custom API through .alert().
> Given that the 2 touchpad manufacturers (Synaptics and Elan) that
> use SMBus Host Notify don't put any data in the SMBus payload, the
> concept actually matches one to one.

I see the advantages. The only question I have: What if we encounter
devices in the future which do put data in the payload? Can this
mechanism be extended to handle that?

>=20
> Benefits are multiple:
> - simpler code and API: the client will just have an IRQ, and
>   nothing needs to be added in the adapter beside internally
>   enabling it.
> - no more specific workqueue, the threading is handled by IRQ core
>   directly (when required)
> - no more races when removing the device (the drivers are already
>   required to disable irq on remove)
> - simpler handling for drivers: use plain regular IRQs
> - no more dependency on i2c-smbus for i2c-i801 (and any other adapter)
> - the IRQ domain is created automatically when the adapter exports
>   the Host Notify capability
> - the IRQ are assign only if ACPI, OF and the caller did not assign
>   one already
> - the domain is automatically destroyed on remove
> - fewer lines of code (minus 20, yeah!)
>=20
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks for keeping at it!


--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYH8jSAAoJEBQN5MwUoCm2S3YQAKGvnIGT1nT+V6hEGnvBkDbz
xy21e4q7uDtY9Nq7ZpkxiSosCmgGRbduA+C9IaC9NWXI9bYrG1yNy8oH7iIUuY4R
/NCtlGxTi2IJr7r3wDTxJw4PYxa1L02zPu+4Jq5zkHm/tjK7UAwmHSn2lNT5peEt
QQ1SByeToFIBHL3xebryFs86gl2W5UFIf5HBVdCpNdIQQqQVO0Ay7dbqAzeLamzE
Kq/CobohYV+RdBbYpBPNXWlwbLmdspJpEpyAwaxgStMJJvavaMVe6hWs/lSNlKSQ
xBz8hQKqtvL48XUg6FL1aKlwMCVXznM784AViCB3MIIq84X9CHCn1tkNMAuowR5U
W4mUEXIqZ8rBXDd+RxAutH/eyIeCj2hdAU37lf/BRuB96DbCrpJLZvhgD1i7ov7s
Nmiuv2LvMH+U5joTjvnjyCKhFEOm2XSnjDnCL5lsUd3+5hUrPvcCovcdlj5daYAF
epH+KLMdomysbPUHcdFvOKfnX7xjPkg2pJaqv5SW2+mBZ9l0OC2O66Co7cunqEUl
30CZ4X7o+SGvsB+2S9ihklJu9AxMHBdtXlOp1yOmRdSWMIGF0549uum5MtPSvYw0
9+ZNx6hb27ndr+9I30W6F8Nb4xMSEtiL+7EFq12Faz4iBJAIy1H2tPzb1i7QYOEr
AEDrwmpuzIyPL8dhRyF9
=Hzgg
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
