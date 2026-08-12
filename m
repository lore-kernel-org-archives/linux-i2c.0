Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202482E7397;
	Wed, 12 Aug 2026 05:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513667; cv=none; b=idBDM+ZfdLHF70vdTmvwrcKwoemilOuxp/xxip+AV4JHtMhJwJz8pZg0AocEeb4AKFsuyK2Qizs7G79jFE8LYldN8kRVJ2R/z+9dzW3xLqts728UI9u4Q5cDpOSzdXcWpL/QMbwpwBa/eTEHw9dZ3WxWmN3PVieHlwrqNdI1YL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513667; c=relaxed/simple;
	bh=45kXpICPk2fQlHBOyTHvZ8n5In6ehM3cu9U3J0fp2cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5L/sEzcw8pPjzC7OGs+n7jBe3wmaYXFiqFYum9RI61gTwOgvHrTvYw0nqDOOJ6u+v5nFSyKY86QpUrWsxu8Tq91Z3yYzJNDB0V7bb26mgS8K0jYDbLQXSN6g53khaVEV3DQwEZgchdgoTvIAlxNqzoy7lhRgfDCdn8Wsa2SfTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=T1ESoodO; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="T1ESoodO"
Received: from L30177.local (unknown [IPv6:2a01:e0a:ac2:22b0:7d8d:27f7:7380:ca30])
	(Authenticated sender: vjardin@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id A2289B0054E;
	Wed, 12 Aug 2026 07:47:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1786513655;
	bh=45kXpICPk2fQlHBOyTHvZ8n5In6ehM3cu9U3J0fp2cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1ESoodOBaikyKpT2rC28GxM4wtzx+caAaLrGFANJbgT5BCATQd1QBXWTImHBzkT4
	 APZqNqzgrhgQhBP3lgDFSn/A0VP49JwOQfHo9lJwls+XMyA5LyFielDVwpI3iC0Zn9
	 78owLe6cCVPT0bdGhqRpJD6DYsic8/0SCJii73qgEXjmR6wJKd12IE82vze1OZsDJY
	 URMwQwV7owzdW7pzJ6nLE2zJbRRi/FkdpTVFVlzGm9NVXZxZEAHY5eyUqpufEKvdr9
	 S50ppMq++G6g/ufJrRkl8J3no1iiAD2ijsPZ3AkkVsbDjxtIE1z2DzawqRcqPvdrcO
	 bq/vgk2nDgfxA==
Date: Wed, 12 Aug 2026 07:47:22 +0200
From: Vincent Jardin <vjardin@free.fr>
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>, Frank Li <frank.li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: imx: add I2C_M_REV_DIR_ADDR and I2C_M_NOSTART
Message-ID: <anwI6qnsikPrd80W@L30177.local>
References: <20260807-for-upstream-i2c-imx-lx2160-reverse-v1-1-f276ce8cb660@free.fr>
 <AM0PR04MB6802658862C4E2ED8628FFA8E8DD2@AM0PR04MB6802.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB6802658862C4E2ED8628FFA8E8DD2@AM0PR04MB6802.eurprd04.prod.outlook.com>

Hi Carlos,

Thanks a lot for the review, and no problem for the delay.

> This is a such rare i2c frame design in the Realtek RTL8366SE SMI read
> frame, right?

It is rare, but I have been inspired for I2C_M_REV_DIR_ADDR by the source
of two client drivers that use it.

Note that I2C_M_NOSTART is not rare at all. It is what regmap uses for a real
gather write. regmap_i2c_gather_write() opens with

        if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_NOSTART))
                return -ENOTSUPP;

FYI, some clients that need REV_DIR_ADDR and NOSTART,

  drivers/input/joystick/as5011.c
  drivers/video/fbdev/matrox/matroxfb_maven.c

both build the identical 2-message pattern,

  i2c_check_functionality(adapter,
                                I2C_FUNC_NOSTART |
                                I2C_FUNC_PROTOCOL_MANGLING)

I do not have those devices, so I did not check it beside code readings.

Some clients that need NOSTART alone,

  drivers/base/regmap/regmap-i2c.c
  drivers/infiniband/hw/hfi1/qsfp.c
  drivers/gpu/drm/i915/display/dvo_ivch.c

About the i2c masters, that use I2C_M_REV_DIR_ADDR in code,

  drivers/i2c/algos/i2c-algo-bit.c
  drivers/i2c/algos/i2c-algo-pcf.c
  drivers/i2c/busses/i2c-s3c2410.c <- the model I did investigate
  drivers/i2c/busses/i2c-tegra-bpmp.c
  drivers/media/pci/cobalt/cobalt-i2c.c

