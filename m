Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610278;
	b=AqF3OrPAST4wa1U2VQcEVNm+upZKmvio/E9+SOHzkwFOaFnfOutrO3hWompSKrD1jhB1
	 /96+s3uPboTpg5q3dwkcXsoejDbsJ+1hs0I0hU5pqlq/3Mk7h1sIG57MZ4ogrtDEI2oqo
	 ieOmCrCN01okoLgJQ0ujmb6/nIgNDa2wqtJyHBL74O4R9z1Cu/jMac7QSHm8+I62oM6Zd
	 Nzla78vSQNjYmMLKTozYtT8vyNaroMj8lNtyGNXTcIjT/hgJgNpTo9XSZhS4qtpKD44xR
	 qcP107SFJS57YnqHL1rRRu64uIqmRvorYbESyldg/giux4ZQiVSREk8usKZ8VpUus2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610278;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=Yev0hfaXosEbpEcqTujskpvy3SSpHx96TzRdJOzYIRY=;
	b=Yw1TjWpb4YmmU44gAIoDqvP+07AqaV9T3pzdCkqfP09t9mAwJG0Bh9wkNkEbp3wCk7Uw
	 kA5qa87bE2d7rjQRCzy/zCaLRjTJsVcYRO/kQ9BL4EGoAyAo0Iao/HEgHzMwaBbr6WGp/
	 XB0dpJovWItfoHB2Zg4Sa1TQYu+cgSD/pP7GT0AxytNArNGlKTAf/Ou+dqXE0lTuhxCj5
	 pfOKnBQlfudtTvqAUopsdUDnhECIXv4CIQDdZZZiopOpHNP+xLvy836KR5fBJ0lvA5Avk
	 vzF33eBPEYc921WX4zOsAX96zxYbL4dWwoSm6I1pvfXKN719Kl+NtwRR8WrGiLvdVVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codeconstruct.com.au;
	spf=pass smtp.mailfrom=codeconstruct.com.au;
	dkim=pass header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=NmWwpHqp;
	arc=none smtp.remote-ip=203.29.241.158
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10D8606A324;
	Mon,  2 Nov 2026 09:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F10D8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=NmWwpHqp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1793610275;
	bh=Yev0hfaXosEbpEcqTujskpvy3SSpHx96TzRdJOzYIRY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NmWwpHqpEIHX6LKkKExcC+gdQkrGjuidbolYONWq6psfQ4W9uxLDvj84Gi5aw/6h5
	 leaUPF7Al1yr3r/hRYrh0F3VGK+0iD/rAQ6va5iEwBToIXG9NtGwugXT6WQt2O+Pue
	 uxkVgamw6U4LEioXH8bPUBxjhEM55GfkqJJmSouaTVEEU6O3t7sq3uoMDH5el/UWka
	 c2OBAqjrTiq11sVLLJiWMqvmxtHw2s30PVchtYDhbnnLbtpy3/f8bsABtXT5Q5buLI
	 DCZLwHmdofLqtTmkfKnCynN+oKtP0/K+sOejbYC2AwQcj5ICRZNSAAzokfuaFmH6QA
	 7Xgk4wGATQkLg==
Received: from [192.168.12.105] (unknown [144.6.157.237])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C47B1648DC;
	Mon,  2 Nov 2026 17:04:31 +0800 (AWST)
Message-ID: <7486b1fc4dbcca755dd2f6b6de54d17919af873a.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v2] mctp i2c: add sysfs control for mux child
 netdevs
From: Matt Johnston <matt@codeconstruct.com.au>
To: Kenny Hsieh <kenny_hsieh@jabil.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "jk@codeconstruct.com.au"	 <jk@codeconstruct.com.au>,
 "andi.shyti@kernel.org" <andi.shyti@kernel.org>,  "peda@lysator.liu.se"	
 <peda@lysator.liu.se>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
 "davem@davemloft.net"	 <davem@davemloft.net>, "edumazet@kernel.org"
 <edumazet@kernel.org>,  "kuba@kernel.org"	 <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>,  "linux-i2c@vger.kernel.org"	
 <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>
