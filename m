From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] i2c: i2c-tiny-usb: fix buffer not being DMA capable
Date: Thu, 4 May 2017 17:50:00 +0200
Message-ID: <20170504155000.jeo7r5mivzjfnp2o@earth>
References: <20170504125632.7034-1-sebastian.reichel@collabora.co.uk>
 <20170504152709.GA15119@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tkeluo6z37q4lfvn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170504152709.GA15119@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Till Harbaum <till@harbaum.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "# Kernel 4 . 9+" <stable@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--tkeluo6z37q4lfvn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Thu, May 04, 2017 at 08:27:09AM -0700, Greg KH wrote:
> On Thu, May 04, 2017 at 02:56:32PM +0200, Sebastian Reichel wrote:
> > The i2c-tiny-usb driver generates the following trace and fails to
> > read or write data on a v4.9 or newer kernels. This patch avoids the
> > problem by allocating a DMA capable buffer for data transfer.
> >=20
> > [   17.504959] ------------[ cut here ]------------
> > [   17.505488] WARNING: CPU: 0 PID: 93 at drivers/usb/core/hcd.c:1587 u=
sb_hcd_map_urb_for_dma+0x37c/0x570
> > [   17.506545] transfer buffer not dma capable
> > [   17.507022] Modules linked in:
> > [   17.507370] CPU: 0 PID: 93 Comm: i2cdetect Not tainted 4.11.0-rc8+ #=
10
> > [   17.508103] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.10.2-1 04/01/2014
> > [   17.509039] Call Trace:
> > [   17.509320]  ? dump_stack+0x5c/0x78
> > [   17.509714]  ? __warn+0xbe/0xe0
> > [   17.510073]  ? warn_slowpath_fmt+0x5a/0x80
> > [   17.510532]  ? nommu_map_sg+0xb0/0xb0
> > [   17.510949]  ? usb_hcd_map_urb_for_dma+0x37c/0x570
> > [   17.511482]  ? usb_hcd_submit_urb+0x336/0xab0
> > [   17.511976]  ? wait_for_completion_timeout+0x12f/0x1a0
> > [   17.512549]  ? wait_for_completion_timeout+0x65/0x1a0
> > [   17.513125]  ? usb_start_wait_urb+0x65/0x160
> > [   17.513604]  ? usb_control_msg+0xdc/0x130
> > [   17.514061]  ? usb_xfer+0xa4/0x2a0
> > [   17.514445]  ? __i2c_transfer+0x108/0x3c0
> > [   17.514899]  ? i2c_transfer+0x57/0xb0
> > [   17.515310]  ? i2c_smbus_xfer_emulated+0x12f/0x590
> > [   17.515851]  ? _raw_spin_unlock_irqrestore+0x11/0x20
> > [   17.516408]  ? i2c_smbus_xfer+0x125/0x330
> > [   17.516876]  ? i2c_smbus_xfer+0x125/0x330
> > [   17.517329]  ? i2cdev_ioctl_smbus+0x1c1/0x2b0
> > [   17.517824]  ? i2cdev_ioctl+0x75/0x1c0
> > [   17.518248]  ? do_vfs_ioctl+0x9f/0x600
> > [   17.518671]  ? vfs_write+0x144/0x190
> > [   17.519078]  ? SyS_ioctl+0x74/0x80
> > [   17.519463]  ? entry_SYSCALL_64_fastpath+0x1e/0xad
> > [   17.519959] ---[ end trace d047c04982f5ac50 ]---
> >=20
> > Cc: <stable@vger.kernel.org> # Kernel 4.9+
>=20
> This has been a USB core requirement since the 2.2 days, it's only since
> 4.9 that most people have started to notice this.  So backporting it to
> anything that it can go to is best to have happen :)

I intentionally did not add a "Fixes:" for the commit in 4.9, since
I assumed that to be the case (did not bisect to the commit either).
OTOH the driver worked before v4.9, so I thought I would reduce your
(and the other backporters) workload - users won't care.

Looks like it added more work now, so I will drop the comment in
PATCHv2 and leave it to stable porters figuring out if they want
to backport it.

> > +	void *dmadata =3D kmalloc(len, GFP_KERNEL);
> > +	void *dmadata =3D kmemdup(data, len, GFP_KERNEL);
>=20
> No error checking?

Coming in PATCHv2.

-- Sebastian

--tkeluo6z37q4lfvn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkLTagACgkQ2O7X88g7
+prKNA//fnptxW8dmaylb4i1IUIFxdedaeL2rlfWbJNwfgzCCWG2aLO/5Eskgx8x
9CWbyZYtoHDPIr33bB1fALijN4ucxyIaMxKmcPV+trC3ZFTJQcovjW+QCjsfW+FD
uTAdieDpLqTNDHaIJJmzqdT+b1uPf2k08kVUtqPSrUkx5PsV1Vh2LzIge6ORAxN+
1rQF1na3+D0lKifrmgfOMWlLsFy0uq1q87jDlJBOApMIs4WHyuMv87Q3ejxXEXiF
wf7+7Q32zuYQQj+4eurJ932YalBi3WBC10ji/5iknu9B9R4/NE1vOQwaisFDSgwy
i/7+M61A8PQWyNgxubHb/Tn46Adqcyn0Ix142nb6gYUqLvGe9wFnGcrae1FOAFgM
OioLOXKzFgVaAkwKUK2kHcRRkvwyGewDbUrwmSG+8ArbnpG8iZAgliHH6aARIm5O
BcISWt2MXd4Bq9ZZddWpGS1xGucJilx1EWKcbtMxx/5rgGWFCFdP6nGlyjSx9MgV
lgP35Otc0rnW1nkJXbYPzj/9En8ed/602q95RHw0tPhwn6cbybCIPTVAG3n6fVS4
HDunoEVNsO44UImSUARt3iL5qRj2ARPi+1TIVIBKYv3WHen2bMx0mdLCzaIDyrfW
sZmsP02EDyFNz6GwRGPTMI3CT08WPadlDkT7eU+QZ9eX8SbET4E=
=uAC9
-----END PGP SIGNATURE-----

--tkeluo6z37q4lfvn--
