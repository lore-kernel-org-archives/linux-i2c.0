From: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v5 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
Date: Mon, 19 Jan 2015 11:15:41 -0800
Message-ID: <54BD57DD.9080002@broadcom.com>
References: <rjui@broadcom.com> <1421451737-7107-1-git-send-email-rjui@broadcom.com> <1421451737-7107-3-git-send-email-rjui@broadcom.com> <54BB795C.6040402@broadcom.com> <20150118094741.GE22880@pengutronix.de> <20150118110658.GA1113@katana> <20150118111759.GG22880@pengutronix.de> <54BB9D2B.20408@broadcom.com> <20150118115650.GH22880@pengutronix.de> <54BBA36A.10608@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54BBA36A.10608-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, =?windows-1252?Q?Uwe_Kleine-?= =?windows-1252?Q?K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On 1/18/2015 4:13 AM, Arend van Spriel wrote:
> On 01/18/15 12:56, Uwe Kleine-K=F6nig wrote:
>> Hello,
>>
>> On Sun, Jan 18, 2015 at 12:46:51PM +0100, Arend van Spriel wrote:
>>> On 01/18/15 12:17, Uwe Kleine-K=F6nig wrote:
>>>> Hello Wolfram,
>>>>
>>>> On Sun, Jan 18, 2015 at 12:06:58PM +0100, Wolfram Sang wrote:
>>>>> On Sun, Jan 18, 2015 at 10:47:41AM +0100, Uwe Kleine-K=F6nig wrot=
e:
>>>>>> On Sun, Jan 18, 2015 at 10:14:04AM +0100, Arend van Spriel wrote=
:
>>>>>>> On 01/17/15 00:42, Ray Jui wrote:
>>>>>>>> +    complete_all(&iproc_i2c->done);
>>>>>>>
>>>>>>> Looking over this code it seems to me there is always a single
>>>>>>> process waiting for iproc_i2c->done to complete. So using compl=
ete()
>>>>>>> here would suffice.
>>>>>> Yeah, there is always only a single thread waiting. That means b=
oth
>>>>>> complete and complete_all are suitable. AFAIK there is no reason
>>>>>> to pick
>>>>>> one over the other in this case.
>>>>>
>>>>> Clarity?
>>>> And which do you consider more clear? complete_all might result in=
 the
>>>> question: "Is there>1 waiter?" and complete might yield to "What a=
bout
>>>> the other waiters?". If you already know there is only one, both a=
re on
>>>> par on clarity. Might only be me?! I don't care much.
>>>
>>> Maybe it is me, but it is not about questions but it is about
>>> implicit statements that the code makes (or reader derives from it)=
=2E
>>> When using complete_all you indicate to the reader "there can be
>>> more than one waiter". When using complete it indicates "there is
>>> only one waiter". If those statements are not true that is a code
>> No, complete works just fine in the presence of>1 waiter. It just wa=
kes
>> a single waiter and all others continue to wait.
>=20
> Yes. Agree.
>=20
>> That is, for single-waiter situations there is no semantic differenc=
e
>> between complete and complete_all. But there is a difference for
>> multi-waiter queues.
>=20
> Indeed.
>=20
>> I think this is just a matter of your POV in the single-waiter
>> situation: complete might be intuitive because you just completed a
>> single task and complete_all might be intuitive because it signals
>> "I'm completely done, there is noone waiting for me any more.".
>=20
> Ok. Let's leave it to the author's intuition or to say it differently
> "sorry for the noise" ;-)
Will stay with complete_all since I meant to say "after this transfer
complete interrupt, there should be no one waiting anymore (although
there's currently only one waiter, and will likely stay that way)"

Thanks!

>=20
> Regards,
> Arend
>=20
>> Best regards
>> Uwe
>>
>=20
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
