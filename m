Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6203E3D85;
	Tue,  6 Oct 2026 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283014; cv=none; b=TOrNAPahVNLnmwiF/dZkXgKsogBCy5PEhGVw+S3oVlkS0tmvBzzLc0fPBVoCPOAZN9Ko/5tDFrVWp8pTX6YjPOEx4mB9jMQAsVzO/XJ/HPQV9N21CssDhVHj9LuqnbJTtp5NVvdZ3CskLK0OqKb9UQbAwqABE0fDARg7y9SIBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283014; c=relaxed/simple;
	bh=e6gYyp+VVMvIE+cIP6zSd7UI+UVp7o8gYbgGORFvP1E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ELrr25h/6YKggZPCzSwuLTXbXpmr5Lehn6UDtsqtJfx4CQj/jgLKRNkHgiZbRlrjBej/2qJSwSUdrrtqLwaTYgCIlfMYiukPkihFZwifH3y4XS0+WJQxTvs2FIgkafXxpuzoj96q+47c5o1ElDD91yrIJKNmu6kRiJ3uH72Be6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=JbJ/bCml; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="JbJ/bCml"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1791282696;
	bh=wsO0jS6a66JvPvsOoDsKXWVw4FZJxwvwMdr7oGG4z/0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JbJ/bCmlRsk4tWD+y0fgOU2RFqndvujfPoxyLXKIB2QpzMDoNrTScBjb5Rs4sNG1D
	 sgVuAfzeAXi8OlUQDPP3StnIz17bZOiEkf5lxSzFmjEkugGL8RBuvEkJLXYqgTD4XX
	 WHTwyS4pZk+zhJiop+tGrZfJeKypHEMa+abJHviSNaV7BIa0BS7t5JQN7TJkpRhrmm
	 tgkeoRM5ANHEXM/m38SXpkNoy1Uvtw6vMC4AofA1CcfZafMnx1dTTpPwnNNVVWU7Tv
	 ZebxAcINgVaK4NGjKxqv8O8vcakwmSmP5DHn5siy1EnNwISAgDIqVOudPdqdb3JXZA
	 zYI8fRuqGSH7g==
Received: from [192.168.14.220] (unknown [144.6.157.237])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E7A4C6E97D;
	Tue,  6 Oct 2026 18:31:33 +0800 (AWST)
Message-ID: <a1e2d7c0644234bd66b806134f7b803af741aa74.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next] mctp i2c: add sysfs control for mux child
 netdevs
From: Matt Johnston <matt@codeconstruct.com.au>
To: Kenny Hsieh <kenny_hsieh@jabil.com>, netdev@vger.kernel.org, Jeremy Kerr
	 <jk@codeconstruct.com.au>, Andi Shyti <andi.shyti@kernel.org>, Peter Rosin
	 <peda@lysator.liu.se>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet	
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	
 <pabeni@redhat.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 06 Oct 2026 18:31:33 +0800
In-Reply-To: <20261002073156.759005-1-kenny_hsieh@jabil.com>
References: <20261002073156.759005-1-kenny_hsieh@jabil.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Kenny,

Thanks for this patch. The sashiko concerns look plausible. I've added a fe=
w
other thoughts.=C2=A0
(Disclosure, I suggested this sysfs approach to Kenny earlier).

On Fri, 2026-10-02 at 15:31 +0800, Kenny Hsieh wrote:
> An MCTP netdev is created for an I2C bus that carries an
> "mctp-controller" property in the devicetree. A bus instantiated at
> runtime through the I2C sysfs interface has no devicetree node on which
> to set that property, so it can never get a netdev.
>=20
> This matters for a mux topology that is only known at runtime. A BMC
> that ships one firmware image across several chassis cannot describe
> every chassis's mux tree in its devicetree. Userspace creates the muxes
> it finds over i2c sysfs instead, and the channels below them have no
> node of their own.
>=20
> Add a writable "mctp_controller" attribute on mux child adapters below
> a bus that has an mctp-i2c-controller device bound to it. A mux tree
> with no such device is untouched. Writing 1 creates the netdev for that
> bus, writing 0 removes it, and reading reports whether one exists.
> Userspace can then enable MCTP per channel once it has created the
> muxes.
>=20
> The root adapter is excluded: its netdev follows the bound
> mctp-i2c-controller device rather than this attribute, so a write there
> returns -EINVAL. The devicetree property keeps working, and both
> mechanisms may be used on the same mux tree.

It might make sense to create the mctp_controller sysfs attribute for root
adapters too, so the root bus mctpi2c netdev can be removed at runtime. It
would probably remove some special-casing for the root node too.

