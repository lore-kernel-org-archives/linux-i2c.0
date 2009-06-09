From: Minkyu Kang <promsoft-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] add MAX17040 Fuel Gauge driver
Date: Tue, 9 Jun 2009 10:12:58 +0900
Message-ID: <1f3430fb0906081812j69f35b18tde3d4ab5d80b504@mail.gmail.com>
References: <4A28BC20.3010307@samsung.com>
	 <5d5443650906060959w678a29acn8200239d35869dca@mail.gmail.com>
	 <4A2C7911.80407@samsung.com>
	 <20090608210007.GA29332@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090608210007.GA29332-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Cc: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dear, Anton Vorontsov

2009/6/9 Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>:
> On Mon, Jun 08, 2009 at 11:36:01AM +0900, Minkyu Kang wrote:
>> Dear Trilok Soni,
>>
>> Thanks for review
>>
>> > Hi Minkyu Kang,
>> >
>> > On Fri, Jun 5, 2009 at 12:03 PM, Minkyu Kang<mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>=
 wrote:
>> >> The MAX17040 is a I2C interfaced Fuel Gauge systems for lithium-i=
on batteries
>> >> This patch adds support the MAX17040 Fuel Gauge
>> >>
>> >
>> > Thanks for making change. Some more comments.
>> >
>> >> =A0endif # POWER_SUPPLY
>> >> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
>> >> index 2fcf41d..9c48995 100644
>> >> --- a/drivers/power/Makefile
>> >> +++ b/drivers/power/Makefile
>> >> @@ -25,4 +25,5 @@ obj-$(CONFIG_BATTERY_TOSA) =A0 =A0+=3D tosa_bat=
tery.o
>> >> =A0obj-$(CONFIG_BATTERY_WM97XX) =A0 +=3D wm97xx_battery.o
>> >> =A0obj-$(CONFIG_BATTERY_BQ27x00) =A0+=3D bq27x00_battery.o
>> >> =A0obj-$(CONFIG_BATTERY_DA9030) =A0 +=3D da9030_battery.o
>> >> -obj-$(CONFIG_CHARGER_PCF50633) +=3D pcf50633-charger.o
>> >> \ No newline at end of file
>> >> +obj-$(CONFIG_BATTERY_MAX17040)) =A0 =A0 =A0 =A0+=3D max17040_bat=
tery.o
>
> There is a typo: "))" should be just ")". I fixed this.
>
> I also fixed "=91max17040_set_rcomp=92 defined but not used" warning
> (just removed this function).

I missed it. thanks.

>> > Are we following any alphabetical order in this Makefile?
>> >
>>
>> I'm not sure either. :(
>> I just grouping with batteries.
>
> It's fine as is. I always wonder when somebody try to sort things
> alphabetically. Humans should not bother with sorting, that's what
> computers are for! ;-)
>
>> >> +static int max17040_suspend(struct i2c_client *client,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_message_t state)
>> >> +{
>> >> + =A0 =A0 =A0 struct max17040_chip *chip =3D i2c_get_clientdata(c=
lient);
>> >> +
>> >> + =A0 =A0 =A0 cancel_delayed_work(&chip->work);
>> >> + =A0 =A0 =A0 return 0;
>> >> +}
>> >> +
>> >> +static int max17040_resume(struct i2c_client *client)
>> >> +{
>> >> + =A0 =A0 =A0 struct max17040_chip *chip =3D i2c_get_clientdata(c=
lient);
>> >> +
>> >> + =A0 =A0 =A0 schedule_delayed_work(&chip->work, MAX17040_DELAY);
>> >> + =A0 =A0 =A0 return 0;
>> >> +}
>> >> +
>> >
>> > Please add #ifdef CONFIG_PM around suspend resume functions.
>> >
>>
>> Ok, I will.
>
> Just did it myself, and queued this patch for 2.6.31.
>
> Thanks!
>

Ok, I appreciate your help.
Many Thanks :)

--=20
from. prom.
promsoft.net
