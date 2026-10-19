Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CE4486E43;
	Mon, 19 Oct 2026 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399129; cv=none; b=YnWaLPQk64UdLEAVk30ZZJ5pqMYxhVP2+Xe+ZjBD5nicuVx7WtPSv2g6Veae5H4RTpAa1Wpuk/H6QnVTz2n1dCkME4EzZ+HWg0u0xKTHPxoLLc6tsvL1JcMMjdLf/ijqEKtErnN4gtjOoYuroxqiZw50x2ZqK7fHJRhYvkTYrZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399129; c=relaxed/simple;
	bh=A10ryxxjlAZp/UQgSAP8VIs3+AgMq3H2oC9VNi7dI3Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aMM7AiZwChFbvG4gGWpjjs2zM0OOrtqA04mYgPPY1mXmXZ0Ke0R5eIFzkIF8lRaoNZzXydg5h11JFcHlZzuiPNaQNFknaPBPlP8ZADxf7QHl/EVjNjiOvBdcRF2Az/J6NuLGdQS72vrXz3lSpxYVX0+nBRibjMXqbtXT/qrA4Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jH1XCQcG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jH1XCQcG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B745E1F000C4;
	Mon, 19 Oct 2026 08:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792399127;
	bh=c7nEGI0RE9s6Y4hvhdtUOzNzi20220f1yZXk73MyRTo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jH1XCQcGk3prMhRGT1uy4agoGT0e7WiQ6UUYmdOEnWAIslPHNDCOjEZF1+tDysxQb
	 TyllWI2jZucgZuIR80y+M5onrNYBpP6EfYtB/w1UDNNis/FXruoJC4egsQ6f5sqeGz
	 eHTLvQI2lmH1eB43kbMTi3i1kFd85Gp5D/h7yfjV1osM5NLbi9MFCouPdLCMPIgq15
	 vo7v0Yh0UKnXWi2aDnHpBvSr5HC6Hk1SQE244n+bPH+Ys/i8oNvF8JxMRa7DGDi8WC
	 0Tfrk3UI9abeh+NlaqbR5tNj6ALy85+Go/yMjjwjX1K5V5gKm2m13vdSYYJHmC8gHJ
	 TlazxzZYue5Yg==
Subject:
 Re: [PATCH net-next v2] mctp i2c: add sysfs control for mux child netdevs
From: netdev-bot+sashiko@kernel.org
To: kenny_hsieh@jabil.com
Cc: netdev@vger.kernel.org, jk@codeconstruct.com.au, matt@codeconstruct.com.au,
 andi.shyti@kernel.org, peda@lysator.liu.se, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 08:38:46 +0000
Message-ID: <179239912623.3135.11352652156626817288@kernel.org>
In-Reply-To: <20261015081341.1262695-1-kenny_hsieh@jabil.com>
References: <20261015081341.1262695-1-kenny_hsieh@jabil.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 11 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 6 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] When mctp_register_netdev() fails, mctp_i2c_add_netdev()
  (drivers/net/mctp/mctp-i2c.c) now always sets `midev = NULL`, so the…
- [High] The store-side guard against adapters being deleted does not
  close the race it claims to close.
- [High] mctp_i2c_remove() runs mctp_i2c_remove_sysfs_all() while the
  client is still on driver_clients.
- [Medium] The new ABI document Documentation/ABI/testing/sysfs-
  bus-i2c-devices-mctp says "The attribute appears only on mux child…
- [Medium] The new ABI lives on i2c adapter devices, which the I2C core
  owns, but the mctp-i2c driver attaches it with sysfs_update_group() on…
- [Medium] In the baseline, mctp_i2c_add_netdev() has a real double
  teardown.
- [Medium] mctp_i2c_new_client() now calls `write_pnet(&mcli->net,
  get_net(current->nsproxy->net_ns))` before i2c_slave_register().
