Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795302178;
	b=1xm8aGIH7JaBZqOFJ8oNhzaezgQ43p3hOjqmdoUJSwVG2TVdP/XEfGLk/AKnGkH4BmeO
	 gfFXgX8DIdt/udCeTk1JXVeAb3wypmm8KilcQigRfYLoYbbt2rjxZMObFbmrNR2Utsk71
	 hfnI8j8k1QhjZ4CYcYLuy+TA1vJKIduBi9uS5IFa5Y+k6l2z6SOn4BAL9TEm3mm8ul7n3
	 mLgzZ74rkVULl4bvPGxiwXiWfxxdiSPzHDN99e8sW6y6lnmIbAuIuP/r4nmB84VzjHGOL
	 DsdZqvYL5q6lE+K/QXRR+6wZZklXm9uF7u8yseV1ptFyk5ZLIbL5h08yVHU77Py8OTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795302178;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=FK3dPssi5EMSDevwdCoFcG7tNlGhpdRScPG7jxoulKY=;
	b=cGySHCq6HAc3v31QSCJ+GTaFF3qjB+n2DIVo/aJk7g2W4RAlMFo0Oy4/OcZf7+3TdLbb
	 4G/5JJlJvRn8Zj1g+et9ZSDM8yzr47MIoq3kuA+MnvCwxqCrkKEXE3iTjC/6/7vR3PyVM
	 BkNPYF/InS/EU34Sx/crt+DTrmjEpnG7rEI930WruQ7TugkD6Uj86xFlwVi1NVVdniWju
	 GAN2Y3SDdHKnADdp04he8V/3JIOCtsTazG3bwfO1ChidS/5qCtaWZC2yZdNV8zRBYstat
	 3wdT2qtHpdNn/w78WmNQCVY8mUUJ00GffgrUd0iwCwDVzA4gakBnR4wzmSjAftgbU0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bzuZIlaA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C38606A336;
	Sat, 21 Nov 2026 23:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bzuZIlaA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656D91F000CF;
	Sat, 21 Nov 2026 23:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795302178;
	bh=FK3dPssi5EMSDevwdCoFcG7tNlGhpdRScPG7jxoulKY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bzuZIlaADQAdLtJnqyhO0OWhrbu0Ley041xIUMxViHB1v4orYyXIdcXMXxjGUD2H9
	 qnHFqwlX+1NMQ252j80Ig+hoNv+4W3tQwZQS9Upr6Nsn4A+/7jEXPlDbcyOx8HOJWR
	 AAlPKn6yIcypfhdkFLIid7v7dodX3qm1fBrTUV0f08r/1p/yPyWoXVEjsd+pFTPMS3
	 HIaWdX7s0tzN5AXHok1uNuQN0OkvhM6MbcpBeOcEv31ou6xT64QnPNI0u2fofjk2aN
	 NVcx/LLc7QSMyTmBI71TU/RMn26AYttUDJ4M8jLZZGxeEHO+HxJary12pHFPktQtA3
	 ez2i/Is3FU4fA==
Subject:
 Re: [PATCH net-next v3] mctp i2c: add sysfs control for mux child netdevs
From: netdev-bot+sashiko@kernel.org
To: kenny_hsieh@jabil.com
Cc: netdev@vger.kernel.org, jk@codeconstruct.com.au, matt@codeconstruct.com.au,
 andi.shyti@kernel.org, peda@lysator.liu.se, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 21 Nov 2026 23:02:56 +0000
