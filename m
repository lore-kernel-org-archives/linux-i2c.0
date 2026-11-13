Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565323;
	b=W0dT0R4qtYh9LIuHmTjCHU/7SYasLdaWuZo6O2GvZESpHbhNO2psC/nmhpKV8l6U9Bf+
	 SDwvnijQNyj5htirMWxJar8cKV6RHtM0uTpnhlZNAG0iUIe9bsnlOCFagTTICj9820cCa
	 KlM2odIeGQyYSQFWZQyP8zMBZ1+rTIrdloEVBeuMuq1iWsCwENKc/rrYmHQHiA6uyol/h
	 ydA6L935ZyPqNqDB8j3xlwoMa9ITirpy/LveWJ0zFSUgvpVR98Pwhz2mY6cID6LwSwrLB
	 qnYANNH8XElKc6RWQyy+1rhRbWmZauIL0zl5ttHuUw57vYRjW3hGxUyBO220dnuYs5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565323;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=msv21g4EpQc6YMT9Pbz13eF8yrETCKSvopiKrlkwUtU=;
	b=49unkvkUdVhDR8wD9s+r23jj6bfYJS+jBdGlgHhFFqaR+FFqalrMZ8STXXMWPkK7aCpO
	 NslrpmD3ZFgR4HIYr6cR+/j7A1vj1P2kNMoW2t1OnE4E+oviIjnmMJ0UN9ex6x6KSQ/nN
	 JMIIuoReAVLJesXQGBmuQFaQ00GK/h6TulNLECOCD0vVatElAvIajdPhkij2VWAtNkKQV
	 Z13Ohc/9biE3pmGV9YySk8pdJ88BhkNQUQAGSERJQNYj2KCetHazzOvE6w3Bx0AhdaTQW
	 itNjouCfKxY7HIs1CS/ZT+W37rPscJkk2wa9DJQWGOjNnnPTpCypVRTtLSw+e6zfnng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QPS/AbJn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848B5606A89B;
	Fri, 13 Nov 2026 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QPS/AbJn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96C71F000C9;
	Fri, 13 Nov 2026 10:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794565322;
	bh=msv21g4EpQc6YMT9Pbz13eF8yrETCKSvopiKrlkwUtU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QPS/AbJnrSPqI+VX5yUtveCpDo14XM0+F/077L2q/nFJUWUH/Uwv03xtACUfluFt1
	 pvpyzCb56dbe9TmQPUyhJsUye/MJjj9XYaiMgaGWA6+2doRqhaBrwA5ThNvTpK/dvf
	 HhxmNY9YdKzAA9vcqMG6jUoPgGmaEBPMFK8Yi1GJhoGb1VRCYzH41EhQsXCBNoucbA
	 yCNLXkTcwJ9VukNbvJVBPkOwa0/ObJ5wJPmgo8LXevBSbYQM6DnguSvqy8hJmxjR/M
	 pQm6GedSSHivuO/KlQmqVNtTSplYa4NgCCPXQ3TQ9TTNqrekbGJ8vnFrC/P6xAQ3SF
	 +bi2PbctWYcUQ==
Subject: Re: [PATCH net-next 3/3] ptp: ocp: add WiWi Time Card production
 image support
From: netdev-bot+sashiko@kernel.org
To: ahmadexp@gmail.com
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, andi.shyti@kernel.org,
 linux-i2c@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 13 Nov 2026 10:22:01 +0000
Message-ID: <179456532138.2199510.9610534349392524646@kernel.org>
In-Reply-To: <20261111041904.48916-4-ahmadexp@gmail.com>
References: <20261111041904.48916-4-ahmadexp@gmail.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says the WiWi register interface 'matches the
  Celestica LitePCIe production image; the VID and flash header differ'.
- [Low] On WiWi, ptp_ocp_probe() makes the PHC visible to userspace at
  ptp_clock_register() (drivers/ptp/ptp_ocp.c:6188).

--

ptp: ocp: add WiWi Time Card production image support

This adds a PCI ID match for the WiWi 2163:1008 Time Card. Before the
card is initialized, the driver checks its PCI layout and core versions.
The ocp_fb_resource entries are translated by 0x02000000 and their
interrupt inputs by 32. UART and XIIC use 32-bit accesses, and a LitePCIe
per-input interrupt gate at BAR0 + 0x1800 is managed during probe and
removal. devlink flash updates are rejected on WiWi cards.

