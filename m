From: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 2/2] i2c: cadence: Check for errata condition involving
 master receive
Date: Thu, 11 Dec 2014 12:46:53 +0530
Message-ID: <CAFcVECJDfJaEALDxfZg5-+tsD02mVT43s7PX4RLs349Kx9Jaeg@mail.gmail.com>
References: <1418211884-5329-1-git-send-email-harinik@xilinx.com>
	<1418211884-5329-3-git-send-email-harinik@xilinx.com>
	<6b2bd13bcd934b0fb09712e8950348e6@BN1AFFO11FD005.protection.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6b2bd13bcd934b0fb09712e8950348e6-reflc3kr++MEH1pyDrHbn+hlVc3/7hDbVaz/vdPVXQ4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: Harini Katakam <harini.katakam-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vishnu Motghare <vishnum-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Soren,

On Wed, Dec 10, 2014 at 11:15 PM, S=C3=B6ren Brinkmann
<soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org> wrote:
> On Wed, 2014-12-10 at 05:14PM +0530, Harini Katakam wrote:
>> Cadence I2C controller has the following bugs:
>> - completion indication is not given to the driver at the end of
>> a read/receive transfer with HOLD bit set.
>> - Invalid read transaction are generated on the bus when HW timeout
>> condition occurs with HOLD bit set.
>>
>> As a result of the above, if a set of messages to be transferred wit=
h
>> repeated start includes any transfer following a read transfer,
>> completion is never indicated and timeout occurs.
>> Hence a check is implemented to return -EOPNOTSUPP for such sequence=
s.
>>
>> Signed-off-by: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Vishnu Motghare <vishnum-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
>> ---
>>
>> v4:
>> Use single dev_warn and make message grep-able.
>>
>> v3:
>> Add warning in case of unsupported transfer.
>>
>> v2:
>> Dont defeteature repeated start. Just check for unsupported conditio=
ns in the
>> driver and return error.
>>
>> ---
>>  drivers/i2c/busses/i2c-cadence.c |   14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i=
2c-cadence.c
>> index 5f5d4fa..f9269a6 100644
>> --- a/drivers/i2c/busses/i2c-cadence.c
>> +++ b/drivers/i2c/busses/i2c-cadence.c
>> @@ -541,6 +541,20 @@ static int cdns_i2c_master_xfer(struct i2c_adap=
ter *adap, struct i2c_msg *msgs,
>>        * processed with a repeated start.
>>        */
>>       if (num > 1) {
>> +             /*
>> +              * This controller does not give completion interrupt =
after a
>> +              * master receive transfer if HOLD bit is set (repeate=
d start),
>> +              * resulting in SW timeout. Hence, if a receive transf=
er is
>> +              * followed by any other transfer, an error is returne=
d
>> +              * indicating that this sequence is not supported.
>> +              */
>> +             for (count =3D 0; count < num-1; count++) {
>> +                     if (msgs[count].flags & I2C_M_RD)
>> +                             dev_warn(adap->dev.parent, "No support=
 for "
>> +                                      "repeated start when receive =
is "
>> +                                      "followed by a transfer\n");
>
> Still not grepable. There must be no line breaks in the string!

This message will be printed in one single line.
Do you want this string to be grepable in the driver? Why is that neces=
sary?

Regards,
Harini
