From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/7] i2c: Add the ability to match device to compatible
 string without an of_node
Date: Fri, 6 Jun 2014 09:10:26 +0100
Message-ID: <20140606081026.GO24240@lee--X1>
References: <1401883796-17841-1-git-send-email-lee.jones@linaro.org>
 <1401883796-17841-4-git-send-email-lee.jones@linaro.org>
 <20140605173620.5BDFBC41CBF@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140605173620.5BDFBC41CBF-WNowdnHR2B42iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 05 Jun 2014, Grant Likely wrote:

> On Wed,  4 Jun 2014 13:09:52 +0100, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> =
wrote:
> > A great deal of I2C devices are currently matched via DT node name,=
 and
> > as such the compatible naming convention of '<vendor>,<device>' has=
 gone
> > somewhat awry - some nodes don't supply one, some supply an arbitra=
ry
> > string and others the correct device name with an arbitrary vendor =
prefix.
> >=20
> > In an effort to correct this problem we have to supply a mechanism =
to
> > match a device by compatible string AND by simple device name.  Thi=
s
> > function strips off the '<vendor>,' part of a supplied compatible s=
tring
> > and attempts to match without it.
> >=20
> > The plan is to remove this function once all of the compatible stri=
ngs
> > for each device have been brought into line.
> >=20
> > Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > ---
> >  drivers/i2c/i2c-core.c | 25 +++++++++++++++++++++++++
> >  include/linux/i2c.h    | 10 ++++++++++
> >  2 files changed, 35 insertions(+)
> >=20
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index d3802dc..7dcd5c3 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -1090,6 +1090,31 @@ struct i2c_adapter *of_find_i2c_adapter_by_n=
ode(struct device_node *node)
> >  	return i2c_verify_adapter(dev);
> >  }
> >  EXPORT_SYMBOL(of_find_i2c_adapter_by_node);
> > +
> > +const struct of_device_id
> > +*i2c_of_match_device_strip_vendor(const struct of_device_id *match=
es,
> > +				  struct device *dev)
> > +{
> > +	const struct i2c_client *client =3D i2c_verify_client(dev);
> > +	const char *name;
> > +
> > +	if (!(client && matches))
> > +		return NULL;
> > +
> > +	for (; matches->compatible[0]; matches++) {
> > +		name =3D strchr(matches->compatible, ',');
> > +		if (!name)
> > +			name =3D matches->compatible;
> > +		else
> > +			name++;
> > +
> > +		if (!strncmp(client->name, name, strlen(client->name)))
> > +			return matches;
> > +	}
>=20
> Is it actually necessary to strip off the vendor name? It would be fi=
ne
> to make users include the vendor prefix when creating the device in
> sysfs. In fact that would be preferrable for new drivers so that vend=
or
> prefixes start getting used correctly.

I see a few issues with this strategy.  Firstly, there are already
users registering their devices via sysfs, some are taking their
device names from an EEPROM which would require reprogramming in order
to prefix the vendor ID.  I'm keen not to break existing systems -
which not stripping off the vendor name would inevitably do.
Secondly, I'm not sure how Wolfram would feel about the client->name
containing a DT compatible string. And finally, other than looking
at the kernel source, there is no real way for a user to know if the
device supports ACPI or OF, or neither and if an i2c_device_table is
supplied or not.

Remember that the idea of this set is to remove i2c_device_table's,
doing so will break any devices which are still registering via sysfs
with only the model number of the device.  I think the sysfs
interface should be a black-box.  I think requiring users to have
kernel knowledge is a sub-optimal idea.

> If you're worried about preserving exisiting ABI, then I would make
> striping the prefix an option that drivers can enable, but by default
> only match on the full string.
>=20
> g.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
