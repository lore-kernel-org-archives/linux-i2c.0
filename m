From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v10 3/8] i2c: thunderx: Add i2c driver for ThunderX SOC
Date: Tue, 23 Aug 2016 22:36:29 +0200
Message-ID: <20160823203628.GB20872@katana>
References: <cover.1465997603.git.jglauber@cavium.com>
 <1ead8831e4dd879d452e8bc1a2a33ccba3a74b3d.1465997604.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1ead8831e4dd879d452e8bc1a2a33ccba3a74b3d.1465997604.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Steven.Hill@caviumnetworks.com
List-Id: linux-i2c@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


>  i2c-octeon-objs :=3D i2c-cavium.o i2c-octeon-core.o
>  obj-$(CONFIG_I2C_OCTEON)	+=3D i2c-octeon.o
> +i2c-thunderx-objs :=3D i2c-cavium.o i2c-thunderx-core.o
> +obj-$(CONFIG_I2C_THUNDERX)	+=3D i2c-thunderx.o

Shouldn't that rather be "i2c-cavium-core.o", "i2c-octeon-platdrv.o",
and "i2c-thunderx-pcidrv.o" for the -objs? I mean, the cavium part is
the core-part...

> +skip:
> +	if (!i2c->sys_freq)
> +		i2c->sys_freq =3D SYS_FREQ_DEFAULT;
> +
> +	dev_info(dev, "Set system clock to %u\n", i2c->sys_freq);

Too many dev_info IMO, see later.

> +	i2c->adap.class =3D I2C_CLASS_HWMON | I2C_CLASS_SPD;

Do you really need that?

> +	ret =3D i2c_add_adapter(&i2c->adap);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to add i2c adapter\n");

I2C core does error reporting for you meanwhile.

> +		goto out_irq;
> +	}
> +
> +	dev_info(i2c->dev, "probed\n");

I'd think all nice to know dev_info should go here in condensed form.

> +out_irq:
> +	devm_free_irq(dev, i2c->i2c_msix.vector, i2c);

If you need to free irq manually here anyhow, then you don't need the
devm variant.

> +out_msix:
> +	pci_disable_msix(pdev);
> +out_unmap:
> +	iounmap(i2c->twsi_base);
> +	thunder_i2c_clock_disable(dev, i2c->clk);
> +out_release_regions:
> +	pci_release_regions(pdev);
> +out_disable_device:
> +	pci_disable_device(pdev);
> +out_free_i2c:
> +	pci_set_drvdata(pdev, NULL);

Similar to devm_*, there is also pcim_* for PCI devices. You might want
to have a look for those.

> +	devm_kfree(dev, i2c);

Not needed.

> +	return ret;
> +}
> +
> +static void thunder_i2c_remove_pci(struct pci_dev *pdev)
> +{
> +	struct octeon_i2c *i2c =3D pci_get_drvdata(pdev);
> +	struct device *dev;
> +
> +	if (!i2c)
> +		return;

How should that happen?

> +
> +module_pci_driver(thunder_i2c_pci_driver);
> +
> +MODULE_LICENSE("GPL");

Please add a minimal GPL header at the top of the file, so it is clear
if you mean "v2" or "v2 or later".

> +MODULE_AUTHOR("Fred Martin <fmartin@caviumnetworks.com>");
> +MODULE_DESCRIPTION("I2C-Bus adapter for Cavium ThunderX SOC");
> --=20
> 1.9.1
>=20

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXvLPMAAoJEBQN5MwUoCm2nDwQAJjvvCVvxZh1D9Hx4jsPXMmc
fFGlRT7tvDswuVRDknXto+QbLA/I7bxzUm+MTWKh6G4g0o0XBLsE/FdK6999ln3O
Az/HHa3b1EiWv5tKUQHogQc8a5mvwkRawBK0DngM3IwO3SNTbrCJ0x8Ci3rQrzTk
5OxnIgUII+Eyzfw8KeRMMVaCvnFWV1xFGW8gYJis4Yc20Z2bsDVJ9Saggu1YmNSv
P+8u/bx1xwzkz1/K2wToDZj9kCrH8MI/Q3Av7JfwhSZPn1Ehmu+CE9dUEqQvaEVh
ImZjnvhPccZNwXq9RIMR245+pJX6FqcnDXZ09UnlskXjEepUY2BmfTLM5LhbNPkd
5h0AfLGgARV2CoKPraNaIwzVNWLIEnP0gVcejupSVLLd6jBe1F6V89fsQhgHTfsq
wB9Frykwnu/SRuE7d7n3+pxPqdH6JYCPEJ2jJ3x6UmzJg047kFteOMRTlpdcLQcS
uYkZuuVXMyCzdvdnXV9D2letfVhhZJ9iA+V6QbemuC5B0vXF4Zk2gmQTgKYnf15R
08VLwUo6CvDqKBgmPg+Ol6LMXAI7A8OCqgRYJsCQlakwYd1bN2FcGBtpNNTZF/xd
42SFVTLvKu3KnxBS8fsdiZy89qmK0HB7qfVn1aoLDpDfBv/MFyLH60CW8gog6ULc
Bl2lAP0izTW9sp8beJJ5
=49Gu
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
