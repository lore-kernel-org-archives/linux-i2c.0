From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: build #350 issue for v2.6.25-rc1 in
 drivers/i2c/busses/i2c-i801.c
Date: Tue, 12 Feb 2008 11:44:13 +0100
Message-ID: <20080212114413.0e99a238@hyperion.delvare>
References: <200802120938.42487.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200802120938.42487.toralf.foerster-Mmb7MZpHnFY@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Toralf =?ISO-8859-1?B?RvZyc3Rlcg==?= <toralf.foerster-Mmb7MZpHnFY@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Toralf,

On Tue, 12 Feb 2008 09:38:35 +0100, Toralf F=F6rster wrote:
> the build with the attached .config failed, make ends with:
> ...
>   LD      drivers/i2c/busses/built-in.o
>   CC [M]  drivers/i2c/busses/i2c-i801.o
> drivers/i2c/busses/i2c-i801.c: In function 'i801_probe':
> drivers/i2c/busses/i2c-i801.c:636: error: implicit declaration of functio=
n 'pci_request_region'
> drivers/i2c/busses/i2c-i801.c:676: error: implicit declaration of functio=
n 'pci_release_region'
> make[3]: *** [drivers/i2c/busses/i2c-i801.o] Error 1
> make[2]: *** [drivers/i2c/busses] Error 2
> make[1]: *** [drivers/i2c] Error 2
> make: *** [drivers] Error 2
> =

> The build was made with :
> $> make mrproper && make rndconfig && <tweak config file> && make oldconf=
ig && make
> =

> Here's the config:
> =

> #
> # Automatically generated make config: don't edit

Note, it says: don't edit.

> # Linux kernel version: 2.6.25-rc1
> # Mon Feb 11 17:42:48 2008
> #
> (...)
> # CONFIG_PCI is not set
> (...)
> # CONFIG_I2C is not set
> CONFIG_I2C_I801=3Dm

You set CONFIG_I2C_I801=3Dm while PCI and I2C are both disabled. You
asked for a built breakage, you got it.

You might argue that "make oldconfig" should fix the configuration file
in such a way that the dependencies are correct again. But then this is
a kconfig issue, to be reported to the kconfig maintainer, not me.

-- =

Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