> The netdev is placed in the network namespace the mctp-i2c-controller
> device was probed in, not the one that writes the attribute, since the
> attribute is visible in every namespace.

Perhaps creating/removing a netdev should only be permitted when the curren=
t
process matches the mctp-i2c-controller network namespace. There could be
unforseen results creating a netdev in a different namespace? The restricti=
on
could be relaxed later if needed and is deemed safe.

> Only one mctp-i2c-controller client is allowed per mux tree. A second
> one would add the same attribute to every child adapter again, and
> either client's removal would delete the attribute the other still
> needs.

This is a bit redundant given mctp-i2c-controller client will already only
bind to root adapters?

> Tested on an AST2700 BMC with a nested mux tree by writing 1 to
> mctp_controller on a channel that has no "mctp-controller" property,
> which brings up the interface, then writing 0, which removes it. The
> attribute also survives an unbind and rebind of the
> mctp-i2c-controller driver.
>=20
> Signed-off-by: Kenny Hsieh <kenny_hsieh@jabil.com>
> ---
>  .../ABI/testing/sysfs-bus-i2c-devices-mctp    |  26 ++
>  MAINTAINERS                                   |   1 +
>  drivers/net/mctp/mctp-i2c.c                   | 256 +++++++++++++++---
>  3 files changed, 242 insertions(+), 41 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp b/Docum=
entation/ABI/testing/sysfs-bus-i2c-devices-mctp
> new file mode 100644
> index 000000000000..a04bc30aa7b5
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp
> @@ -0,0 +1,26 @@
> +What:		/sys/bus/i2c/devices/i2c-<n>/mctp_controller
> +Date:		October 2026
> +KernelVersion:	7.4
> +Contact:	Kenny Hsieh <kenny_hsieh@jabil.com>
> +Description:
> +		Controls whether an MCTP network device exists for this I2C
> +		bus. Writing 1 creates it, writing 0 removes it, and reading
> +		returns 1 while it exists. Writing a value that matches the
> +		current state is a no-op.
> +
> +		The attribute appears only on mux child busses whose mux tree
> +		root has an mctp-i2c-controller device bound to it. The root
> +		bus itself is excluded, because its network device follows
> +		that mctp-i2c-controller device rather than this attribute.
> +
> +		A bus described in the devicetree can carry an
> +		"mctp-controller" property instead, which creates the network
> +		device when the mctp-i2c-controller device probes. This
> +		attribute covers busses instantiated at runtime through the
> +		I2C sysfs interface, which have no devicetree node on which to
> +		set that property. Both mechanisms may be used on the same mux
> +		tree.
> +
> +		Removal is synchronous and does not drain traffic: queued
> +		packets are discarded and in-flight requests fail, so a
> +		requester sees a timeout rather than an error.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3011f995437f..1ba32f61a21a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15718,6 +15718,7 @@ M:	Jeremy Kerr <jk@codeconstruct.com.au>
>  M:	Matt Johnston <matt@codeconstruct.com.au>
>  L:	netdev@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp
>  F:	Documentation/networking/mctp.rst
>  F:	drivers/net/mctp/
>  F:	include/linux/usb/mctp-usb.h
> diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
> index b02476d338bb..d4da32656744 100644
> --- a/drivers/net/mctp/mctp-i2c.c
> +++ b/drivers/net/mctp/mctp-i2c.c
> @@ -22,6 +22,8 @@
>  #include <linux/i2c.h>
>  #include <linux/i2c-mux.h>
>  #include <linux/if_arp.h>
> +#include <linux/sysfs.h>
> +#include <linux/nsproxy.h>
>  #include <net/mctp.h>
>  #include <net/mctpdevice.h>
> =20
> @@ -89,6 +91,10 @@ struct mctp_i2c_dev {
>  struct mctp_i2c_client {
>  	struct i2c_client *client;
>  	u8 lladdr;
> +	/* Namespace the controller was probed in. Netdevs are created here
> +	 * regardless of which namespace writes the mctp_controller attribute.
> +	 */
> +	possible_net_t net;
> =20
>  	struct mctp_i2c_dev *sel;
>  	struct list_head devs;
> @@ -128,7 +134,7 @@ static struct i2c_adapter *mux_root_adapter(struct i2=
c_adapter *adap)
>   */
>  static struct mctp_i2c_client *mctp_i2c_new_client(struct i2c_client *cl=
ient)
>  {
> -	struct mctp_i2c_client *mcli =3D NULL;
> +	struct mctp_i2c_client *mcli =3D NULL, *m =3D NULL;
>  	struct i2c_adapter *root =3D NULL;
>  	int rc;
> =20
> @@ -154,6 +160,21 @@ static struct mctp_i2c_client *mctp_i2c_new_client(s=
truct i2c_client *client)
>  		goto err;
>  	}
> =20
> +	/* One client per mux tree. A second one would add the same
> +	 * mctp_controller attribute to every child adapter again, and either
> +	 * client's removal would delete the attribute the other still needs.
> +	 */
> +	WARN_ON(!mutex_is_locked(&driver_clients_lock));
> +	list_for_each_entry(m, &driver_clients, list) {
> +		if (m->client->adapter =3D=3D root) {
> +			dev_err(&client->dev,
> +				"An mctp-i2c-controller client is already attached to adapter %s\n",
> +				root->name);
> +			rc =3D -EBUSY;
> +			goto err;
> +		}
> +	}
> +
>  	mcli =3D kzalloc_obj(*mcli);
>  	if (!mcli) {
>  		rc =3D -ENOMEM;
> @@ -163,6 +184,7 @@ static struct mctp_i2c_client *mctp_i2c_new_client(st=
ruct i2c_client *client)
>  	INIT_LIST_HEAD(&mcli->devs);
>  	INIT_LIST_HEAD(&mcli->list);
>  	mcli->lladdr =3D client->addr & 0xff;
> +	write_pnet(&mcli->net, current->nsproxy->net_ns);
>  	mcli->client =3D client;
>  	i2c_set_clientdata(client, mcli);
> =20
> @@ -857,6 +879,25 @@ static int mctp_i2c_ndo_open(struct net_device *dev)
>  	return 0;
>  }
> =20
> +/* Returns the netdev for adap, or NULL if there is none */
> +static struct mctp_i2c_dev *mctp_i2c_find_dev(struct mctp_i2c_client *mc=
li,
> +					      struct i2c_adapter *adap)
> +{
> +	struct mctp_i2c_dev *midev =3D NULL, *m =3D NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&mcli->sel_lock, flags);
> +	/* List size is limited by number of MCTP netdevs on a single hardware =
bus */
> +	list_for_each_entry(m, &mcli->devs, list)
> +		if (m->adapter =3D=3D adap) {
> +			midev =3D m;
> +			break;
> +		}
> +	spin_unlock_irqrestore(&mcli->sel_lock, flags);
> +
> +	return midev;
> +}
> +
>  static int mctp_i2c_add_netdev(struct mctp_i2c_client *mcli,
>  			       struct i2c_adapter *adap)
>  {
> @@ -883,7 +924,12 @@ static int mctp_i2c_add_netdev(struct mctp_i2c_clien=
t *mcli,
>  		rc =3D -ENOMEM;
>  		goto err;
>  	}
> -	dev_net_set(ndev, current->nsproxy->net_ns);
> +	/* Tie the netdev to the namespace the mctp-i2c-controller device was
> +	 * probed in, not to whoever happens to write mctp_controller. A write
> +	 * from another namespace must not place the netdev there, since the
> +	 * attribute is visible in all of them.
> +	 */
> +	dev_net_set(ndev, read_pnet(&mcli->net));
>  	SET_NETDEV_DEV(ndev, &adap->dev);
>  	dev_addr_set(ndev, &mcli->lladdr);
> =20
> @@ -920,18 +966,10 @@ static int mctp_i2c_add_netdev(struct mctp_i2c_clie=
nt *mcli,
>  static void mctp_i2c_remove_netdev(struct mctp_i2c_client *mcli,
>  				   struct i2c_adapter *adap)
>  {
> -	struct mctp_i2c_dev *midev =3D NULL, *m =3D NULL;
> -	unsigned long flags;
> +	struct mctp_i2c_dev *midev =3D NULL;
> =20
>  	WARN_ON(!mutex_is_locked(&driver_clients_lock));
> -	spin_lock_irqsave(&mcli->sel_lock, flags);
> -	/* List size is limited by number of MCTP netdevs on a single hardware =
bus */
> -	list_for_each_entry(m, &mcli->devs, list)
> -		if (m->adapter =3D=3D adap) {
> -			midev =3D m;
> -			break;
> -		}
> -	spin_unlock_irqrestore(&mcli->sel_lock, flags);
> +	midev =3D mctp_i2c_find_dev(mcli, adap);
> =20
>  	if (midev)
>  		mctp_i2c_unregister(midev);
> @@ -968,6 +1006,121 @@ static bool mctp_i2c_adapter_match(struct i2c_adap=
ter *adap, bool match_no_of)
>  	return of_property_read_bool(adap->dev.of_node, MCTP_I2C_OF_PROP);
>  }
> =20
> +/* Returns the client owning @root's mux tree, or NULL.
> + * Call with driver_clients_lock held. The returned pointer is only vali=
d
> + * while that lock is held.
> + */
> +static struct mctp_i2c_client *mctp_i2c_find_client(struct i2c_adapter *=
root)
> +{
> +	struct mctp_i2c_client *mcli =3D NULL;
> +
> +	WARN_ON(!mutex_is_locked(&driver_clients_lock));
> +	list_for_each_entry(mcli, &driver_clients, list)
> +		if (mcli->client->adapter =3D=3D root)
> +			return mcli;
> +
> +	return NULL;
> +}
> +
> +/* A bus instantiated at runtime has no devicetree node on which to set =
the
> + * "mctp-controller" property, so this attribute is how userspace asks f=
or its
> + * netdev once the adapter exists.
> + */
> +static ssize_t mctp_controller_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_adapter *root =3D NULL, *adap =3D NULL;
> +	struct mctp_i2c_client *mcli;
> +	bool present =3D false;
> +
> +	adap =3D mctp_i2c_get_adapter(dev, &root);
> +	if (!adap)
> +		return -ENODEV;
> +
> +	mutex_lock(&driver_clients_lock);
> +	mcli =3D mctp_i2c_find_client(root);
> +	if (mcli)
> +		present =3D mctp_i2c_find_dev(mcli, adap);
> +	mutex_unlock(&driver_clients_lock);
> +
> +	return sysfs_emit(buf, "%d\n", present);
> +}
> +
> +static ssize_t mctp_controller_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	struct i2c_adapter *root =3D NULL, *adap =3D NULL;
> +	struct mctp_i2c_client *mcli;
> +	bool enable;
> +	int rc;
> +
> +	rc =3D kstrtobool(buf, &enable);
> +	if (rc < 0)
> +		return rc;
> +
> +	adap =3D mctp_i2c_get_adapter(dev, &root);
> +	if (!adap)
> +		return -ENODEV;
> +
> +	/* The root adapter's netdev follows the mctp-i2c-controller client
> +	 * itself, so it is not ours to add or remove here.
> +	 */
> +	if (adap =3D=3D root)
> +		return -EINVAL;
> +
> +	mutex_lock(&driver_clients_lock);
> +	mcli =3D mctp_i2c_find_client(root);
> +	if (!mcli) {
> +		/* No mctp-i2c-controller on this mux tree's root */
> +		rc =3D -ENODEV;
> +		goto out;
> +	}
> +
> +	if (enable) {
> +		if (mctp_i2c_find_dev(mcli, adap))
> +			rc =3D 0;	/* Already present, nothing to do */
> +		else
> +			rc =3D mctp_i2c_add_netdev(mcli, adap);
> +	} else {
> +		mctp_i2c_remove_netdev(mcli, adap);
> +		rc =3D 0;
> +	}
> +out:
> +	mutex_unlock(&driver_clients_lock);
> +
> +	return rc < 0 ? rc : count;
> +}
> +
> +static DEVICE_ATTR_RW(mctp_controller);
> +
> +static struct attribute *mctp_i2c_adapter_attrs[] =3D {
> +	&dev_attr_mctp_controller.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group mctp_i2c_adapter_group =3D {
> +	.attrs =3D mctp_i2c_adapter_attrs,
> +};
> +
> +/* The root adapter is skipped: its netdev follows the bound client. The=
 group
> + * is never removed, since kernfs drops it when the adapter is deleted, =
and
> + * updating rather than creating lets a rebind accept an existing group.

Is there a use case for the sysfs attributes to be persistent even if the t=
he
mctp-i2c-controller client is removed and re-added? To me it would be less
surprising if they started with their initial settings when it's re-added.

> + */
> +static void mctp_i2c_add_sysfs(struct i2c_adapter *adap,
> +			       struct i2c_adapter *root)
> +{
> +	int rc;
> +
> +	if (adap =3D=3D root)
> +		return;
> +
> +	rc =3D sysfs_update_group(&adap->dev.kobj, &mctp_i2c_adapter_group);
> +	if (rc < 0)
> +		dev_warn(&adap->dev,
> +			 "Failed adding mctp_controller attribute, %d\n", rc);
> +}
> +
>  /* Called for each existing i2c device (adapter or client) when a
>   * new mctp-i2c client is probed.
>   */
> @@ -981,37 +1134,62 @@ static int mctp_i2c_client_try_attach(struct devic=
e *dev, void *data)
>  		return 0;
>  	if (mcli->client->adapter !=3D root)
>  		return 0;
> +
> +	/* Unmarked busses get the attribute too, so userspace can enable them =
*/
> +	mctp_i2c_add_sysfs(adap, root);
> +
>  	/* Must either have mctp-controller property on the adapter, or
>  	 * be a root adapter if it's non-devicetree
>  	 */
>  	if (!mctp_i2c_adapter_match(adap, adap =3D=3D root))
>  		return 0;
> =20
> -	return mctp_i2c_add_netdev(mcli, adap);
> +	/* @mcli cannot be unbound here: the driver core holds the device lock
> +	 * across probe, and an unbind needs that same lock.
> +	 */
> +	mutex_lock(&driver_clients_lock);
> +	mctp_i2c_add_netdev(mcli, adap);
> +	mutex_unlock(&driver_clients_lock);
> +
> +	return 0;
>  }
> =20
>  static void mctp_i2c_notify_add(struct device *dev)
>  {
> -	struct mctp_i2c_client *mcli =3D NULL, *m =3D NULL;
> +	struct mctp_i2c_client *mcli =3D NULL;
>  	struct i2c_adapter *root =3D NULL, *adap =3D NULL;
> +	bool have_client;
> +	bool match;
>  	int rc;
> =20
>  	adap =3D mctp_i2c_get_adapter(dev, &root);
>  	if (!adap)
>  		return;
> +
>  	/* Check for mctp-controller property on the adapter */
> -	if (!mctp_i2c_adapter_match(adap, false))
> -		return;
> +	match =3D mctp_i2c_adapter_match(adap, false);
> =20
> -	/* Find an existing mcli for adap's root */
>  	mutex_lock(&driver_clients_lock);
> -	list_for_each_entry(m, &driver_clients, list) {
> -		if (m->client->adapter =3D=3D root) {
> -			mcli =3D m;
> -			break;
> -		}
> -	}
> +	have_client =3D mctp_i2c_find_client(root);
> +	mutex_unlock(&driver_clients_lock);
> +
> +	if (!have_client)
> +		return;
> +
> +	/* Outside the lock: updating the group waits for a kernfs drain, and a
> +	 * concurrent mctp_controller_store() holds that reference while it
> +	 * waits for driver_clients_lock.
> +	 */
> +	mctp_i2c_add_sysfs(adap, root);
> +
> +	if (!match)
> +		return;
> =20
> +	mutex_lock(&driver_clients_lock);
> +	/* The pointer from the first lookup does not outlive the dropped
> +	 * lock, so look the client up again.
> +	 */
> +	mcli =3D mctp_i2c_find_client(root);
>  	if (mcli) {
>  		rc =3D mctp_i2c_add_netdev(mcli, adap);
>  		if (rc < 0)
> @@ -1030,36 +1208,32 @@ static void mctp_i2c_notify_del(struct device *de=
v)
>  		return;
> =20
>  	mutex_lock(&driver_clients_lock);
> -	list_for_each_entry(mcli, &driver_clients, list) {
> -		if (mcli->client->adapter =3D=3D root) {
> -			mctp_i2c_remove_netdev(mcli, adap);
> -			break;
> -		}
> -	}
> +	mcli =3D mctp_i2c_find_client(root);
> +	if (mcli)
> +		mctp_i2c_remove_netdev(mcli, adap);
>  	mutex_unlock(&driver_clients_lock);
>  }
> =20
>  static int mctp_i2c_probe(struct i2c_client *client)
>  {
> -	struct mctp_i2c_client *mcli =3D NULL;
> -	int rc;
> +	struct mctp_i2c_client *mcli;
> =20
>  	mutex_lock(&driver_clients_lock);
>  	mcli =3D mctp_i2c_new_client(client);
>  	if (IS_ERR(mcli)) {
> -		rc =3D PTR_ERR(mcli);
> -		mcli =3D NULL;
> -		goto out;
> -	} else {
> -		list_add(&mcli->list, &driver_clients);
> +		mutex_unlock(&driver_clients_lock);
> +		return PTR_ERR(mcli);
>  	}
> +	list_add(&mcli->list, &driver_clients);
> +	mutex_unlock(&driver_clients_lock);
> =20
> -	/* Add a netdev for adapters that have a 'mctp-controller' property */
> +	/* Add a netdev for adapters that have a 'mctp-controller' property.
> +	 * Runs with the lock dropped, for the reason mctp_i2c_notify_add()
> +	 * gives.
> +	 */
>  	i2c_for_each_dev(mcli, mctp_i2c_client_try_attach);
> -	rc =3D 0;
> -out:
> -	mutex_unlock(&driver_clients_lock);
> -	return rc;
> +
> +	return 0;
>  }
> =20
>  static void mctp_i2c_remove(struct i2c_client *client)

Cheers,
Matt
