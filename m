From: Jean Delvare <khali@linux-fr.org>
Subject: Re: I2C_PARPORT_LIGHT dependence problem
Date: Sun, 20 Jan 2008 11:11:51 +0100
Message-ID: <20080120111151.08b0266a@hyperion.delvare>
References: <BAY101-W29C4113A3B79204F64B0DCC8430@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753543AbYATKMS@vger.kernel.org>
In-Reply-To: <BAY101-W29C4113A3B79204F64B0DCC8430@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Turk <bofh1234@hotmail.com>
Cc: linux-kernel@vger.kernel.org, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

Hi Adam,

On Sat, 19 Jan 2008 13:37:05 -0500, Adam Turk wrote:
> I am updating an old config to run on 2.6.23.14 and noticed I am
> still prompted for I2C_PARPORT_LIGHT even though I don't have
> the parallel port driver enabled.  Shouldn't I2C_PARPORT_LIGHT
> depend on the parallel port being selected? (...)
>=20
> Symbol: I2C_PARPORT_LIGHT [=3Dn]
>   =E2=94=82 Prompt: Parallel port adapter (light)
>   =E2=94=82   Defined at drivers/i2c/busses/Kconfig:348
>   =E2=94=82   Depends on: I2C
>   =E2=94=82   Location:
>   =E2=94=82     -> Device Drivers
>   =E2=94=82       -> I2C support (I2C [=3Dm])
>   =E2=94=82         -> I2C Hardware Bus support
>   =E2=94=82   Selects: I2C_ALGOBIT

The help text says:

"This driver is a light version of i2c-parport.  It doesn't depend on
the parport driver, and uses direct I/O access instead."

So I think that the (lack of) dependencies is correct. We don't want to
force the user to select PARPORT (and built the parport driver) to get
access to the i2c-parport-light driver which does NOT need this parport
driver.

--=20
Jean Delvare
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
