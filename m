From: "Byron Bradley" <byron.bbradley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Add support for the S-35390A RTC chip.
Date: Sun, 6 Jan 2008 22:11:25 +0000
Message-ID: <57e2b00801061411g4d5280deg4bc9f8dc4c8bce8b@mail.gmail.com>
References: <1199573894-9189-1-git-send-email-byron.bbradley@gmail.com>
	<20080106190100.5e7b6be9@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080106190100.5e7b6be9-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Jan 6, 2008 6:01 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> Hi Byron,
>
> On Sat,  5 Jan 2008 22:58:14 +0000, Byron Bradley wrote:
> > This adds basic get/set time support for the Seiko Instruments
> > S-35390A. This chip communicates using I2C and is used on the
> > QNAP TS-109/TS-209 NAS devices. It takes up eight addresses on
> > the I2C bus and depends on the following patches:
> >
> >       i2c-remove-redundant-i2c_client-list.patch
> >       i2c-add-i2c_new_dummy-utility.patch
> >
> > Signed-off-by: Byron Bradley <byron.bbradley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Tested-by: Tim Ellis <tim-ReWupQYfQ/MAvxtiuMwx3w@public.gmane.org>
> > Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
> > ---
> >  drivers/rtc/Kconfig       |    9 ++
> >  drivers/rtc/Makefile      |    1 +
> >  drivers/rtc/rtc-s35390a.c |  316 +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 326 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/rtc/rtc-s35390a.c
>
> Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>
> With just one comment:
>
> > +     /* This chip uses multiple addresses, use dummy devices for them */
> > +     for (i = 1; i < 8; ++i) {
> > +             s35390a->client[i] = i2c_new_dummy(client->adapter,
> > +                                     client->addr + i, "rtc-s35390a");
> > +             if (!s35390a->client[i]) {
> > +                     dev_err(&client->dev, "Address %d unavailable\n",
> > +                                             client->addr + i);
> > +                     err = -ENOCSI;
> > +                     goto exit_dummy;
> > +             }
> > +     }
>
> -ENOCSI? Don't you rather mean -EBUSY?
>
> Also, the address would be better printed as an hexadecimal value -
> decimal I2C addresses isn't something people are used to.
>
> You should get your driver reviewed by Alessandro Zummo now, and then
> it can be merged upstream... After the i2c cleanups it depends on are
> upstream themselves, that is (working on it.)

Thanks Jean, I've sent it to Alessandro Zummo and the rtc-linux list.

David, the ENOCSI comment probably applies to your at24 eeprom driver
too. I was wondering why that error code was chosen since other than
"No CSI structure available" I couldn't find anything about it.

Cheers,

-- 
Byron Bradley
