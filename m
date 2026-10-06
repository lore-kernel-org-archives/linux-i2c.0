Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678723C0619;
	Tue,  6 Oct 2026 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273709; cv=none; b=kF1cSiGJ+o8sQ/CcleRmCtHbX7PkxSyMZUY3O97ZtaFOCZNSM6+WJujRZB8UPgElEvThM8rV2GAlnkb9rxEZAgYgE+I7031rp+kZPQP/8GbpugwDWEJoiYT3lXoscVMdtYMLtR71XNqTTJAaS08PHf+GHLP8Y5lTu+nsqaFc48k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273709; c=relaxed/simple;
	bh=tQuN2ykBm7vFgH5VNhBvhZ2vH+f7BfhAEmdqXzHa+HY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P7OkYFloz2h7Kv/WoIJpKrDuxVL4Kuop7QbqaWEx8dMEHcFbm9WEFYypV+rQI/ZjFqikdAq40uAkk/VaxhCSoPfF8rwZPjbzzi7zS7VltDjLE1d3K8PXIyiZSuGk+A+t1CG//ffqV15Iy3CsKO/BVEM4gahODuMcZy8PigYr2ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ezlg9jxo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ezlg9jxo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95AC1F000FF;
	Tue,  6 Oct 2026 08:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791273703;
	bh=coaUuS+tbXlKfBZwVhq0/8z50QTFeibqvMpR7gQtenU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ezlg9jxo8xlXIruzNcq4bUfMzxAPZtctip8+54H9kCt5G59Pd9KngTdcVxdBlWDQd
	 9EJOiBWOoN56isRKAG6xFXArGK6bO/sVmZXnNSeJbBAfXU46TTPvCuLY+w7F17U8n1
	 fJmnzlYxeKjfjTSe+XMy5ZXXZZ0A3vTr1D4oZ7OA/xDS3WoJtVW7WRdKFRmBTZQBBt
	 tlvzBskfBijYiGvBp4xyatPR+/reoDDf39YzFYSeEdCKb9BjBmeqvGrRVcf54CKhNf
	 5iB6N4GBhQWReqmeaIp2C/sA3UjndpJABZalkKE/YnJQt3p4ozmV2ZFfxQUEEBLd+m
	 PWCIH2OWEMnaQ==
Subject:
 Re: [PATCH net-next] mctp i2c: add sysfs control for mux child netdevs
From: netdev-bot+sashiko@kernel.org
To: kenny_hsieh@jabil.com
Cc: netdev@vger.kernel.org, jk@codeconstruct.com.au, matt@codeconstruct.com.au,
 andi.shyti@kernel.org, peda@lysator.liu.se, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 06 Oct 2026 08:01:42 +0000
Message-ID: <179127370242.434549.12627690088274157947@kernel.org>
In-Reply-To: <20261002073156.759005-1-kenny_hsieh@jabil.com>
References: <20261002073156.759005-1-kenny_hsieh@jabil.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 1 · High: 1 (1) · Medium: 4 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Use-after-free of module text and data through the leftover
  mctp_controller sysfs file.
- [High] mctp_i2c_new_client() caches the probe-time namespace with
  write_pnet(&mcli->net, current->nsproxy->net_ns) (line 187) and never…
- [Medium] The ABI document disagrees with the code.
- [Medium] mctp_controller_store() can create a netdev for an adapter
  that is already being deleted.
- [Medium] mctp_i2c_probe() now publishes mcli on driver_clients and
  walks the bus with driver_clients_lock dropped, and…
- [Medium] net: TOCTOU race allows concurrent sysfs writes to attempt
  duplicate netdev creation
- [Low] The commit message says that for the root adapter 'a write there
  returns -EINVAL'.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the new
  mctp_controller store makes it reachable on demand.
- [Medium] This problem wasn't introduced by this patch.

--

mctp i2c: add sysfs control for mux child netdevs

This patch adds a writable mctp_controller sysfs attribute to the mux
child adapters below a root bus that has an mctp-i2c-controller bound.
Writing 1 or 0 to it creates or removes the MCTP netdev for that channel.
The patch also stores the probe-time network namespace in the client,
allows only one client per mux tree, and drops driver_clients_lock while
probe walks the bus.

> The root adapter is excluded: its netdev follows the bound
> mctp-i2c-controller device rather than this attribute, so a write there
> returns -EINVAL. The devicetree property keeps working, and both
> mechanisms may be used on the same mux tree.

[Severity: Low]
Is this accurate? mctp_i2c_add_sysfs() returns early for the root adapter:

	if (adap == root)
		return;

So mctp_controller never exists on the root bus, and a write there fails
with ENOENT, not EINVAL. That also seems to make the adap == root check in
mctp_controller_store() unreachable.

