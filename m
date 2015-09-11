From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH v4 0/8] i2c: Relax mandatory I2C ID table passing
Date: Fri, 11 Sep 2015 17:30:35 +0100
Message-ID: <20150911163035.GE18779@x1>
References: <1441972564-9621-1-git-send-email-kieranbingham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441972564-9621-1-git-send-email-kieranbingham@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieranbingham@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Samuel Ortiz <sameo@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, javier@osg.samsung.com
List-Id: linux-i2c@vger.kernel.org

On Fri, 11 Sep 2015, Kieran Bingham wrote:
> Hi Wolfram,
>=20
> I have picked this patchset [0] up from Lee to rebase it, with an aim=
 to
> get this series moving again.
>=20
> This resend fixes up my SoB's as highlighted by Lee
>=20
> A couple of minor issues were resolved in the rebase. As it stood, Ja=
vier
> proposed [1] to merge this series, and use a follow up series to make=
 sure
> that all I2C drivers are using a MODLE_DEVICE_TABLE(of,...)
>=20
> I have prepared a Coccinelle patch to work through the bulk of the ch=
anges
> required for the conversion, which will assist the transition process=
=2E
>=20
> Once this patch set is accepted, I will commence converting the other
> drivers, and submitting with a per subsystem breakdown or simliar to
> reduce traffic.
>=20
> [0] https://lkml.org/lkml/2014/8/28/283
> [1] https://lkml.org/lkml/2014/9/12/496

I appreciate that my SoB is on every patch, but this set still looks
good to me, so for extra clarification:

Acked-by: Lee Jones <lee.jones@linaro.org>

[...]

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
