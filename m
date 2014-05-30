From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] i2c: Make I2C ID tables non-mandatory for DT'ed and/or
 ACPI'ed devices
Date: Fri, 30 May 2014 20:25:16 +0100
Message-ID: <20140530192516.GA4319@lee--X1>
References: <1401452797-29521-1-git-send-email-lee.jones@linaro.org>
 <1401452797-29521-2-git-send-email-lee.jones@linaro.org>
 <20140530123656.GC2742@katana>
 <20140530133405.GB29731@lee--X1>
 <20140530174800.GA4917@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140530174800.GA4917@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, linus.walleij@linaro.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

> > Would you mind telling me what I have changed that affects drivers
> > registering via Sysfs?
>=20
> Check Documentation/i2c/instantiating-devices, method 4. If a driver
> does not have i2c_device_id, then this method won't work because the
> newly created device has no of_node or ACPI_node and nothing will mat=
ch.
> Looking at the bigger picture, I'd really like to keep this feature.
> People use it.

Right, I read the function which provides the functionality, but my
point is; I don't think my patch changes the semantics in a way which
would adversely affect this option.  If you think that it does, can you
specify how please?

Does the sysfs method create a i2c_device_id table?  If not, how does
it probe successfully pre-patch?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