> diff --git a/Documentation/networking/devlink/ptp_ocp.rst b/Documentation/networking/devlink/ptp_ocp.rst
> index f94b759d9cd65..a81dc113688b6 100644
> --- a/Documentation/networking/devlink/ptp_ocp.rst
> +++ b/Documentation/networking/devlink/ptp_ocp.rst

[ ... ]

> @@ -73,3 +74,35 @@ with the standard devlink status notifications.
>  Example::
>  
>      $ devlink dev flash pci/0000:02:00.0 file adva-cpld.bin component fw.cpld
> +
> +WiWi production firmware
> +========================
> +
> +WiWi Time Cards with PCI ID ``2163:1008`` and subsystem ID ``10ee:0007``
> +use the Celestica register layout behind a LitePCIe bridge. The driver

[ ... ]

> +The image uses the Celestica LitePCIe production map: add ``0x02000000``
> +to the peripheral offsets and use aligned 32-bit MMIO. Interrupt input
> +``n`` uses MSI-X vector ``n + 32``. The per-input enable mask is at BAR0
> +offset ``0x1800``. The driver enables the SPI interrupt before probing

[Severity: Low]
How does this fit with the existing Celestica entry in ptp_ocp_pcidev_id?

The commit message says "the register interface matches the Celestica
LitePCIe production image; the VID and flash header differ". This section
calls the layout "the Celestica LitePCIe production map".

The Celestica entry binds the same table but gets none of this handling:

	{ PCI_DEVICE_DATA(CELESTICA, TIMECARD, &ocp_fb_resource) },

For 18d4:1008, bp->wiwi is false, so:

- ptp_ocp_register_resources() applies neither the 0x02000000 offset nor
  the +32 vector translation.
- ptp_ocp_serial_line() keeps UPIO_MEM.
- probe allocates 1..17 MSI/MSI-X vectors.
- the 0x1800 gate is never opened.

The earlier xiic patch in this series says the LitePCIe bridge raises a
fatal machine check on subword MMIO.

If a card with the Celestica PCI ID can run the LitePCIe production
image, would it need the same handling?

If it can't, could the changelog and this section say that the existing
Celestica entry targets a different image? That would stop the "Celestica
LitePCIe" wording from suggesting otherwise. The line "Leave non-WiWi
resource tables and access modes unchanged" only says that code is
untouched.

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 625a85b2dc7e5..ee22423890230 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c

[ ... ]

> @@ -6047,6 +6228,11 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  			goto out_dpll;
>  		}
>  	}
> +	/* All handlers and the PHC are ready for timestamp interrupts. */
> +	if (bp->wiwi_msi) {
> +		iowrite32(OCP_WIWI_IRQS, bp->wiwi_msi);
> +		ioread32(bp->wiwi_msi);
> +	}
>  	queue_delayed_work(system_power_efficient_wq, &bp->sync_work, HZ);

[Severity: Low]
Can a timestamper stop delivering interrupts if it is armed before this
gate write?

Earlier in ptp_ocp_probe(), this call makes the PHC visible to userspace:

	bp->ptp = ptp_clock_register(&bp->ptp_info, &pdev->dev);

The timing inputs (0-2, 6, 11-16) are only opened here. That happens
after ptp_ocp_complete(), devlink_register() and the DPLL device and pin
registration.

During that window, userspace can arm a timing core:

- PTP_EXTTS_REQUEST or PTP_ENABLE_PPS on /dev/ptpN
- enabling a signal generator through sysfs

Each of these goes through ptp_ocp_ts_enable(). If an event arrives
while the gate is still closed, it sets the core's sticky interrupt
status. Only the ack in ptp_ocp_ts_irq() clears it:

	iowrite32(1, &reg->intr);	/* write 1 to ack */

Whether that event gets delivered once the gate opens depends on how the
LitePCIe enable mask handles inputs that are already asserted. The patch
doesn't document that behaviour.

If the gate only detects edges, would that channel deliver no more
MSI-X interrupts until userspace disables and re-enables it?

Would acknowledging the ts/signal intr status after opening the timing
gate make the probe sequence independent of how the gate behaves?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111041904.48916-1-ahmadexp%40gmail.com