> Tested on an AST2700 BMC with a nested mux tree by writing 1 to
> mctp_controller on a channel that has no "mctp-controller" property,
> which brings up the interface, then writing 0, which removes it. The
> attribute also survives an unbind and rebind of the
> mctp-i2c-controller driver.

The file survives, but does the enabled state survive too?

mctp_i2c_remove() unregisters every midev, including the ones created
through mctp_controller. On rebind, mctp_i2c_client_try_attach() only
recreates netdevs for DT-marked adapters (or a non-OF root). Channels that
userspace enabled read 0 afterwards.

Should the commit message or the ABI document say that userspace has to
write 1 again after a rebind?

> diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp b/Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp
> new file mode 100644
> index 0000000000000..a04bc30aa7b51
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp
> @@ -0,0 +1,26 @@
> +What:		/sys/bus/i2c/devices/i2c-<n>/mctp_controller

[ ... ]

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

[Severity: Medium]
Does the code match this description? The group is never removed (the
mctp_i2c_add_sysfs() comment says so), and mctp_i2c_remove() does not
touch it. After the controller is unbound, the attribute stays on every
child adapter that existed while it was bound.

Child adapters created after the unbind never get the attribute, because
mctp_i2c_notify_add() returns before it calls mctp_i2c_add_sysfs():

	if (!have_client)
		return;

So whether a channel has the attribute depends on the order things were
created, not on whether a controller is bound.

The no-op rule doesn't hold either when no controller is bound.
mctp_controller_show() reports 0, but mctp_controller_store() returns
-ENODEV for every value, including a write of 0.

The commit message gives this reason for the one-client-per-tree rule:
"either client's removal would delete the attribute the other still
needs". The comment in mctp_i2c_new_client() says the same. With no
removal path, does that reason still apply?

[ ... ]

> diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
> index b02476d338bbf..d4da32656744a 100644
> --- a/drivers/net/mctp/mctp-i2c.c
> +++ b/drivers/net/mctp/mctp-i2c.c

[ ... ]

> @@ -163,6 +184,7 @@ static struct mctp_i2c_client *mctp_i2c_new_client(struct i2c_client *client)
>  	INIT_LIST_HEAD(&mcli->devs);
>  	INIT_LIST_HEAD(&mcli->list);
>  	mcli->lladdr = client->addr & 0xff;
> +	write_pnet(&mcli->net, current->nsproxy->net_ns);

[Severity: High]
Should this hold a reference on the namespace? write_pnet() is a plain
rcu_assign_pointer(). The driver never calls get_net() or put_net(), and
mctp_i2c_free_client() releases nothing.

Suppose the controller is probed from a non-init netns, for example by
writing new_device or the driver's bind file under ip netns exec, and that
netns is later deleted. The struct net is freed while mcli lives on. Any
MCTP netdevs in it are moved to init_net, but mcli->net still points at
the freed namespace.

Later, a write of 1 to mctp_controller or a DT-marked mux child being
added goes through:

mctp_i2c_add_netdev()
    dev_net_set(ndev, read_pnet(&mcli->net));
    mctp_register_netdev()
        register_netdevice()

Can this become a use-after-free of struct net in dev_get_valid_name(),
dev_index_reserve() or list_netdevice()?

Before this patch, mctp_i2c_add_netdev() used current->nsproxy->net_ns
at call time, which was always live.

[ ... ]

> @@ -968,6 +1006,121 @@ static bool mctp_i2c_adapter_match(struct i2c_adapter *adap, bool match_no_of)

[ ... ]