Message-ID: <179530217699.3135.2359467047069026979@kernel.org>
In-Reply-To: <20261118100231.3827609-1-kenny_hsieh@jabil.com>
References: <20261118100231.3827609-1-kenny_hsieh@jabil.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] mctp_i2c_controller_write() (drivers/net/mctp/mctp-i2c.c)
  checks permission with ns_capable(current->nsproxy->net_ns->user_ns,…
- [Low] Two inaccuracies in the commit message.
- [Low] Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp documents
  only two errors: EEXIST (adding a bus that already has a netdev) and…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  makes it reachable from userspace.

--

mctp i2c: add sysfs control for mux child netdevs

This patch adds write-only add_mctp_controller and remove_mctp_controller
attributes to the mctp-i2c-controller device. Writing a bus name to them
creates or removes an MCTP netdev for that bus in the controller's mux
tree, so muxes instantiated at runtime without a devicetree node can still
get a netdev. It also makes mctp_i2c_add_netdev() skip adapters that
already have a netdev, and it now handles BUS_NOTIFY_REMOVED_DEVICE in the
bus notifier.

> diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp b/Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp
> new file mode 100644
> index 0000000000000..4ee96254f57a4
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp
> @@ -0,0 +1,24 @@
> +What:		/sys/bus/i2c/devices/<bus>-<addr>/add_mctp_controller
> +What:		/sys/bus/i2c/devices/<bus>-<addr>/remove_mctp_controller

[ ... ]

> +		Writing an I2C bus name such as "i2c-30" to add_mctp_controller
> +		creates an MCTP network device for that bus, and writing it to
> +		remove_mctp_controller removes it. The bus must be the
> +		controller's root bus or a mux child below it. Adding a bus
> +		that already has a network device fails with EEXIST, and
> +		removing one that has none fails with ENODEV.

[Severity: Low]
Should this ABI description list the other errors the store can return?

mctp_i2c_find_named() returns -ENODEV when bus_find_device_by_name() finds
nothing, on both add and remove:

	dev = bus_find_device_by_name(&i2c_bus_type, NULL, name);
	if (!dev)
		return ERR_PTR(-ENODEV);

On remove_mctp_controller, ENODEV can therefore mean "no such bus" or
"bus exists but has no netdev", and userspace can't tell which.

It also returns -EINVAL when the name is an i2c client rather than an
adapter, or an adapter outside this controller's mux tree.
mctp_i2c_controller_write() returns -EPERM when the CAP_NET_ADMIN check
fails.

The text also doesn't say that a CAP_NET_ADMIN check applies, or that the
netdev is created in the writer's network namespace.

[ ... ]

> diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
> index b02476d338bbf..61dd4a9e72545 100644
> --- a/drivers/net/mctp/mctp-i2c.c
> +++ b/drivers/net/mctp/mctp-i2c.c

[ ... ]

> @@ -876,6 +894,9 @@ static int mctp_i2c_add_netdev(struct mctp_i2c_client *mcli,
>  	}
>  
>  	WARN_ON(!mutex_is_locked(&driver_clients_lock));
> +	if (mctp_i2c_find_dev(mcli, adap))
> +		return 0;
> +

[Severity: Low]
The commit message gives this reason for the skip:

  mctp_i2c_add_netdev() now skips an adapter that already has a netdev,
  so a probe walk or an add notifier that reaches an adapter a second
  time no longer fails on the duplicate mctpi2c name.

Can a probe walk actually reach an adapter twice? mctp_i2c_probe()
allocates a new mcli with an empty devs list. It holds driver_clients_lock
for the whole i2c_for_each_dev() walk, and bus_for_each_dev() visits each
device only once. The dev_groups attributes are created only after probe
returns, so a sysfs add can't come first either.

The duplicates that can happen seem to be on the notifier side:

- an adapter is already on the bus klist, so the probe walk picks it up,
  and then BUS_NOTIFY_ADD_DEVICE fires for it;
- a sysfs add lands before the ADD_DEVICE notifier.

Could the commit message describe those cases instead?

The commit message body also doesn't mention that mctp_i2c_notifier_call()
now runs mctp_i2c_notify_del() on BUS_NOTIFY_REMOVED_DEVICE. That reason
appears only in the v3 notes below the cut line and in a code comment. The
v3 notes are dropped when the patch is applied.

>  	snprintf(namebuf, sizeof(namebuf), "mctpi2c%d", adap->nr);
>  	ndev = alloc_netdev(sizeof(*midev), namebuf, NET_NAME_ENUM, mctp_i2c_net_setup);
>  	if (!ndev) {

[ ... ]

> +static ssize_t mctp_i2c_controller_write(struct device *dev, const char *buf,
> +					 size_t count, bool add)
> +{
> +	struct mctp_i2c_client *mcli = i2c_get_clientdata(to_i2c_client(dev));
> +	struct i2c_adapter *adap;
> +	int rc = 0;
> +
> +	if (!ns_capable(current->nsproxy->net_ns->user_ns, CAP_NET_ADMIN))
> +		return -EPERM;

[Severity: Medium]
Is a check against the writer's own netns user namespace strong enough
here?

Any task can do unshare(CLONE_NEWUSER | CLONE_NEWNET) and then hold
CAP_NET_ADMIN in that namespace. So this check passes for anyone who can
open the attribute, and the root-owned 0200 file mode is the only real
gate. A privileged process could pass an open fd into a user-namespaced
context, or an admin could chown the attribute to a delegated user.

On add, mctp_i2c_add_netdev() does:

	dev_net_set(ndev, current->nsproxy->net_ns);

This puts the netdev for a physical I2C bus directly into a netns the
writer owns. Moving a physical netdev out of init_net over rtnetlink needs
CAP_NET_ADMIN in the source netns as well as the destination.

On remove, the branch below never checks dev_net(midev->ndev):

	else if (!mctp_i2c_find_dev(mcli, adap))
		rc = -ENODEV;
	else
		mctp_i2c_remove_netdev(mcli, adap);

A writer that has CAP_NET_ADMIN only in its own namespace can therefore
unregister an MCTP netdev in init_net. That includes one created at probe
time from the devicetree "mctp-controller" property. rtnetlink doesn't
allow that.

The commit message says "a write requires CAP_NET_ADMIN there, as for a
netdev created over rtnetlink". That comparison seems to hold only for
creating virtual devices.

Would capable(CAP_NET_ADMIN) fit better here? mctp_serial_open() in
drivers/net/mctp/mctp-serial.c already uses that check.

> +
> +	mutex_lock(&driver_clients_lock);
> +	adap = mctp_i2c_find_named(mcli, buf);
> +	if (IS_ERR(adap)) {
> +		rc = PTR_ERR(adap);
> +		goto out;
> +	}
> +
> +	if (add && mctp_i2c_find_dev(mcli, adap))
> +		rc = -EEXIST;
> +	else if (add)
> +		rc = mctp_i2c_add_netdev(mcli, adap);

[Severity: High]
This bug predates this patch, but the new store makes it reachable
from userspace. Can a failed registration free midev twice on this path?

mctp_i2c_add_netdev() calls mctp_register_netdev(), which reaches
register_netdevice(). Several of its failure paths call ndo_uninit:

- netdev_check_ops failure
- pcpu stats allocation failure
- a NETDEV_POST_INIT notifier veto
- a netdev_register_kobject() failure such as ENOMEM
- a NETDEV_REGISTER notifier veto, via unregister_netdevice_queue()

The first four reach err_uninit:

net/core/dev.c:register_netdevice() {
    ...
err_uninit:
	if (dev->netdev_ops->ndo_uninit)
		dev->netdev_ops->ndo_uninit(dev);
    ...
}

For this driver that is mctp_i2c_ndo_uninit()->mctp_i2c_midev_free(). That
function does list_del(&midev->list) and drops the get_device() references
on the adapter and the client.

The error then comes back to mctp_i2c_add_netdev(), which frees midev a
second time:

drivers/net/mctp/mctp-i2c.c:mctp_i2c_add_netdev() {
    ...
err:
	if (midev)
		mctp_i2c_midev_free(midev);
	if (ndev)
		free_netdev(ndev);
    ...
}

The second list_del() runs on poisoned pointers. The adapter and client
refcounts are also dropped twice, which can free those devices while they
are still in use.

Before this patch, only probe and the bus notifier reached this path. Now
add_mctp_controller lets a writer trigger it repeatedly.

The v3 notes point to a separate fix for this double free:

https://lore.kernel.org/netdev/20261118090515.3390034-1-kenny_hsieh@jabil.com/

That fix isn't in this tree yet, and the err: path above is unchanged.
Should that fix land before this patch, or together with it?

> +	else if (!mctp_i2c_find_dev(mcli, adap))
> +		rc = -ENODEV;
> +	else
> +		mctp_i2c_remove_netdev(mcli, adap);
> +	put_device(&adap->dev);
> +out:
> +	mutex_unlock(&driver_clients_lock);
> +	return rc < 0 ? rc : count;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118100231.3827609-1-kenny_hsieh%40jabil.com
