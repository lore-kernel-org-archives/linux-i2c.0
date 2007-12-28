From: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [PATCH 0/5] Version 17,  series to add device tree naming to i2c
Date: Fri, 28 Dec 2007 13:14:28 +0100
Message-ID: <uyqq2ui6.1198844066.4263970.khali@gcu-squad.org>
References: <9e4733910712270847j35778e43i66fda3eca9dc125@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753887AbXL1MOs@vger.kernel.org>
In-Reply-To: <9e4733910712270847j35778e43i66fda3eca9dc125@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jonsmirl@gmail.com
Cc: i2c@lm-sensors.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


Hi John,

Le 27/12/2007, Jon Smirl =E9crit:
>On 12/19/07, Jon Smirl <jonsmirl@gmail.com> wrote:
>> Another rework of the i2c for powerpc device tree patch. This versio=
n implements standard alias naming only on the powerpc platform and onl=
y for the device tree names. The old naming mechanism of i2c_client.nam=
e,driver_name is left in place and not changed for non-powerpc platform=
s. This patch is fully capable of dynamically loading the i2c modules. =
You can modprobe in the i2c-mpc driver and the i2c modules described in=
 the device tree will be automatically loaded. Modules also work if com=
piled in.
>
>Are there any further objections to this patch? Can it all go in
>through the powerpc trees or do the i2c people want to send it on?

I am on vacation until January 4th. I will review your patchset the wee=
k
following my return.

Thanks for your patience,
--
Jean Delvare
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