> +static ssize_t mctp_controller_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{

[ ... ]

> +	mutex_lock(&driver_clients_lock);
> +	mcli = mctp_i2c_find_client(root);
> +	if (!mcli) {
> +		/* No mctp-i2c-controller on this mux tree's root */
> +		rc = -ENODEV;
> +		goto out;
> +	}
> +
> +	if (enable) {
> +		if (mctp_i2c_find_dev(mcli, adap))
> +			rc = 0;	/* Already present, nothing to do */
> +		else
> +			rc = mctp_i2c_add_netdev(mcli, adap);

[Severity: Medium]
Can this create a netdev for an adapter that is already being deleted?

device_del() sends BUS_NOTIFY_DEL_DEVICE, which runs
mctp_i2c_notify_del(), well before it calls kobject_del(). The
mctp_controller file was added straight onto the adapter kobject, so it
stays usable until kobject_del() drains kernfs.

Here is the case where a store is waiting on driver_clients_lock while
mctp_i2c_notify_del() holds it:

CPU1                                  CPU2
device_del(&adap->dev)
  bus_notify(DEL_DEVICE)
    mctp_i2c_notify_del()
      mutex_lock(&driver_clients_lock)
                                      mctp_controller_store()
                                        mutex_lock(&driver_clients_lock)
      mctp_i2c_remove_netdev()
      mutex_unlock(&driver_clients_lock)
                                        mctp_i2c_find_dev() -> NULL
                                        mctp_i2c_add_netdev()
                                          mctp_i2c_midev_init()
                                            get_device(&adap->dev)
  kobject_del(&dev->kobj)

No second DEL notification will come, so the new netdev is never torn
down. The adapter reference taken in mctp_i2c_midev_init() is never
dropped either.

Would i2c_del_adapter() then block here until the controller client is
unbound?

	device_unregister(&adap->dev);
	wait_for_completion(&adap->dev_released);

If kobject_del() has already deactivated the adapter directory,
netdev_register_kobject() fails instead. That leads into the
mctp_i2c_add_netdev() error path described below.

[Severity: High]
This isn't a bug introduced by this patch, but the new store lets
userspace reach the mctp_i2c_add_netdev() error path whenever it likes.
Can mctp_i2c_add_netdev() free midev twice when mctp_register_netdev()
fails?

mctp_i2c_ndo_uninit() is installed as ndo_uninit and calls
mctp_i2c_midev_free(). register_netdevice() calls ndo_uninit on its
err_uninit path. That path is reached when netdev_do_alloc_pcpu_stats(),
dev_index_reserve(), a NETDEV_POST_INIT notifier or
netdev_register_kobject() fails. A NETDEV_REGISTER notifier error reaches
ndo_uninit through unregister_netdevice_queue().

midev is still set when mctp_i2c_add_netdev() reaches its error label:

err:
	if (midev)
		mctp_i2c_midev_free(midev);
	if (ndev)
		free_netdev(ndev);

The second mctp_i2c_midev_free() runs list_del() on an entry that is
already poisoned. It also calls put_device() a second time on both
&midev->adapter->dev and &mcli->client->dev.

Could the extra puts release the i2c client or the adapter early and lead
to a later use-after-free?

> +	} else {
> +		mctp_i2c_remove_netdev(mcli, adap);

[Severity: Medium]
This is a pre-existing issue, but writing 0 here lets userspace remove the
selected channel's netdev at any moment. When the midev that mcli->sel
points at is freed, mctp_i2c_midev_free() does:

	if (mcli->sel == midev) {
		struct mctp_i2c_dev *first;

		first = list_first_entry_or_null(&mcli->devs, struct mctp_i2c_dev, list);
		__mctp_i2c_device_select(mcli, first);
	}

That selects the most recently added netdev, whichever mux channel is
physically selected. mctp_i2c_slave_cb() files every received byte under
mcli->sel. Replies from the removed channel's endpoint, or the rest of a
partly received frame, would then be credited to an unrelated channel's
netdev.

Does that fit the new ABI text saying "in-flight requests fail"?

> +		rc = 0;
> +	}
> +out:
> +	mutex_unlock(&driver_clients_lock);
> +
> +	return rc < 0 ? rc : count;
> +}
> +
> +static DEVICE_ATTR_RW(mctp_controller);

[ ... ]

