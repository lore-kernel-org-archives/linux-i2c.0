From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v3] add MAX17040 Fuel Gauge driver
Date: Tue, 9 Jun 2009 01:00:07 +0400
Message-ID: <20090608210007.GA29332@oksana.dev.rtsoft.ru>
References: <4A28BC20.3010307@samsung.com> <5d5443650906060959w678a29acn8200239d35869dca@mail.gmail.com> <4A2C7911.80407@samsung.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755683AbZFHVAV@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4A2C7911.80407@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Minkyu Kang <mk7.kang@samsung.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-i2c@vger.kernel.org, Anton Vorontsov <cbou@mail.ru>, Andrew Morton <akpm@linux-foundation.org>, kyungmin.park@samsung.com
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 08, 2009 at 11:36:01AM +0900, Minkyu Kang wrote:
> Dear Trilok Soni,
>=20
> Thanks for review
>=20
> > Hi Minkyu Kang,
> >=20
> > On Fri, Jun 5, 2009 at 12:03 PM, Minkyu Kang<mk7.kang@samsung.com> =
wrote:
> >> The MAX17040 is a I2C interfaced Fuel Gauge systems for lithium-io=
n batteries
> >> This patch adds support the MAX17040 Fuel Gauge
> >>
> >=20
> > Thanks for making change. Some more comments.
> >=20
> >>  endif # POWER_SUPPLY
> >> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> >> index 2fcf41d..9c48995 100644
> >> --- a/drivers/power/Makefile
> >> +++ b/drivers/power/Makefile
> >> @@ -25,4 +25,5 @@ obj-$(CONFIG_BATTERY_TOSA)    +=3D tosa_battery.=
o
> >>  obj-$(CONFIG_BATTERY_WM97XX)   +=3D wm97xx_battery.o
> >>  obj-$(CONFIG_BATTERY_BQ27x00)  +=3D bq27x00_battery.o
> >>  obj-$(CONFIG_BATTERY_DA9030)   +=3D da9030_battery.o
> >> -obj-$(CONFIG_CHARGER_PCF50633) +=3D pcf50633-charger.o
> >> \ No newline at end of file
> >> +obj-$(CONFIG_BATTERY_MAX17040))        +=3D max17040_battery.o

There is a typo: "))" should be just ")". I fixed this.

I also fixed "=E2=80=98max17040_set_rcomp=E2=80=99 defined but not used=
" warning
(just removed this function).

> > Are we following any alphabetical order in this Makefile?
> >=20
>=20
> I'm not sure either. :(
> I just grouping with batteries.

It's fine as is. I always wonder when somebody try to sort things
alphabetically. Humans should not bother with sorting, that's what
computers are for! ;-)

> >> +static int max17040_suspend(struct i2c_client *client,
> >> +               pm_message_t state)
> >> +{
> >> +       struct max17040_chip *chip =3D i2c_get_clientdata(client);
> >> +
> >> +       cancel_delayed_work(&chip->work);
> >> +       return 0;
> >> +}
> >> +
> >> +static int max17040_resume(struct i2c_client *client)
> >> +{
> >> +       struct max17040_chip *chip =3D i2c_get_clientdata(client);
> >> +
> >> +       schedule_delayed_work(&chip->work, MAX17040_DELAY);
> >> +       return 0;
> >> +}
> >> +
> >=20
> > Please add #ifdef CONFIG_PM around suspend resume functions.
> >=20
>=20
> Ok, I will.

Just did it myself, and queued this patch for 2.6.31.

Thanks!

--=20
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
