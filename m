From: Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v5 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
Date: Sun, 18 Jan 2015 13:13:30 +0100
Message-ID: <54BBA36A.10608@broadcom.com>
References: <rjui@broadcom.com> <1421451737-7107-1-git-send-email-rjui@broadcom.com> <1421451737-7107-3-git-send-email-rjui@broadcom.com> <54BB795C.6040402@broadcom.com> <20150118094741.GE22880@pengutronix.de> <20150118110658.GA1113@katana> <20150118111759.GG22880@pengutronix.de> <54BB9D2B.20408@broadcom.com> <20150118115650.GH22880@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150118115650.GH22880-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 01/18/15 12:56, Uwe Kleine-K=F6nig wrote:
> Hello,
>
> On Sun, Jan 18, 2015 at 12:46:51PM +0100, Arend van Spriel wrote:
>> On 01/18/15 12:17, Uwe Kleine-K=F6nig wrote:
>>> Hello Wolfram,
>>>
>>> On Sun, Jan 18, 2015 at 12:06:58PM +0100, Wolfram Sang wrote:
>>>> On Sun, Jan 18, 2015 at 10:47:41AM +0100, Uwe Kleine-K=F6nig wrote=
:
>>>>> On Sun, Jan 18, 2015 at 10:14:04AM +0100, Arend van Spriel wrote:
>>>>>> On 01/17/15 00:42, Ray Jui wrote:
>>>>>>> +	complete_all(&iproc_i2c->done);
>>>>>>
>>>>>> Looking over this code it seems to me there is always a single
>>>>>> process waiting for iproc_i2c->done to complete. So using comple=
te()
>>>>>> here would suffice.
>>>>> Yeah, there is always only a single thread waiting. That means bo=
th
>>>>> complete and complete_all are suitable. AFAIK there is no reason =
to pick
>>>>> one over the other in this case.
>>>>
>>>> Clarity?
>>> And which do you consider more clear? complete_all might result in =
the
>>> question: "Is there>1 waiter?" and complete might yield to "What ab=
out
>>> the other waiters?". If you already know there is only one, both ar=
e on
>>> par on clarity. Might only be me?! I don't care much.
>>
>> Maybe it is me, but it is not about questions but it is about
>> implicit statements that the code makes (or reader derives from it).
>> When using complete_all you indicate to the reader "there can be
>> more than one waiter". When using complete it indicates "there is
>> only one waiter". If those statements are not true that is a code
> No, complete works just fine in the presence of>1 waiter. It just wak=
es
> a single waiter and all others continue to wait.

Yes. Agree.

> That is, for single-waiter situations there is no semantic difference
> between complete and complete_all. But there is a difference for
> multi-waiter queues.

Indeed.

> I think this is just a matter of your POV in the single-waiter
> situation: complete might be intuitive because you just completed a
> single task and complete_all might be intuitive because it signals
> "I'm completely done, there is noone waiting for me any more.".

Ok. Let's leave it to the author's intuition or to say it differently=20
"sorry for the noise" ;-)

Regards,
Arend

> Best regards
> Uwe
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
