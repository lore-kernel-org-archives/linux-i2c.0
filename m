From: ludovic.desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] i2c: at91: add a sanity check on i2c message length
Date: Fri, 2 Nov 2012 12:04:45 +0100
Message-ID: <5093A8CD.60006@atmel.com>
References: <1349879158-27268-1-git-send-email-ludovic.desroches@atmel.com>
 <20121101222922.GD22956@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121101222922.GD22956@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: ludovic.desroches@atmel.com, nicolas.ferre@atmel.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Le 11/01/2012 11:29 PM, Wolfram Sang a =E9crit :
> On Wed, Oct 10, 2012 at 04:25:58PM +0200, ludovic.desroches@atmel.com wro=
te:
>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>>
>> If the i2c message length is zero, i2c-at91 will directly return an error
>> instead of trying to send a zero-length message.
>>
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> What happens if you send a 0 byte message? Some hardware is able to do
> this and it will be used in SMBUS QUICK which the driver states to
> support according to at91_twi_func().

Without this I had some data corruption when writing to / reading from a =

serial eeprom (depending on the IP version).

Yes SMBUS quick command is supported but is not managed in the driver, =

we have to tell explicitly the IP that we want to send this command.


Regards

Ludovic

>
> Regards,
>
>     Wolfram
>
