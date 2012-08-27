From: ludovic.desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v11 4/4] G45 TWI: remove open drain setting for twi
 function gpios
Date: Mon, 27 Aug 2012 15:27:48 +0200
Message-ID: <503B75D4.2030803@atmel.com>
References: <cover.1345618760.git.n.voss@weinmann.de>
 <6acdbd0f06cb9902efc510346564e10b07fa0b91.1345618760.git.n.voss@weinmann.de>
 <503B4AE6.4090107@atmel.com>
 <EF2E73589CA71846A15D0B2CDF79505D090EC3D6E4@wm021.weinmann.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <EF2E73589CA71846A15D0B2CDF79505D090EC3D6E4@wm021.weinmann.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Voss, Nikolaus" <N.Voss@weinmann.de>
Cc: "'rmallon@gmail.com'" <rmallon@gmail.com>, "'nicolas.ferre@atmel.com'" <nicolas.ferre@atmel.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'balbi@ti.com'" <balbi@ti.com>, "'h.feurstein@gmail.com'" <h.feurstein@gmail.com>, "'ludovic.desroches'" <ludovic.desroches@atmel.com>, "'linux-i2c@vger.kernel.org'" <linux-i2c@vger.kernel.org>, "'ben-linux@fluff.org'" <ben-linux@fluff.org>, "'adrian.yanes@aalto.fi'" <adrian.yanes@aalto.fi>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>, "'carsten.behling@garz-fricke.com'" <carsten.behling@garz-fricke.com>
List-Id: linux-i2c@vger.kernel.org

Le 08/27/2012 03:22 PM, Voss, Nikolaus a =E9crit :
> Hi Ludovic,
>
> ludovic.desroches wrote on Monday, August 27, 2012 12:25 PM:
>> Le 11/08/2011 12:11 PM, Nikolaus Voss a =E9crit :
>>> The G45 datasheets explicitly states that setting the open drain proper=
ty
>>> on peripheral function gpios is not allowed. (How about other A91 chips=
?)
>>
>> Did you remove open drain because you had some issues or because you
>> had  seen it into datasheet?
>>
>> I tried with and without open drain. The behavior was the same. Looking
>> to the G45 datasheet, I didn't see that the open drain property is not
>> allowed on peripheral function gpios:
>>
>> 'The Multi Drive can be selected whether the I/O line
>> is controlled by the PIO controller or assigned to a peripheral function=
.'
>>
>> The datasheet should have been updated or there is another place where
>> it is mentioned that open drain property is not allowed in this case.
>
> well, it didn't work on my G45. I found the following note in the
> TWI chapter 31.6.1 of the G45 datasheet:
> "The user must not program TWD and TWCK as open-drain.
> It is already done by the hardware."

Ok so it seems there is a contradiction. I'll try to inquire about this =

point.

Regards

Ludovic

>
> After removing the open-drain setting, it worked.
>
> Regards,
> Nikolaus
>
>
>
>
