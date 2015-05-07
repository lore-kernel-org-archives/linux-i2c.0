From: Lee Jones <lee.jones@linaro.org>
Subject: Re: Why isn't IRQ shared for i2c-ocore
Date: Thu, 7 May 2015 08:01:49 +0100
Message-ID: <20150507070149.GB3400@x1>
References: <55304D8E.8070204@freescale.com>
 <55312AF7.7070504@freescale.com>
 <20150420064231.GE3447@x1>
 <55352839.70905@freescale.com>
 <20150420181651.GF3447@x1>
 <5535460B.2060309@freescale.com>
 <20150421073534.GK3447@x1>
 <554A8A8B.1020703@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <554A8A8B.1020703@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: York Sun <yorksun@freescale.com>
Cc: Julia.Lawall@lip6.fr, linux-i2c@vger.kernel.org, wolfram@the-dreams.de, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

> I have a follow up question regarding interrupt. I see many I2C bus d=
rivers
> request interrupt with flag =3D 0. Why not using IRQF_SHARED?

Probably because that particular IRQ is only used by the I2C
Controller.  I'm not exactly sure that you're getting at?  Why do you
think it should be shared?  You should only flag it as shared if it
is.

> I understand the performance concern. If there is any other reason, I=
 want to
> know about it before I go too far on my driver.

This sort of stuff is trivial to fix and shouldn't stand in the way
of you writing and submitting v1 of your driver.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
