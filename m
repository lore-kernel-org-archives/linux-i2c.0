Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129B31282F;
	Sat, 10 Oct 2026 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791663289; cv=none; b=Gvshr1eiPrziO/88makT45GjVZECdyO9c72tQ261gsiGMvJuSjV5O2KPO3cp65/S38q8YAuxbxEOOHnINvagP6OfnjJRoMt4ETJ7DSTBYiOjuR7fHSQOwjS+l9Y8wHktgOGdqT6ZhUTTRC8njvek0S0qYb8PqgY7zA+sfO3ZTRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791663289; c=relaxed/simple;
	bh=iCgdcsh25B8wEUuF+bnVSjG3edMBuHkSzO1PSPziEtk=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:Mime-Version:
	 References:In-Reply-To; b=kh3JyVFBTCdG8lXIpOrNR4ubJVHtNqOn8Fo00UW/gZJXdGjznIdS/UH0UgPdgm/IUoTcECSiS2TJLE78+5DnYhkAN1E+4ZGGII2oH8ShZFc8/jIRRx+sJGwKMYJUTXsZCGNZZgD/MXTJfH52FZAMa/iKClPdc9JQqXvZXHAcyhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiQLPb9e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiQLPb9e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A241F000FF;
	Sat, 10 Oct 2026 20:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791663287;
	bh=PfND1oxrSlch9gNnjXBMa6fzwmkDvGzc9OOWiypHiX0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=JiQLPb9etvz46/L3KeTPl2cJGgxsD7Fol2NCJTExAUY9sAfRnfiV8XSxYfUAgmYAB
	 fbv5AK6cAx7N/IRNJZf5o4ims+AXXOLoaLlBc4tTHINYnmXnM19KOZwp5l/NUy1jM2
	 lPUGzpWgl4YNDZhVsfG/v8MNk/BqXeEXPrtYPyVZbaseNo+yiJkk4rtWyEgI3lXc/O
	 avVwqNvu9nc6n/Io9/tLHTJbDAWwul7QoAidQCXCcT9SZf+ppcYHRzjKYmvSPJNW+j
	 n05qDXo/XHlAXbqW2KFN6g/RKHlLY916XCEsaALCb8pXITmzMqR3oBd2kbF1ZMYB33
	 THPILcvbp6ZEA==
Content-Type: text/plain; charset=UTF-8
Date: Sat, 10 Oct 2026 22:14:44 +0200
Message-Id: <DM1FMM3KEYU9.1D26IINII93FO@kernel.org>
Subject: Re: [PATCH] drm/xe/i2c: Fix use-after-free on driver unload
Cc: <intel-xe@lists.freedesktop.org>, <rodrigo.vivi@intel.com>, "Bartosz
 Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>, "Heikki Krogerus"
 <heikki.krogerus@linux.intel.com>, "Andi Shyti" <andi.shyti@kernel.org>,
 <linux-i2c@vger.kernel.org>, <driver-core@lists.linux.dev>
To: "Balasubramani Vivekanandan" <balasubramani.vivekanandan@intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20261009164241.923756-2-balasubramani.vivekanandan@intel.com>
In-Reply-To: <20261009164241.923756-2-balasubramani.vivekanandan@intel.com>

(Cc: i2c, driver-core)

On Fri Oct 9, 2026 at 6:42 PM CEST, Balasubramani Vivekanandan wrote:
> The kernel crashes when unloading the xe driver on CRI:
>
>  Oops: general protection fault, probably for non-canonical address 0x6b6=
b6b6b6b6b6b73
>  RIP: 0010:platform_device_release+0x80/0x90
>  Call Trace:
>   device_release+0x44/0xa0
>   kobject_put+0x9b/0x250
>   put_device+0x13/0x30
>   platform_device_unregister+0x29/0x40
>   xe_i2c_remove+0x80/0xa0 [xe]
>   devm_action_release+0x16/0x30
>   release_nodes+0x3d/0x140
>   devres_release_all+0x96/0xd0
>
> This started after commit 0f485f88656af ("drm/xe/i2c: use
> device_create_managed_software_node()"), which attaches a managed
> software node to a platform device created with platform_device_alloc().
>
> Comment above the device_create_managed_software_node function cautions
> that the software node created by it should not be shared or reused as
> the lifetime of the node is linked to the device.

Yes, it does not distinguish between provider and consumer and hence always
calls swnode_put() in the managed path of software_node_notify_remove().

This seems to be a bit of a footgun, and I think we should address this.

> But the DesignWare i2c driver which creates an adapter device as a child
> of the platform device reuses the software node as its fwnode.
> (device_set_node() in i2c_dw_probe()).
>
> During module unbind, when the adapter device is deleted, it drops the
> reference count for the software node and frees the software node.
> Later when the platform device is removed, it tries to dereference the
> software node pointer and results in use-after-free.
>
> Instead of managed software node use a static struct software_node
> passed through platform_device_info.swnode to
> platform_device_register_full().
> But we have a blocker which doesn't allow to use
> platform_device_register_full() simply.

I think this works out as the I2C adapter and hence its children are destro=
yed
when the platform device is unregistered.

But also note that technically this approach has some friction in its lifet=
ime
model: The software node pointer stored only lives as long as the Xe module=
 and
becomes invalid after module unload. The structures this pointer is shared =
with
are reference counted though and could technically be longer lived.

Thanks,
Danilo
