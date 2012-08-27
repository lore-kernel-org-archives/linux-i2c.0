From: ludovic.desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v11 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
Date: Mon, 27 Aug 2012 16:00:14 +0200
Message-ID: <503B7D6E.7090906@atmel.com>
References: <cover.1345618760.git.n.voss@weinmann.de>
 <4f3dcfbf1e8eab3e251ab3558e9e1e9123643928.1345618760.git.n.voss@weinmann.de>,
 <503B4919.6080306@atmel.com>
 <BC0F374A1C27184AB96177CDFEC2F54225ECC330@EXMDB06.org.aalto.fi>,
 <503B623C.4030304@atmel.com>
 <BC0F374A1C27184AB96177CDFEC2F54225ECD36E@EXMDB06.org.aalto.fi>
 <EF2E73589CA71846A15D0B2CDF79505D090EC3D6F6@wm021.weinmann.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <EF2E73589CA71846A15D0B2CDF79505D090EC3D6F6@wm021.weinmann.com>
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
Cc: "'ben-linux@fluff.org'" <ben-linux@fluff.org>, "'carsten.behling@garz-fricke.com'" <carsten.behling@garz-fricke.com>, "'nicolas.ferre@atmel.com'" <nicolas.ferre@atmel.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'balbi@ti.com'" <balbi@ti.com>, "'h.feurstein@gmail.com'" <h.feurstein@gmail.com>, "'ludovic.desroches'" <ludovic.desroches@atmel.com>, "'linux-i2c@vger.kernel.org'" <linux-i2c@vger.kernel.org>, 'Yanes Martinez Adrian' <adrian.yanes@aalto.fi>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>, "'rmallon@gmail.com'" <rmallon@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Le 08/27/2012 03:32 PM, Voss, Nikolaus a =E9crit :
> Hi Adian,
>
> Yanes Martinez Adrian wrote on Monday, August 27, 2012 2:46 PM:
>> Le 08/27/2012 12:40 PM, Yanes Martinez Adrian a =E9crit :
>>> Hi Ludovic,
>>>
>>>> Tested on at91rm9200, at91sam9261, at91sam9g20 and at91sam9m10 with
>>>> eeprom, temperature sensor and rtc devices (and wolfson chip for
>>>> sam9g20).
>>>
>>> concerning the at91rm9200, what was the amount of bytes you
>> transmitted?
>>>
>>
>>> I have only checked that I can communicate with i2c devices so the
>>> amount is very low (1-4 bytes).
>>
>> IIRC it was from >7 bytes when the issues appeared.
>>
>>> Some months ago I performed some testing[1] with the previous version of
>>> the patch and the main conclusion was that the absence of PDC in the
>>> AT91RM9200 made this driver unusable in such platform.
>
> I didn't get your last post  in that thread. In my opinion RM9200 should =
really
> be excluded from being configured with this driver, what's your opinion
> Ludovic?

Yes, the use of the TWI controller may be removed for some chips since =

there are issues that are dependent on the controller itself. RM9200 is =

not the only one.

For the moment, I don't have the necessary knowledge about the TWI =

controller to take a decision. I would say it can be done in an other =

patch in order to have your driver included in the mainline quickly =

since it doesn't introduce a breakage.

Regards

Ludovic

>
> Regards,
> Niko
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