- [Medium] mctp_i2c_probe() now releases driver_clients_lock after
  list_add() and before i2c_for_each_dev(mcli,…
- [Medium] Writing 0 to mctp_controller removes a channel's netdev
  through mctp_i2c_remove_netdev() -> mctp_i2c_unregister() ->…
- [Low] The commit message says "a rebind reattaches it reading 0".
- [Low] The commit message gives "an adapter that the devicetree cannot
  describe at all, such as a USB-attached one" as a use case.

--

mctp i2c: add sysfs control for mux child netdevs

This adds a writable mctp_controller sysfs attribute to every adapter of a
mux tree whose root has an mctp-i2c-controller client bound. Userspace can
use it to create or remove the MCTP netdev for busses that have no
devicetree node. Netdevs are now created in the namespace the client was
probed in, and the client holds a reference on that namespace.

> It also matters for an adapter that the devicetree
> cannot describe at all, such as a USB-attached one.

[Severity: Low]
Can the USB-attached adapter case actually happen? The attribute only
appears once an mctp-i2c-controller client binds at the root, and
mctp_i2c_new_client() needs i2c_slave_register() to succeed:

	rc = i2c_slave_register(mcli->client, mctp_i2c_slave_cb);
	if (rc < 0) {
		dev_err(&client->dev, "i2c register failed %d\n", rc);
		...
		goto err;
	}

That needs adapter->algo->reg_slave. In this tree only SoC controllers
provide it: aspeed, at91-slave, axxia, bcm-iproc, cadence, designware,
emev2, gxp, imx, mlxbf, npcm7xx, pxa, rcar and stm32f7. No USB-attached
adapter implements it, so neither a client nor the attribute can exist on
one.

Also, a root adapter without an OF node already gets its netdev
automatically through mctp_i2c_adapter_match(adap, adap == root).

> The attribute is removed when the client is
> unbound, so it does not outlive the module, and a rebind reattaches it
> reading 0.

[Severity: Low]
Does it really read 0 on every adapter after a rebind? A rebind runs
mctp_i2c_probe()->i2c_for_each_dev()->mctp_i2c_client_try_attach(). That
calls mctp_i2c_add_netdev() whenever mctp_i2c_adapter_match(adap,
adap == root) is true, which covers adapters with the "mctp-controller"
property and a root adapter without an OF node.

If userspace writes 0 on one of those and the controller is then rebound,
the netdev comes back and the attribute reads 1.

> diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp b/Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp
> new file mode 100644
> index 000000000000..a04bc30aa7b5
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp
> @@ -0,0 +1,26 @@

[ ... ]

> +		The attribute appears only on mux child busses whose mux tree
> +		root has an mctp-i2c-controller device bound to it. The root
> +		bus itself is excluded, because its network device follows
> +		that mctp-i2c-controller device rather than this attribute.

[Severity: Medium]
Does this paragraph match the code? The commit message says "the root
adapter included", and mctp_i2c_client_try_attach() calls
mctp_i2c_add_sysfs() for the root as well:

	if (mcli->client->adapter != root)
		return 0;

	/* Unmarked busses get the attribute too, so userspace can enable them */
	mctp_i2c_add_sysfs(adap, root);

mctp_controller_store() also has no special case for the root, so writing
0 on the root bus removes its netdev.

Is this text left over from v1?

[ ... ]

> diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
> index b02476d338bb..6c53bfcc50a3 100644
> --- a/drivers/net/mctp/mctp-i2c.c
> +++ b/drivers/net/mctp/mctp-i2c.c

[ ... ]

> @@ -162,7 +191,13 @@ static struct mctp_i2c_client *mctp_i2c_new_client(struct i2c_client *client)
>  	spin_lock_init(&mcli->sel_lock);
>  	INIT_LIST_HEAD(&mcli->devs);
>  	INIT_LIST_HEAD(&mcli->list);
> +	INIT_LIST_HEAD(&mcli->attrs);
> +	mutex_init(&mcli->attrs_lock);
>  	mcli->lladdr = client->addr & 0xff;
> +	/* The reference keeps the namespace alive for this client's lifetime,
> +	 * and is dropped in mctp_i2c_free_client().
> +	 */
> +	write_pnet(&mcli->net, get_net(current->nsproxy->net_ns));
>  	mcli->client = client;
>  	i2c_set_clientdata(client, mcli);
>  

[Severity: Medium]
Does this leak the netns reference when i2c_slave_register() fails? The
reference is taken before that call, and the error path frees mcli without
calling put_net():

	rc = i2c_slave_register(mcli->client, mctp_i2c_slave_cb);
	if (rc < 0) {
		dev_err(&client->dev, "i2c register failed %d\n", rc);
		mcli->client = NULL;
		i2c_set_clientdata(client, NULL);
		goto err;
	}
	...
err:
	if (mcli) {
		i2c_unregister_device(mcli->client);
		kfree(mcli);
	}

One way to hit this is an adapter without reg_slave, which returns
-EOPNOTSUPP. If the probe ran in a non-init namespace, that namespace can
never be freed.

[ ... ]

> @@ -900,6 +971,12 @@ static int mctp_i2c_add_netdev(struct mctp_i2c_client *mcli,
>  		dev_err(&mcli->client->dev,
>  			"register netdev \"%s\" failed %d\n",
>  			ndev->name, rc);
> +		/* register_netdevice() has already run ndo_uninit, which
> +		 * frees midev. Every error path it takes reaches err_uninit
> +		 * except err_free_name, and that one needs an ndo_init this
> +		 * driver does not provide.
> +		 */
> +		midev = NULL;
>  		goto err;
>  	}

[Severity: High]
Does this hold for every failure of mctp_register_netdev()? Some failures
return before err_uninit, so ndo_uninit never runs:

net/mctp/device.c:mctp_register_netdevice() {
	...
	mdev = mctp_add_dev(dev);
	if (IS_ERR(mdev))
		return PTR_ERR(mdev);
	...
}

net/core/dev.c:register_netdevice() {
	...
	ret = ethtool_check_ops(dev->ethtool_ops);
	if (ret)
		return ret;
	...
	ret = dev_get_valid_name(net, dev, dev->name);
	if (ret < 0)
		goto out;

	ret = -ENOMEM;
	dev->name_node = netdev_name_node_head_alloc(dev);
	if (!dev->name_node)
		goto out;
	...
}

On all of these paths, mctp_i2c_midev_init() has already done four things:

- linked midev into mcli->devs
- possibly set mcli->sel
- taken get_device() on the adapter and the client
- woken tx_thread

With midev = NULL, the err label only calls free_netdev(ndev), and that
frees the private area holding midev.

Can this leave the tx kthread running on freed memory? It would also leave
a freed node on mcli->devs, which later mctp_i2c_find_dev() and
mctp_i2c_remove() calls walk. The leaked adapter reference would make
i2c_del_adapter() wait forever on dev_released.

The name collision case is deterministic. The name is a fixed
"mctpi2c<nr>" with no '%', so dev_get_valid_name() returns -EEXIST if any
netdev in the client's namespace already has that name:

  ip link set dev X name mctpi2c7
  echo 1 > /sys/bus/i2c/devices/i2c-7/mctp_controller

Before this patch, these early paths ran mctp_i2c_midev_free() correctly.

[Severity: Medium]
Separately, the double teardown on late failures that this addresses
already exists in the baseline. On the err_uninit paths, and when a
NETDEV_REGISTER notifier fails, mctp_i2c_ndo_uninit()->mctp_i2c_midev_free()
runs first. The err label then calls mctp_i2c_midev_free() again, which
does a second list_del() and a second put_device() on both the adapter and
the client.

Could that fix be split into its own patch with a Fixes: tag, so it can go
to net and stable? Right now it is only described in the v2 notes below
the ---, and those don't end up in git history.

[ ... ]

> @@ -968,6 +1037,287 @@ static bool mctp_i2c_adapter_match(struct i2c_adapter *adap, bool match_no_of)

[ ... ]

> +static ssize_t mctp_controller_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{

[ ... ]

> +		rc = mctp_i2c_add_netdev(mcli, adap);
> +	} else {
> +		mctp_i2c_remove_netdev(mcli, adap);
> +		rc = 0;
> +	}

[Severity: Medium]
What happens to receive traffic on this channel after a write of 0? The
call chain is mctp_i2c_remove_netdev()->mctp_i2c_unregister()->
ndo_uninit->mctp_i2c_midev_free(). That releases any flow lock and points
mcli->sel at whichever midev is first on the list:

	if (mcli->sel == midev) {
		struct mctp_i2c_dev *first;

		first = list_first_entry_or_null(&mcli->devs, struct mctp_i2c_dev, list);
		__mctp_i2c_device_select(mcli, first);
	}

The physical mux is not deselected. With an idle-as-is mux such as
pca954x it can stay on the removed channel. mctp_i2c_recv() attributes all
target-mode receive data to mcli->sel->ndev, with
cb->haddr[0] = source_slave >> 1.

Could late replies or unsolicited writes from endpoints on the removed
channel then be delivered on an unrelated netdev, and a reply be sent on
the wrong mux channel? Before this patch, a netdev only went away together
with its adapter or the client.

If so, the ABI text "in-flight requests fail, so a requester sees a timeout
rather than an error" is also not accurate, because the late reply can
still arrive through another interface in the same MCTP net.

[ ... ]

> +static void mctp_i2c_add_sysfs(struct i2c_adapter *adap,
> +			       struct i2c_adapter *root)
> +{

[ ... ]

> +	/* Outside both locks: updating the group waits for a kernfs drain, and
> +	 * a concurrent mctp_controller_store() holds that reference while it
> +	 * waits for driver_clients_lock.
> +	 */
> +	rc = sysfs_update_group(&adap->dev.kobj, &mctp_i2c_adapter_group);

[Severity: Medium]
Is it ok for mctp-i2c to add an attribute group to an i2c adapter device,
which the I2C core owns, after that device has been registered? The
commit message's main case is a runtime mux whose adapters already exist
when the mctp-i2c-controller client binds. There,
mctp_i2c_client_try_attach() adds mctp_controller long after KOBJ_ADD was
sent, and no uevent is generated.

udev rules keyed on the adapter would never see the attribute appear.
Whether it exists also depends on whether, and when, a separate client
binds. Adapters added after the bind are fine, because
BUS_NOTIFY_ADD_DEVICE runs before KOBJ_ADD.

Should this ABI on the adapter device be agreed with the I2C maintainers?

[ ... ]

> +static void mctp_i2c_remove_sysfs_all(struct mctp_i2c_client *mcli)
> +{
> +	struct mctp_i2c_attr *attr = NULL, *tmp = NULL;
> +	LIST_HEAD(attrs);
> +
> +	lockdep_assert_not_held(&driver_clients_lock);
> +
> +	mutex_lock(&mcli->attrs_lock);
> +	list_splice_init(&mcli->attrs, &attrs);
> +	mutex_unlock(&mcli->attrs_lock);
> +
> +	list_for_each_entry_safe(attr, tmp, &attrs, list) {
> +		sysfs_remove_group(&attr->adap->dev.kobj,
> +				   &mctp_i2c_adapter_group);
> +		list_del(&attr->list);
> +		put_device(&attr->adap->dev);
> +		kfree(attr);
> +	}
> +}

[Severity: High]
Can this race with mctp_i2c_add_sysfs() for an adapter X being added to
the same tree? mctp_i2c_remove() calls this before list_del(&mcli->list),
so mctp_i2c_notify_add()->mctp_i2c_add_sysfs() can still find the client.

If add_sysfs inserts its entry after the splice, mctp_i2c_free_client()
hits WARN_ON(!list_empty(&mcli->attrs)) and frees mcli with the entry
still linked. The entry's reference on X leaks. A later notify_del for X
finds no client, so i2c_del_adapter(X) hangs on dev_released.

If add_sysfs inserted its entry and dropped both locks before calling
sysfs_update_group():

CPU0 mctp_i2c_add_sysfs(X)       CPU1 mctp_i2c_remove_sysfs_all()
list_add(&attr->list, ...)
unlock both locks
                                 list_splice_init(&mcli->attrs, &attrs)
                                 sysfs_remove_group()  /* nothing yet */
                                 put_device(); kfree(attr)
sysfs_update_group()

then mctp_controller is created on X with no tracking entry, and nothing
ever removes it.

After rmmod, would a read or write of i2c-X/mctp_controller go into the
freed module's dev_attr_mctp_controller and its show/store handlers? That
would contradict "so it does not outlive the module" in the commit
message.

[ ... ]

> @@ -1030,36 +1405,35 @@ static void mctp_i2c_notify_del(struct device *dev)
>  		return;
>  
>  	mutex_lock(&driver_clients_lock);
> -	list_for_each_entry(mcli, &driver_clients, list) {
> -		if (mcli->client->adapter == root) {
> -			mctp_i2c_remove_netdev(mcli, adap);
> -			break;
> -		}
> -	}
> +	mcli = mctp_i2c_find_client(root);
> +	if (mcli)
> +		mctp_i2c_remove_netdev(mcli, adap);
>  	mutex_unlock(&driver_clients_lock);
> +
> +	/* Outside the lock, for the reason mctp_i2c_remove_sysfs() gives */
> +	mctp_i2c_remove_sysfs(adap, root);
>  }

[Severity: High]
Does the mctp_i2c_attr_tracked() check in mctp_controller_store() close
the deleted-adapter race? Here the netdev is removed and
driver_clients_lock is dropped before mctp_i2c_remove_sysfs() untracks the
adapter. The attribute is still writable because kobject_del() has not run
yet:

CPU0                                CPU1
mctp_i2c_notify_del()
  mutex_lock(&driver_clients_lock)
  mctp_i2c_remove_netdev()
  mutex_unlock(&driver_clients_lock)
                                    mctp_controller_store("1")
                                      mctp_i2c_attr_tracked() == true
                                      mctp_i2c_add_netdev()
                                        get_device(&adap->dev)
mctp_i2c_remove_sysfs()
  mctp_i2c_drop_attr()
  sysfs_remove_group()
/* back in i2c_del_adapter() */
wait_for_completion(&adap->dev_released)

No second BUS_NOTIFY_DEL_DEVICE arrives, so the new netdev keeps its
reference on the dying adapter. Wouldn't i2c_del_adapter() then block
until the mctp-i2c client is unbound?

Would untracking the adapter before mctp_i2c_remove_netdev(), in the same
critical section, avoid this?

>  
>  static int mctp_i2c_probe(struct i2c_client *client)
>  {
> -	struct mctp_i2c_client *mcli = NULL;
> -	int rc;
> +	struct mctp_i2c_client *mcli;
>  
>  	mutex_lock(&driver_clients_lock);
>  	mcli = mctp_i2c_new_client(client);
>  	if (IS_ERR(mcli)) {
> -		rc = PTR_ERR(mcli);
> -		mcli = NULL;
> -		goto out;
> -	} else {
> -		list_add(&mcli->list, &driver_clients);
> +		mutex_unlock(&driver_clients_lock);
> +		return PTR_ERR(mcli);
>  	}
> +	list_add(&mcli->list, &driver_clients);
> +	mutex_unlock(&driver_clients_lock);
>  
> -	/* Add a netdev for adapters that have a 'mctp-controller' property */
> +	/* Add a netdev for adapters that have a 'mctp-controller' property.
> +	 * Runs with the lock dropped, for the reason mctp_i2c_notify_add()
> +	 * gives.
> +	 */
>  	i2c_for_each_dev(mcli, mctp_i2c_client_try_attach);

[Severity: Medium]
With driver_clients_lock no longer held across the walk, can
mctp_i2c_notify_del() for a mux adapter X finish while this walk is still
running? device_del() sends BUS_NOTIFY_DEL_DEVICE before
bus_remove_device() takes X off the bus klist:

CPU0                                CPU1
                                    mctp_i2c_probe()
                                      list_add(&mcli->list, ...)
                                      mutex_unlock(&driver_clients_lock)
device_del(X)
  mctp_i2c_notify_del()
    /* nothing to remove for X yet */
                                      i2c_for_each_dev()
                                        mctp_i2c_client_try_attach(X)
                                          mctp_i2c_add_sysfs()
                                            get_device(&X->dev)
                                          mctp_i2c_add_netdev()
  bus_remove_device(X)

Nothing drops those references afterwards, so i2c_del_adapter(X) would
block on dev_released until the client is unbound.

Before this patch, probe held driver_clients_lock across the walk, which
limited this to a narrower window affecting only the netdev. This change
widens the window, and the tracking entry adds a second leaked reference.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015081341.1262695-1-kenny_hsieh%40jabil.com
