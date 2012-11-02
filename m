From: ludovic.desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] i2c: at91: add a sanity check on i2c message length
Date: Fri, 2 Nov 2012 17:00:43 +0100
Message-ID: <5093EE2B.8080005@atmel.com>
References: <1349879158-27268-1-git-send-email-ludovic.desroches@atmel.com>
 <20121101222922.GD22956@pengutronix.de> <5093A8CD.60006@atmel.com>
 <20121102111432.GD21313@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121102111432.GD21313@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>, "Voss, Nikolaus" <N.Voss@weinmann.de>
Cc: "ludovic.desroches" <ludovic.desroches@atmel.com>, nicolas.ferre@atmel.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Le 11/02/2012 12:14 PM, Wolfram Sang a =E9crit :
> On Fri, Nov 02, 2012 at 12:04:45PM +0100, ludovic.desroches wrote:
>> Hi Wolfram,
>>
>> Le 11/01/2012 11:29 PM, Wolfram Sang a =E9crit :
>>> On Wed, Oct 10, 2012 at 04:25:58PM +0200, ludovic.desroches@atmel.com w=
rote:
>>>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>>>>
>>>> If the i2c message length is zero, i2c-at91 will directly return an er=
ror
>>>> instead of trying to send a zero-length message.
>>>>
>>>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>>>
>>> What happens if you send a 0 byte message? Some hardware is able to do
>>> this and it will be used in SMBUS QUICK which the driver states to
>>> support according to at91_twi_func().
>>
>> Without this I had some data corruption when writing to / reading
>> from a serial eeprom (depending on the IP version).
>>
>> Yes SMBUS quick command is supported but is not managed in the
>> driver, we have to tell explicitly the IP that we want to send this
>> command.
>
> Ok, so unless you want to implement the support, please update this
> patch with a comment that SMBUS_QUICK is a TODO and remove the
> SMBUS_QUICK capability.
>

Implementation should not be a huge task, only one bit to set in a =

register but I have no device to test it.
So I will choose to remove the SMBUS_QUICK capability.

Hi Nikolaus,

Did you test the driver with SMBus compatible devices? Can I keep other =

SMBus capabilities from SMBUS_EMUL?

Thanks

Regards

Ludovic