So a taxnonomy can be,

  adapter            REV_DIR impl   MANGLING adv   NOSTART adv   usable
  i2c-algo-bit           yes            yes            yes         yes
  i2c-algo-pcf           yes            yes            no          no
  i2c-s3c2410            yes            yes            yes         yes
  i2c-tegra-bpmp         yes            yes            yes         yes
  cobalt-i2c             yes         (private adapter, not exposed)
  i2c-brcmstb            no             yes            yes         no
  i2c-pxa                no             yes            yes         no
  i2c-tegra              no             yes         yes (cond)     no
  i2c-imx (this patch)   yes            yes            yes         yes

> Is Realtek RTL8366SE SMI driver upstream? Can I found the driver?

Not yet, and I cannot point you at a tree today. It is Realtek's
"Unmanaged Switch" DSA driver, which is not public yet.

What I can share is the message construction, which is the part you
asked about and is not Realtek-specific.

        static int as5011_i2c_read(struct i2c_client *client,
                                   uint8_t aregaddr, signed char *value)
        {
                uint8_t data[2] = { aregaddr };
                struct i2c_msg msg_set[2] = {
                        {
                                .addr = client->addr,
                                .flags = I2C_M_REV_DIR_ADDR,
                                .len = 1,
                                .buf = (uint8_t *)data
                        },
                        {
                                .addr = client->addr,
                                .flags = I2C_M_RD | I2C_M_NOSTART,
                                .len = 1,
                                .buf = (uint8_t *)data
                        }
                };
                int error;

                error = i2c_transfer(client->adapter, msg_set, 2);
                if (error < 0)
                        return error;

                *value = data[0] & 0x80 ? -1 * (1 + ~data[0]) : data[0];
                return 0;
        }

And the Realtek accessor, which is the same two messages with a 2-byte
register and 2-byte data instead of 1 and 1:

        u8 ra[2]   = { reg & 0xff, (reg >> 8) & 0xff };
        u8 data[2] = { 0xff, 0xff };
        struct i2c_msg msgs[2] = {
                {
                        .addr  = client->addr,
                        .flags = I2C_M_REV_DIR_ADDR,
                        .len   = sizeof(ra),
                        .buf   = ra,
                }, {
                        .addr  = client->addr,
                        .flags = I2C_M_RD | I2C_M_NOSTART,
                        .len   = sizeof(data),
                        .buf   = data,
                },
        };

        ret = i2c_transfer(client->adapter, msgs, 2);
        if (ret != 2)
                return ret < 0 ? ret : -EIO;

        *val = data[0] | (data[1] << 8);

msgs[0] is a write message carrying I2C_M_REV_DIR_ADDR, so the address
byte goes out with the read bit set while the master keeps transmitting
the two register-address bytes. msgs[1] is the read half with
I2C_M_NOSTART, so no repeated start is emitted and the controller simply
turns the bus around. Writes are an ordinary unflagged 4-byte write and
need nothing from this patch.

> ... Have you test this i2c-imx feature in your LS board with RTL8366SE?

Yes, on an LX2160A board carrying four RTL8366SE-CG. Two are strapped to
the chip's 2-wire "EEPROM SMI" mode and hang off hardware i2c-imx
controllers; the other two are on MDIO, for both the same switch registers
are reachable both ways and should answer the same values.

First, the failure on an unpatched kernel, which is reproducible with
nothing but i2ctools and is I think the clearest way to see the problem.
These two commands are byte-identical:

        # i2ctransfer -y -f -a 1 w2@0x7c 0x00 0x13 r4@0x7c
        0xff 0xff 0x00 0x00
        # i2ctransfer -y -f -a 1 r6@0x7c        # no preceding write at all
        0xff 0xff 0x00 0x00 0x00 0x00

Then, with this patch both chips answer correctly. For testing this patch,
I did use the following that I have just pushed to help, for the record:

        https://github.com/vjardin/smi-probe

        # smi-probe -t i2c -b /dev/i2c-1 -a 0x7c id
        chip_num    0x6980  CHIP_RTL8367E (inside RTL8366SE-CG)
        chip_ver    0x0030
        svlan_tpid  0x88a8  reset default, as expected

        # smi-probe -t i2c -b /dev/i2c-1 -a 0x7c rd 0x1300
        reg 0x1300 = 0x6980
        # smi-probe -t i2c -b /dev/i2c-1 -a 0x7c rd 0x1202
        reg 0x1202 = 0x88a8

        # smi-probe -t i2c -b /dev/i2c-2 -a 0x5c rd 0x1202 # U19, IIC3
        reg 0x1202 = 0x88a8
        # smi-probe -t mdio -b 0x8b97000 -a 0x1a rd 0x1202 # MDIO control
        reg 0x1202 = 0x88a8

Then it binds as a DSA switch and enumerates its four user ports:

        realtek-US-switch-dsa-i2c 2-005c: RTK DSA unit 0 (EEPROM SMI, addr 0x5c)

I have many other i2c devices on this board, no regression.

Thanks again for your review,
  Vincent
