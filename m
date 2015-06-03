From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [V4, 1/2] i2c: brcmstb: Add Broadcom settop SoC i2c controller
 driver
Date: Thu, 4 Jun 2015 00:54:24 +0900
Message-ID: <20150603155423.GB2873@katana>
References: <1432052625-6210-1-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1432052625-6210-1-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, rajeevkumar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2015 at 12:23:44PM -0400, Kamal Dasu wrote:
> Adding support for i2c controller driver for Broadcom settop
> SoCs.
>=20
> Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

We are very close.

> +/* Wait for device to be ready */
> +static int brcmstb_i2c_wait_if_busy(struct brcmstb_i2c_dev *dev)
> +{
> +	unsigned long timeout =3D jiffies + msecs_to_jiffies(I2C_TIMEOUT);
> +
> +	while ((bsc_readl(dev, iic_enable) & BSC_IIC_EN_INTRP_MASK)) {
> +		if (time_after(jiffies, timeout)) {
> +			dev_err(dev->device, "i2c device busy timeout\n");

Don't print out, it will spoil the logs. Timeouts can happen on I2C
busses, no need to inform the user.

=2E..

> +	/* Wait for transaction to finish or timeout */
> +	rc =3D brcmstb_i2c_wait_for_completion(dev);
> +	if (rc) {
> +		dev_err(dev->device, "intr timeout for cmd %s\n",
> +			cmd_string[cmd]);
> +		goto cmd_out;
> +	}

ditto

> +
> +	if ((CMD_RD || CMD_WR) &&
> +	    bsc_readl(dev, iic_enable) & BSC_IIC_EN_NOACK_MASK) {
> +		rc =3D -EREMOTEIO;
> +		dev_dbg(dev->device, "controller received NOACK intr for %s\n",
> +			cmd_string[cmd]);

I'd leave this out, too. But you decide.

=2E..

> +	rc =3D of_property_read_string(dev->device->of_node, "interrupt-names",
> +				     &int_name);

I haven't checked but is that really needed? of_irq_to_resource() seems
to parse the "interrupt-names" property.

Thanks,

   Wolfram


--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbyMvAAoJEBQN5MwUoCm2MqkP/Rxhtuhxs0o5WMj98jNnhU5h
z222NRhq04lhLGE9ot186pi+lzJfNnWbIq14VqtIK5hpa3klxSlDecnRe3U1/fyY
hIMJ3G+1XFHIOzoiZkeu0d93WaZrhxY14ezExWLtEsAxgpxrkzwHHSFZNRKwtDbV
7+CkeYIvDl2A9QvFyZmTBzccstr7P+sD9XcLz9SlnShmukWfxPzNKsnoBqMPaNhG
9ph3nroqql0fXmumQgxoi8tL3s9zv5rtzIbU/EH8xpb9g29HLIbO/JaRwf/i72yg
LOyGLp6V/zt7MBVv2BcPTNPk6cz5e7WlfE0eZJNftEuQ8PhjnwBkHxKXlsssDiaS
uC4gMNHHzDpAmR+Pl/AjYxqJ07hSRJ0j+S3zs0BnpdpLJp+DY0UXNzu7DNtx1ewr
r2sdEJXAfhukUmBUIrIcIU6f+WPULesllTlFBqC4XGDhTT87XLwTtitZIqIGf5kj
ZUu/0dp/73EqOdaoo+Pz8HBmi3JSmHeHDLzCpNUPvGo+UbEerQXJygcDK+wXhtC0
AYd/u8abd49IUTkRQX1va0HG7KFqKg/wfkgdyuG3QplyKEp7CC6LsskoPjXrl7uG
aG9N8g2poSWpeE2ITuCA5FOMZRtyPFG/GA8NyhUSJVEYAoULpNzx/3ZQoA57YxQ2
NqqzgzZXjwkCU35KFID1
=1nSY
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