Date: Mon, 02 Nov 2026 17:04:31 +0800
In-Reply-To: <DM8PR02MB808768B7D02FF12777B7777E8E602@DM8PR02MB8087.namprd02.prod.outlook.com>
References: <20261015081341.1262695-1-kenny_hsieh@jabil.com>
	 <179239912623.3135.11352652156626817288@kernel.org>
	 <DM8PR02MB808768B7D02FF12777B7777E8E602@DM8PR02MB8087.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Kenny,

On Tue, 2026-10-27 at 08:58 +0000, Kenny Hsieh wrote:
> Hi Andi, Peter, Matt, Jeremy,
>=20
> > - [High] The store-side guard against adapters being deleted does not
> >   close the race it claims to close.
>=20
> > - [High] mctp_i2c_remove() runs mctp_i2c_remove_sysfs_all() while the
> >   client is still on driver_clients.
>=20
> > - [Medium] mctp_i2c_probe() now releases driver_clients_lock after
> >   list_add() and before i2c_for_each_dev(mcli,...
>=20
> > - [Medium] The new ABI lives on i2c adapter devices, which the I2C core
> >   owns, but the mctp-i2c driver attaches it with sysfs_update_group() o=
n...
>=20
> These races come back to the last point: mctp-i2c bolts the attribute
> onto adapters the i2c core owns. Before I respin I'd like to check which
> way to go.
>=20
> I can keep it in mctp-i2c and fix the races there, mostly by reordering
> notify_del() and remove(), and adding the attributes after the probe
> walk so it can hold driver_clients_lock again. That works, but it's more
> bookkeeping and there's still no uevent for the attribute.
>=20
> The other option is to declare it on i2c_adapter_type in the core and
> have mctp-i2c register the show/store callbacks. That's cleaner, the
> driver core handles the lifetime and most of the races go away, but it
> adds an i2c API with mctp-i2c as its only user.
>=20
> I prefer to keep it in mctp-i2c, but happy to go either way.

I agree it would be cleaner to avoid having mctp-i2c create items in i2c co=
re
sysfs space.

An alternative could be to create sysfs attributes under the mctp-i2c devic=
e
instance itself (the i2c slave).

Mux buses could have mctp-i2c netdevs instantiated with

echo "i2c-6" > /sys/bus/i2c/devices/2-1060/add_mctp_controller

(where i2c-6 is a child mux bus of i2c-2, and i2c-2 0x60 is a mctp-i2c i2c
device).

"echo i2c-6 > .../2-1060/remove_mctp_controller" would remove the mctp-i2c
netdev.
Setting a root node as an mctp controller would involve writing its own nam=
e
to the attribute file.

How does that look to you?

Cheers,
Matt


> > - [High] When mctp_register_netdev() fails, mctp_i2c_add_netdev()
> >   (drivers/net/mctp/mctp-i2c.c) now always sets `midev =3D NULL`, so th=
e...
>=20
> > - [Medium] In the baseline, mctp_i2c_add_netdev() has a real double
> >   teardown.
>=20
> This is the known double free, tracked in a separate patch on net, and
> v3 drops the midev =3D NULL change:
> https://lore.kernel.org/netdev/20261027053715.1623087-1-kenny_hsieh@jabil=
.com/
>=20
> > - [Medium] The new ABI document Documentation/ABI/testing/sysfs-
> >   bus-i2c-devices-mctp says "The attribute appears only on mux child...
>=20
> > - [Medium] mctp_i2c_new_client() now calls `write_pnet(&mcli->net,
> >   get_net(current->nsproxy->net_ns))` before i2c_slave_register().
>=20
> > - [Low] The commit message says "a rebind reattaches it reading 0".
>=20
> > - [Low] The commit message gives "an adapter that the devicetree cannot
> >   describe at all, such as a USB-attached one" as a use case.
>=20
> Will fix all four in v3.
>=20
> > - [Medium] Writing 0 to mctp_controller removes a channel's netdev
> >   through mctp_i2c_remove_netdev() -> mctp_i2c_unregister() ->...
>=20
> The sel reselection on removal isn't new, removing a mux adapter already
> goes down that path. I'd rather leave that for a separate patch and just
> fix the ABI wording here.
>=20
> pw-bot: cr
