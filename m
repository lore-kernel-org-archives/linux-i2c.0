From: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>
Subject: Re: [PATCH] i2c-cadence: Do not let signals interrupt I2C transfers
Date: Tue, 11 Mar 2014 07:59:16 +0100
Message-ID: <531EB444.4090406@topic.nl>
References: <1394449954-10797-1-git-send-email-mike.looijmans@topic.nl> <20140310215952.GF13293@xsjandreislx> <b6f0755f-cfc9-4962-851f-5eeac767e93e@AM1EHSMHS008.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b6f0755f-cfc9-4962-851f-5eeac767e93e-dAX9Bq04yCSsiP+nND6G/7jjLBE8jN/0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suneel Garapati <suneel.garapati-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Soren Brinkmann <sorenb-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: git <git-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=EF=BB=BFOn 03/11/2014 05:49 AM, Suneel Garapati wrote:
> Hi Mike/Soren,
>
>>=20

Met vriendelijke groet / kind regards,

Mike Looijmans

TOPIC Embedded Systems
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: (+31) (0) 499 33 69 79
Telefax:  (+31) (0) 499 33 69 70
E-mail: mike.looijmans-Oq418RWZeHk@public.gmane.org
Website: www.topic.nl

Please consider the environment before printing this e-mail

-----Original Message-----
>> From: S=C3=B6ren Brinkmann [mailto:soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org]
>> Sent: Tuesday, March 11, 2014 03:30
>> To: Mike Looijmans; Michal Simek
>> Cc: git; wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
>> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Subject: Re: [PATCH] i2c-cadence: Do not let signals interrupt I2C t=
ransfers
>>
>> Hi Mike,
>>
>> The cadence driver is not in mainline yet. I think for our vendor tr=
ee we can
>> pretty much take it this way.
>> Regarding getting this into mainline, I'll send another iteration of=
 the change
>> set and include these changes.
>>
>> On Mon, 2014-03-10 at 12:12PM +0100, Mike Looijmans wrote:
>>> Pressing CTRL-C while communicating with an I2C device leads to
>>> erratic behaviour. The cause is that the controller will interrupt =
the
>>> I2C transfer in progress, and leave the client device in an undefin=
ed
>>> state. Many drivers do not handle error return codes on I2C transfe=
rs.
>>> The calling driver has no way of telling how much of the transfer h=
as
>>> actually completed, so it cannot reliably determine the device's st=
ate.
>>>
>>> The best solution here is to not handle signals in the I2C bus driv=
er
>>> at all, but always complete a transaction before returning control.
>>>
>>> See for a related patch and discussion on this topic:
>>> http://lkml.org/lkml/2014/1/9/246
>>
>> Can we get your Signed-off-by, please?

Sure, I forgot the -s, will add it in the next version.

>>
>>> ---
>>>   drivers/i2c/busses/i2c-cadence.c |   12 ++++--------
>>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-cadence.c
>>> b/drivers/i2c/busses/i2c-cadence.c
>>> index 86713d6..32ce2ee 100644
>>> --- a/drivers/i2c/busses/i2c-cadence.c
>>> +++ b/drivers/i2c/busses/i2c-cadence.c
>>> @@ -452,16 +452,12 @@ static int cdns_i2c_process_msg(struct cdns_i=
2c
>> *id, struct i2c_msg *msg,
>>>                      cdns_i2c_msend(id);
>>>
>>>              /* Wait for the signal of completion */
>>> -           ret =3D wait_for_completion_interruptible_timeout(
>>> -                                                   &id->xfer_done,=
 HZ);
>>> -           if (ret < 1) {
>>> +           ret =3D wait_for_completion_timeout(&id->xfer_done, HZ)=
;
>>> +           if (ret =3D=3D 0) {
>>
>> To match the style used throughout the file this should just be
>>        if (!ret) {

Will do.

> Instead of discarding Ctrl+C, Can we wait until the current msg trans=
fer completes
> [to avoid client undefined state or re-init the host to a known state=
]
>
> I see da-vinci driver handling in a similar way.

My patch for the davinci should have completely ignored the signals too=
=2E I=20
haven't come across a driver that actually calls the xfer function with=
 more=20
than one item anyway. If drivers check the result of the xfer at all, t=
hey=20
usually don't have a clue how to handle partial transfers. Many drivers=
 just=20
ignore the return code completely and don't even report failure.

The gain is a stable I2C system. The loss here is something like <1ms m=
ore=20
latency to interrupt a process in the case it was just transferring I2C=
 data.=20
 From experience I can tell that the gain far outweighs that loss.

Mike.