> +/* The root adapter is skipped: its netdev follows the bound client. The group
> + * is never removed, since kernfs drops it when the adapter is deleted, and
> + * updating rather than creating lets a rebind accept an existing group.
> + */
> +static void mctp_i2c_add_sysfs(struct i2c_adapter *adap,
> +			       struct i2c_adapter *root)
> +{
> +	int rc;
> +
> +	if (adap == root)
> +		return;
> +
> +	rc = sysfs_update_group(&adap->dev.kobj, &mctp_i2c_adapter_group);

[Severity: Critical]
What happens to these files when the module is unloaded?
MCTP_TRANSPORT_I2C is tristate. The adapter kobjects belong to the i2c
core and the mux drivers, so they outlive mctp-i2c.

Nothing in the driver calls sysfs_remove_group(). mctp_i2c_remove()
doesn't, and mctp_i2c_mod_exit() only does:

	rc = bus_unregister_notifier(&i2c_bus_type, &mctp_i2c_notifier);
	...
	i2c_del_driver(&mctp_i2c_driver);

sysfs_add_file_mode_ns() stores &dev_attr_mctp_controller.attr as the
kernfs node's private data and takes no module reference. dev_sysfs_ops
later calls dev_attr->show and dev_attr->store through that pointer.

After rmmod mctp_i2c, every child adapter would still have
/sys/bus/i2c/devices/i2c-N/mctp_controller. DEVICE_ATTR_RW gives it mode
0644, so wouldn't a read by any user load the show pointer from freed
module data and jump into freed module text?

[ ... ]

> @@ -1030,36 +1208,32 @@ static void mctp_i2c_notify_del(struct device *dev)

[ ... ]

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
mcli is now on driver_clients while the bus walk runs without
driver_clients_lock. Can mctp_i2c_client_try_attach() and
mctp_i2c_notify_add() then call sysfs_update_group() on the same adapter
at the same time?

device_add() puts a new adapter on the bus klist in bus_add_device()
before it sends BUS_NOTIFY_ADD_DEVICE. i2c_register_adapter() calls
device_add() without core_lock, and i2c_for_each_dev() holds only
core_lock. So both paths can see a mux child that is registered during
probe.

In update mode, create_files() calls kernfs_remove_by_name() and then
sysfs_add_file_mode_ns(), and the pair is not atomic. Take the
interleaving A-remove, B-remove, A-add, B-add. B fails with -EEXIST, and
its error path calls remove_files(parent, grp), which deletes the file A
just created.

The adapter is then left without a mctp_controller attribute, and the only
trace is a "Failed adding mctp_controller attribute, -17" warning. Should
these group updates be serialized?

[ ... ]

> @@ -981,37 +1134,62 @@ static int mctp_i2c_client_try_attach(struct device *dev, void *data)
>  		return 0;
>  	if (mcli->client->adapter != root)
>  		return 0;
> +
> +	/* Unmarked busses get the attribute too, so userspace can enable them */
> +	mctp_i2c_add_sysfs(adap, root);
> +
>  	/* Must either have mctp-controller property on the adapter, or
>  	 * be a root adapter if it's non-devicetree
>  	 */
>  	if (!mctp_i2c_adapter_match(adap, adap == root))
>  		return 0;
>  
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
>  
>  static void mctp_i2c_notify_add(struct device *dev)
>  {
> -	struct mctp_i2c_client *mcli = NULL, *m = NULL;
> +	struct mctp_i2c_client *mcli = NULL;
>  	struct i2c_adapter *root = NULL, *adap = NULL;
> +	bool have_client;
> +	bool match;
>  	int rc;
>  
>  	adap = mctp_i2c_get_adapter(dev, &root);
>  	if (!adap)
>  		return;
> +
>  	/* Check for mctp-controller property on the adapter */
> -	if (!mctp_i2c_adapter_match(adap, false))
> -		return;
> +	match = mctp_i2c_adapter_match(adap, false);
>  
> -	/* Find an existing mcli for adap's root */
>  	mutex_lock(&driver_clients_lock);
> -	list_for_each_entry(m, &driver_clients, list) {
> -		if (m->client->adapter == root) {
> -			mcli = m;
> -			break;
> -		}
> -	}
> +	have_client = mctp_i2c_find_client(root);
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
>  
> +	mutex_lock(&driver_clients_lock);
> +	/* The pointer from the first lookup does not outlive the dropped
> +	 * lock, so look the client up again.
> +	 */
> +	mcli = mctp_i2c_find_client(root);
>  	if (mcli) {
>  		rc = mctp_i2c_add_netdev(mcli, adap);
>  		if (rc < 0)

[Severity: Medium]
The client is looked up again once the lock is retaken, but the netdev
is not. By this point mctp_i2c_add_sysfs() has already made
mctp_controller visible on adap, so a store can run in between:

CPU1                                  CPU2
mctp_i2c_notify_add()
  mctp_i2c_add_sysfs(adap, root)
                                      mctp_controller_store()
                                        mutex_lock(&driver_clients_lock)
                                        mctp_i2c_find_dev() -> NULL
                                        mctp_i2c_add_netdev()
  mutex_lock(&driver_clients_lock)
  mctp_i2c_find_client(root)
  mctp_i2c_add_netdev(mcli, adap)

The second mctp_i2c_add_netdev() allocates another ndev with the same
mctpi2c<nr> name and links a second midev for adap into mcli->devs.
mctp_register_netdev() then fails with -EEXIST, because that name is
already taken in mcli->net, and the error path unwinds it. The netdev
created by the store keeps working. The log still reports "register
netdev ... failed -17" and "Failed adding mctp-i2c net device" for a
bus that is fine.

mctp_i2c_client_try_attach() has the same gap between
mctp_i2c_add_sysfs() and mctp_i2c_add_netdev(), and on a rebind it is
much wider. The group is never removed, so every child adapter already
has mctp_controller, and mcli sits on driver_clients for the whole
i2c_for_each_dev() walk. A write of 1 to a DT-marked channel during
the walk creates the netdev before try_attach reaches that adapter.
The duplicate attempt then fails the same way. The return value is
discarded there, so only the dev_err() is left.

Would it be simpler to do the mctp_i2c_find_dev() check inside
mctp_i2c_add_netdev(), which already requires driver_clients_lock, and
treat an existing netdev as success? mctp_i2c_notify_add(),
mctp_i2c_client_try_attach() and mctp_controller_store() would then
all get it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002073156.759005-1-kenny_hsieh%40jabil.com
